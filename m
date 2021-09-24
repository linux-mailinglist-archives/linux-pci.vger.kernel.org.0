Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB030416ABC
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 06:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244080AbhIXERZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 00:17:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3740 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244056AbhIXERY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 00:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632456951; x=1663992951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EEYOkUC0z0v7W7yWDZPlUNJfWbsPw8Zsm21yaRlvfIc=;
  b=R1xlAVPY7JghyAHt9/kkzeseJMnoxBnXmXGTILshkwwEc6JTELT5ew62
   ROAgoywkhCmX8nEHFBv5ZyDkBxPQVhuy3Wx+1t4s/8IZYYWANErBt6oRt
   cAirsfc6fh3q8+xiLldtXhvqX8NL/wCrrB8FTBoP6WS3PLh/rfvR6kk5Q
   O5UJBG2wPRB68y66d6K5YLlz3esa/8vsPojigmmypE8RfyRj/i7jhlCZ4
   0xCH/gktsKp8vRbSaxdpY5RKdwaaJmd4E/HqHaNtkZrZfAvEGt3Euxte2
   RuACh6aVbJpJUT+mL8iZXLKCjvY6ffAV5hy5XsXXOlRHVhaO8WWG85J+I
   A==;
IronPort-SDR: UgjGFEoN9KWaEl4Cengmt8HjZNwwKKYpEGDHt89BQb2tQT8DYKuz0MPHpmwmbIJ5WOy681A3qa
 FbrP4w0ZE/bQuy+Awg4bKZDbDLX+14HtgT0NOhep9TQ3Yhxq7eXjRw6I5PGFfAP6iiUma1mLJd
 ZQVv1noj4mpRTow8DVIbcNtC6krA6jbCkZeArp7VwT3jG+oPrwG0DMS9GHVr0FRiC6m73Bm3t3
 gFwYMgk1m42zKTvVVGqFCi+QsEYj1+raz5w6f2c7Dcv1i0Vrh8nxYvvK+qzTDJk01JwijbECu/
 mXoJErJxWO3ZRbau/uODpoKh
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="130437088"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 21:15:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 21:15:51 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 23 Sep 2021 21:15:51 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 3/5] PCI/switchtec: Update the way of getting management VEP instance ID
Date:   Fri, 24 Sep 2021 11:08:40 +0000
Message-ID: <20210924110842.6323-4-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924110842.6323-1-kelvin.cao@microchip.com>
References: <20210924110842.6323-1-kelvin.cao@microchip.com>
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
index 76f14ed15445..b76094e2c885 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1125,7 +1125,7 @@ static int ioctl_pff_to_port(struct switchtec_dev *stdev,
 			break;
 		}
 
-		reg = ioread32(&pcfg->vep_pff_inst_id);
+		reg = ioread32(&pcfg->vep_pff_inst_id) & 0xFF;
 		if (reg == p.pff) {
 			p.port = SWITCHTEC_IOCTL_PFF_VEP;
 			break;
@@ -1171,7 +1171,7 @@ static int ioctl_port_to_pff(struct switchtec_dev *stdev,
 		p.pff = ioread32(&pcfg->usp_pff_inst_id);
 		break;
 	case SWITCHTEC_IOCTL_PFF_VEP:
-		p.pff = ioread32(&pcfg->vep_pff_inst_id);
+		p.pff = ioread32(&pcfg->vep_pff_inst_id) & 0xFF;
 		break;
 	default:
 		if (p.port > ARRAY_SIZE(pcfg->dsp_pff_inst_id))
@@ -1545,7 +1545,7 @@ static void init_pff(struct switchtec_dev *stdev)
 	if (reg < stdev->pff_csr_count)
 		stdev->pff_local[reg] = 1;
 
-	reg = ioread32(&pcfg->vep_pff_inst_id);
+	reg = ioread32(&pcfg->vep_pff_inst_id) & 0xFF;
 	if (reg < stdev->pff_csr_count)
 		stdev->pff_local[reg] = 1;
 
-- 
2.25.1

