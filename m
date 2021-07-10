Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D932C3C3830
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jul 2021 01:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhGJXyI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Jul 2021 19:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233286AbhGJXxf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Jul 2021 19:53:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA6A1613B5;
        Sat, 10 Jul 2021 23:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625961046;
        bh=7zuqEJtcX/xnHOsRzILBcADqTxEWzA2lE8i1F+mGGWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HS2X9B+1/LG8afaQGYEjBVrSrWgqnP6ZCWQlo4YuLzE5zj3JAh/z6DCVe4r1GYj6l
         r11NO9CNNbXt0WlBKiW6DXiCWuPPwLs8X9ZY48B9HTc405jB9m+8awDHrmVFtld0ms
         gm8xUysG3LZzq+iiDfiHs9JXsDTiG5LG/ZPLu8a7IWYKYnoqDbd9dGYAo7iDpbnp/d
         wJ1E8CxQZQIwbsO8ons2TtLKx+SaBy0h7r2rI2x7o+yDTQX+Za24dhYqyAuroEqtmU
         VWCgrVRLxM60SkKtkADLieaJDW9odNgfvvXmrVYhPq5eKVJY6kozTexznDxzjVsekI
         limSuoKBz9WpA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zou Wei <zou_wei@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 21/37] PCI: tegra: Add missing MODULE_DEVICE_TABLE
Date:   Sat, 10 Jul 2021 19:49:59 -0400
Message-Id: <20210710235016.3221124-21-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710235016.3221124-1-sashal@kernel.org>
References: <20210710235016.3221124-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

[ Upstream commit 7bf475a4614a9722b9b989e53184a02596cf16d1 ]

Add missing MODULE_DEVICE_TABLE definition so we generate correct modalias
for automatic loading of this driver when it is built as a module.

Link: https://lore.kernel.org/r/1620792422-16535-1-git-send-email-zou_wei@huawei.com
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 8fcabed7c6a6..1a2af963599c 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2506,6 +2506,7 @@ static const struct of_device_id tegra_pcie_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pcie", .data = &tegra20_pcie },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tegra_pcie_of_match);
 
 static void *tegra_pcie_ports_seq_start(struct seq_file *s, loff_t *pos)
 {
-- 
2.30.2

