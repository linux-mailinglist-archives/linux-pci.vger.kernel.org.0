Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5420D3CAEDB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 00:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhGOWDP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 18:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231247AbhGOWDP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 18:03:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 559A1610C7;
        Thu, 15 Jul 2021 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626386421;
        bh=2277Bu4KNEpmiIPbnq6vMfKjJ0AKuRTGi1urAIdLul0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFUDQEkvMxuvKaz4RBDmT1SfztVwhzpSZYWTUvuCnFPjfG87uSRfejJS9gg6Q8WYJ
         3kLYZSgBJ37gnTqBc+4DR8lyGrcAJ5l6NT4mPQ1nFtM2oe8jzFHAm0qydGL0ZueuzR
         vLAfoGPjdWS8MSrSiJ5Cfm6W2s1fVQ4HVxL9/b9RT58YpfpF82hoGBuwwYtO69K7uW
         tG/bTlu1sg6iT04Ru6zlPf+GZf3n+mL5zna71QXduLjtoqppgwdHkuL4uIV7S0JngQ
         n2X9b4MoNjD8RRijVzmeCpA6aJuSEXV1Aun8HN65/w2hpLtb9VNuZ1WHZwEHA21A+7
         dwXTCQWWZ4gvw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/5] PCI/VPD: Allow access to valid parts of VPD if some is invalid
Date:   Thu, 15 Jul 2021 16:59:59 -0500
Message-Id: <20210715215959.2014576-6-helgaas@kernel.org>
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

Previously, if we found any error in the VPD, we returned size 0, which
prevents access to all of VPD.  But there may be valid resources in VPD
before the error, and there's no reason to prevent access to those.

"off" covers only VPD resources known to have valid header tags.  In case
of error, return "off" (which may be zero if we haven't found any valid
header tags at all).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vpd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index d7a4a9f05bd6..92acbbcc8059 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -85,7 +85,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 			if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
 				pci_warn(dev, "failed VPD read at offset %zu",
 					 off + 1);
-				return 0;
+				return off;
 			}
 			size = pci_vpd_lrdt_size(header);
 
@@ -115,13 +115,13 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
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

