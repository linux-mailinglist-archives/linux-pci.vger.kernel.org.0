Return-Path: <linux-pci+bounces-6878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD518B7542
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 14:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E94286602
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 12:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4537413D881;
	Tue, 30 Apr 2024 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcaGiXU4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE9513D289;
	Tue, 30 Apr 2024 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478551; cv=none; b=SLVmNYmXb2VysNB14vow8STZ7Zn3h36QQN/KWgSHzrDJNvx3aajWS5aFjJJTOJ/JOKEzuvax2jYoHx1eaafpfnSDw1PxKjaRB7cvrngHPVHzniKgm8/9xkz/Tf0NI3fBRkHNwwPJCfo6d6KeouSb6fc5J4974lT783zxWyJTAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478551; c=relaxed/simple;
	bh=FF5kjYOiGGFH7JDZ21aiyiTHxQMew/SAJYkr6QWZ3L0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5l5/QU+FWhL7bZFW4hSTDObxMSq/IKyXnag6c371dGoPk0yhr9LWCss2zfMfeSGWg967zFwocVZAHw9ADp9jZWwSRCfmqQ/ieNbLQY4lNrZm1V+5AzC3jy0j995yOgeO3dOEGGPvsyGdN8tSUSYAQiU9vse/X8Bd9GYToCydCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcaGiXU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2E3C4AF1C;
	Tue, 30 Apr 2024 12:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478551;
	bh=FF5kjYOiGGFH7JDZ21aiyiTHxQMew/SAJYkr6QWZ3L0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KcaGiXU402q2xQs1/uLSZa/2IXGGF1G1oar16jKhwao5h/3LvE1Cr8fpKyoOQeogD
	 3+76kl+NvaU+nVPkuWi+zhdQ5NOUBJJfFqbzz94OTjWDgWcyAW/Uvph7SUWZRdv4nv
	 i1S9f5Y4Uhem+EEbjhh7YquW7EAEFgoNdQsHZKBw97txvORKVhRMqBQJcoZleVecrN
	 UL5S2CCqB5+BHMz8zfsa1XMQ+rbwiMZquwAZzTwvElOKQ4eUrXh7FiZq/USfbGOQGS
	 dnfA50YMvZ/jqfrwHhdYb17cPtE/sslhfzBqKw5SSJRlBf3l9Tp8zBxoi2rKiO/3zi
	 h3Z8JkTXyEPuA==
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 30 Apr 2024 14:01:05 +0200
Subject: [PATCH v2 08/14] PCI: dw-rockchip: Add rockchip_pcie_ltssm()
 helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rockchip-pcie-ep-v1-v2-8-a0f5ee2a77b6@kernel.org>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
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
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIM7m7Yto2TsXXa9x3nrPfs9TMQ+7DrU/zR4y1KWS5nS
 m8rMOhd7ihlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEPiQyMnzQyH+4l3d+9dO9
 is6/p825cCD4fILegV/LHr1UDn45v7CQkaHD4/Uc7t3c2tf9Tzf/05NtSIi8spShnfXWdOWM6ni
 GU8wA
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


