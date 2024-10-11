Return-Path: <linux-pci+bounces-14296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FAD99A390
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B359B282375
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED941217312;
	Fri, 11 Oct 2024 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgxeAguj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661A212F13;
	Fri, 11 Oct 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648859; cv=none; b=FkL0d815VrrB+iS4VdAgCsySGtNPjWtusPR1vSP7GqlzKS1duEU50SxslIRFCcaGJlK9h37SKXEGdPJLLetjlmixPYHJ6O7SuQO4efZdnO5M1QJ3gQ+X5iaZSugfiCVg8Jx5iKFd3BTh8voAR4gJBGSjjuywNLwrh2qdaygOwr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648859; c=relaxed/simple;
	bh=pSHsBhnbjSj04jRr4dxkMJFuwUPFncYPKlMS7obkf/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQG5EeNdPHFiE/A9uU4VPR9MA/Mv6oFpiAbchiJEl/xK3C5ux7D0AxyegHelEtI9w0LrpdnoaRuHn8UExlslmg8Rr6ECiKAEsyLYOlV0fj4VmEJrENYnCUDuTGIDSI8L6Alty73DRpryE9BLXL/FCdlNsPa17xOHHgVgP1e5OxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgxeAguj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B74C4CECF;
	Fri, 11 Oct 2024 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648858;
	bh=pSHsBhnbjSj04jRr4dxkMJFuwUPFncYPKlMS7obkf/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgxeAgujYv4rm3bDl1R7Fvbzoc4H5oYIlF+lb9GR4mtydmMCSGzyNNoYaNH1t4hOr
	 scY43kZuCt1LoAfMyEFawxrNnVyWT83E/e6nYQqNM3iZUAfKVMNwQPAtuhDFpyJsdd
	 KwNohLGhz2f8t6+aPTizVrlqGWTm3kFG4lpZyfTh4Hy+sfampwIG5JM2TCqYM/il7R
	 W/gbiaTvbdJpD/uX+JPJ5WuChL86jif2LXZJho9zzgs8grIojVP608RIE3i7/x3EhZ
	 97Cpq6+1YPClo/2yRnMJPePmA3ps5V5/z8o26AdMVvpLO1ZICRdr6YbHUHt9N+hkdK
	 Vmt0lW3UO7d+Q==
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
Subject: [PATCH v4 03/12] PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
Date: Fri, 11 Oct 2024 21:13:59 +0900
Message-ID: <20241011121408.89890-4-dlemoal@kernel.org>
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

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

There is no need to loop over all regions to find the memory window used
to map an address. We can use rockchip_ob_region() to determine the
region index, together with a check that the address passed as argument
is the address used to create the mapping. Furthermore, the
ob_region_map bitmap should also be checked to ensure that we are not
attempting to unmap an address that is not mapped.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 5a07084fb7c4..89ebdf3e4737 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -256,13 +256,9 @@ static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u32 r;
-
-	for (r = 0; r < ep->max_regions; r++)
-		if (ep->ob_addr[r] == addr)
-			break;
+	u32 r = rockchip_ob_region(addr);
 
-	if (r == ep->max_regions)
+	if (addr != ep->ob_addr[r] || !test_bit(r, &ep->ob_region_map))
 		return;
 
 	rockchip_pcie_clear_ep_ob_atu(rockchip, r);
-- 
2.47.0


