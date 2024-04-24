Return-Path: <linux-pci+bounces-6638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C9A8B0DCD
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5C91C25166
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C935D15EFD5;
	Wed, 24 Apr 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPXtupJw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3DE15EFC7;
	Wed, 24 Apr 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971824; cv=none; b=Eifjr1j91le1bvsu4dCv51AN/X1aEk2e/Lo2GBalH9yDelEsiJnrfPzpn+qNU/8rW9UtYJ6Tqef3usUW/Sc2Wt08SB/gBpQqvcOtAM0g7km8HnY0BlO//cO3tNlxgCb5fQMKgY/uB8b92v5LLSCtCK1bxZg8iBIWO9C/QlTdl0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971824; c=relaxed/simple;
	bh=FF5kjYOiGGFH7JDZ21aiyiTHxQMew/SAJYkr6QWZ3L0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxcaMhDHB6sLNNYPx67U7qBY3GbGXLgs13iiEMGmoxl3jdxTqO9UrrEk9AgXZqsxBwN9v/Pbsvq0uOh4gjjWuzR8Vqcs/UefhcNjY4B+biCzr469yZrXG0YfH/7uRZcUmlbi+hx9fbOMTOqSbzA7tr+rsggizcuil5A3AP79Nj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPXtupJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72145C32781;
	Wed, 24 Apr 2024 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971824;
	bh=FF5kjYOiGGFH7JDZ21aiyiTHxQMew/SAJYkr6QWZ3L0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gPXtupJwvQI0VzNSJo08xI3gOu5/Ce1onCCtgbRBU6w8nIhyI//SwKptY+X7V6a6f
	 4gJurYIcOHkLnZEiQ6wdrqxWIITWxirB/R1+xIAj9NXcCbr/1IP08znLyJV2SHoDPx
	 1KTfbwwXe6PNs2rVnjWCAyEij0Asw2irl7clK4658/EjDGwqJZ+cc8iy3LiDAf/5uG
	 DdV1EKmOoADD7FgjfDEchDS4nHBFO8KpW+K489iJ8WkTjrGlSYJCf4i2yfGSKSgBja
	 YSRS8q5NcIanAf4IresMrEZlTMnNtgW+0TgWiaye/tkzSzhPE+xI39qO0TBhld4pjB
	 ije6TNVTw4qWQ==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 24 Apr 2024 17:16:24 +0200
Subject: [PATCH 06/12] PCI: dw-rockchip: Add rockchip_pcie_ltssm() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-rockchip-pcie-ep-v1-v1-6-b1a02ddad650@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=cassel@kernel.org;
 h=from:subject:message-id; bh=FF5kjYOiGGFH7JDZ21aiyiTHxQMew/SAJYkr6QWZ3L0=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI0lYI6nypunOamvWVTwsu+uqMWanlv+yY39C54Hjxr4
 ikv2YOzOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRRW4M//Rv2ccwtHZM0zzF
 UfJZNDyzRnlxM7/GLrUNSvNcriRrlTL8dzi9KMCW5VKW2KcwsV/y61b+8FJ7F/ZXn+v3movfG1l
 d2AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Add a rockchip_pcie_ltssm() helper function that reads the LTSSM status.
This helper will be used in additional places in follow-up patches.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1993c430b90c..4023fd86176f 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -143,6 +143,11 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
+static inline u32 rockchip_pcie_ltssm(struct rockchip_pcie *rockchip)
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
+	u32 val = rockchip_pcie_ltssm(rockchip);
 
 	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
 	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)

-- 
2.44.0


