Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F385741A9CA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 09:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbhI1HgN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 03:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239344AbhI1HgF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 03:36:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C6FB6127A;
        Tue, 28 Sep 2021 07:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632814466;
        bh=L5VBPXPF3a3+JuHK1TGXG2l1hFTKd7XTrWcbAK+XzsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTNhfm9CJaQDq9vy6VjA/m2g2IxvrB1Y+/B6JnWXt1Sy/KhXKn72GKKhUqkFf/9M9
         bu4i/1Uqk/f9JfEsk9TUjr4kUPEinFYLRqhpYivfk+6KSNL3v7Ts/kQ40jvUdTKhqR
         VmZokhhxEHTESUUecDwLKrXvFg4rUrkC4xwGlziTxPT21mKVoXMfkjhJT6ZwRdNhvn
         pWFXa13jQosvzcMI99QCFyjLnTnAjLv5WreYZpRZQ11dRDgeytrqr4GoVW5GdiwdM1
         NfJeFaVR6Unak6qNz46/lRahFFixTmDig4D7hxfLpFDqTGch9n8gZsQh6lHQlcrQGE
         QbhU+IRCtl3+g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mV7dA-000RQF-Qs; Tue, 28 Sep 2021 09:34:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v12 11/11] PCI: kirin: Allow removing the driver
Date:   Tue, 28 Sep 2021 09:34:21 +0200
Message-Id: <bfc8c93639f460e14d06bc5430140e99a8df6dd2.1632814194.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632814194.git.mchehab+huawei@kernel.org>
References: <cover.1632814194.git.mchehab+huawei@kernel.org>
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

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v12 00/11] at: https://lore.kernel.org/all/cover.1632814194.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index ffc63d12f8ed..efab2af093b6 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -828,7 +828,7 @@ static struct platform_driver kirin_pcie_driver = {
 		.suppress_bind_attrs	= true,
 	},
 };
-builtin_platform_driver(kirin_pcie_driver);
+module_platform_driver(kirin_pcie_driver);
 
 MODULE_DEVICE_TABLE(of, kirin_pcie_match);
 MODULE_DESCRIPTION("PCIe host controller driver for Kirin Phone SoCs");
-- 
2.31.1

