Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939673EA016
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 10:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhHLICy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 04:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234118AbhHLICv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 04:02:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84EFA61058;
        Thu, 12 Aug 2021 08:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628755345;
        bh=JgWDoQUrKOFUwGiM7gGufcT0bw/BUsf7qXoxA1UbGIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fbz8IkkxZVz91HWP9Vuty9YnN7ON9wM+nzeZGsZD1kfayGQo2Nxi41j3kvJ58CUzG
         /lHQ8rKBz5wS2oQZpsVAJolDWdlLGvuvWrROC5s9RpI1iAZSclg8lLpIr2N3l9u+nq
         G5IIQVakXK4c0eMui4BwGGwtSVbwy14O2XXxoTZY45vgByg3C+pl1/MF1Y10M118c8
         KN6Rm6pUORfD18greds4RLOZMXMw18nI7DKHLgucuNt5z0O78YdfYJPet/wI0OBFKT
         5rpeGku3p1lNWDxryBKLHLDsQHrRt1IrLGitsvV2+UEZrVsIfoC/wNjpUvH1KrCEgH
         bLbT5k2p4/uPw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mE5fT-00DZD7-Rr; Thu, 12 Aug 2021 10:02:23 +0200
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
Subject: [PATCH v11 07/11] PCI: kirin: Add MODULE_* macros
Date:   Thu, 12 Aug 2021 10:02:18 +0200
Message-Id: <c3a0b498954d4cf3bcee14b0314de7ee274b3370.1628755058.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628755058.git.mchehab+huawei@kernel.org>
References: <cover.1628755058.git.mchehab+huawei@kernel.org>
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
index 4f4c86b92353..d5c29a266756 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -804,3 +804,8 @@ static struct platform_driver kirin_pcie_driver = {
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

