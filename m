Return-Path: <linux-pci+bounces-6640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2923E8B0DD1
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28FB1F283C0
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DDB15F336;
	Wed, 24 Apr 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y09UtNfE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D515EFC2;
	Wed, 24 Apr 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971833; cv=none; b=tZ1LIhYqfoWuMgHaKYgJwUeitCJx9DrISWUPhuknF7iCDSapJC/TlJIZGRPXURQLo2iCYQyHn+ifb0PY4KwdUqP4D4bG4D02vGjP6L+qcWjvC5T9egZKD/jT/F/1uLaZEKM3klOBXOboxEDQq8alFiFEvZolInLn5yFEK6RSvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971833; c=relaxed/simple;
	bh=mt3fTJOfG/BTsLeq/PZ08Of6pjfAbWiTUEPasz3PC7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfWcWMtISqDadRUXQju0lFOQ1JrvxY+iWMpjwKNaUmD5OIKk0pHlmlsIXIu6jJ2MHS1nXt92et0mEU67XFNIerV+EJzmYj5BEdrqqH0tL+ijoT94AoXhxOvzd4Fy3mInW4JkMYRMuXPukt76qDXYPhQn0h1I/iihjKmwVPCfdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y09UtNfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD236C32782;
	Wed, 24 Apr 2024 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971832;
	bh=mt3fTJOfG/BTsLeq/PZ08Of6pjfAbWiTUEPasz3PC7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y09UtNfEeZ4v/d7lAzd//iB+8vNw0593Hgr7DGQfHvCxJR/5sNgsloAaDgKB581GU
	 DejVUKxqy+n7mmNr537U0hXpgduwGexpoMhG68fHagiqV3izSoAp/S8iY2tX58eS15
	 OalWx1F0l4mBPVVkDB8jY8gY6SSKXmZpBfLdyst49Vht5HJVcnUQT69UssYWu8Y/zW
	 QWY+pN5sXvIYFrzfNeEWVKfMEtbEPXpMUzJwoAuRHjHgkWzOg/jzS3k+bzrfHdiYo9
	 aVtjRbJweI8gweY5cLia1fn6mSoHMcLMi45ZwLG+qU1HlYARHcCnAOo2vGkgfXICY7
	 R4ysVG19Z9Acw==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 24 Apr 2024 17:16:26 +0200
Subject: [PATCH 08/12] PCI: dw-rockchip: Add explicit rockchip,rk3588-pcie
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-rockchip-pcie-ep-v1-v1-8-b1a02ddad650@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=cassel@kernel.org;
 h=from:subject:message-id; bh=mt3fTJOfG/BTsLeq/PZ08Of6pjfAbWiTUEPasz3PC7A=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI0lYJ2y/fGNOTqfro6JYKxKX7a/di44+bbeC60HGDmU
 3RVF5TuKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwEQ2vmH4w8sXZJ2nuSR46y6H
 Q1VMByZaxh5j/7bwBWPXm5B//14eOM7IsKMpSTD99Ub34NCzcUs2/1rmWcOheIFzwbYf+jZTJx/
 i4gAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

The rockchip-dw-pcie.yaml device tree binding already defines
rockchip,rk3588-pcie as a supported compatible string.

Add an explicit rockchip,rk3588-pcie entry to make it easier to find the
driver that implements this compatible string.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index bc1347e84f72..332ada5cb9c6 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -400,6 +400,10 @@ static const struct of_device_id rockchip_pcie_of_match[] = {
 		.compatible = "rockchip,rk3568-pcie",
 		.data = &rk3568_pcie_rc_of_data,
 	},
+	{
+		.compatible = "rockchip,rk3588-pcie",
+		.data = &rk3568_pcie_rc_of_data,
+	},
 	{},
 };
 

-- 
2.44.0


