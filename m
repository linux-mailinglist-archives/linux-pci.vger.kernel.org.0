Return-Path: <linux-pci+bounces-40937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2CFC4FF51
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 23:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AB63A8C6F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 22:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907362E6127;
	Tue, 11 Nov 2025 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lihuqsIQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EAC283FC5;
	Tue, 11 Nov 2025 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899396; cv=none; b=DXRwO2NgZhs7QVihDy3aT4sHM/Bgymgm0xgvX7JqDHSUTyOktfeYiC7NiWVKVe42fLUWG2Szfrq1AC38AhTEXrKa3FD4JwMy8XZWIvF1qKnLKv6dq4nadrkrxPo9VgrnBVAX563daQO2Y8jq7f/vv33CmeBrre+XsJkGPuk0m24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899396; c=relaxed/simple;
	bh=tWgtFDVczwJGDGIoy+OuLVGscnJT3/fUkwwYZbHhyNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaHBzRU34lU7HyzMXIex33d/xGxbjsQhYIxARTGfthCxz9yK0OxrERVDmXxdt9IIPGJcdzqgsmFpEFE54oPDLUB4X2lNgRx7JZYeZj+NxRCK1d/M0jLzJQLczwfORbvdgmehVeWL/aaVy43l6MQzehkc8mdBXmQ4hHep9EeJX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lihuqsIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862D8C16AAE;
	Tue, 11 Nov 2025 22:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762899395;
	bh=tWgtFDVczwJGDGIoy+OuLVGscnJT3/fUkwwYZbHhyNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lihuqsIQ6lvYr+A5OEmUsIVIOt1oRZ57SAYptaA2Tyn8sLN2VpGGeo7KV7CZW3eFZ
	 Q9F+diyamYV2ozlV5h4/z8+h8tLs526kYd0pqEkNW828INbciF1ROW9sqczxTkfz9u
	 U6OA67BwczHfvaBKmK7Tl/t/mwuQQJkT3D1OvoyQDZoBND06UAp1i/eEi0Z4DE84NO
	 uZn3nAfFEfAQsPy0SRMqu2M4Wy9g8Myb0CV/P+NDF5EJUds9oKs6yZHFkY2b2xL4z2
	 4S96Nt2rxGsFJxmqo3aAWjVjBPYOFOfZ8f0DHbCOouzKLobgPhe5eAZeV3SuMCQwbL
	 e+/pyjb+tlywQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.li@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/4] PCI: tegra194: Remove unnecessary L1SS disable code
Date: Tue, 11 Nov 2025 16:16:09 -0600
Message-ID: <20251111221621.2208606-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111221621.2208606-1-helgaas@kernel.org>
References: <20251111221621.2208606-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The DWC core clears the L1 Substates Supported bits unless the driver sets
the "dw_pcie.l1ss_support" flag.

The tegra194 init_host_aspm() sets "dw_pcie.l1ss_support" if the platform
has the "supports-clkreq" DT property.  If "supports-clkreq" is absent,
"dw_pcie.l1ss_support" is not set, and the DWC core will clear the L1
Substates Supported bits.

The tegra194 code to clear the L1 Substates Supported bits is unnecessary,
so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 32 ----------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 3934757baa30..d5545bf37f81 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -608,24 +608,6 @@ static struct pci_ops tegra_pci_ops = {
 };
 
 #if defined(CONFIG_PCIEASPM)
-static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
-	val &= ~PCI_L1SS_CAP_ASPM_L1_1;
-	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
-}
-
-static void disable_aspm_l12(struct tegra_pcie_dw *pcie)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
-	val &= ~PCI_L1SS_CAP_ASPM_L1_2;
-	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
-}
-
 static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 {
 	u32 val;
@@ -729,8 +711,6 @@ static void init_debugfs(struct tegra_pcie_dw *pcie)
 				    aspm_state_cnt);
 }
 #else
-static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
-static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
 static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
 static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
 #endif
@@ -934,12 +914,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 	init_host_aspm(pcie);
 
-	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
-	if (!pcie->supports_clkreq) {
-		disable_aspm_l11(pcie);
-		disable_aspm_l12(pcie);
-	}
-
 	if (!pcie->of_data->has_l1ss_exit_fix) {
 		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
 		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
@@ -1874,12 +1848,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	init_host_aspm(pcie);
 
-	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
-	if (!pcie->supports_clkreq) {
-		disable_aspm_l11(pcie);
-		disable_aspm_l12(pcie);
-	}
-
 	if (!pcie->of_data->has_l1ss_exit_fix) {
 		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
 		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-- 
2.43.0


