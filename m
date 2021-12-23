Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8C47DC9A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345643AbhLWBL2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbhLWBLY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A5C061401;
        Wed, 22 Dec 2021 17:11:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35FF961C04;
        Thu, 23 Dec 2021 01:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF44C36AEE;
        Thu, 23 Dec 2021 01:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221882;
        bh=QDle4GEHP+VzIlHo0RChYIQ/WFmjI4YP/x4ESfOQkZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpIe8nj+BHPIEcjhMuUSuo6A8TsW92oTiKFaqdg/AzCCbockFTElcFQfG6Sb2eMYk
         4cqyiM+rMqFQ9JsAYIA240RQlVCq+vX1dTp/llDt7FNVubDTaJQi5En7KSqSiMIXng
         7A8xA4Gn2u2U2GwO5vCRjs1JURLMteFoLhTzjkRUsEenFp2o7RK2+78CA3Rgx8IJHE
         JAD0+9GToxQbWszsRZvbbjPW836ltgwMzcnP1LCFdYSozJZbn7svtJt4eKH5VcaB/I
         7hrdmU9yY0nRTYfBGGReyyaI+42+rjVJJKoPqkAg7gdUZegD4NVQR2xk6EQIATxcYy
         cFt0qrk/fsTEw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: [PATCH v2 07/23] PCI: kirin: Prefer of_device_get_match_data()
Date:   Wed, 22 Dec 2021 19:10:38 -0600
Message-Id: <20211223011054.1227810-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fan Fei <ffclaire1224@gmail.com>

The kirin driver only needs the device data, not the whole struct
of_device_id.  Use of_device_get_match_data() instead of of_match_device().
No functional change intended.

[bhelgaas: commit log]
Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 095afbccf9c1..8d6e241bd171 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -773,7 +773,6 @@ static const struct of_device_id kirin_pcie_match[] = {
 static int kirin_pcie_probe(struct platform_device *pdev)
 {
 	enum pcie_kirin_phy_type phy_type;
-	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct kirin_pcie *kirin_pcie;
 	struct dw_pcie *pci;
@@ -784,13 +783,12 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	of_id = of_match_device(kirin_pcie_match, dev);
-	if (!of_id) {
+	phy_type = (long)of_device_get_match_data(dev);
+	if (!phy_type) {
 		dev_err(dev, "OF data missing\n");
 		return -EINVAL;
 	}
 
-	phy_type = (long)of_id->data;
 
 	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
 	if (!kirin_pcie)
-- 
2.25.1

