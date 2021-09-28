Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D8441A9C1
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 09:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbhI1HgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 03:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239318AbhI1HgF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 03:36:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E20F611CC;
        Tue, 28 Sep 2021 07:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632814466;
        bh=Ch4CkbGQ8MzEW98aDXUuR4Mk26ryuc9f5Yt2REp7dfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EH0vGTiNhrFEll+KhxOvlpy9tGmjnnwTFuAc+b7Q6uvcfipL3JgZl7yYt+nwvWBV5
         b2vyIIR2mxJokLeyNPk4fgfXF/j5TqudgmMoYIJ22xdlhl6bjzeObVtMLz6ArzotT0
         rX4pm+H62XM64FCRal5IiQiYtsRIv59nUfMdzIqOpqWV+mOs8mUjANoKyQmx+o+I+b
         V5X2Jx8++aGysKP3xCzoxDfhhn0DEyq+pl8lOMVFT9vj9wrQvuwYO6nmK+p1S76Ay9
         bfL2PVyft7f05+OJZisbXWBBwcp/oDSXpEdfXI03oQtklKjBuDQ1wOw/beR5L5o1DP
         QIHSKAZMZwFdQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mV7dA-000RPz-LF; Tue, 28 Sep 2021 09:34:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v12 07/11] PCI: kirin: Add MODULE_* macros
Date:   Tue, 28 Sep 2021 09:34:17 +0200
Message-Id: <a1897ec860065544a2953a38fb0a9d82783b091f.1632814194.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632814194.git.mchehab+huawei@kernel.org>
References: <cover.1632814194.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This driver misses the MODULE_* macros. Add them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v12 00/11] at: https://lore.kernel.org/all/cover.1632814194.git.mchehab+huawei@kernel.org/

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

