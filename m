Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA942D38D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 09:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhJNH2a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 03:28:30 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:15542 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhJNH2Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 03:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634196381; x=1665732381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WxuhAGIVqe9v2R3ZyelOWDi7CHT04MYAzY0b5QLN2qc=;
  b=lsO538LUNQmB4IeD5TGa8LWNB0Vwc9dZnVGGIqOyQYlVYkj49s4PCmxz
   /UsJxvS67EmonjeeNG6p68Cn+Yk/NTbQK+aRuECe2KVpiC1TdDo+fl8ie
   EoDSdfaUBSTmcU9X2gW5r/BsqM80J5m20YoQZHSlz6/FtoCAIHzlP4iqo
   6Oa9GM2vK1EZ9GQ+4oh1MlpL/hsYm+Pnd3qRZuAxYSY10AI0ARMBun7D3
   E2lFTpFX4TkPrP8KfsckP72O21Mb0/Gna1pUKppE404koQwXjqTd6ciPP
   crIuzcUNwdj/S3839+KdX74J/azpB9PYUbYbSAIBHukvAPBJ08BPbuAAn
   Q==;
IronPort-SDR: 0BAYzRjLsp3W/Yl/KBsUVvdeKO0DuJgpEOmh/+ji1UTI1A3Qvca4xaeeoXb1MLxA3XJnUold21
 QjDZAa9bwOB4yFHmIWNuof4QXcR0LsQkgZ+dX9QwKrbRnVqsdi9oSh70I7c1/ZParg1trkzxD2
 2IvFAjIXZqxwXOu1pCDPC7RPZcGcvvYCZo8OEceH+pQ/+GMzuUEjr3cnCn1gKM+Wt+llEMaAi2
 AKagRrveziLr8i2xa6vG6x9AyUJcP60B369K2aaR198cNR9XdWJIISttH35E1iGWroz9GF0iFn
 ThutRPuRB05jt/3Zoxz/6Huz
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="140250737"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Oct 2021 00:26:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Oct 2021 00:26:19 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 14 Oct 2021 00:26:18 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH v2 3/5] PCI/switchtec: Update the way of getting management VEP instance ID
Date:   Thu, 14 Oct 2021 14:18:57 +0000
Message-ID: <20211014141859.11444-4-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014141859.11444-1-kelvin.cao@microchip.com>
References: <20211014141859.11444-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

Gen4 firmware adds DMA VEP and NVMe VEP support in VEP (virtual EP)
instance ID register in addtion to management EP, update the way of
getting management VEP instance ID.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/pci/switch/switchtec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 5c300ff3921d..97a93c9b4629 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1133,7 +1133,7 @@ static int ioctl_pff_to_port(struct switchtec_dev *stdev,
 			break;
 		}
 
-		reg = ioread32(&pcfg->vep_pff_inst_id);
+		reg = ioread32(&pcfg->vep_pff_inst_id) & 0xFF;
 		if (reg == p.pff) {
 			p.port = SWITCHTEC_IOCTL_PFF_VEP;
 			break;
@@ -1179,7 +1179,7 @@ static int ioctl_port_to_pff(struct switchtec_dev *stdev,
 		p.pff = ioread32(&pcfg->usp_pff_inst_id);
 		break;
 	case SWITCHTEC_IOCTL_PFF_VEP:
-		p.pff = ioread32(&pcfg->vep_pff_inst_id);
+		p.pff = ioread32(&pcfg->vep_pff_inst_id) & 0xFF;
 		break;
 	default:
 		if (p.port > ARRAY_SIZE(pcfg->dsp_pff_inst_id))
@@ -1553,7 +1553,7 @@ static void init_pff(struct switchtec_dev *stdev)
 	if (reg < stdev->pff_csr_count)
 		stdev->pff_local[reg] = 1;
 
-	reg = ioread32(&pcfg->vep_pff_inst_id);
+	reg = ioread32(&pcfg->vep_pff_inst_id) & 0xFF;
 	if (reg < stdev->pff_csr_count)
 		stdev->pff_local[reg] = 1;
 
-- 
2.25.1

