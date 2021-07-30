Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2E3DB658
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 11:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbhG3Juj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 05:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238330AbhG3Juc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 05:50:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81EF561042;
        Fri, 30 Jul 2021 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627638628;
        bh=TXJ1u7MVWN0FWVTPNy5JjGB30jYHeFOl74oKTqbFZYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QqtoT2JiyID1/+6+xjTqJN6hlnUPCE37fqEb82oBSJX8Cp20A6UlOfA248EhckKNL
         Q+pMyNRhYVedbvhii1WDMv3S8LAqcYaULgbmZO6xdkdmnmKYSF+JN9YWsBE8396CoB
         YuL6JvvfzwnRTOJ2GdFARnV2kv3y/nWfmL85P641EiIPD+ePx6UevA5rnLNnQTkBln
         ChQYksrZ/fEgH8ljdPmO9COuhBzCOO0v5y1pEQiUQdGqykn6TvgmVtu0ihcAMcF+/1
         M2SL8RHYpHqB0d70g4ZYH70C6WU+RNqjK50AaoO7tmzsS1NPOCptXOO7SB2EtB1ByH
         qMBKLCGiFh9TQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m9P9t-006s4M-GJ; Fri, 30 Jul 2021 11:50:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Wesley Sheng <wesley.sheng@amd.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v8 08/11] PCI: kirin: Allow building it as a module
Date:   Fri, 30 Jul 2021 11:50:11 +0200
Message-Id: <89f8eb8141ddc0d53872c87ef9c846d2e0536027.1627637745.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627637745.git.mchehab+huawei@kernel.org>
References: <cover.1627637745.git.mchehab+huawei@kernel.org>
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

