Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD33DAB23
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 20:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhG2Smu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 14:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230503AbhG2Smt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 14:42:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 208EC60F5E;
        Thu, 29 Jul 2021 18:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627584166;
        bh=3ungDbb3OMklU9ftRu0d0idMhHW/9diicRxu5L/gMP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xb/R8y/LV3KbeKUpHOXgH4OSKwUxqdO+hhtXZay8z48EIMTbV6XUlzdYvea2rQNaS
         mJCBdrUgEkLZuVocjfz9adoexgVXccFkuLHKO5nMhzypM92XuWyokF6NkUQElvLlhi
         Zrz5VHFP9TFBJSjvBUJnlYHXc6pGkKz9NLV4lmaftvqrA/Wz7VMrFd9JkzCY6QU/d1
         Z7vUrXUl3fPAto7+LrnkhyCI3q62nn3Rmg1r2mG9yrQ+khhmVDIqkaZATeJAopx1be
         f4DbZROTS/CPfj8nA6vbq858xoLYPhh+980+mBM96tL55okHTKZXbqInVn5m1uzhO+
         ngA6ODpDwhMnQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 4/6] PCI/VPD: Reject resource tags with invalid size
Date:   Thu, 29 Jul 2021 13:42:32 -0500
Message-Id: <20210729184234.976924-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729184234.976924-1-helgaas@kernel.org>
References: <20210729184234.976924-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

VPD is limited in size by the 15-bit VPD Address field in the VPD
Capability.  Each resource tag includes a length that determines the
overall size of the resource.  Reject any resources that would extend past
the maximum VPD size.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vpd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 66703de2cf2b..e52382050e3e 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -77,6 +77,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 
 	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
 		unsigned char tag;
+		size_t size;
 
 		if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
 			goto error;
@@ -94,8 +95,11 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 						 off + 1);
 					return 0;
 				}
-				off += PCI_VPD_LRDT_TAG_SIZE +
-					pci_vpd_lrdt_size(header);
+				size = pci_vpd_lrdt_size(header);
+				if (off + size > PCI_VPD_MAX_SIZE)
+					goto error;
+
+				off += PCI_VPD_LRDT_TAG_SIZE + size;
 			} else {
 				pci_warn(dev, "invalid large VPD tag %02x at offset %zu",
 					 tag, off);
@@ -103,9 +107,12 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 			}
 		} else {
 			/* Short Resource Data Type Tag */
-			off += PCI_VPD_SRDT_TAG_SIZE +
-				pci_vpd_srdt_size(header);
 			tag = pci_vpd_srdt_tag(header);
+			size = pci_vpd_srdt_size(header);
+			if (size == 0 || off + size > PCI_VPD_MAX_SIZE)
+				goto error;
+
+			off += PCI_VPD_SRDT_TAG_SIZE + size;
 			if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
 				return off;
 		}
-- 
2.25.1

