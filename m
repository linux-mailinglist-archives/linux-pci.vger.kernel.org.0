Return-Path: <linux-pci+bounces-7233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E05498BFE43
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A9B22C7D
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4790F7E56B;
	Wed,  8 May 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLprvzBP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6E6A338;
	Wed,  8 May 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174050; cv=none; b=beblYFGcyiizsI8mkSPHyGdhGYO3YedfSE2cbPyu3Q5jW2sjDv69nvRDy/fkCvcaNhgWmYBehyBbuBR0uG2AX3c7XYZc8pIsscKFzfn20EH9TrLFOyPg8UycJE7bEkV1qYHoMxXKuiBwLYSCzS8qwFreDY/i6pMFW/rbHCtcx9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174050; c=relaxed/simple;
	bh=zij3IqGLZejzZqkbvWLGGDEZbugER7QuKFOEIkUZjb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZgKYnszX20CNMfSQCb4gHuB6dVXghw6KCVVGOo+EHqSkXFHjYFuSx74WKHkrWPh+nFYXtCfgGJrYuOY/8Y1dBlTVUajkjazkoAXLz3utK7pf3bKkjDyFcnwIMJ36n62s+Pzxk1xdpcYOj7zEdS38h7jlTN5m0diF30Pnh3GKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLprvzBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61B0C3277B;
	Wed,  8 May 2024 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174049;
	bh=zij3IqGLZejzZqkbvWLGGDEZbugER7QuKFOEIkUZjb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GLprvzBPoV0oAu11Is8QP+AZVk2wFkQF8KHhN2jPTqLr0FcnWQ3Pqf4tU+K4urzOD
	 +LBVD+VhEPxCWVD53avw/BqIz6o0x5cwMo3cVoeYVZdTLIU6shElCrbhcpAGJ4JVMh
	 8vFVlOqW+aT0ix5LtEaWx/lzIQTOnaxg3ViI7ClPBCPihBO9e/se2E/BFTV3+OzjBF
	 Ji5WEhep+OAdeERMYbJLokborErGlsTWmv+ZMOe4eTGiWDMtLKfDGFggTH4fax85Te
	 2hR26C7xcCg0VR7kB2PBku2YmXURnmvJe0LYRZmak5/tlGtxDvY+FatHf+oWyAOSZn
	 qRLG0heB/eEWg==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 08 May 2024 15:13:38 +0200
Subject: [PATCH v3 07/13] PCI: dw-rockchip: Fix weird indentation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-rockchip-pcie-ep-v1-v3-7-1748e202b084@kernel.org>
References: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
In-Reply-To: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
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
 h=from:subject:message-id; bh=zij3IqGLZejzZqkbvWLGGDEZbugER7QuKFOEIkUZjb0=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKsq+onGig/ebujIUVOotn2Q756Tgd7/5fbUz4J8VzLO
 HGnlzOyo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPprWNkaHetORKhryt4yXe7
 zQTOFMWYexkqRm6XK4sUb65feczpNyPDjsux0nH97Zdt727xmiuYaXtFW2bRqpnzHeNLJi4Xu5L
 DCQA=
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


