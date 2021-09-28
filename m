Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C808B41A9BF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 09:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbhI1HgG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 03:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239315AbhI1HgF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 03:36:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 497B3611CA;
        Tue, 28 Sep 2021 07:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632814466;
        bh=Ugmax27xzWkKf+gMt8SnB5d5Z0/GmeY8FEO//x4qaFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2g8prbCZI8fTdYg66+O4T63Rx0iDUTWZ8asnD5tBjJo5/B46p7P0qr1fPAhECNHv
         hCxlSpIIlB3VLatA+523NWVKD8wSb+Zaini3qoMktAXLpoTPW4LAUgyEFVGo9BU/1X
         /35D2f/eAUa9u7Q2zjhMcJDPIZDBQ23Djc7OCvNdofpa0kB3Xxnh7CRiJlHHhm7YtD
         VPvGb0nQlEtU5OdEPRqykw4aEZzCKm0AsHuYOHt/qY+e7pNNu0Fhd+ApYUArVbb7sf
         kUNo1KjRKgavutUDpydHfpDnGtGAMP5+YYu50WFfz8Vk12hZfKP+2xfbnob4cPHIPM
         NdAccJVPN0Xig==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mV7dA-000RPv-Je; Tue, 28 Sep 2021 09:34:24 +0200
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
Subject: [PATCH v12 06/11] PCI: kirin: Add Kirin 970 compatible
Date:   Tue, 28 Sep 2021 09:34:16 +0200
Message-Id: <0eaede49be097471ea90e1e5a35686f1528522f0.1632814194.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632814194.git.mchehab+huawei@kernel.org>
References: <cover.1632814194.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that everything is in place, add a compatible for Kirin 970.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v12 00/11] at: https://lore.kernel.org/all/cover.1632814194.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 5c97e91adbb0..4f4c86b92353 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -738,6 +738,10 @@ static const struct of_device_id kirin_pcie_match[] = {
 		.compatible = "hisilicon,kirin960-pcie",
 		.data = (void *)PCIE_KIRIN_INTERNAL_PHY
 	},
+	{
+		.compatible = "hisilicon,kirin970-pcie",
+		.data = (void *)PCIE_KIRIN_EXTERNAL_PHY
+	},
 	{},
 };
 
-- 
2.31.1

