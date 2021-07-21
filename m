Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B072E3D0D7B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbhGUKnL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 06:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238793AbhGUJeq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 05:34:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5DC46121F;
        Wed, 21 Jul 2021 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626862523;
        bh=TXJ1u7MVWN0FWVTPNy5JjGB30jYHeFOl74oKTqbFZYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsOgGDejJPd7YSI26Pni+5+GVuK3sfotExMnI7ne5Us+IPOWbkv3rb0HxBDqw6XKl
         6OEqOEpwsu08/DWDPIlnqnTaG2Xcg5wlRd3pMOuE+NHtoqqRDnOYk0aWSd/n1hLOeb
         RPj7ncmQ4fvK9U9vmvLvN/GmySO5P9LcACdhcgmdzHbnc4iJwimHYtEPSKy1gWoTWz
         nlsiaZ61trfZAKuXifXUV3/fYlS70AvJoFv2/x0x82TqpTnA+BgWszZrfJOFoUf2I+
         J1sUeaQ4Xz11vOGmyP4zY76rnIm9dHi9yxPOZ4QeMx2080iU2B2ZI28l8JRJ9MxEI1
         nehxTCjOEhyzQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m69G5-002565-D1; Wed, 21 Jul 2021 12:15:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Henry Styles <hes@sifive.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Wesley Sheng <wesley.sheng@amd.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v7 11/10] PCI: kirin: Allow building it as a module
Date:   Wed, 21 Jul 2021 12:15:17 +0200
Message-Id: <8dbdde3eda0e5d22020f6a8bf153d7cfb775c980.1626862458.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626855713.git.mchehab+huawei@kernel.org>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
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


