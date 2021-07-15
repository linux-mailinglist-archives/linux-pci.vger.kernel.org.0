Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC893CAEDA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 00:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhGOWDO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 18:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhGOWDN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 18:03:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD94560FE7;
        Thu, 15 Jul 2021 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626386420;
        bh=7GX89LyvSQPClxnegp6N1W9nDIfrwiEDYQISro10bos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhLANE8hEbxYfivzMrReud/kBGHjRBwqNSyA621Q5ERlu9GY0VyZamUdiRr8gNbvc
         FD/ue5QAPgZiyK+ITUyhErDE/nirB6+wGGffdL4gnmngIORWHRA8IYN3ITB8cSBbK1
         7k8IzddVyzRFVgHqX/SG7Ym9mLHJg4sgExZPtpGQ7ffGuchUxoddPJSt06fnMsZfbh
         ka3+wws6Hheqq9UvxbSexAEPxbubyU+cy8kC3NAlTQ9hELp4QskCcKDdJpHXJNv5HT
         oDt6qyr+kDQV3NGnJdawtxlDZRi6nxcGYsI7e27TWN/knTVRrOjFtCAxnxekBRbPIL
         5dqbp49Bwtm6w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/5] PCI/VPD: Don't check Large Resource types for validity
Date:   Thu, 15 Jul 2021 16:59:58 -0500
Message-Id: <20210715215959.2014576-5-helgaas@kernel.org>
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

VPD consists of a series of Small and Large Resources.  Computing the size
of VPD requires only the length of each, which is specified in the generic
tag of each resource.  We only expect to see ID_STRING, RO_DATA, and
RW_DATA in VPD, but it's not a problem if it contains other resource types.

Drop the validity checking of Large Resource items.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vpd.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 9c2744d79b53..d7a4a9f05bd6 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -82,31 +82,22 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 		if (header[0] & PCI_VPD_LRDT) {
 			/* Large Resource Data Type Tag */
 			tag = pci_vpd_lrdt_tag(header);
-			/* Only read length from known tag items */
-			if ((tag == PCI_VPD_LTIN_ID_STRING) ||
-			    (tag == PCI_VPD_LTIN_RO_DATA) ||
-			    (tag == PCI_VPD_LTIN_RW_DATA)) {
-				if (pci_read_vpd(dev, off+1, 2,
-						 &header[1]) != 2) {
-					pci_warn(dev, "failed VPD read at offset %zu",
-						 off + 1);
-					return 0;
-				}
-				size = pci_vpd_lrdt_size(header);
-
-				/*
-				 * Missing EEPROM may read as 0xff.
-				 * Length of 0xffff (65535) cannot be valid
-				 * because VPD can't be that large.
-				 */
-				if (size > PCI_VPD_MAX_SIZE)
-					goto error;
-				off += PCI_VPD_LRDT_TAG_SIZE + size;
-			} else {
-				pci_warn(dev, "invalid large VPD tag %02x at offset %zu",
-					 tag, off);
+			if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
+				pci_warn(dev, "failed VPD read at offset %zu",
+					 off + 1);
 				return 0;
 			}
+			size = pci_vpd_lrdt_size(header);
+
+			/*
+			 * Missing EEPROM may read as 0xff.  Length of
+			 * 0xffff (65535) cannot be valid because VPD can't
+			 * be that large.
+			 */
+			if (size > PCI_VPD_MAX_SIZE)
+				goto error;
+
+			off += PCI_VPD_LRDT_TAG_SIZE + size;
 		} else {
 			/* Short Resource Data Type Tag */
 			tag = pci_vpd_srdt_tag(header);
-- 
2.25.1

