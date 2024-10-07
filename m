Return-Path: <linux-pci+bounces-13913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B38C99236D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CB1282949
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356132261D;
	Mon,  7 Oct 2024 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGyv6Gea"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB243C2F;
	Mon,  7 Oct 2024 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274349; cv=none; b=FFMyoqXyN1pb/yrVa54mUrvLJGAdAJZAU281NlzXyd1rhF/Jpik8d83o9j2+GgqAqVvK8o0ByvOEXbnfOxetIRRnP5lWxhRxfvLoeSbcvLZTQ8AGeKAkK6qT9miPMp5Y6pRhHOpbS6wteqsP8t1FZ0VL3hHxlWIPIZeZKQKNsEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274349; c=relaxed/simple;
	bh=5w+3NShXDU/wbYOsiv93TvrG7kU2oPVW7277Gez3AR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfaV4MyZMwhlj5nbp6KAYIWXY5RaigchfKI1/NTCQEtmerqP3IpaSg88xjPFshGsQdT+YZ48nIaMtBTj/eM7J2r0TbCV8MTISo+5jb7WBcnuEjU9lR+wgwAwZ6RAGT4x/gzLt/HXBaQ7u+gc4Mge/sj1ZidPSCIAYJxF5gP6da4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGyv6Gea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071A8C4CECF;
	Mon,  7 Oct 2024 04:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728274348;
	bh=5w+3NShXDU/wbYOsiv93TvrG7kU2oPVW7277Gez3AR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGyv6GeaMtH/0srjMhy4Mx6yx8duOHHSMcfTtn/qwnmxj9s998T3LIdDSkxkV5+TF
	 t1EgNx3ei6UFALwjjIgwzQ3gyDKf3iYZNwmffbNsZmmXHamU+FvxRKCvzhsr+LFcUQ
	 HwtwJnzOJqLLKgLG3tHEAkdIdsGHi36VcFrp9Pg7xvXWvWznoGqRqskfsstJRFvSz5
	 AG57q7IfebNRTF1kyUl6xkP1ALD4XwZHxB+VhSp4IWOLF9xfE8o0LZLJY2b65MSr8t
	 bKOxD3k7+07mT3lFJEsIchHYVQa5VVR+uMjY6jNqBNtL/Uw632Aq51KL1bzF7ZhbVh
	 JnKNRvprB/MrQ==
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
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 03/12] PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
Date: Mon,  7 Oct 2024 13:12:09 +0900
Message-ID: <20241007041218.157516-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007041218.157516-1-dlemoal@kernel.org>
References: <20241007041218.157516-1-dlemoal@kernel.org>
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
2.46.2


