Return-Path: <linux-pci+bounces-8005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FACF8D31A2
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88828B2EDC2
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A715B16936B;
	Wed, 29 May 2024 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRNGiRuS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80265374F6;
	Wed, 29 May 2024 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971387; cv=none; b=Mgrj8QpRQDOEZBsa41tPt/4n/0QDa/a8bvvKw2kqQ8YjcWodzT7QAXb1bxamvE6Wb+GM6IAc2W7fx6GCJuL7Xrpwfafyb1Q9GIyyOMxJuUDWgH5czEfHItakL2e9TZ+lcgeJ7M3EEX+GZNHilUwdBqzggpPh2PQEPiRrDYRX9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971387; c=relaxed/simple;
	bh=HSVP5fO1xteYLr3eNC2G4UOEz2LEMqziZSkp+Sf41N0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cuma0ef5gwOKrk8bI60DTamGLIqzIS6Qaw9LTmg+52lhB6kU6XKN7D01Ggrn2wGRD6A83UQC7SbZmpzLihQIh3JLTvSzyJIhqHOtmLZX1A4n7xa5CQ+HOG2GcGpDEZHu1bW/JqRSQJMGDRMu4avaVF5HUbJqbwmtW6MLs17oNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRNGiRuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB7CC2BD10;
	Wed, 29 May 2024 08:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971387;
	bh=HSVP5fO1xteYLr3eNC2G4UOEz2LEMqziZSkp+Sf41N0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NRNGiRuSrg3XQvmSdOFqBeLUMZzgzkBW5Xz64cPyI8nrqs1N0pSHv9nDK5CHw8UOn
	 Khbl/n25WgD+f7yVQz0a3wUCz8p6Di9WMKmlsPQR93TH9wBUK5GUsf6osBTjuRte72
	 3kSVjARIAQ5GiBFkKaRILNDlqDzuTp/JzYlCLLlyQuCmwVFNe6LGxSCd516/Cf6Viy
	 zFbbx3nMychM1zH0ikxVUsYZBHJ0p12ybUKTOwiyl5Ko8AW1SfiGbb/xCoxWZ4PK/3
	 fzgBu77mseltWWamhU0mwKofrElyxLfLrcDDmOeRE5ljIb5lL4QcVJWcZvPbwE3l4C
	 5h+QiQTzpwoEw==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 29 May 2024 10:29:02 +0200
Subject: [PATCH v4 08/13] PCI: dw-rockchip: Add rockchip_pcie_get_ltssm()
 helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-rockchip-pcie-ep-v1-v4-8-3dc00fe21a78@kernel.org>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
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
 h=from:subject:message-id; bh=HSVP5fO1xteYLr3eNC2G4UOEz2LEMqziZSkp+Sf41N0=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLCnoc68fivD7KdkMf+XcE076Rx4JLj0xfdKLRVfjP/w
 sUq/uB9HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIQQvDPwX/QvYryeE7yo3W
 neM917/picEVo/uNrSHdNQxF9xZc3MnIcGufYtubLc8WGvx64berIso9TqnY7ceJyUXdKtEn6/O
 yWQE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Add a rockchip_pcie_ltssm() helper function that reads the LTSSM status.
This helper will be used in additional places in follow-up commits.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 3dfed08ef456..1380e3a5284b 100644
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
2.45.1


