Return-Path: <linux-pci+bounces-36678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B806B919A2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E157B2A546E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3F619E7E2;
	Mon, 22 Sep 2025 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEDi49bV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E119DF66;
	Mon, 22 Sep 2025 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550157; cv=none; b=hjEh6MxdPuxH0dQhGNkOuzlEf1WnWriO1gTmfJkKPFloe45NYz679/VZ3AXB7MkjqybqPmQfceWh8h10zqjpIgIuSnu5NuEL5CgbHuaZDb7HDfB1QLvyea1/aKR6e3bLSkJwoNkhivWF7vnJ8V3TN8q+Rt65HgGEcXPfCC2Dg20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550157; c=relaxed/simple;
	bh=3Z0vzhtk8Z9wqBgwb+sBDsVBExQR8+ip9ZDisIwHB08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ew3a1dgEqJ9W8EIJXeGFQvOmV63JYZgQ4UczcTeVALj2hc/AdN26hM+z+qpbtSMeAO+PfTqa3bRiBXA9KFZwRX71O+kNkKvGHcoNVebcFsmSm5W5vfX8bEEiYX5mUHbj3MmXC7nP5aNfGx1E0Dw2QtbodxPl3HbQRnDOSPioGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEDi49bV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B03C113D0;
	Mon, 22 Sep 2025 14:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550156;
	bh=3Z0vzhtk8Z9wqBgwb+sBDsVBExQR8+ip9ZDisIwHB08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEDi49bV8FK5snnTTmJZH3CjJl6VIKaBFteYSPhPzbAeX4I2hK9HNTT5+q3Uznbu9
	 cxMqVGF/LZDJSrG54Us6iS8xmQ9Yu999f+71/8N5zBmYr2m0UmYk988T8UKLltQR9d
	 docPi9QsdKPPNqfsizjcyNGGiOkvmEUwwnXMAr+wvcuhzcdIIEdnzlz0tnhlRZZBRT
	 pE3O9DUqsL/KjGC9ic2tkr9KV7itI+pMOPrEMVD0UFvitfUFM9j1FsLDZIw8u7WzGl
	 OcZBS93nJJR+uKT8DZKlqAX+TrxHMA5msjxtLQ63zn8HWvQn7O3UtzcizXj0qhaGoJ
	 kdCV4F2GfCaKQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: tegra194: Handle errors in BPMP response
Date: Mon, 22 Sep 2025 16:08:26 +0200
Message-ID: <20250922140822.519796-8-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922140822.519796-5-cassel@kernel.org>
References: <20250922140822.519796-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3846; i=cassel@kernel.org; h=from:subject; bh=1IAp3u5+U6hQsW7eq1X/l3YmaF7ChrnKbrfeJ2PJF9E=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIuRsQ/PvTRnDX0rnD6gojyCeysuu1rJkc3rpESf7A20 Y3Lp31dRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbSeoSRod9Z12anMftyBt1L /yfsObOyWjrshphwWdY/dvWSj69WPGD4KzB/2/SHGz0mMr9a13M3JoOHf03SgnMF701afzIEqfJ ksAMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Vidya Sagar <vidyas@nvidia.com>

The return value from tegra_bpmp_transfer() indicates the success or
failure of the IPC transaction with BPMP. If the transaction
succeeded, we also need to check the actual command's result code.

If we don't have error handling for tegra_bpmp_transfer(), we will
set the pcie->ep_state to EP_STATE_ENABLED (even though the
tegra_bpmp_transfer() command failed). Thus, the pcie->ep_state will
get out of sync with reality, and any further PERST# assert + deassert
will be a no-op (will not trigger the hardware initialization sequence).

This is because pex_ep_event_pex_rst_deassert() checks the current
pcie->ep_state, and does nothing if the current state is already
EP_STATE_ENABLED.

Thus, it is important to have error handling for tegra_bpmp_transfer(),
such that the pcie->ep_state can not get out of sync with reality, so
that we will try to initialize the hardware not only during the first
PERST# assert + deassert, but also during any succeeding PERST# assert +
deassert.

One example where this fix is needed is when using a rock5b as host.
During the initial PERST# assert + deassert (triggered by the bootloader
on the rock5b) pex_ep_event_pex_rst_deassert() will get called, but for
some unknown reason, the tegra_bpmp_transfer() call to initialize the PHY
fails. Once Linux has been loaded on the rock5b, the PCIe driver will once
again assert + deassert PERST#. However, without tegra_bpmp_transfer()
error handling, this second PERST# assert + deassert will not trigger the
hardware initialization sequence.

With tegra_bpmp_transfer() error handling, the second PERST# assert +
deassert will once again trigger the hardware to be initialized and this
time the tegra_bpmp_transfer() succeeds.

Cc: stable@vger.kernel.org
Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
[cassel: improve commit log]
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7eb48cc13648e..c4265b3f72048 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1223,6 +1223,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	/*
 	 * Controller-5 doesn't need to have its state set by BPMP-FW in
@@ -1245,7 +1246,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
@@ -1254,6 +1261,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
@@ -1273,7 +1281,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
-- 
2.51.0


