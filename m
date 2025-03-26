Return-Path: <linux-pci+bounces-24793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B369A71FD3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 21:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E4D1899134
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 20:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25426137930;
	Wed, 26 Mar 2025 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqKmWNpL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118324C676
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019282; cv=none; b=ty20x4pO3BBAzdKToI97kq7zrHFP1vo6IyRw9Q6zFWXhede3x/WAbdkfv5JPCjo6EsGo0Oe9kjbdCwh3HnGUGOn/My3MK84+H4t/TlJYXDO91nPsqx1S8syTZNhaoCx4641tWwL0UCWbSK/VYa2J4tZt7uQqO+Ro0/ZyZv8Nc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019282; c=relaxed/simple;
	bh=i8re7YWTitL9f6q0yBgZpLjWpQ/yfsSdCER2Kwhwp3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADR4yNhQKu7/+psfZuoP/iE/OdfGu+QKOPwMWLGfd8yzqKBxsr+so3FW9aPsbT6zns3Fy7uWxtu+GMQsmrVkb5et4ZAapmGOTwr48Xxx/ZScxzVrQGKuKncLaitbqNBMwMaeeUE+w4bMPTlBmiiW4MA6BHMeudNIQpDZ13CZGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqKmWNpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2658FC4CEE2;
	Wed, 26 Mar 2025 20:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743019281;
	bh=i8re7YWTitL9f6q0yBgZpLjWpQ/yfsSdCER2Kwhwp3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=aqKmWNpLmO16WQsdMwJSY2lJZHc9hgCr5lmOJC7VF6ghV2dZq/slLku6u9l9Pctz4
	 HhYbD1DDomjdBAnGz162DxaA7dELeGdu8tMRSOiKYRgD3A4VIrMZoQBswxvsjjGgM5
	 wE9Syl+PFcyK7/6nTBB/lr1a8ZDgYnE9qwnuFPgDAa9SGSjkaniRP/OLLNi1HDVn7E
	 o+ySK2drIsqXg9ahtBp7Dm+nglbE0GYn8WxZljbCamJlzS9TjP04ukIubOfEC3LIu8
	 +8s8BdjGFYN5oi9kGWLanyLBvWrBvORPQefgr48Z5m3SxJgvaJ6gcdWYxFt2SR7dEx
	 saImDQiMKtWZQ==
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: rockchip-ep: Mark RK3399 as intx_capable
Date: Wed, 26 Mar 2025 21:01:16 +0100
Message-ID: <20250326200115.3804380-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; i=cassel@kernel.org; h=from:subject; bh=i8re7YWTitL9f6q0yBgZpLjWpQ/yfsSdCER2Kwhwp3Q=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKfxHIrp4pYKfNN70t76aU+Y/rjkqmODU5FKW+23is/3 XkodPL6jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzEv5vhN3tF7mqpO/PnvO1x 9p6ffWmKp8r994qKp2fv6BDgv638/gQjw55MqyUBBRM7laOK9u+Z5HFWKGJO/tINlnyL7km+VNV 6zQoA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

RK3399 can raise INTx interrupts, as can be seen by
rockchip_pcie_ep_send_intx_irq().

This is also in line with the register description of
PCIE_CLIENT_LEGACY_INT_CTRL, section "17.6.3 PCIe Client Detail Register
Description" of the RK3399 TRM.

Thus, mark RK3399 as intx_capable.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 85ea36df2f59a..626f6b31b0f66 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -694,6 +694,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.msix_capable = false,
+	.intx_capable = true,
 	.align = ROCKCHIP_PCIE_AT_SIZE_ALIGN,
 };
 
-- 
2.49.0


