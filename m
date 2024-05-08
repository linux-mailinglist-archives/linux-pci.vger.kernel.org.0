Return-Path: <linux-pci+bounces-7234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2369E8BFE45
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F1BB22C83
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878C8811E6;
	Wed,  8 May 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHn57ocs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5116A8A6;
	Wed,  8 May 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174054; cv=none; b=FQQPMXchinh71CCyDARvVpBfQAn2zKzOBzbQFDlel2AVkYqzn+3/YAp5cB2FVUM6H/w4Hx6zpidsitid/OB55ZLimAb3ibf/qGPDFtGGHsz6cuLEBMz46hFIMRL2hMonWYSyeib9AZrTZrvW1MOndY8v9HM24eSVYqyW6C+2PEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174054; c=relaxed/simple;
	bh=KjWl1JIkPYpwTbCHiK+X6uD304vyVCxgjTUQh/FZ8VQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSPYPEz+0DMMXziDWyiQ1v/+5KDpONebOFkcFMLsPqMV1SDIEWy7+CiVkpgzajLuflqrMn4q9NOelfryUGbFu0d2WIC/uHOzkfRqBWWbSkVASL2eU9ybYSPoSiTWrVZ53V/ZIy8ZV6B6QnajrW/ISaMZteJVjqnXWjlaK+LLDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHn57ocs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1E2C4AF18;
	Wed,  8 May 2024 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174053;
	bh=KjWl1JIkPYpwTbCHiK+X6uD304vyVCxgjTUQh/FZ8VQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IHn57ocstpd54cLclBPMY39ZzBo8WFq6ybv73maNAwKmjY5aAKpT71jkYnqEKeQvK
	 iUwUJ0E/brCpqBpIDDE8znwSfQfbQwBmKorNhJ3SVdmp3RB7kmwOylJDDSTUKpNCp8
	 e16QK/vXLNWD96ChzJB9Pz6DKDxFRDB4yJJTNb9DltRPLXUfaEE81Va+ijUAdDjoU/
	 gNfgdZw5PXrJn8MHOiLkkI70t6M/A/U2X7+8K/iNJfQFke6TABfeI/KLLO3CcztO+r
	 JAK81eLq34aqETle8tv5K1Jg11X9EOJ8hBB5ZDZCI8q6MIr3ruCL3lmdtqnoqAig0t
	 6VlWYY6nayMiA==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 08 May 2024 15:13:39 +0200
Subject: [PATCH v3 08/13] PCI: dw-rockchip: Add rockchip_pcie_get_ltssm()
 helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-rockchip-pcie-ep-v1-v3-8-1748e202b084@kernel.org>
References: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
In-Reply-To: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=cassel@kernel.org;
 h=from:subject:message-id; bh=KjWl1JIkPYpwTbCHiK+X6uD304vyVCxgjTUQh/FZ8VQ=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKsq+pf3pnzwPfPLnl9845TN/a2dP5Rnyzr437mcFe7s
 5S7S9qijlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEyk8AHD/8B9+j5cp3oM4755
 +sVufHEn07xav1RSMCEg9S6DQq/HG0aGF6s3/LnzvGNG8NTyci9POwOJOY0Jh+d2nYjXTd/xpEC
 eFQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Add a rockchip_pcie_ltssm() helper function that reads the LTSSM status.
This helper will be used in additional places in follow-up commits.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1993c430b90c..2a70326cc0bc 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -143,6 +143,11 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
+static u32 rockchip_pcie_get_ltssm(struct rockchip_pcie *rockchip)
+{
+	return rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
+}
+
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
@@ -152,7 +157,7 @@ static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 static int rockchip_pcie_link_up(struct dw_pcie *pci)
 {
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
-	u32 val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
+	u32 val = rockchip_pcie_get_ltssm(rockchip);
 
 	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
 	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)

-- 
2.44.0


