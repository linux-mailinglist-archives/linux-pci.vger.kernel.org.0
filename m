Return-Path: <linux-pci+bounces-14708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788119A1837
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294B11F26CD9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDCF282FA;
	Thu, 17 Oct 2024 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz+6vzb/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D7FF4ED;
	Thu, 17 Oct 2024 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130340; cv=none; b=kPRGuFYdg5MQCfZJJiNTwdb8kQUt4EuRcsrPEM9kA7lA3bmAmmp2lrfumBYeqQlHxjAricqiszyFTBxUdVktXoJ0OHds6vtsZ0cqN4PXMVQhr7GPTvfB+BUPCvuStIHACRuOPdtVyBMPjI5LKLrxExI5zphd156VJlE8km0dQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130340; c=relaxed/simple;
	bh=fQ5LGyIBaK46oPYJY75HQ+s1l6zSxG5jS7LECMmdORg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyYFSDsvR0qAO9vsSTFztpXbEZQo5KgghEeblWnFdIvgCfu/OjlwZXOPxsE0qmtuj82REjbJvF2PZj6b9/bq7W9AU62UbiFaboAiJBiiOnM3+njf+CqNJVPlzsEUwXWEemx/p+nL0u5eDs8Z1C93ACkLg4uJnADO+sM6fAlK7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz+6vzb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B99C4CECF;
	Thu, 17 Oct 2024 01:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130340;
	bh=fQ5LGyIBaK46oPYJY75HQ+s1l6zSxG5jS7LECMmdORg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cz+6vzb/fZFpRvwRxJb4Fuz2E6UrnbUk5iAcFm5KDqJ7PEkZzH0l0M4INTCFSi6C9
	 T10ao7kqbl9/eRuIJ514GRuX0kbq+nZTZrIaS7M0Gh4Vf+S98sMoBklE4176ywTKEY
	 g/McpYHTqlnmotG400WETMq6YltrcFXlfckErJbvF4v+PABw14hTKsCi76/NRmF+2v
	 oHiPhLH4nC7nh73PbDeEJkXYC7xfvlTD3AiYXAi0SXhcGuMLTY9GeN+zMJSpzb+Jae
	 57apqdsAgA40JgiU4ICzRxQFXkIcKvGyxnci3bno/YfnP81f84EDe1UshJbrcLOePB
	 3Gr66HdU5u3rw==
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
Subject: [PATCH v5 04/14] PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
Date: Thu, 17 Oct 2024 10:58:39 +0900
Message-ID: <20241017015849.190271-5-dlemoal@kernel.org>
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

Add a check to verify that the outbound region to be used for mapping an
address is not already in use.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 89ebdf3e4737..edb84fb1ba39 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -243,6 +243,9 @@ static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct rockchip_pcie *pcie = &ep->rockchip;
 	u32 r = rockchip_ob_region(addr);
 
+	if (test_bit(r, &ep->ob_region_map))
+		return -EBUSY;
+
 	rockchip_pcie_prog_ep_ob_atu(pcie, fn, r, addr, pci_addr, size);
 
 	set_bit(r, &ep->ob_region_map);
-- 
2.47.0


