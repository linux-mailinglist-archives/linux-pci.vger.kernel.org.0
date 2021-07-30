Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714793DB656
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 11:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbhG3Juj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 05:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238333AbhG3Jud (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 05:50:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3E616109D;
        Fri, 30 Jul 2021 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627638628;
        bh=Z6BIJsdcYwnFuOM9ZkHExFNeqE4EIBKp7kCuktxqcXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYTzYbRk1LDcAudkz17VQp8UM7b+5bTWrIIrAe7/rpu1fvFrpGyd9ln/9vgjc7UwO
         YnqTb32+4uYsGvbHPEt7p6ccl50jMLOM67uuv08r9GRz42/4upgeLT5oR7jhqWnRJ6
         ptXfiixcua1cbDfYyf0Bl3R7GU1GucjCrRzYdLho/q/nZst5jkTbA1IvDxkCtYEuJU
         oNdphmYm7qiP36p/UAY7oxGexId2GRy3XIptC4ZF6cNz85bWbv+guPONzG/5KpSOSh
         FVOK2Rp5/F6NOPNmxtphIa1BdmAHrTGhzeetRJwf/KQHhkdN+8UAOUNpqSUPTEAwSV
         PPmUli8/PASGw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m9P9t-006s4Y-LI; Fri, 30 Jul 2021 11:50:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v8 11/11] PCI: kirin: Allow removing the driver
Date:   Fri, 30 Jul 2021 11:50:14 +0200
Message-Id: <9a482c476a0e99e3f9f4bc6ddb14890daf0b0fd0.1627637745.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627637745.git.mchehab+huawei@kernel.org>
References: <cover.1627637745.git.mchehab+huawei@kernel.org>
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
index bdf45d29cdc3..25aa840b0ee3 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -831,7 +831,7 @@ static struct platform_driver kirin_pcie_driver = {
 		.suppress_bind_attrs	= true,
 	},
 };
-builtin_platform_driver(kirin_pcie_driver);
+module_platform_driver(kirin_pcie_driver);
 
 MODULE_DEVICE_TABLE(of, kirin_pcie_match);
 MODULE_DESCRIPTION("PCIe host controller driver for Kirin Phone SoCs");
-- 
2.31.1

