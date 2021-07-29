Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078DF3DAB27
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 20:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhG2Sm4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 14:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhG2Smx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 14:42:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56FCF60FED;
        Thu, 29 Jul 2021 18:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627584169;
        bh=FH7c/v8eNoRP4MKEI2nHhlzG8/WwzP4fZLwjKx4ZIfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IkeB1UqZhHsA11mwFeqpNdfJrpr34JNE+nD0xrr/L757+Rilp4wMZ69x1H3HlAwjc
         JQdHavwXveriYZJKF9WiHSOXlakxY+EN9uRdeCAAwDY/HEdxFXD5BtY4hpxNnAxcV6
         kFgtnnu7Xi1krsusfg277bCHekS0l8g9zc7lyZW43wRZVozK5P7Dw+lbgxCYE0iYjE
         CPkp1Xy26e58PEHyEI3hlbaNREGR8FjC3yDIzHFKqFJ41BxyLSdcxKDckTOkOpWeAh
         S+d2Ahbi/kCbPlPywICf/FEvrAWB1EWnPcYzYFIBTtb0Tsz/XfqzSVvNA4XdTXfJAo
         ZyxwAsxyk7s4g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 6/6] PCI/VPD: Allow access to valid parts of VPD if some is invalid
Date:   Thu, 29 Jul 2021 13:42:34 -0500
Message-Id: <20210729184234.976924-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729184234.976924-1-helgaas@kernel.org>
References: <20210729184234.976924-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously, if we found any error in the VPD, we returned size 0, which
prevents access to all of VPD.  But there may be valid resources in VPD
before the error, and there's no reason to prevent access to those.

"off" covers only VPD resources known to have valid header tags.  In case
of error, return "off" (which may be zero if we haven't found any valid
header tags at all).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/pci/vpd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 6fa09e969d6e..f74d2f5194e4 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -85,6 +85,11 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 		if (header[0] & PCI_VPD_LRDT) {
 			/* Large Resource Data Type Tag */
 			tag = pci_vpd_lrdt_tag(header);
+			if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
+				pci_warn(dev, "failed VPD read at offset %zu",
+					 off + 1);
+				return off;
+			}
 			size = pci_vpd_lrdt_size(header);
 			if (off + size > PCI_VPD_MAX_SIZE)
 				goto error;
@@ -102,13 +107,13 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 				return off;
 		}
 	}
-	return 0;
+	return off;
 
 error:
 	pci_info(dev, "invalid VPD tag %#04x at offset %zu%s\n",
 		 header[0], off, off == 0 ?
 		 "; assume missing optional EEPROM" : "");
-	return 0;
+	return off;
 }
 
 /*
-- 
2.25.1

