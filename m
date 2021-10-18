Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD15431107
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 09:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhJRHJu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 03:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhJRHJu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 03:09:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B201260F46;
        Mon, 18 Oct 2021 07:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634540859;
        bh=3xoT5wtX2K/NpueQnSgjg4Op4oMdefUO9mVaG/2HjVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7K4wTnoRuvTnGOsQpVRwM95VUsMAHIwmW3up9jp2m/YCW6gEe7jYEhdyc+0A4ecd
         n6DnAuBdiykiBRMIlEHgMhRMWOEnxwqPKeLFkUp4398GzUyrzi05kcQpZdpUG2yRvb
         Ug8/RlhBuk7kdG3/Ny1LvAv0jJlzLlIeGqziehQRwes/4pv1rkeoPemLM7TdaXSAzb
         +zLrwecvw//6FwwmD/FkpPUmCtPmRwomFnt08X6ixoPnmju/Eu04b5ZIp/O7uiYnHn
         UD2NT1Yk+Q+TjkZntZBUGZb+nxRIcGafXCj9gXDjRuSUctlyo7p1HYcf11+PjX/v1F
         q2lyi6VEyMskA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mcMkC-000Id4-Qo; Mon, 18 Oct 2021 08:07:36 +0100
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
Subject: [PATCH v13 05/10] PCI: kirin: Add Kirin 970 compatible
Date:   Mon, 18 Oct 2021 08:07:30 +0100
Message-Id: <2e24c61ba31ef2442460a8805d1ee244098bddff.1634539769.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634539769.git.mchehab+huawei@kernel.org>
References: <cover.1634539769.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that everything is in place, add a compatible for Kirin 970.

Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v13 00/10] at: https://lore.kernel.org/all/cover.1634539769.git.mchehab+huawei@kernel.org/

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

