Return-Path: <linux-pci+bounces-14706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9DF9A1833
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E44283BA3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26C2CCB4;
	Thu, 17 Oct 2024 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIMvmO3x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7FF4ED;
	Thu, 17 Oct 2024 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130336; cv=none; b=Yx43gB0bhct5X1MiTWJYbljE0i6VBxGdHb4HXH60zPPIeQH+o8FGPOTuRGVNrK+Yt2GxwXxY0Z6j/7HfpY0bIbKZxrbxjQiCRU/o8IepoH13IHvFOG+2D/2ypFpUCJ0iS8LGZD8P7hCcH1fVzxvRN5oLOzPbnS0fGSFpGahthhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130336; c=relaxed/simple;
	bh=zQqRrc/dvgOEU1I54D/JpkTrW4JiU5wFmnUl/V52Wko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMRU8rw45wcQxMWu2vT+nhlKL5uGSdj33Z/Bl6lZkfXmAqi0F4J3wTRoiacSLamxMGBbi0TtZictXt/KjG33k2tRXrXfSnJEKqq8Q/Q8fsdkeRPm5/DM2kgCE1MkybF5kPijOjsx9y5M4PyjcxAw0IYloitpomVjLCMneDUWAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIMvmO3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6B0C4CECF;
	Thu, 17 Oct 2024 01:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130336;
	bh=zQqRrc/dvgOEU1I54D/JpkTrW4JiU5wFmnUl/V52Wko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIMvmO3xsvyiCZx6PkUhTJPk6j51/4/b9Tl3axx/A84NhFbWRIqePt2QA4rQKB537
	 AZ0Nn/b5GbLNb4b+Ty3mD/YGM2unwWyX5xMrAVP/1+46poFyxoUWtwfDcsZH+21H4k
	 ugRqPGGSP+TtvSi9rzeGzQx9n9LLdSb/+dKo3yRqnK0S5ID1KomKr/OT2eX2xqAS8e
	 pucvPqWC+Nu2X8y8rdB4FaYcv1j7CJfsn3x8fAesKo4w2GtsTJndLyegaY448ufzsl
	 wMg9V4ZaBhrudm4R1IPgOCwhfT1o5qKPehT32FqlVhTWAWSF8VzpteYBbVO8nOjYeJ
	 rA86ETS6Ysgaw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 02/14] PCI: rockchip-ep: Use a macro to define EP controller .align feature
Date: Thu, 17 Oct 2024 10:58:37 +0900
Message-ID: <20241017015849.190271-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017015849.190271-1-dlemoal@kernel.org>
References: <20241017015849.190271-1-dlemoal@kernel.org>
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


