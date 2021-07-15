Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D3F3CAED9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 00:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhGOWDO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 18:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhGOWDM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 18:03:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2967A613CF;
        Thu, 15 Jul 2021 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626386418;
        bh=uuqbgYsdR09711D4OQRZWd0so/Mh3lkDLC8k/5VKZYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frF1Rl49DC1bxW4jo6t7Zqy0v4cEXAMcfgZJ7Yy3XDLE/NunwuRLtKzvNSSNQ2BVV
         3hnpkrb6D9h+zxncKwpIeG245Gc5cxPSDFn4VnEInWHsdWBfOZnELi4xP/XYjBcK0H
         7MDYuRKpKyHHwI1HiL2ca2U/bNzIcwuyoz+8Ms2NmzRy7BG2DVsUg0rnSYu67cCnzy
         iQnIxLn2IBqGVfCKWspQ17nQImmFougbdvj5GrGWS4OeQefH7d3IqXMZ7CoeNkJlHI
         ASzPd/2gj4GwNT324ZALpyT4+VG8velgVS8gSKfPPWDaxXwP2lW4FazIGIFpc9QVSA
         8i+cUwMVz1NIw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/5] PCI/VPD: Consolidate missing EEPROM checks
Date:   Thu, 15 Jul 2021 16:59:57 -0500
Message-Id: <20210715215959.2014576-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715215959.2014576-1-helgaas@kernel.org>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
 <20210715215959.2014576-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

A missing VPD EEPROM typically reads as either all 0xff or all zeroes.
Both cases lead to invalid VPD resource items.  A 0xff tag would be a Large
Resource with length 0xffff (65535).  That's invalid because VPD can only
be 32768 bytes, limited by the size of the address register in the VPD
Capability.

A VPD that reads as all zeroes is also invalid because a 0x00 tag is a
Small Resource with length 0, which would result in an item of length 1.
This isn't explicitly illegal in PCIe r5.0, sec 6.28, but the format is
derived from PNP ISA, which *does* say "a small resource data type may be
2-8 bytes in size" (Plug and Play ISA v1.0a, sec 6.2.2.

Check for these invalid tags and return VPD size of zero if we find them.
If they occur at the beginning of VPD, assume it's the result of a missing
EEPROM.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vpd.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 9b54dd95e42c..9c2744d79b53 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -77,11 +77,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 
 	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
 		unsigned char tag;
-
-		if (!header[0] && !off) {
-			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
-			return 0;
-		}
+		size_t size;
 
 		if (header[0] & PCI_VPD_LRDT) {
 			/* Large Resource Data Type Tag */
@@ -96,8 +92,16 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 						 off + 1);
 					return 0;
 				}
-				off += PCI_VPD_LRDT_TAG_SIZE +
-					pci_vpd_lrdt_size(header);
+				size = pci_vpd_lrdt_size(header);
+
+				/*
+				 * Missing EEPROM may read as 0xff.
+				 * Length of 0xffff (65535) cannot be valid
+				 * because VPD can't be that large.
+				 */
+				if (size > PCI_VPD_MAX_SIZE)
+					goto error;
+				off += PCI_VPD_LRDT_TAG_SIZE + size;
 			} else {
 				pci_warn(dev, "invalid large VPD tag %02x at offset %zu",
 					 tag, off);
@@ -105,14 +109,28 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 			}
 		} else {
 			/* Short Resource Data Type Tag */
-			off += PCI_VPD_SRDT_TAG_SIZE +
-				pci_vpd_srdt_size(header);
 			tag = pci_vpd_srdt_tag(header);
+			size = pci_vpd_srdt_size(header);
+
+			/*
+			 * Missing EEPROM may read as 0x00.  A small item
+			 * must be at least 2 bytes.
+			 */
+			if (size == 0)
+				goto error;
+
+			off += PCI_VPD_SRDT_TAG_SIZE + size;
 			if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
 				return off;
 		}
 	}
 	return 0;
+
+error:
+	pci_info(dev, "invalid VPD tag %#04x at offset %zu%s\n",
+		 header[0], off, off == 0 ?
+		 "; assume missing optional EEPROM" : "");
+	return 0;
 }
 
 /*
-- 
2.25.1

