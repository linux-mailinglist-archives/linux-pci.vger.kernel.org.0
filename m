Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B833DB64E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 11:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbhG3Juc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 05:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238223AbhG3Jub (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 05:50:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29EA861008;
        Fri, 30 Jul 2021 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627638627;
        bh=Yd2bYHkd8E8ONHsZI8KUy+MzMZl1bqQzimkubkFkRp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ocTeqIOxaNEAeg9Zg1Ar4B/V+c0mOKt1Drnt2yzHD8Cc4Rv+Jn/Krhgmgm4g8XIdm
         9yGyEHRk2apX26WOkWhpIhylQ3tuuG7G1hb6hT8rv3qeAq55bdy4qM00Ve6H5CXC2m
         2jZDQzpMQvrY7Aut4h6DEl+I2l5nYPzg1oqjlqwvZTUp7tsiNsZUfmcbDJxSGBwiZq
         3DjaSkmqd7NLcSCuWr06mR7QE79SpxbIs1aJvAO+vHjJZDLfHvhNJ/u4ovDxCDq2vA
         aJirVgvk+jPntT199y+ItHqdhQG3ueDqoPIE4jhMT4+8h2g63r4tSEfo9xrScuA+CK
         CyN+UqUYYOyFw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m9P9t-006s4I-EU; Fri, 30 Jul 2021 11:50:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v8 07/11] PCI: kirin: Add MODULE_* macros
Date:   Fri, 30 Jul 2021 11:50:10 +0200
Message-Id: <a1da97cf15f16613c3bf54e618cfda58c43fe6fb.1627637745.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627637745.git.mchehab+huawei@kernel.org>
References: <cover.1627637745.git.mchehab+huawei@kernel.org>
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
index b5f3ff543339..dc6e38ee02b3 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -807,3 +807,8 @@ static struct platform_driver kirin_pcie_driver = {
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

