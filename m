Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A67A30D3C7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 08:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhBCHFa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 02:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232034AbhBCHD0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 02:03:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 713CE64F7C;
        Wed,  3 Feb 2021 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612335721;
        bh=MMNo+h3HEqIoqHzAyjt4M5/YBbQxBfZXIFkLGwOoWfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZB4TT+DYLy810UDcivav4AxNXtzTUSCSHk+qpJ4JrjlhfHBlnePtsImAdPVSefl+
         94TMiVZhtsLeRsksWM1ucqBRfFlXHhuv6D8hd+tOP/9I3TRuMoT+mw4zgZnxdP2w4U
         XlIg+cyLwbw0flSutndMnhVtqp6pQ6YOt+qrEEODRktMbf0S0POrm3xw0Ufv2kFmGt
         x2Bs8YB1DfZ9GkuSdyVBwggSplPfvbUIxwOJS7a1s7uCy3yV1hSmL7Od4c93eDCilm
         cVbW6txQVlVgeWEzlKF2ILYs2T3jgjdafphb4BlFMAJnND7T9me2H/3SoClSUAZQir
         yZgPqx0MWvEvw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l7CAo-001CAf-7r; Wed, 03 Feb 2021 08:01:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 08/11] PCI: dwc: pcie-kirin: add support for a regulator
Date:   Wed,  3 Feb 2021 08:01:52 +0100
Message-Id: <f2ddbc72b378bd28cc249da6e3135c7d7bad5af4.1612335031.git.mchehab+huawei@kernel.org>
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

On Kirin 970 designs, a power supply is required to enable
a PCI bridge and other components of the board.

For instance, on HiKey 970, the Hi6421v600 regulator provides a
power line (LDO33) which powers on the PCI bridge, the M.2 slot,
the mini PCIe 1x slot and the Realtek 8169 Ethernet card.

Without enabling such power supply, the PCI resource allocation
fails.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 2bce6e3750d4..005fc4c2ad7f 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -22,6 +22,7 @@
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/types.h>
 #include "pcie-designware.h"
@@ -335,8 +336,21 @@ static long kirin970_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				      struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct regulator *reg;
 	int ret;
 
+	reg = devm_regulator_get(dev, "pcie_vdd");
+	if (IS_ERR_OR_NULL(reg)) {
+		if (PTR_ERR(reg) == -EPROBE_DEFER)
+		    return PTR_ERR(reg);
+	} else {
+		ret = regulator_enable(reg);
+		if (ret) {
+			dev_err(dev, "Failed to enable regulator\n");
+			return ret;
+		}
+	}
+
 	kirin970_pcie_get_eyeparam(kirin_pcie);
 
 	kirin_pcie->gpio_id_reset[0] = of_get_named_gpio(dev->of_node,
-- 
2.29.2

