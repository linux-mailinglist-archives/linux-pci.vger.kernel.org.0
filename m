Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEEF3EA017
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 10:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhHLICy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 04:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234788AbhHLICv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 04:02:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8856F61059;
        Thu, 12 Aug 2021 08:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628755345;
        bh=4RkuJR3n6FQT5kN5AEWUNE1c78C8J4Xw1YfED1kNxoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBEAtXvmMWNx76EcsBy4jqL7cKUOgW8DVnktahdjXZEPoDe/PbM9nd4u1DSrWNokC
         KQupfd6E6oCPGlbyH43yCToyFFSpxHauVYsD/jiF0Qb8DMk5g7TyHegkocC4VS03j2
         DAhW0zhY2aXvjOjnTxVIs3AR/vrrOUD0KwVGXnUE43G5mRaSq20ehyo7X/fuZ96iMa
         ExAxignIuSvDTb0xZs3fop3yWnxEwW+ItE9Yd7269VvZuRDXQrsVS9pgbgs8XyTvwq
         ojPR56aPCK47y9d0TPDGM87D4kPn6RGsuHghn1JhVEaleoJ/ttc62NMeL/7r8jBLrM
         ILy1Z2Ni30now==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mE5fT-00DZD3-QF; Thu, 12 Aug 2021 10:02:23 +0200
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
Subject: [PATCH v11 06/11] PCI: kirin: Add Kirin 970 compatible
Date:   Thu, 12 Aug 2021 10:02:17 +0200
Message-Id: <ec29cea148ec8e89ec2b2afe1ee4863b3fc37d3e.1628755058.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628755058.git.mchehab+huawei@kernel.org>
References: <cover.1628755058.git.mchehab+huawei@kernel.org>
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

