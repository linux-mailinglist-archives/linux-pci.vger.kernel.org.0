Return-Path: <linux-pci+bounces-23173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A12A57639
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 00:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D0F189B5E4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 23:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6572139A6;
	Fri,  7 Mar 2025 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Acw2g1gV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909561925AC;
	Fri,  7 Mar 2025 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390679; cv=none; b=IZva8KIiVWbaxbvpEq1OGo0riAFkDMUEh4I29h92FXZtruKDjnNXfMnyp7eVTrJsblm0G0h+JKZNtaM2fobeDI+vYMe1IBbfemP0FlC4x6YgUWXEuIQBPCPL3hETLnpPhDZOzPfixjkZ/C339jbxkAY50zRs+/q/iGzS6ZOU0aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390679; c=relaxed/simple;
	bh=/Vd5KWvSiGu6/wCPX+6AfloWDVGSa9tpnOhgexIbXEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxy7EWaWbZB5Yxw8oBd7Lw5/gxBrVAqEQL8XUjDfS3VUAEEOplJMm+JUkX7/q4cafu/q6/q4hZRZPDJ8yJemfAON4UHLdB6l5J6I/9WsUHA/OmX4s5KAD00TzwsrMdo8lcW0GOUm6SfcGqTY4riekX2g3z3+KtcWzG89p0p63qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Acw2g1gV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84F2C4CED1;
	Fri,  7 Mar 2025 23:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741390678;
	bh=/Vd5KWvSiGu6/wCPX+6AfloWDVGSa9tpnOhgexIbXEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Acw2g1gVGlLFYF0SltDeaIZQ9KwE6vcOMVM6luvqFnf40847eeFswIpbIcKP7nYmK
	 kLfy9MxLzQTzSH6s3Z89HAKeYyAkRWntv/8ABqAaA448ttme/dLea5kZsaYAmqFFP6
	 ewMoOpEu5OkfDAbLuh5EASyV3tIAxSSUSiaBKwXNsmbTY+PqEmSmd/X16B+bxvRwXa
	 9F/AJYwbCjcu98r6x2PN4GM8JR6ll0mddTmGzUA4jduF9Jzp4gcmcMbI/9IvFdElM6
	 jH8I65HYqEKV1VKtGUdzKPSm++TdZHO7sRTdZkbXMfSAhq3YKLvpUe7U34881mIz0B
	 r8S0mvulLLNqA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/4] PCI: dwc: Delay cfg0 setup until after discovering bridge windows
Date: Fri,  7 Mar 2025 17:37:42 -0600
Message-Id: <20250307233744.440476-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307233744.440476-1-helgaas@kernel.org>
References: <20250307233744.440476-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

devm_pci_alloc_host_bridge() reads host bridge windows and any translation
offsets.  Some .cpu_addr_fixup() implementations depend on the window
offset, e.g., imx_pcie_cpu_addr_fixup() uses the offset of the first bridge
window.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index de2f2dcf5c40..b9eaba157dae 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -456,14 +456,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	ret = dw_pcie_cfg0_setup(pp);
-	if (ret)
-		return ret;
-
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
 
+	ret = dw_pcie_cfg0_setup(pp);
+	if (ret)
+		return ret;
+
 	pp->bridge = bridge;
 
 	/* Get the I/O range from DT */
-- 
2.34.1


