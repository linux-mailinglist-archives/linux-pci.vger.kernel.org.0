Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE342435F87
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhJUKry (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 06:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhJUKru (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 06:47:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED86F61213;
        Thu, 21 Oct 2021 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634813134;
        bh=G+b584k4tQ2fwQ3W1w2eccdVGaOwa88+od2/2SHzSWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcInEMA7hEXIKyTYrkM556DcXiVzD16UwAqKHOkSKMKgK0yCOR3buGMvLIQFjdgj1
         Q7bss6AQunAN7kGKNT9Cc3WsZM+JnZsQ5rr/QZ7qZMQIQ/eRbcQY6L+UJ4renUKcSe
         1UZpsGl8DBJJcDlaLF77qenoSsjo8ih5hrpcCIYCqZHGOZc8vj9gl4d06uFi8oiq3U
         VllcP1gE3JgIO0oD9ZQttuuINq9ryFJ+fK9U+RnMAFokNu11jLKelEpScWeYy6/7XJ
         ws9SwQd8Ldn9OaJ3PWuCpeMDGgeR38NUH+Xgxf1z7bCPmsOr/FgwLSJjbDMwSqfYsb
         KPR89UByUOqtw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mdVZj-002z5Q-89; Thu, 21 Oct 2021 11:45:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v15 13/13] PCI: kirin: Allow removing the driver
Date:   Thu, 21 Oct 2021 11:45:20 +0100
Message-Id: <53b40494252444a9b830827922c4e3a301b8f863.1634812676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634812676.git.mchehab+huawei@kernel.org>
References: <cover.1634812676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that everything is in place at the poweroff sequence,
this driver can use module_platform_driver(), which allows
it to be removed.

Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v15 00/13] at: https://lore.kernel.org/all/cover.1634812676.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index fea4d717fff3..cdf568ea0f68 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -827,7 +827,7 @@ static struct platform_driver kirin_pcie_driver = {
 		.suppress_bind_attrs	= true,
 	},
 };
-builtin_platform_driver(kirin_pcie_driver);
+module_platform_driver(kirin_pcie_driver);
 
 MODULE_DEVICE_TABLE(of, kirin_pcie_match);
 MODULE_DESCRIPTION("PCIe host controller driver for Kirin Phone SoCs");
-- 
2.31.1

