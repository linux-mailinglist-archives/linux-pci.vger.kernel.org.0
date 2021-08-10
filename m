Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9773E5797
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 11:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbhHJJ4L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 05:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238400AbhHJJ4J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7D9361078;
        Tue, 10 Aug 2021 09:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628589348;
        bh=FNhMa3ARnkUqgywjPKmDLcBbdox5t8J3LGZ7Cu8izcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqAmV5T2x8rmna01c+loa1kN4ufHcs42c+6l58cQoxNnaAi7+DrfPWaxHn0I0fjRt
         zIPZfDUILT7gQE757HJhB9IJhj8bKELMWO/UM+fHnFs22cWJqDwO1Vair5qyj7Le82
         ACPbcuV0X0MZWxDZzYjl/UQgHnlaq1TRqy5wUq6RKozNRQenS8i/01EYt23X+Rmxtz
         /hYUXdweYCmPTMtJzOwoFtQS2f/6a14RzUwigUMxgglxCy+Jgwp4xgr8vNjAor4cPz
         PkecwvlWE6ln3Ubnkp9mXH9FXYSREb26XzGGZ2hZM1fvI8AJVZlykHL5Sb40Hzi0IY
         ObCZ1aHKMPUZA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mDOU5-00AcFv-Vo; Tue, 10 Aug 2021 11:55:45 +0200
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
Subject: [PATCH v10 06/11] PCI: kirin: Add Kirin 970 compatible
Date:   Tue, 10 Aug 2021 11:55:37 +0200
Message-Id: <a3dda9b64292dd6fe0e51e0f9a356077a36ddc8b.1628589155.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628589155.git.mchehab+huawei@kernel.org>
References: <cover.1628589155.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that everything is in place, add a compatible for Kirin 970.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 95962983e6f2..306d440e1b62 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -736,6 +736,10 @@ static const struct of_device_id kirin_pcie_match[] = {
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

