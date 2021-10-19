Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B23432DBC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 08:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhJSGJJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 02:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233888AbhJSGJH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 02:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8355261373;
        Tue, 19 Oct 2021 06:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634623614;
        bh=iHRCoJdY12lbkMgj4QQPYWpAI4R82b3YcYTv1Ko6LMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xn7oat32iLSI79vXrkM0r3+iecLNlvtU9y/m+ENFQvgiebB58DWMRl0LYVa+G5in5
         JPVhqr7fYfIDG2duXC2wlnVWHRRjpSHID6xzDGTlOtSaAu60/cY+MdEoZdLOzc6nJB
         gO5BnUz7tnJRHoofxJbFHWGsK8pJoeLK2HZ+Usp7Z3uFIUn8tXu7YChsiQYAGNtbi7
         vbEZcqSqGzIHrOLYjLMweBAzIh7XO2RkG78172zVDhFNMR8VbABKjOknX5mdFH7VDO
         Kh7RmQBOXS8Uj1UBEymWJ1Ue4Mv4+vpZbXtVRg/Jd63F5MbxMoc3ZY1jHzRrePqY/A
         HYQY4ASkdojww==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mciGx-001krq-Rv; Tue, 19 Oct 2021 07:06:51 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Songxiaowei" <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v14 07/11] PCI: kirin: Add MODULE_* macros
Date:   Tue, 19 Oct 2021 07:06:44 +0100
Message-Id: <ae1bfe03acde5d68f781006c206d43245ffd73fd.1634622716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634622716.git.mchehab+huawei@kernel.org>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This driver misses the MODULE_* macros. Add them.

Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 475ef57d5261..b55830d2a19b 100644
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

