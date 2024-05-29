Return-Path: <linux-pci+bounces-8004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE568D3187
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88C21F22E78
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791FE181326;
	Wed, 29 May 2024 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFGVC93v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16416ABEB;
	Wed, 29 May 2024 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971383; cv=none; b=cNF87aq/sD9PdICYQz9LjXlC0RV2kcAdmxtDpjY/APZNEkV3r1ld0T5yvzsaTRX5MPorMLRXB80PBXeXHA4NOAJvolfpseFZ2XfFCQa+qlL17kOUQGwq0vuIs43SLjh8qEw5IttIsUhrDXT4I/N4zcYkB4U5WSbQ6VTn1vF3NaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971383; c=relaxed/simple;
	bh=j29Odjmid02gVXIY5mRFCi+Esy8gIr9tXG/wl62J2qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e74r9dGn/tABNxhhAKEj8lNpVt+2d79NGW4Xz2c4ZmLP+/hSMGkHjSjNXffJsSUbZNT5IJpSKOxPADv9b4FEpfa/QIDphseqyS51jyAHlk/Urms9pRAnk2xT9z1KjE6OX0b3d+gpdKF97dPVVjsEf0VGA6XxDIUTQDifXduY1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFGVC93v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD3EC4AF0A;
	Wed, 29 May 2024 08:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971382;
	bh=j29Odjmid02gVXIY5mRFCi+Esy8gIr9tXG/wl62J2qI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RFGVC93vi/1w7P/FWNhVdBwm1mpeCcOFUviLios9IyLqeoSSHA/D/z8wlYXVys4RC
	 F4H2umpX32USOj8b8AaoyvuAUzuhVOs4EnxXq6mXZo6ajpluMp6KKy7+NTD+XM6pWd
	 78doFhIvyx7GooTRDiKxhhP0zIvqf2J9YNyuFzVJIoNyDr9pbYAlIx0maZmv9B7/Xe
	 Pkf+RumNOZ0Ln1Q4e0Wna0FoHdkFRwjUdAjj82jaYTKOy5SDZkOk18JS3A2Cew64Ed
	 xFFtFothCeXw/QV1IEwlgoveIsLvWSMGZYMX3mzLagQeLZIE3RtEM9xRDYgqr2mMZb
	 Q91twdZtTvpgw==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 29 May 2024 10:29:01 +0200
Subject: [PATCH v4 07/13] PCI: dw-rockchip: Fix weird indentation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-rockchip-pcie-ep-v1-v4-7-3dc00fe21a78@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=cassel@kernel.org;
 h=from:subject:message-id; bh=j29Odjmid02gVXIY5mRFCi+Esy8gIr9tXG/wl62J2qI=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLCnoeevvBM8P2lxolLF685d/3q2VuF7AclEhxTXOI9J
 0ozdVyL6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEeBMY/mcIV9clmN7Mlnz5
 stO+wPLI1YdXIq9Lvz83xaXnhrnNRX2Gv2JOG7ccyfHr1q2M5bmarJO2ZemkHSvnX5utb5JXLSD
 UwwYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Fix the indentation of rockchip_pcie_{readl,writel}_apb() parameters to
match the opening parenthesis.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 61b1acba7182..3dfed08ef456 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -60,14 +60,13 @@ struct rockchip_pcie {
 	struct irq_domain		*irq_domain;
 };
 
-static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
-					     u32 reg)
+static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
 {
 	return readl_relaxed(rockchip->apb_base + reg);
 }
 
-static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
-						u32 val, u32 reg)
+static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip, u32 val,
+				     u32 reg)
 {
 	writel_relaxed(val, rockchip->apb_base + reg);
 }

-- 
2.45.1


