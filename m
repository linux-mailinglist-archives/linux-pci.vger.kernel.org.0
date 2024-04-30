Return-Path: <linux-pci+bounces-6877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71438B7541
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 14:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FFA1F22C07
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060C713D53E;
	Tue, 30 Apr 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mshrpd3+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE413D289;
	Tue, 30 Apr 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478546; cv=none; b=MJWW9HXxkl/aeD14emteZFCDiG75WjAfirt1m1dEXjBp5/U3PhnqVW0EZX9yLR1ziWzmx0VFY5dYoPD5P+9C6VK+oW//944faRBFvwbil/pmuZwaUu0VsxCAzuimR1epm5R6gqGk1W2wltr6SdGJ4jlsam9ohTpbLaiWEHwmVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478546; c=relaxed/simple;
	bh=lzJ2BxKBBswxjN9lBrWUoaKYI/aG2NTtIprX120aOD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TVhSlJ98dHCCAv+CP84WwuJ77P9RJGz23G15rCe9Ha13MHRforR1g3PmC8HS1rAcnG9hsg8ybda9XjfCHKovCwa6CJSpMc/sdK0B8Tg8Ufv79SEGU1O6T8al4WcCwTvh3xoEwQyP77uBmJ1gzTOC1l4YthMN/2kVW86HxBIF8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mshrpd3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC8DC4AF19;
	Tue, 30 Apr 2024 12:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478546;
	bh=lzJ2BxKBBswxjN9lBrWUoaKYI/aG2NTtIprX120aOD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mshrpd3+GxeXid8yQwzqyaI9ns5tOsXZMqB0SmwCgCCxjhboCwiHiY3X83OacEbzn
	 hBjfOrR+sKtjWYhJxFl0XxLYi6d1dHM8iysbDBIKfrUetJjK/adMcN1GlY+x9HxCnB
	 Xiz36g4u3Q0I6Lz02uj7AiYvzYLCrAIZJXrh8+KD7CLFgtcaSK5Yiyy1reLAXwFNBC
	 H/X1DVas9vnQFgrq+ATGLLI+nTdC1TfcVAQNckUBE0bfMkkCGJhKA6ZfTl2pZiWh+u
	 k1OpuAxuzC2ZRkfkVei2dJRX1IDW/7szMUSUNx/Xo6nZ1sXKb0jcNzppKoBoF2mB9M
	 SovevHKW4CJqw==
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 30 Apr 2024 14:01:04 +0200
Subject: [PATCH v2 07/14] PCI: dw-rockchip: Fix weird indentation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rockchip-pcie-ep-v1-v2-7-a0f5ee2a77b6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=cassel@kernel.org;
 h=from:subject:message-id; bh=lzJ2BxKBBswxjN9lBrWUoaKYI/aG2NTtIprX120aOD4=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIM7m7Y9e/gD7YlVyYUJzaoewtGKy2Y0XVgy/ZFdfejV
 9ZN01c70VHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJyMQwMuzTmntRV5k3IyxS
 ePqZk28aPObOSOhYITnjuOJE6X8Hbksy/LM30/x+r3Bqa4txlpLE9b/G6+a8vBFTHhIVua7kicb
 lmwwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Fix the indentation of rockchip_pcie_{readl,writel}_apb() parameters to
match the opening parenthesis.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index d6842141d384..1993c430b90c 100644
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
2.44.0


