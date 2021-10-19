Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED26E432DB7
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 08:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhJSGJI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 02:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233540AbhJSGJG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 02:09:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7122960F25;
        Tue, 19 Oct 2021 06:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634623614;
        bh=SatJHGAjaLnJb+LouOcuyzXya/cU/vKs75owulz+ocY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRb7+oUm0ArWtSpc/wdEPiroCX1hmtE/WZbzbuOgYEDns+vl1edMtmwDKTOUX1y/U
         zTs/vIUhLhSnQnGMmVVx+6ts8KnQMI0OA0y+jWW8Uo4P+yra3gKzjwR1wnoterzn6w
         Kgx5a6jZJ/o5H+WtQMELhm4i5nHTaartvxngkK9LbXZKYdZ62F2VDJ7KdwYDU18Uvw
         jqoeDOV/Aqfmhj42QjiTlvcGXYoGLF8ZADkQ0qITp3QIfxvClSCCCVRpnmiaKxwY/g
         TQY0T4D+jXGJ/gdGWwCfQTxDJY052pDodwtZzqSt/fAzy/HqtJ/gHOZbLhjfo6lhlF
         JAzlnVF67uiOw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mciGx-001krn-RV; Tue, 19 Oct 2021 07:06:51 +0100
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
Subject: [PATCH v14 06/11] PCI: kirin: Add Kirin 970 compatible
Date:   Tue, 19 Oct 2021 07:06:43 +0100
Message-Id: <396f8ce668cbbfb25205aed85ed68b527c4857d1.1634622716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634622716.git.mchehab+huawei@kernel.org>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
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

See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index bc329673632a..475ef57d5261 100644
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

