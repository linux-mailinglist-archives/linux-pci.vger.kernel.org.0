Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0405680C5
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2019 20:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfGNSkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Jul 2019 14:40:39 -0400
Received: from endrift.com ([173.255.198.10]:49514 "EHLO endrift.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728125AbfGNSkj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 14 Jul 2019 14:40:39 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jul 2019 14:40:39 EDT
Received: from diardi.hsd1.ca.comcast.net (c-67-180-122-246.hsd1.ca.comcast.net [67.180.122.246])
        by endrift.com (Postfix) with ESMTPSA id E6D5CA2D1;
        Sun, 14 Jul 2019 11:33:16 -0700 (PDT)
From:   Vicki Pfau <vi@endrift.com>
To:     linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Woods <brian.woods@amd.com>
Cc:     Vicki Pfau <vi@endrift.com>
Subject: [PATCH 2/2] hwmon: (k10temp) Add PCI device IDs for family 17h, model 70h
Date:   Sun, 14 Jul 2019 11:32:09 -0700
Message-Id: <20190714183209.29916-2-vi@endrift.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190714183209.29916-1-vi@endrift.com>
References: <20190714183209.29916-1-vi@endrift.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI device IDs for the new AMD Ryzen 3xxx (Matisse) CPUs to k10temp,
as they function identically from k10temp's point of view.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index c77e89239dcd..5c1dddde193c 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -349,6 +349,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
-- 
2.22.0

