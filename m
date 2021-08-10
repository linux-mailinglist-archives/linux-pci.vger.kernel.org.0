Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363063E579A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 11:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbhHJJ4M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 05:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239274AbhHJJ4K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB3C26109E;
        Tue, 10 Aug 2021 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628589348;
        bh=N9/YcIenJR/XOmZm6Zglqx5lf0VytJltRDOLZ++zXHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tn5beqWtzdxlPHHWwCs+1zEctk1P2UXy9OtVowZ24OcWHfBVPpYd+SaH9TBaa0FGL
         sbK7NhAKDifwff2FfaqAuVMWw5/jiPjZeQn8+NuF+K4Bho0WSocFfX4qnChDobo/0H
         YF4RBFwGnGeLBZSeeIOrs0BYRetIUPME/CniQouhLYiKD20/GS0jnon/ssxwMWNlPI
         3kKHynn7tlRU9ir6mKMwT9ocRXMQxpkSl8689zvtBHaBtfJ0M3yCyDK6e6aV0RujhT
         T9G5bcwL9bMdko22Db2XXhGM5FRCPuu/SLWk2J2Hej7HJvxGnTUqBJ599kBmE9WfO5
         UOTKXliohVOsw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mDOU6-00AcFz-0S; Tue, 10 Aug 2021 11:55:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v10 07/11] PCI: kirin: Add MODULE_* macros
Date:   Tue, 10 Aug 2021 11:55:38 +0200
Message-Id: <b2f7344594662c41c7130ed52334029eef9f53ca.1628589155.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628589155.git.mchehab+huawei@kernel.org>
References: <cover.1628589155.git.mchehab+huawei@kernel.org>
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
index 306d440e1b62..218b90ac93dc 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -802,3 +802,8 @@ static struct platform_driver kirin_pcie_driver = {
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

