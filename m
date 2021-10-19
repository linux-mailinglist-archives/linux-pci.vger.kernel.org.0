Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B4C432DC3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 08:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhJSGJN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 02:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233986AbhJSGJH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 02:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F0CC613A6;
        Tue, 19 Oct 2021 06:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634623615;
        bh=hLEq7+OQ/uMwGAS4T3XnUMjJocDtk40l6CypKplJ3JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LuRU7PHEhngRy+QXUqk2jEJxwwP+P3ttddQ3/2X5dRUb/eKGSwYaMWvAuOZJ6QIAw
         ImQ2p1x30sMLhI+QtzpDFYs4woy+Z9Ns9ON+UXJYaoCCnhPjwf9VM8UKpHPDaXPY6g
         NVies2fVW8XyxefdSoiuQkaHQENozvDXCr6EcwJGmo0LJ3ty6Ic/6lW0ll0pPc2kSu
         lAo7jdeHS1m9ynAIRuGRFEvQjgJ8fb6D3MqDPHLaH6ALELoKhTg6dWjXO6/3ZPhgr/
         /J5cj1juXyCttfgNfLDvinZdG/LYfizX6CP+DWYnM4FA4HgZSHLxU6GqabH8IPd2Ci
         nAaB2KfaWV1vw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mciGx-001krt-SS; Tue, 19 Oct 2021 07:06:51 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Songxiaowei" <songxiaowei@hisilicon.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>, Simon Xue <xxm@rock-chips.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Wesley Sheng <wesley.sheng@amd.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v14 08/11] PCI: kirin: Allow building it as a module
Date:   Tue, 19 Oct 2021 07:06:45 +0100
Message-Id: <33e7df9253c0fc9b0ff0672e1a83062a84b820b5.1634622716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634622716.git.mchehab+huawei@kernel.org>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's nothing preventing this driver to be loaded as a
module. So, change its config from bool to tristate.

Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 071a1fb12beb..62ce3abf0f19 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -274,7 +274,7 @@ config PCIE_KEEMBAY_EP
 
 config PCIE_KIRIN
 	depends on OF && (ARM64 || COMPILE_TEST)
-	bool "HiSilicon Kirin series SoCs PCIe controllers"
+	tristate "HiSilicon Kirin series SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
-- 
2.31.1

