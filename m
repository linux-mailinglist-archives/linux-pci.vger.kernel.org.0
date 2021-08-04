Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6790E3E0524
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhHDQD1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 12:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhHDQDX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 12:03:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F11C61037;
        Wed,  4 Aug 2021 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628092990;
        bh=TXJ1u7MVWN0FWVTPNy5JjGB30jYHeFOl74oKTqbFZYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcTRWo/BFHnDstSgp90vPSip/YvXHKAkmF5ZEmjOqXg+hXHeqnHRKFdhor33lX8qo
         NKwvC97f+pBcltcpDitEAEiyggHsxuGW1PwGeUBW+a6mhr/cS6w7tjw5efsLmsCRp8
         JAEWGBQ05sktmXjKVcKpGAi3PtiBpZfSezftWPOOXbq4rqidBj/nzq8N2afQ7vjvDr
         KI7S5MUbi0JKOgZ3GAoPOR0hEU4q8lVuzRLNy7IrZ4iv0tpnfBH3EcaQ1NMZLditds
         kK2AXROJKqnWHkQa1GRzDvWBZ4kEGNeeMi4UwzD+V1W2j5jjX+sovq1s5Oo8g5ErFa
         T8UTWvFh/mACg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBJMK-000Pzn-MU; Wed, 04 Aug 2021 18:03:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Wesley Sheng <wesley.sheng@amd.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v9 08/11] PCI: kirin: Allow building it as a module
Date:   Wed,  4 Aug 2021 18:03:04 +0200
Message-Id: <ccf1c30e2423e752ea89b0e72846e3894274af48.1628092716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628092716.git.mchehab+huawei@kernel.org>
References: <cover.1628092716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's nothing preventing this driver to be loaded as a
module. So, change its config from bool to tristate.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 423d35872ce4..e0091bfae5b5 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -227,7 +227,7 @@ config PCIE_INTEL_GW
 
 config PCIE_KIRIN
 	depends on OF && (ARM64 || COMPILE_TEST)
-	bool "HiSilicon Kirin series SoCs PCIe controllers"
+	tristate "HiSilicon Kirin series SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
-- 
2.31.1

