Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33B4435F8D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 12:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhJUKr6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 06:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231129AbhJUKry (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 06:47:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A978C613A3;
        Thu, 21 Oct 2021 10:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634813138;
        bh=gRzjZR2i3+PX8QmmnpFooG4PYPyeUIKfI68izIx0rcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=awd0UBwc4sT/qWLw4vsMner260mTCeEAuC3MVS4/ktoSKEc/EMiX8tNWQPuha4X5v
         kweP1lCu2o+8crHQPqGR88ldwhQ+yhLn3RRGjnxu3lzrNDz+Mdg+d8wjdCm1CT5KA/
         1JFayfSNan3M2vNRRRWjMBsBM6J0lWc9WsPkpxT5kYjSCxFJMvhYBWYen6Z6GMy7xe
         muC7NZp6NqG4lpn9/G98DLeqqAVEHO8vfPSB4HvqoiJIxn+G3ltXG0f5gBEmDfK7dS
         uBCe0bovjYozfpkH1AcZp3j4OJYoWpcNGBMuQUom8m+iMIkQNmBwxTqw6iGaCf2DLR
         dfOVfZ579mrBw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mdVZj-002z5B-4W; Thu, 21 Oct 2021 11:45:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
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
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Xiaowei Song <songxiaowei@hisilicon.com>
Subject: [PATCH v15 08/13] PCI: kirin: Allow building it as a module
Date:   Thu, 21 Oct 2021 11:45:15 +0100
Message-Id: <b5e7cfe9df09b492750bd6db0f0c911eaae8c2d4.1634812676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634812676.git.mchehab+huawei@kernel.org>
References: <cover.1634812676.git.mchehab+huawei@kernel.org>
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

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v15 00/13] at: https://lore.kernel.org/all/cover.1634812676.git.mchehab+huawei@kernel.org/

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

