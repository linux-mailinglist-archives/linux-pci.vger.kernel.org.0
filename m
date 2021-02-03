Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0954530D3B4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 08:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhBCHDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 02:03:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232012AbhBCHDY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 02:03:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 792C864E30;
        Wed,  3 Feb 2021 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612335720;
        bh=4knJo6OkRBqQrTR3UVhhAX+TpSaav9x8tCsbL69SdgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngLI2w461tDcIne3RSvMw0lQtKF989ppIZFq3V28daW4JQJPpye4OFF3+figBnpb0
         0X8US8qw/bACXvBQHvkkXNdKW6EGOf+y1b9MFK9UxdH/KdAo5CiMwniKKpLknxa8jq
         YNjNiOn/HwLKfz2+PeeV/5ovLKHuJ3bDHwqJ6XGwPeLPZynxwnSSnYuSXRK4sb0Kho
         ruCohXIFQVGP9SKRX1cxY9J5/zTK7/tZLkjWRriL7FDAc4qzjHfNRS6Jxonu1DrFWP
         Q4eR+mHh53232YVGdy6l3Ule3UtSFleQ+qKki6omhiQJLkMSGt5hdx7bztbEDdgbGg
         AQiqovtODnMqA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l7CAo-001CAn-AU; Wed, 03 Feb 2021 08:01:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 11/11] pci: dwc: pcie-kirin: cleanup kirin970_pcie_get_eyeparam()
Date:   Wed,  3 Feb 2021 08:01:55 +0100
Message-Id: <1584b35df936f50bb3187c233b9110c53652a518.1612335031.git.mchehab+huawei@kernel.org>
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

Cleanup the routine, to let it clearer that eye_param is optional and
that, if not specified, the driver will assume the default.

While here, also drop the useless debug prints.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index c5404f1eca28..88f10aff8b09 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -246,21 +246,18 @@ static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
 void kirin970_pcie_get_eyeparam(struct kirin_pcie *pcie)
 {
 	struct device *dev = pcie->pci->dev;
-	int i;
 	struct device_node *np;
+	int ret, i;
 
 	np = dev->of_node;
 
-	if (of_property_read_u32_array(np, "eye_param", pcie->eye_param, 5)) {
-		for (i = 0; i < 5; i++)
+	ret = of_property_read_u32_array(np, "eye_param", pcie->eye_param, 5);
+	if (!ret)
+		return;
+
+	/* There's no optional eye_param property. Set array to default */
+	for (i = 0; i < 5; i++)
 		pcie->eye_param[i] = EYEPARAM_NOCFG;
-	}
-
-	dev_dbg(dev, "eye_param_vboost = [0x%x]\n", pcie->eye_param[0]);
-	dev_dbg(dev, "eye_param_iboost = [0x%x]\n", pcie->eye_param[1]);
-	dev_dbg(dev, "eye_param_pre = [0x%x]\n", pcie->eye_param[2]);
-	dev_dbg(dev, "eye_param_post = [0x%x]\n", pcie->eye_param[3]);
-	dev_dbg(dev, "eye_param_main = [0x%x]\n", pcie->eye_param[4]);
 }
 
 static void kirin970_pcie_set_eyeparam(struct kirin_pcie *kirin_pcie)
-- 
2.29.2

