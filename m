Return-Path: <linux-pci+bounces-13914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFF999236B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F171D28288D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D841746;
	Mon,  7 Oct 2024 04:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucjKKuO+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C70738F97;
	Mon,  7 Oct 2024 04:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274351; cv=none; b=Z0Wm9nSbubv/6Jg/tFkZXh79C/dOwylFx4F/KFmnAXXnUj5rIhntd0pW5BrdHXH8iD88WGCfKnNDuz1hSnNvv+80Z3cJXy59cAJiw2w7tZuvhDdKankgbTqChTmni4xbRhgzQ8iSk6BbdC6sKgngZbHRyGil3VFz4kpxhJKi4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274351; c=relaxed/simple;
	bh=zktM0WskKmnp+ZKqC5RGFOFYiXLFR0gT3RgJ3fgJtgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcLtLdNW+Vzz6L0YksmJ/+ziEHd+yAZEQianqhL9yEnn/1T17CKRIex/CgQJ1YyV9muA6+dMBQDPeE7byr9hOUoVVa4LP+P23qMTd7dgoWq/bQ1cNzcdQ/AFMBlza/lxOsOBN/ySKFlPPTn9FPDAiPzUloTpQBhszqp5A7Vp7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucjKKuO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DA9C4CED0;
	Mon,  7 Oct 2024 04:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728274351;
	bh=zktM0WskKmnp+ZKqC5RGFOFYiXLFR0gT3RgJ3fgJtgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucjKKuO++3JQEC0ULvO6hFfjlamLaP8cmEOOiLPwNkzBBpF4gRvuRE6DkQKBE5GdY
	 YSMJaZkWIbPfMKVEmmQUI2I+++P6TQJjid4Faa8N+yLZk8vyqDKdMeyNhK02lu08J8
	 69/WnS4Y6+SUZpbqvPs/OB/D9Owd3I0xA+63rGV45iXrdrxbf5h4XoOxkDyvGW2LIv
	 7/CqsvCLo77L/WltZ1NXgsO8wsHiKssxEA3CUPVv2j81Lkxk+u3gRyn3e+NVXAU5v9
	 fbjFMa3V1FyXMNTNDAtZmyukrLKul2TmGLp9uh2RWdDlDT3LCh5wgtshOSVAl0WPIZ
	 omn2eDi4ZF4hg==
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
Subject: [PATCH v3 04/12] PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
Date: Mon,  7 Oct 2024 13:12:10 +0900
Message-ID: <20241007041218.157516-5-dlemoal@kernel.org>
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

Add a check to verify that the outbound region to be used for mapping an
address is not already in use.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
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
2.46.2


