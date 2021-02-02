Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A258D30BF71
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 14:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhBBNbC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 08:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231667AbhBBNan (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 08:30:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD8AF64F5E;
        Tue,  2 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=4gFTxbD8NGyOTtlIIHu+xGitdIxhXiStTHAdYZ5nKqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGXwZfzTvBnJHo9rS+xLZejT5Gkiqa9j0iAdqH7VYxTgJ1qV35K99pSAH7PJYVQk2
         I66ShXK9ezA3B67CndWUOLRRyeAmUhSNeqWS3jujnlGoF+GXLpSaX1ZvpFHaocl+nW
         d8U2uBoCefUwJL9xbEK4oWSLH/je8qSNoyHoi20IuM5Hvw1LUeqc0r6SIBxMpK1ZsM
         bwAZXeG7mR6HUBUru2QLy8GcCdascsc2BxoyPLzNdtuc/v1fvW2tCsDQMBa/WGmril
         tWtaUSNDyAT7MrdCzlM0zXMZksVycBU4WI9E8TRHqDhJ/ZZoWuV2/eJ4/8ZQXUrYsa
         2I8gqJIvnv99w==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011yx-Lg; Tue, 02 Feb 2021 14:29:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 06/13] pci: dwc: pcie-kirin: simplify error handling logic
Date:   Tue,  2 Feb 2021 14:29:51 +0100
Message-Id: <e277e765c3c1e36f3b98825810ed3f4280993c1c.1612271903.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612271903.git.mchehab+huawei@kernel.org>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of returning -ENODEV when of_get_named_gpio() fails,
make it return the actual error code.

With that, there's no need anymore to check for -EPROBE_DEFER
at kirin_pcie_probe().

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

