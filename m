Return-Path: <linux-pci+bounces-5385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC750891573
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A101F22A27
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662A738FA6;
	Fri, 29 Mar 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAh3YGV4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2737152
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703405; cv=none; b=I9hHW1/jrwKUkM1ghtgHOzZTeM5oIbTsUE+y7Kjbvlf7JFfpWWafMFDFyMfOnkznSLDfAThvLEckuZxP2X0lN/vjX3fiJlV52z9vmGgJSuXNlrEJ01b86D+kD2INQdAPAAUtnq/sfacHm3222ZjLoFhnSzRfK7mR398gAInZkY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703405; c=relaxed/simple;
	bh=xJl20dD/sfAgaEM4rbGBuGwJ0fENngDOuq2Kb9XiBoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3aoRLYrTQCBT7W1rigz6W1IzCZwfM6Xx/ESLRNsmSRgOlG24O/Nza+3zKcFcMUAuYNc5/ONCo78Dy5N2uck+XlYXMp/Cpi6AT9xomj1Nr2FaUPjATHlmQqAv0VLg4gyVg1omIqsz3vre3C9w3giAnQm068m9AX2WzpVAbUQqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAh3YGV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90708C43390;
	Fri, 29 Mar 2024 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703404;
	bh=xJl20dD/sfAgaEM4rbGBuGwJ0fENngDOuq2Kb9XiBoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAh3YGV40g4BCrUXtyYt20wRiTXN1/OQGNo3ZwZVUpR4ybt/IDow9+EDtMWYdGM7G
	 MMeEu+3i+Ipaa+otSjP2rRf42ea2nOeYP7fhSOcn+OBSnRtveN6dqGta2NXmBfDX1s
	 ABoVFQdzc6RZ2NDF9JRrTu2UMBQBWhRoU8nS/XO9uNUryvslBt7TLsBrX6zHIqYG2i
	 UTpvdBMkzmJlNrfQyAoP54xs0/ByeRXF8Il66eaAmFB0QjYwNF4OoZOa7Gk868GKQC
	 ypVmQjC+tJ4OCeMtvVOnQiJ1B78xy4xwbBIhOEoBgxfZrSOkFRa3lgFtJUP2cYmy+/
	 21OFctA6yIICQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 11/19] PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
Date: Fri, 29 Mar 2024 18:09:37 +0900
Message-ID: <20240329090945.1097609-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329090945.1097609-1-dlemoal@kernel.org>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
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
index 296916d4a6e4..c2ca7878cee3 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -245,6 +245,9 @@ static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct rockchip_pcie *pcie = &ep->rockchip;
 	u32 r = rockchip_ob_region(addr);
 
+	if (test_bit(r, &ep->ob_region_map))
+		return -EBUSY;
+
 	rockchip_pcie_prog_ep_ob_atu(pcie, fn, r, addr, pci_addr, size);
 
 	set_bit(r, &ep->ob_region_map);
-- 
2.44.0


