Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CB23CAED8
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 00:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhGOWDO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 18:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhGOWDK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 18:03:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 953A0610C7;
        Thu, 15 Jul 2021 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626386416;
        bh=7ik2o5DzC87ePSGVyDb14Q44TcV8OQwmLXrv0d+tdfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDmjtrEHE9Rq6vzvDNNwSWbXhht3guH2k0aK6Tzw5TO18CodMzfOqHCprGmIf3U0z
         ee5u7+bd7+7vM1D8oWmtm2Y+sTXGvZnTExmLOrQL29ALoH0hrIzQTFOKASndXhujBo
         ECEQAGOkQFIXNFpidNlwXEhgzKbLz7E6iE9Juh2bjHqliNjISSMICP6wVruPQD8jtb
         bvXQHX7HlWhAOuprVyYk5ckse7/9nDWKvK7n7mRsW3gtMXH2qw+hrDIAGldnLhS/cw
         T9wAGyznvoIzKRqhBpQjMjcvi6+msl7MRmrBWWyQwJrEqYM4j5oIP7vykRKVVrGaz8
         6zhALQluaI/6A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/5] PCI/VPD: Check Resource tags against those valid for type
Date:   Thu, 15 Jul 2021 16:59:56 -0500
Message-Id: <20210715215959.2014576-3-helgaas@kernel.org>
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

Previously, we checked for PCI_VPD_STIN_END, PCI_VPD_LTIN_ID_STRING, etc.,
outside the Large and Small Resource cases, so we checked Large Resource
tags against a Small Resource name and vice versa.

Move these tests into the Large and Small Resource cases, so we only check
PCI_VPD_STIN_END for Small Resources and PCI_VPD_LTIN_* for Large
Resources.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vpd.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 7bfb8fc4251b..9b54dd95e42c 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -98,24 +98,18 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 				}
 				off += PCI_VPD_LRDT_TAG_SIZE +
 					pci_vpd_lrdt_size(header);
+			} else {
+				pci_warn(dev, "invalid large VPD tag %02x at offset %zu",
+					 tag, off);
+				return 0;
 			}
 		} else {
 			/* Short Resource Data Type Tag */
 			off += PCI_VPD_SRDT_TAG_SIZE +
 				pci_vpd_srdt_size(header);
 			tag = pci_vpd_srdt_tag(header);
-		}
-
-		if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
-			return off;
-
-		if ((tag != PCI_VPD_LTIN_ID_STRING) &&
-		    (tag != PCI_VPD_LTIN_RO_DATA) &&
-		    (tag != PCI_VPD_LTIN_RW_DATA)) {
-			pci_warn(dev, "invalid %s VPD tag %02x at offset %zu",
-				 (header[0] & PCI_VPD_LRDT) ? "large" : "short",
-				 tag, off);
-			return 0;
+			if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
+				return off;
 		}
 	}
 	return 0;
-- 
2.25.1

