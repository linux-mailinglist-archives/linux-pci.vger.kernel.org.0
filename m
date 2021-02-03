Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B6130D3C8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 08:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhBCHFb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 02:05:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhBCHDZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 02:03:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BBB864F6A;
        Wed,  3 Feb 2021 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612335720;
        bh=s0fWuTBl8hAo4L2qfW2NnlYEUKCtkScUbYwEi6kp9HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxV86Y/IpuUgUWybL8qRFzEO9IkHmm64Wrv19xHBVtFs8mK6n447N6yieivwpbHCl
         j23AP1npMuCjNkXvG1qixmLxsGnnESp3x52YUx1t1kadUOELiqUt66GgBX6XfAyGBk
         eFeHLa4fDaEKFLYBwUKA9ANI0GDZHDSTGTofxcwyczAdLtrpTAZiT7Xq+y0DeU6Jxk
         8fKSOuvE3IXQof3zaBmzEMAzXpEeI1uryPpimdaON47fDJXniZxJuiDBgNzw1mgbcm
         UVq12srYXOGTT1zCK7OZP1isYgIsBhB5+W9qqbuQ4FMubzDPknp5DhbibmdALJMUmY
         +m8K2dNxEGpVg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l7CAo-001CAZ-5N; Wed, 03 Feb 2021 08:01:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 05/11] PCI: dwc: pcie-kirin: simplify error handling logic
Date:   Wed,  3 Feb 2021 08:01:49 +0100
Message-Id: <6298de2ed4384c2a3f012e9dedc101ae5f184ab2.1612335031.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612335031.git.mchehab+huawei@kernel.org>
References: <cover.1612335031.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of returning -ENODEV when of_get_named_gpio() fails, make it
return the actual error code.

With that, there's no need anymore to check for -EPROBE_DEFER at
kirin_pcie_probe().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 5925d2b345a8..f46a51ffd2c8 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -320,7 +320,7 @@ static long kirin960_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 	kirin_pcie->gpio_id_reset[0] = of_get_named_gpio(dev->of_node,
 						      "reset-gpios", 0);
 	if (kirin_pcie->gpio_id_reset[0] < 0)
-		return -ENODEV;
+		return kirin_pcie->gpio_id_reset[0];
 
 	return 0;
 }
@@ -354,22 +354,22 @@ static long kirin970_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 	kirin_pcie->gpio_id_reset[0] = of_get_named_gpio(dev->of_node,
 						"switch,reset-gpios", 0);
 	if (kirin_pcie->gpio_id_reset[0] < 0)
-		return -ENODEV;
+		return kirin_pcie->gpio_id_reset[0];
 
 	kirin_pcie->gpio_id_reset[1] = of_get_named_gpio(dev->of_node,
 						"eth,reset-gpios", 0);
 	if (kirin_pcie->gpio_id_reset[1] < 0)
-		return -ENODEV;
+		return kirin_pcie->gpio_id_reset[1];
 
 	kirin_pcie->gpio_id_reset[2] = of_get_named_gpio(dev->of_node,
 						"m_2,reset-gpios", 0);
 	if (kirin_pcie->gpio_id_reset[2] < 0)
-		return -ENODEV;
+		return kirin_pcie->gpio_id_reset[2];
 
 	kirin_pcie->gpio_id_reset[3] = of_get_named_gpio(dev->of_node,
 						"mini1,reset-gpios", 0);
 	if (kirin_pcie->gpio_id_reset[3] < 0)
-		return -ENODEV;
+		return kirin_pcie->gpio_id_reset[3];
 
 	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[0],
 				    "pcie_switch_reset");
@@ -1148,11 +1148,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	kirin_pcie->gpio_id_reset[0] = of_get_named_gpio(dev->of_node,
-						      "reset-gpios", 0);
-	if (kirin_pcie->gpio_id_reset[0] == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
-	} else if (!gpio_is_valid(kirin_pcie->gpio_id_reset[0])) {
+	if (!gpio_is_valid(kirin_pcie->gpio_id_reset[0])) {
 		dev_err(dev, "unable to get a valid gpio pin\n");
 		return -ENODEV;
 	}
-- 
2.29.2

