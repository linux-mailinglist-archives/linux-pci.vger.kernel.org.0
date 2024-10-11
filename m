Return-Path: <linux-pci+bounces-14297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA1599A391
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E01C222C3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A014216A3B;
	Fri, 11 Oct 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5zgAa5C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227642141C6;
	Fri, 11 Oct 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648861; cv=none; b=PG4RSl9PeJb5TrT3kRBgMfv8iLeFgN6h+4vqWhxOJwuB4j+t3sQNGRw6IzDlLktdRNnIqRng+pc/2v/QbP+yaEaoBB4Xt6GkH1Dj+K5ZiJNeeuYfwoiTlHzfDh9GExj/DUDKNv2AUTTnTaioRHymk4KcBCjfpTuog4IQg41qdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648861; c=relaxed/simple;
	bh=fQ5LGyIBaK46oPYJY75HQ+s1l6zSxG5jS7LECMmdORg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWGgJcx9JBkOM2BpCHM+QW+C8vDVyGna4t/3m6xIOw3alyBK2KiXyAwvKBillw0t57AjTJW1a+NKNUIe6WbQljgdQaWWyclTfKcS6m95HozhufbXalqBL6udmFDiRmCP3Oj2FE1DbsK4ApNrv7nDYR+fDCgMB90vIRv5nxCtZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5zgAa5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CA2C4CECD;
	Fri, 11 Oct 2024 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648860;
	bh=fQ5LGyIBaK46oPYJY75HQ+s1l6zSxG5jS7LECMmdORg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5zgAa5CrOc9lo3nDI25cqkuu2ZncQ5zNPwL3Ia4OAPYD8aBDQCaXzF8Z+juq0ob3
	 6vx2/sk3kvkJuFXDoNwddtZI9CBZMc0jYHyeYE81T2jv46n7+6P7QvgVrTq7E+Lo90
	 7p72g/sIniO7yrq9UPdN/4mnebNVn43A5nNJTlDYN3iwsKDnr+ghnUbGky2UadeA9Z
	 ribttT+rSBnsPpN6nFPQvWiRTFW9KGEDV8FD0ikY9SK1iSrNwLVorhEABAdJvMwf+c
	 0LBZpeMuZaT8ONUBltIXEKiHHxrl/+aQQ0yvfyMBsRl66bPRdvALLSsH3iatnNvMup
	 06WPKSkIUcG9Q==
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
Subject: [PATCH v4 04/12] PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
Date: Fri, 11 Oct 2024 21:14:00 +0900
Message-ID: <20241011121408.89890-5-dlemoal@kernel.org>
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


