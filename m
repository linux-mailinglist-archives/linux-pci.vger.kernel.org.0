Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 296CD132138
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 09:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgAGITU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 03:19:20 -0500
Received: from mout.perfora.net ([74.208.4.196]:49309 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgAGITT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jan 2020 03:19:19 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jan 2020 03:19:19 EST
Received: from marcel-nb-toradex-int.toradex.int ([31.10.206.124]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1Mml4M-1jWHxg3b0g-00juCB; Tue, 07 Jan 2020 09:14:07 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2] PCI: tegra: Fix afi_pex2_ctrl reg offset for Tegra30
Date:   Tue,  7 Jan 2020 09:14:02 +0100
Message-Id: <20200107081402.213149-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Z6BGdrzj9vfd7CHH+h+VNTlhMN6i/n3zrJrLBf74VzTcTagsZRs
 CYbwMDWa7U5utTeBbIUlv4i01sItD5AfXIFyYKzR7pOLM6b9rLkTRRAIF+yKI6L97O4Mifg
 EOgILDaCxMvLGK9Tz3WZinWrEBZQX96ygIVykYNXOQR5ZaUeoakzm7pz4mrQOrVE2FkPi/w
 hoQ9/xzkmjQhpa/LeR1OA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SnBIWhN+lxA=:/Xh9JdjUVv7Lm7miaV0GAV
 YQ0118pB+35LDRNOG4OESyUwLGlfR5Qh+vF7L1TJiMryAvQzK9lDo54Tx10CsRmhDwk5XXKOi
 ZM4KpGvLd0DRvMdleQ4Mdg5z77hkN5yC9XPCTkmJtj8xKK8usznMr38FR8zUlqenBDhkfW+QL
 HBGh+AfskCIRqFHGjdLk87Vc1hWp65mm6zsKTarxjFuiqxzs9A5WsQzAeujNvVTa5k6G4cNit
 BokhCHOQdKxSEO1eCFijIOFZ9vnXTkAR77RDvIdWExYsDJvsX9b0JtGQG7vvdslDEStlg3P6j
 dCsjW3uv3xAopCGOrG4oZ2czzSSKBx/SqA0+0W2DZDYs+JWyCQNWSWyH77AE0fN1RhE76oEOf
 vTpw+jBMS/aPhIY3eU2s4z6B3lf+hC+c5v22nAE/XyemyNIK49ANEPfnJM2FbBRZa31ncerhv
 2Br6Q6/OonQUgGd5pBYk5oFwbexEVU4Nr/QPcOgzK++tgKTdVQRNRO7YbwmlEbwhwETiW9rJN
 doa4NhjehnomDWM3AoJp8K9p5BXK12BgEXVMijnejfrwFzFCJaDNBXEnakuotIUqALruon+xn
 EIYEk0uZKoAoL20B0t01K/kBO33wDTFi/hyZENQf3elR9Y/EF7MViukap7N+0L8tp7F2XfMd9
 QIdu8J3nvcBecAbWxhdulW8roM2JCFT1IBMmt5LN7PYVd6EDZa7wQWRQekNwrUM8HFbN80pO4
 vM91KaSCR8GTJF8w1ose7VAGeUqs1cdwWNQo87CBI73xxa2qAdgElKpq5viQrpHvFM5SU8lvM
 55trFg+tkpUchLmafB2k9e1jLWvwdnOM90r1RqRRAsMzJ3J//YerOXl5DNw3yVb2QOSm7lJB6
 nC239YNpbCX0EabGNaSQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix AFI_PEX2_CTRL reg offset for Tegra30 by moving it from the Tegra20
SoC struct where it erroneously got added. This fixes the AFI_PEX2_CTRL
reg offset being uninitialised subsequently failing to bring up the
third PCIe port.

Fixes: adb2653b3d2e ("PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of SoC struct")

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
Acked-by: Thierry Reding <treding@nvidia.com>

---

Changes in v2:
- Fix recipient list concerning CC: and To: lines as suggested by
  Thierry.
- Fix subject line and commit message to adhere to standard formatting
  rules as suggested by Thierry.
- Add Thierry's Acked-by tag.
- Add standard Fixes tag as suggested by Andrew.

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

