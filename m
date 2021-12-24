Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BE447EA35
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 02:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350708AbhLXBZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 20:25:13 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25932 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350649AbhLXBZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 20:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640309109; x=1671845109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wu5IURmBwZeW3y4oSE+nzpn5LdHJ/yuuFONebUzH3pY=;
  b=kjpUkkqfeIxRw4ZGpFji0DdbibsBhi3IlsdiGaB9nEyNdbbUNuumORnU
   GQXakSkPXxlZH7yhVvahyle1iGWfw5Q/GiItrBv08JZn9Br15f3w1eumS
   OS8BTiSR1HA8Yd1gqHni8o19lgzw3zkLdXzXby2mSrFGu/PsgTiKlO7zh
   7rIBF6XeAB2QllsWjBCRmdB/P4c/uBaN87HpS/bT9urr1yM/TOWL6DcMo
   iFIqtKXRwQ7AgPZgU3ToCQVlmW63RVe5seo8vyTX9WRyMBup/g3s8e3u+
   bX4GIr9iU1a5w8g93Tq4J0NQ53HJvHxaN+eEcre9XkG+5hPIg/beWkuzU
   Q==;
IronPort-SDR: E/zcbyMnMFuwNuUq0taYrhkGjjVLQ1MBCYrKzui2gwba1TRoQbpqMLfXujojIgC3LnNpnZB5Op
 sPYR8XydPIt5jp+0T5RHCqXhRKqNWcj89xYrOznzk/Z1BkCmkzcaiGl+l1L97DnUKPlScoWA4m
 O6y5/8XL3k49/okNGo3wx+qVwIpVQ4mqqjsWGc9cUUVEALodqwDZNggSNxuTGOOr/3H0WanmHz
 BS1RihxjQ5NdC4L2bBJOb/p+7KfCqQUpanhIQts2HvvwZ1QakvbDkFvyHPSo0POJwIK6bLq42D
 lDvaK3+BqsCn4XXMHIZvWsRz
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="80533989"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 18:25:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 18:25:07 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 23 Dec 2021 18:25:07 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-ntb@googlegroups.com>, <linux-kernel@vger.kernel.org>
CC:     Kelvin Cao <kelvin.cao@microchip.com>, <kelvincao@outlook.com>,
        "Jeremy Pallotta" <jmpallotta@gmail.com>
Subject: [PATCH 6/6] ntb_hw_switchtec: Fix a minor issue in config_req_id_table()
Date:   Thu, 23 Dec 2021 17:23:34 -0800
Message-ID: <20211224012334.89173-7-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224012334.89173-1-kelvin.cao@microchip.com>
References: <20211224012334.89173-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The req_id_table_size field is 16-bit wide, use ioread16() to read the
value.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 0e33eef64ec6..189faad0d0d5 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -955,7 +955,7 @@ static int config_req_id_table(struct switchtec_ntb *sndev,
 	u32 error;
 	u32 proxy_id;
 
-	if (ioread32(&mmio_ctrl->req_id_table_size) < count) {
+	if (ioread16(&mmio_ctrl->req_id_table_size) < count) {
 		dev_err(&sndev->stdev->dev,
 			"Not enough requester IDs available.\n");
 		return -EFAULT;
-- 
2.25.1

