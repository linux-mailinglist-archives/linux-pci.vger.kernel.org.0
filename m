Return-Path: <linux-pci+bounces-29166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B80AD1240
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 14:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA707A2F7B
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B42153C6;
	Sun,  8 Jun 2025 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeCVE0hS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA21A5BA3;
	Sun,  8 Jun 2025 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749387326; cv=none; b=HhjmDEORM8bMPHCQHQsPXRzzjfBJDAm3UhE5Km89y2EtDsIYQkSuhhRAJdv5SGIs2tKZkDh9WFYGJvwjHF4XNb1ggL8zVv0sqOB3+2wAuWakLIk9jhUSqUZGtVnfl/356xwDgswFs8MFWC5C8u/I6RYcTnMA1PA1bKB7MIx3IXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749387326; c=relaxed/simple;
	bh=k9WQ8zf71PaFQUYStBWojJDS3GDR41VS8kCjbdCtVzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOr/tIPOXSV6kQG2uRcmQsQiqolXT3avOPHMLp8wO62fvFkBwB/UrktzHH0wNSaZqolpLfJtilxCkaRvrQ57pM1YPb0qC64gKxSyxMZnKpF7dLXu/JjERFPrzwFx64We6SCvj+XbgefZTj7NS7Kd5bgKMxIETwcJyIoEjo7My0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeCVE0hS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0CBC4CEEE;
	Sun,  8 Jun 2025 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749387326;
	bh=k9WQ8zf71PaFQUYStBWojJDS3GDR41VS8kCjbdCtVzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UeCVE0hSX9biDHFqZxL3ZkCHo3YwJaPTsZIE68dRBCYaLi6EkRlNw2R+QwU8YWxXv
	 sMQ+PF4rwDjomdu1bjDOwhurZHZbEj3ynshNMXH/X3SHeXgUrkL6ENxI4DvgSzf983
	 32BePKdYkdaLhA9AgVu7Grd7+nZxHh8yyatOyZwQpt/ymXLRrRQfGc8Xa2a2qesILn
	 fDkfS05U2DuD2ZWFZZ9sSArWjJvA4yfLAnzbCDP1nRGL3HqnzyEqmck4LMHhm/ql7J
	 97J3VADsLzfZi16eAufecKIvD01hV9LmhGeH5UR9vHMl9LFJgx0MPOZS5kr+lCFOQs
	 gHFHFCMm4E0pQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>,
	l.stach@pengutronix.de,
	shawnguo@kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 10/10] PCI: imx6: Add workaround for errata ERR051624
Date: Sun,  8 Jun 2025 08:55:07 -0400
Message-Id: <20250608125507.934032-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250608125507.934032-1-sashal@kernel.org>
References: <20250608125507.934032-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.32
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit ce0c43e855c7f652b6351110aaaabf9b521debd7 ]

ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through Beacon
or PERST# De-assertion

When the auxiliary power is not available, the controller cannot exit from
L23 Ready with beacon or PERST# de-assertion when main power is not
removed. So the workaround is to set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.

This workaround is required irrespective of whether Vaux is supplied to the
link partner or not.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[mani: subject and description rewording]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://patch.msgid.link/20250416081314.3929794-5-hongxing.zhu@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## **Primary Justification: Hardware Errata Fix**

**ERR051624** is a documented silicon-level hardware errata affecting
i.MX95 PCIe controllers. The commit message clearly states this is a
workaround for a fundamental hardware limitation where "the controller
cannot exit from L23 Ready with beacon or PERST# de-assertion when main
power is not removed" when auxiliary power is unavailable.

## **Code Analysis**

The changes are **minimal and targeted**:

```c
+       /*
+        * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
+        * Through Beacon or PERST# De-assertion
+        *
+        * When the auxiliary power is not available, the controller
+        * cannot exit from L23 Ready with beacon or PERST# de-assertion
+        * when main power is not removed.
+        *
+        * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
+        */
+       regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+                       IMX95_PCIE_SYS_AUX_PWR_DET);
```

The fix is:
- **Self-contained**: Only affects i.MX95 PCIe initialization path
  (`imx95_pcie_init_phy`)
- **Low risk**: Simple register bit set with no complex logic
- **Well-documented**: Includes detailed errata description and official
  workaround
- **Hardware-specific**: No impact on other platforms or subsystems

## **Impact Assessment**

This errata affects **critical system functionality**:
- **Power Management**: Prevents proper exit from L23 Ready state
- **System Resume**: Could cause hangs during suspend/resume cycles
- **Platform Stability**: Affects fundamental PCIe power state
  transitions

## **Historical Precedent**

Examining similar commits shows a **consistent pattern of hardware
errata backporting**:

1. **Similar Commit #4 (Status: YES)**: "PCI: dwc: Provide deinit
   callback for i.MX" - Also addresses i.MX PCIe initialization issues
   and was backported
2. **ERR005723 workaround**: Recently backported to stable (`Cc:
   stable@vger.kernel.org`)
3. **ERR010728 workaround**: Multiple commits addressing this errata,
   showing active stable maintenance

## **Stable Tree Criteria Compliance**

✅ **Important bugfix**: Addresses hardware limitation affecting system
power management
✅ **Minimal risk**: Single register bit set with no side effects
✅ **Small and contained**: 13 lines of code, confined to one function
✅ **No architectural changes**: Simple workaround implementation
✅ **Critical subsystem**: PCIe power management is fundamental to system
operation
✅ **Clear documentation**: Well-documented errata with official
workaround

## **Risk Analysis**

**Regression Risk: MINIMAL**
- Only affects i.MX95 platforms specifically
- Workaround is mandated by hardware vendor (NXP)
- No conditional logic that could fail
- Register bit set follows official errata documentation

## **Maintainer Pattern**

The i.MX PCIe driver maintainers (Richard Zhu/NXP, Manivannan
Sadhasivam) have consistently tagged hardware errata fixes for stable
backporting, demonstrating their commitment to stable kernel support for
production hardware issues.

## **Conclusion**

This commit represents a **mandatory workaround for broken hardware**
that affects basic system functionality (power management). It follows
established patterns of similar errata fixes that have been successfully
backported, poses minimal regression risk, and addresses a real-world
issue that would impact users of i.MX95-based systems in production
environments.

 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ad3028b755d16..3b24fed3177de 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -48,6 +48,8 @@
 #define IMX95_PCIE_SS_RW_REG_0			0xf0
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+#define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
 #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
@@ -206,6 +208,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	/*
+	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
+	 * Through Beacon or PERST# De-assertion
+	 *
+	 * When the auxiliary power is not available, the controller
+	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
+	 * when main power is not removed.
+	 *
+	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
+	 */
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			IMX95_PCIE_SYS_AUX_PWR_DET);
+
 	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			IMX95_PCIE_SS_RW_REG_0,
 			IMX95_PCIE_PHY_CR_PARA_SEL,
-- 
2.39.5


