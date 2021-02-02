Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EE830BFD0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 14:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhBBNmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 08:42:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232321AbhBBNbZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 08:31:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E058364F66;
        Tue,  2 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=ezNQ33gqeTJQlThS5T6ajxdq1pnm4VEvay3F+5RFye8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOlcAydoxHp9DQ4ujW5nUImaRK4VEO1n0sTAkyhibsDc0TBup3S7WrN+YyGQMuJIC
         TBdKNp/Nz2NewPNABpGzEngsnlj/e4I7kQpzEIUSlet8/0/XsxcqmPZkGpTgIU6Nyw
         4S18cU23hkeKqXCbnXLSQLeYt1+NJtAbDUVL8jD6zR0bjHlHxuHIvgVssBR7IxRYQf
         mbNv679ohAPvgn5MLAXclLYs00xLGaQNgSrJW+euXcAq4W0lW37u5rXZ1oy+DgC9OC
         fHmh5zS2XP8i8F5FLGrFuNXqZ+5OeHt/9DLDsmfgdyGOlijCCLLM4u5LEIbsU/lIqH
         HWTtwxXh/AM3w==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011zD-Sz; Tue, 02 Feb 2021 14:29:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 12/13] pci: dwc: pcie-kirin: cleanup kirin970_pcie_get_eyeparam()
Date:   Tue,  2 Feb 2021 14:29:57 +0100
Message-Id: <e543536db7bb8c5e3551859c329a86a493700bd9.1612271903.git.mchehab+huawei@kernel.org>
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

Cleanup the routine, to let it clearer that eye_param is
optional and that, if not specified, the driver will assume
the default.

While here, also drop the useless debug prints.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 37b964386d21..769110b39302 100644
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

