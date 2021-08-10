Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED23E57A2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 11:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbhHJJ4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 05:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239275AbhHJJ4K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEE1F610FF;
        Tue, 10 Aug 2021 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628589348;
        bh=TXJ1u7MVWN0FWVTPNy5JjGB30jYHeFOl74oKTqbFZYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXH2MZFLLbs2BDXg0mu1gOxAmCXSK1hfp75m5vSEuUt9ENArQK8GPjqB93n2cKIpX
         dTU0TyfYuM8fjmObjp0ZvLqiIH8X3vzbD/3kDLp3utekA2J5WgXGkcgogoub15CtD6
         fqMgj5FU3/8d1Ko8J1MKNKRiAlpvYGy89vd8fRuITMTB7CAvhiZgI7EEgVRzsb+lFA
         gnRoeys2pH4skqPUbq4l5s7IW5L+CYh3YJEtzgOCyHjCVF1KTqFLqCUOgP+wEdhaGs
         O3pGY6mOFQaueVM7fAr+/giY6jRe9SsRXW4WbYzCxUEp2L+s5x1YeK1QVJapXKpE0s
         sZOZoKCinwUXg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mDOU6-00AcG3-1Q; Tue, 10 Aug 2021 11:55:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Wesley Sheng <wesley.sheng@amd.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v10 08/11] PCI: kirin: Allow building it as a module
Date:   Tue, 10 Aug 2021 11:55:39 +0200
Message-Id: <c3d415b1b9b66ffaea3150fc3e73292dd8f3ad87.1628589155.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628589155.git.mchehab+huawei@kernel.org>
References: <cover.1628589155.git.mchehab+huawei@kernel.org>
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

