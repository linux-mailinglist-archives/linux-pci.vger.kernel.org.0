Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4143E051D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 18:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhHDQDY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 12:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhHDQDX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 12:03:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F8A760E97;
        Wed,  4 Aug 2021 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628092990;
        bh=KqC1eKH6wetvp4xklgFSpVBWpzSCXRAM4eNnU6SKrR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PyYUx5sh+i11NVdj7xor/5PryNwYFoHruGfzkAjz4BLM7AoggK1gnIUHAghSYWJ5o
         vyZIkoHvmCOj4COj8BkIKSAEQv4/oet2GkDL1FiwiKMJCw0UmlouXaVDAZwuI2rPgn
         NMeJjSnSy3gpKtskmJFSVLoeebI5DTFNa6LBfSSx0aQzheQegbWqc5fg6e8vZcLfQO
         wbmJKxJfZ9nJMg5+h/9GCSowzhxlbe5u32IoHgYtmn1+V89XjEfR+sh0SPPyvx4dde
         xUEh7ZHbJugdjOfASgbJ4R18XzXHMcBoS9IRc5LEBeFF/JlhCiG1yjlhoea23axr0b
         iq4cxUJwsrarg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBJMK-000Pzj-Kn; Wed, 04 Aug 2021 18:03:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v9 07/11] PCI: kirin: Add MODULE_* macros
Date:   Wed,  4 Aug 2021 18:03:03 +0200
Message-Id: <a920feb6d06bc96dace9e756b4432814b48b6668.1628092716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628092716.git.mchehab+huawei@kernel.org>
References: <cover.1628092716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This driver misses the MODULE_* macros. Add them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index bf69ad070093..dbd45896920f 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -806,3 +806,8 @@ static struct platform_driver kirin_pcie_driver = {
 	},
 };
 builtin_platform_driver(kirin_pcie_driver);
+
+MODULE_DEVICE_TABLE(of, kirin_pcie_match);
+MODULE_DESCRIPTION("PCIe host controller driver for Kirin Phone SoCs");
+MODULE_AUTHOR("Xiaowei Song <songxiaowei@huawei.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1

