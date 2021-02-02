Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D99E30BF61
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 14:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhBBNap (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 08:30:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhBBNam (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 08:30:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7BBC64F45;
        Tue,  2 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=AH432J4B7ZDZZSd0PksUuJcGVmlwemb+J6aFQtCeJ8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=urcf2yeHU1lygxszS/epnxF/w1NsCkpIfUSIzGodkmWwz/CJqrbqu85px6M1tSB+T
         xHfYq0dIsT0cLXTvypR4U8ZC7VTEpc2jfQQJCBzPe/gebS8atBZiM1TN3bOhSva4aM
         r02krnYVvuCiu2NKrywlLbIpFMMsWY1yjiANu787bL8Xlx8NY0oFKDAMZOq2xqSwIy
         Sl37NraJTwaHv4ZY40jfmdBMflvKKule2AxYJJwYIcQJaH26rYwOaHmK1iEgFAMKJx
         vgcXBLUObG3FHj92rwKoSHt+LixBVAJTVeik6k4aPJdVLwXT7OQ3xcDggAjE2suOAL
         ZwNtqjK+a9Bew==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011z5-P5; Tue, 02 Feb 2021 14:29:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 09/13] pci: dwc: pcie-kirin: allow to optionally require a regulator
Date:   Tue,  2 Feb 2021 14:29:54 +0100
Message-Id: <7f4abd1ba9f4b33fe6f66213f56aa4269db74317.1612271903.git.mchehab+huawei@kernel.org>
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

On Hikey 970, there's a power supply controlled by Hi6421v600
regulator that turns on the PCI devices on the board. Without
that, no PCI hardware would work.

As this is device-dependent, such regulator line should be
optional.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 2bce6e3750d4..42aea34dff4d 100644
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
@@ -295,6 +296,22 @@ static void kirin970_pcie_set_eyeparam(struct kirin_pcie *kirin_pcie)
 static long kirin_common_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 					   struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct regulator *reg;
+	int ret;
+
+	reg = devm_regulator_get_optional(dev, "pci");
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
 	kirin_pcie->apb_base = devm_platform_ioremap_resource_byname(pdev,
 								     "apb");
 	if (IS_ERR(kirin_pcie->apb_base))
-- 
2.29.2

