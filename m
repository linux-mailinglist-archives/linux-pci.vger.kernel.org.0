Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B737312CB76
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 01:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfL3AwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Dec 2019 19:52:23 -0500
Received: from mout.perfora.net ([74.208.4.197]:57029 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfL3AwW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Dec 2019 19:52:22 -0500
Received: from marcel-nb-toradex-int.cardiotech.int ([81.221.65.116]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LrtWq-1jksBF3egw-013iAl; Mon, 30 Dec 2019 01:52:16 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v1] pci: tegra: fix afi_pex2_ctrl reg offset for tegra30
Date:   Mon, 30 Dec 2019 01:52:09 +0100
Message-Id: <20191230005209.1546434-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TEb6gkiuTbGtsFXArq0mNHHPPNNqCPrumd3IVTaSjf3yx/9vMhs
 foswH6A01yTPu2rpApDjn9attuLrSJWu5bYuGc/tdTxU8uLUZQoCxFpXunQbhZIfdWMWLXM
 lQralP2mUEflNoS03f1L46rnkc9/BGF9/IYRyteT6FeQLtq4xnQ/smb/6PYA0soO/CCJCgl
 PPvBkYDEa1wRbEcCzkz5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jzRK0YLa2yE=:1Cg0MiY8MhBFIdhwFDWIHb
 IfRiGFudWId7q4f/flVCULIPWo4xKwaDlgV0uyPT/dKsjXPY7YSwq9pGu7WmiIq8WWDIesGxh
 Cuasv7EjSoWrWzf1NFxFrXUXE2xFTzRixpY4rxfD78fnDGkUyEQ20VRTbrXG8i0MWPNGHgHEE
 7kXs6YlFV88smMJi1q8V/mCsJ2SWRgMxPVJZ7MhRaiQfTBp+UMhpbB/ogVjlstAxYaml7fx7c
 JxpP/zLMM1J5YtQoZu8hlfjAFfSuY1f15s3nvgLEo735/73yBXz3jvszth4ZajFGvyXonik4A
 TqL/aDyb+09PFPHX/fztcagq7Wo4ONC7PCd31kfH6lm+7bti9zcHTAq2pb+79FLd9nwrgrlTF
 g3gdOrXsMaG2Zl+ychPxDHTbwZEm5apehtShy68XkIQdaZgYGVdt45Ln3SRxqi6g2qxKupLL8
 uL+nyH/K3mJ+kHgREMRHSUHwecrPdMIcjjMSanKrII2wseYVF25TFy1jVkETn0ap6WdDXBCiJ
 iNLCtNHmtaeKacAgal/e1ZFTXiuhwKYCyhQrHv9zipjBOa8RmmLxKYt6nd2weAGUfPVUmvxex
 tzT2f6/FfyG2Kv1HQQQpLD0K1dMVY/oGM485xbFjINRZHMJGtG9sxDbqWIK9fvm3GY1IUuaaT
 Um0ptmVg3yRuS+CjaGLXChUot24957QP7uf9VTMYO+lTHOUlfISywGqg0mkkRXz1KezxJHb8P
 +tYKYuG7oLZs7hBdB/nhAO/CXiBDaDEhyAMwp3mgGcANMacdcM8NFxNbsNH3aV8AGPAgXac/f
 TJ1vZkrFJk/P6PBH3Ig1cT0rCkFK5IS16InbMbYrIfLgv6b4yscooqIZKH4qgwoiw48mj+yRL
 1qx/eOY5AN/dxEBxyOfg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix AFI_PEX2_CTRL reg offset for tegra30 by moving it from the tegra20
SoC struct where it erroneously got added by commit adb2653b3d2e
("PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of SoC struct").
This fixes the AFI_PEX2_CTRL reg offset being uninitialised
subsequently failing to bring up the third PCIe port.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>

---

 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 090b632965e2..ac93f5a0398e 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2499,7 +2499,6 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.num_ports = 2,
 	.ports = tegra20_pcie_ports,
 	.msi_base_shift = 0,
-	.afi_pex2_ctrl = 0x128,
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
 	.pads_refclk_cfg0 = 0xfa5cfa5c,
@@ -2528,6 +2527,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.num_ports = 3,
 	.ports = tegra30_pcie_ports,
 	.msi_base_shift = 8,
+	.afi_pex2_ctrl = 0x128,
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0xfa5cfa5c,
-- 
2.24.1

