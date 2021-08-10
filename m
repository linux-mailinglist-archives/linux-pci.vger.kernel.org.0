Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D567F3E57A0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 11:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhHJJ4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 05:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239316AbhHJJ4L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 05:56:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F9FB610A7;
        Tue, 10 Aug 2021 09:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628589349;
        bh=/ntXjC0T/LfuRQkxXY7V2CnXziznXTVk99SyCyqh69g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6lbQWC6N3YuSJFnTmPdPQ4BggpPnj9vU9bqmrWabqkB9w52AXsitIQTAkzD3AhvT
         WPNjraM050QXi3ShOxQTSKRFYU/5XOIYkulOleY1n0NWRUaOUNJ19q0lCQvfrex8NU
         OICH8G9oWeyPTi7qWKLEQMAZvCPJgj65BqkBillENx4w6myqSt8vCJ9Dn1klv9kJUA
         KQUZqeMcvbY9olAJ7dyYvp0BRfCSJXazzB9c0TFxt0VldlJGr9iAjqFE2qggWz0azZ
         xlhHwBcwPZQPeMmuh0G2sBguRa70eAI25Z4Z+JEmuY5BxE2l3/2nxlA7xA2UNw93As
         M4VyWeiKBaICQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mDOU6-00AcGF-4L; Tue, 10 Aug 2021 11:55:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v10 11/11] PCI: kirin: Allow removing the driver
Date:   Tue, 10 Aug 2021 11:55:42 +0200
Message-Id: <22fc912a3e6c1c6c25c672eefad89bb21164ff6f.1628589155.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628589155.git.mchehab+huawei@kernel.org>
References: <cover.1628589155.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that everything is in place at the poweroff sequence,
this driver can use module_platform_driver(), which allows
it to be removed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 5535605ab1e7..7cbe434a3bd1 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -826,7 +826,7 @@ static struct platform_driver kirin_pcie_driver = {
 		.suppress_bind_attrs	= true,
 	},
 };
-builtin_platform_driver(kirin_pcie_driver);
+module_platform_driver(kirin_pcie_driver);
 
 MODULE_DEVICE_TABLE(of, kirin_pcie_match);
 MODULE_DESCRIPTION("PCIe host controller driver for Kirin Phone SoCs");
-- 
2.31.1

