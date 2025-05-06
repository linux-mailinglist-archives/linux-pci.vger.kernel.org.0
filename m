Return-Path: <linux-pci+bounces-27263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFD3AABC71
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 10:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB077B7CDA
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E813E47B;
	Tue,  6 May 2025 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP0Lfkva"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A472205E2F
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517198; cv=none; b=LG8+oJ3SA8tymty8MCIFVhrK5jL+QSJ5NCiuSKPTxKYOGr44Y+yjPGow367DjmF+3Fhc99rWMbi8dbjL9OuXNfawijxFqNnsjS1GaOw5Sert5P8pWJCHDJv7DKsS1BZV5lrwzXSoJHXopycmKvXYne5cmKNLL99BD5FRMbk5pUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517198; c=relaxed/simple;
	bh=AER962ZuZOG4wg10/L/A+V16dE9LvDSa7EDpShemSR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWUWyQY9znxlwmSHBmzExMRnDHl61g58SbBF7kT68SWuUW+gxxnGreg0/xon+2+BNJRGWENOSkNgBpV7P1yYgQXdFLt0FCu1hSdoiY5KsXLb9a4/tcJNMcrThvRL4UoSqJr72fznf5cdAHjek4suMOE9dJ08bnjDu9ZcJNlrbOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP0Lfkva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14F2C4CEE4;
	Tue,  6 May 2025 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746517197;
	bh=AER962ZuZOG4wg10/L/A+V16dE9LvDSa7EDpShemSR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HP0LfkvaCaUaq/ASe75mL4MzHbEBt0Siq4iUkOIixnsNFQUbcpi6mBrxSTCQ/FURw
	 rIC+BZohwUELQQgvtnW4rXOePJLkSKTn+0wbCnH3AVsXAUsVNnZdt8GadaFXb+nFB1
	 F9q7Hr/MvqlqfsDY4Ehy/fvB8eOJr0J95PcOV8ypo8Lx1b4hayjQFepDthrrtGLc2j
	 LmC6iKR9scGGgTWZJqKXMa6iHbRHVhf2Yfr4EFDJxA2rJH22iH0/OcaFH4/GZujFmx
	 VdZSnCSXBThLidB1jQMtk2LBMqfvZJUjoZ2PRLIMrgvMsBjpgNVsJPnSrRgZ1Q2Xfw
	 uZJG3PwfiZzuQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 3/4] PCI: dw-rockchip: Replace PERST sleep time with proper macro
Date: Tue,  6 May 2025 09:39:38 +0200
Message-ID: <20250506073934.433176-9-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506073934.433176-6-cassel@kernel.org>
References: <20250506073934.433176-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=cassel@kernel.org; h=from:subject; bh=AER962ZuZOG4wg10/L/A+V16dE9LvDSa7EDpShemSR0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIk9+zun3Xrp2Prl8+vjr79rMs+zTtpwfFV9tI3OiavO CJnn/VyYkcpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAm8jyA4b+P7ffq8F0ucu9j rtcWTr0r1b/h5srN0xklQi4uzN9dv9eV4X9QFA+zyLsbFTO+OM7kKLz3km3Z/rln3+3hC13r6SW 2wZ8NAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Replace the PERST sleep time with the proper macro (PCIE_T_PVPERL_MS).
No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 6a7ec3545a7f..0baf9da3ac1c 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -225,7 +225,7 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
 	 * We need more extra time as before, rather than setting just
 	 * 100us as we don't know how long should the device need to reset.
 	 */
-	msleep(100);
+	msleep(PCIE_T_PVPERL_MS);
 	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
 
 	return 0;
-- 
2.49.0


