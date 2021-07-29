Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25023DAB21
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 20:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhG2Smq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 14:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhG2Smq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 14:42:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C69F360249;
        Thu, 29 Jul 2021 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627584163;
        bh=auhxKJrYSDOfxalsGZS8NQWEtQT9lrJGrSdzj+8Q7+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAf1ovqouRw1XQ5sAMSPMnGgNamFaKjr/Zq+1xkXcLhAEYyIWU/r88SO9sCLXrrJr
         L2gbuHUtLCikDdE0NZ+nm6vd/o4XIwYeo+vufaWfCwKaqOcWgTsi0wA6yKo+1G6Gy3
         ub4fEfw+v7/316caGvihrEuDuz1QHvHIWPMss9dXI+KRCVIMQy9L+v2b3moxzDq7Af
         pPurE3KE8Si94VNnwO6kObBsxINmgojaVfv2e4FdZWhjr4mS/usua4wheOUAG7nZXr
         hWnSH4tobHVU2U2TZc64pqCtUIIH3G/IrR9Hm/ka1Sp1NIJPskfU+gKKg/Xj/qG8XJ
         TAfAqHxy1MFdA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/6] PCI/VPD: Check Resource Item Names against those valid for type
Date:   Thu, 29 Jul 2021 13:42:30 -0500
Message-Id: <20210729184234.976924-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729184234.976924-1-helgaas@kernel.org>
References: <20210729184234.976924-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously, we checked for PCI_VPD_STIN_END, PCI_VPD_LTIN_ID_STRING, etc.,
outside the Large and Small Resource cases, so we checked Large Resource
Item Names against a Small Resource name and vice versa.

Move these tests into the Large and Small Resource cases, so we only check
PCI_VPD_STIN_END for Small Resources and PCI_VPD_LTIN_* for Large
Resources.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

