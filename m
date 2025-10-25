Return-Path: <linux-pci+bounces-39318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3241DC09420
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 18:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 664224F197B
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72751304BDE;
	Sat, 25 Oct 2025 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQQQGkRi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471372F5B;
	Sat, 25 Oct 2025 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408703; cv=none; b=ofz4vd0c8vob7bMrIfGk6uHlYR3tlo3+bUUv6srDu13R7bguGcjrsuKqyL2090Ah+BSHa9dxQjOJpTDpRo11O0UT77AViOgPH2Trif8y0uU0GC2j52dBsSQvgVUc344TdEJrPAKytJg6+OGIww8CeIfi7TgxZIt7UM2B1KjCWrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408703; c=relaxed/simple;
	bh=DEkVSc8NRFn6ItZeWrbNxU3sOFl/C8fQJwK+oMewsvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHv+HmyTfRFpN2fBOjh6fiLlzdy1xSPVEUKS9fMT9v0Ip4KcjXS147ouVEzVWd/5PdYZibtYb+eQHaHFz4l92sMhA9JX4U9YU0vQ0ExP2NzS1acEleG0txyJEmWcLFBQEiuDhhsjJ+RK9skgsdnsTs+iNhZx6MdnphLFXMmR97U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQQQGkRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06E1C4CEFF;
	Sat, 25 Oct 2025 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408703;
	bh=DEkVSc8NRFn6ItZeWrbNxU3sOFl/C8fQJwK+oMewsvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQQQGkRiCMLTJ1HsAmxO1O9mo9qyagiCGlvwb2/mSM+zSnGt/+ZACUViznRh/OIbf
	 MgOoknXreViuIjigkuZ/rawYU/E56f2ilyU8Pms3hXcoDi/zslNW8c87lVxZez5uxF
	 5JCUlN3NGQcpyEBfi3Ng2mCOyLN+YTUwHLIAuwHGWDlrWtdy8xwEvWEbs6Ww7EPBUV
	 MKQsuA0KAPnL6vLKZE0K05LoThB57VXw2ybZA9+1b8Q0U+CJYOgkZKkHqbAMxNiAN6
	 orPc8RxgfL1VhSRWEszVIM6+xXTscBIjH+f/c3+ALzUPYjjnHTnnb5lUKlrQirKw90
	 Shrq2bXCoNUAg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>,
	l.stach@pengutronix.de,
	shawnguo@kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH AUTOSEL 6.17-6.12] PCI: imx6: Enable the Vaux supply if available
Date: Sat, 25 Oct 2025 11:54:38 -0400
Message-ID: <20251025160905.3857885-47-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit c221cbf8dc547eb8489152ac62ef103fede99545 ]

When the 3.3Vaux supply is present, fetch it at the probe time and keep it
enabled for the entire PCIe controller lifecycle so that the link can enter
L2 state and the devices can signal wakeup using either Beacon or WAKE#
mechanisms.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[mani: reworded the subject, description and error message]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250820022328.2143374-1-hongxing.zhu@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- The change enables an optional 3.3V auxiliary PCIe supply early in
  probe and keeps it on for the controller’s lifetime via devm, which
  directly addresses link low‑power (L2) entry and wake signaling
  reliability. The new call
  `devm_regulator_get_enable_optional(&pdev->dev, "vpcie3v3aux")` is
  added in `drivers/pci/controller/dwc/pci-imx6.c:1744`. Errors other
  than “not present” are surfaced using `dev_err_probe()`
  (`drivers/pci/controller/dwc/pci-imx6.c:1745`), ensuring a clear,
  fail‑fast behavior if hardware provides the supply but it cannot be
  enabled.

- The helper used is a standard devres API that both acquires and
  enables the regulator for the device lifetime, and automatically
  disables it on device teardown. See the declaration in
  `include/linux/regulator/consumer.h:166` and implementation in
  `drivers/regulator/devres.c:110`. This matches the commit’s intent to
  “keep it enabled for the entire PCIe controller lifecycle.”

- This is a contained, minimal change within the i.MX DesignWare PCIe
  host driver probe path. It does not alter broader PCIe core behavior,
  call flows, or add architectural changes. It only:
  - Enables `vpcie3v3aux` if present (`drivers/pci/controller/dwc/pci-
    imx6.c:1744`).
  - Leaves existing supply handling intact for `vpcie` and `vph`
    (`drivers/pci/controller/dwc/pci-imx6.c:1748` and
    `drivers/pci/controller/dwc/pci-imx6.c:1755`).
  - Keeps `vpcie` enable/disable at host init/exit unchanged
    (`drivers/pci/controller/dwc/pci-imx6.c:1205`,
    `drivers/pci/controller/dwc/pci-imx6.c:1280`,
    `drivers/pci/controller/dwc/pci-imx6.c:1297`).

- The functional impact is to enable proper L2 and wake signaling
  (Beacon or WAKE#) on boards that wire up 3.3Vaux. The driver already
  carries context that AUX power matters; for example, i.MX95 has an
  erratum requiring AUX power detect handling to exit L23 Ready
  (`drivers/pci/controller/dwc/pci-imx6.c:245` comment explains AUX
  power implications). Turning on AUX power when available is therefore
  a correctness fix, not a feature.

- Risk/regression assessment:
  - If the supply is not defined, nothing changes (uses “optional” API
    and ignores `-ENODEV`).
  - If the supply is defined but cannot be enabled, probe now fails
    loudly; this surfaces real hardware/regulator issues instead of
    running with broken low‑power/wake behavior.
  - The pattern matches existing PCIe controller drivers that enable
    optional PCIe supplies at probe with the same helper (e.g.,
    `drivers/pci/controller/pcie-rcar-host.c:954`), indicating
    established practice across subsystems.
  - Binding-wise, the i.MX PCIe common binding allows additional
    properties (`additionalProperties: true` in
    `Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-
    common.yaml:246`), so using `vpcie3v3aux-supply` is non‑disruptive
    for DT validation. DT updates are optional and can follow
    separately.

- Stable criteria fit:
  - Fixes a real user-visible issue (L2 entry and wake signaling fail
    without AUX).
  - Small and self-contained change in a single driver.
  - No architectural refactor or feature addition beyond enabling an
    optional, already-described hardware supply.
  - Uses existing, widely deployed APIs with minimal regression risk.

Given the clear bugfix nature, minimal scope, and alignment with
established patterns, this is a good candidate for stable backport.

 drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf6..db51e382a7cf3 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1745,6 +1745,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	pci->max_link_speed = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 
+	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie3v3aux");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable Vaux supply\n");
+
 	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx_pcie->vpcie)) {
 		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
-- 
2.51.0


