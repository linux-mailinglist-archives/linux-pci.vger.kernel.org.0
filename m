Return-Path: <linux-pci+bounces-14295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D0699A38D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E141C21532
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D5216450;
	Fri, 11 Oct 2024 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+OfFH4s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3321500F;
	Fri, 11 Oct 2024 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648856; cv=none; b=pF5cXOI2mxWxVA+c5Ekc8MAS9TixjMnsWOEZT8kZLTatSqXIeuCWGLud85f5X1SGkg7DX8QrjCpBlowcfNxkp3rdZGYP6IyuYIP42kp6F//f0GCRa8OKjsFM8Nclym4o2T1Evy4U3HfJAioYzy5zqmmWtu2RiMjUTFSqbjhbLtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648856; c=relaxed/simple;
	bh=zQqRrc/dvgOEU1I54D/JpkTrW4JiU5wFmnUl/V52Wko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbSUPERWhqJ7P33QxKKf5qt6YDaGV9gIdAhci6CYWIAbuym5cR8cYoqvLRZ9Ys/ygD3jztYvufrAmIFt+YJPraPWf3vSLNp8F1Jr8FUkwH7OLpwijhcnmQgJKSbv+8jHMLOQrQSU2ePbw3QksyOMeIcAl4b2xqrcnUuiYXBg2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+OfFH4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231ADC4CED1;
	Fri, 11 Oct 2024 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648856;
	bh=zQqRrc/dvgOEU1I54D/JpkTrW4JiU5wFmnUl/V52Wko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+OfFH4sv0rCu/sTV0MyrtVr/CRTlDpYdRJ7ENI5HlTrl1W7l75ZStre3YEczDkI9
	 Q13jbLghGcVWP5kuu4P9Qtg/+cLdYthA6Ufh9YIXxe9SMtPkiWgTLAEM33GHHM7vOP
	 QuzQy5McInOTE96wKH90Ocp/v+O2fz2A+ALsqApRnptA37rlhfpvDKgYA+RcUgs4Ob
	 mn7WiUOc7k6DoxpK/5CW9so6oFAhTiS9B9ozCkP5gi//IXzuX1PzeEcUBszKKIGBAj
	 9cm3jPrS6NGuoM5KsDSTdvJ6I5h69d4Te9e8EBXY2KN/7FpYg8lOuYoNZF4VgPo/JP
	 Po8PVIgI2Pqbg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 02/12] PCI: rockchip-ep: Use a macro to define EP controller .align feature
Date: Fri, 11 Oct 2024 21:13:58 +0900
Message-ID: <20241011121408.89890-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011121408.89890-1-dlemoal@kernel.org>
References: <20241011121408.89890-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the macro ROCKCHIP_PCIE_AT_SIZE_ALIGN to initialize the .align
field of the controller epc_features structure to 256. This is defined
as a shift using the macro ROCKCHIP_PCIE_AT_MIN_NUM_BITS (to avoid
using the "magic" value 8 directly).

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 2 +-
 drivers/pci/controller/pcie-rockchip.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 27a7febb74e0..5a07084fb7c4 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -446,7 +446,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
-	.align = 256,
+	.align = ROCKCHIP_PCIE_AT_SIZE_ALIGN,
 };
 
 static const struct pci_epc_features*
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 15ee949f2485..02368ce9bd54 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -248,6 +248,7 @@
 
 #define ROCKCHIP_PCIE_AT_MIN_NUM_BITS  8
 #define ROCKCHIP_PCIE_AT_MAX_NUM_BITS  20
+#define ROCKCHIP_PCIE_AT_SIZE_ALIGN    (1UL << ROCKCHIP_PCIE_AT_MIN_NUM_BITS)
 
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
 	(PCIE_CORE_AXI_CONF_BASE + 0x0828 + (fn) * 0x0040 + (bar) * 0x0008)
-- 
2.47.0


