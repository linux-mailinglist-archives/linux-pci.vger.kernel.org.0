Return-Path: <linux-pci+bounces-8454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F57F9001C6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 13:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9181C21B24
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784E615821E;
	Fri,  7 Jun 2024 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRTdJ0dI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A018249F;
	Fri,  7 Jun 2024 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758905; cv=none; b=dfJrZkIvS5USUzTIQhQ7od2X2WuTrpV9LoG7FjKTy+Mavjik1yZ/h+6MwI72+ZXjuHQwo3ARUDl2xh50W66GEbZv/I5RLmmZG9CfVBwUfHkD7KdMxZJXaIeuqnGUUw6lq5l0JdAmDmm0XgyIhx6/srTzwg4HwUttLxSl26kl09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758905; c=relaxed/simple;
	bh=Do8GU9Lg2HtlRwxkwoHL7mqEXY9onLHHOVGqL0ZdFBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LN+M1V2T9pULwie4yWeysHI9+IJnTD602rrDfWUAkBoBCOVpGkbuu7Wu4kzwCarTwSh7qs3cGGTPadvEARuyfOPlrE15SI328yrlkbtkyTa++9guNngYw155iV78nHzH/Pc7g/M+djsrym+BBrBV9t/gNEH1IJAltVBwsXsn4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRTdJ0dI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE6EC4AF09;
	Fri,  7 Jun 2024 11:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717758905;
	bh=Do8GU9Lg2HtlRwxkwoHL7mqEXY9onLHHOVGqL0ZdFBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uRTdJ0dIfABOQpolMQUyKwBxLeRdBZY4qaI5j6f8qMN2UiFO67np69LnIrjtok4QK
	 VXbECs6MdxqRc4biUIo79SuHs/Nm0p+Ilw1GfqERduAr9viPMnqIEHVaN6Y2fh8HXR
	 xQntYkZ8gHx2yvp2jXqoozFzyXydPMtlfevflTj6zz40ZtRFEwBunyUDL10JyYlZkR
	 2aweCOjOJyxKrg3DfFdVES8tJJIOaT2uIABdGFY64s4EOeqlH3pMbTm2NirFgv3uPm
	 UHhcMzBYZ2hxIgP9BJMzhmJEkb/bqS0X4kMSyzbV6d+I8ZelMd04Mw0ADGnqwbAcMV
	 LAUU4UoLdzTuA==
From: Niklas Cassel <cassel@kernel.org>
Date: Fri, 07 Jun 2024 13:14:28 +0200
Subject: [PATCH v5 08/13] PCI: dw-rockchip: Add rockchip_pcie_get_ltssm()
 helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-rockchip-pcie-ep-v1-v5-8-0a042d6b0049@kernel.org>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
In-Reply-To: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=cassel@kernel.org;
 h=from:subject:message-id; bh=Do8GU9Lg2HtlRwxkwoHL7mqEXY9onLHHOVGqL0ZdFBk=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKSXk8SLA+vkj/EPy1TSmob8ynOL4+PHLZfOvf+PDWz5
 Vuero2e1lHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJpE9nZJh9sm9jof2/iVva
 Xv1LdO7jNVpZP2H7w/Pzth89YFh/vXwFw//MlctPM/Nl6XUIpvNffntdueLmhAsxr58nSgSU12/
 bys4HAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Add a rockchip_pcie_ltssm() helper function that reads the LTSSM status.
This helper will be used in additional places in follow-up commits.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
2.45.2


