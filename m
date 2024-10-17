Return-Path: <linux-pci+bounces-14710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFB49A183C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB6C1C20AD3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841A7339A1;
	Thu, 17 Oct 2024 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu+jOt9W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32E22087;
	Thu, 17 Oct 2024 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130344; cv=none; b=oG91VvR9KH1COoL5xusyKkU8er5rntKg2ysNLe5BNTBTOOjen0b1QzYMCaTW2lxh1SJyZ7On08y3GpNJ93c/Ujs9M07O4eyBmithAGMfyRhgZboN8E/yZh60R0iPBGx0qWecmR39IoaD4Uhpi26y7Yx6Woq07Q3cTZY0+QJTm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130344; c=relaxed/simple;
	bh=7C0hw6Xvm/YDpj0Qd/1mzkBWX8qAwGyMmQLAjgMUqK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IExAwQH/p/elCL4ElqH41yYJxF8gyrCa2zDdiPj/1M3C5+UL28h849W0BDiSCftxYmFWS62qTHnX8DDk34w9cYfESS6/62R3uiHbdJRHv4eImPgwuQsybInzOX306kyk4DfrNqq/CPUd4rveAki0wnV8s/gG6Gd5zj/6L4GuCKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pu+jOt9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D5EC4CECF;
	Thu, 17 Oct 2024 01:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130344;
	bh=7C0hw6Xvm/YDpj0Qd/1mzkBWX8qAwGyMmQLAjgMUqK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pu+jOt9WMdPC+tc7WU7kCqCAKrA6RW0lOOIV4Ch8NL2+KQQb7SuVfxd3vHIBzWGVt
	 AIzk94e0gZcPc81Hk6kaCFWsPH9vDM6TLEdJ84sdPUkbxk+lCKL4zx/nnLf/J3K/+A
	 qJp743NUARFFhTIqSEJByEaJx2XrxyWMm5JG2njWBKmCqlwfBRlMuR53X0Nqfi9D5+
	 Fe4hSs4+yWObsq8ycMDGNjKE0BlVpnf5yrexHZRVkM4oIPNnooDhoIEPHIy4q91LIx
	 FLPXtKZsW8X0id9Oxa2N9d4caULUo5G5qKrz87N0ITbE4yrG9yrK8jnR+06XMXEntE
	 WHStCHIKncwtg==
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
Subject: [PATCH v5 06/14] PCI: rockchip-ep: Fix MSI IRQ data mapping
Date: Thu, 17 Oct 2024 10:58:41 +0900
Message-ID: <20241017015849.190271-7-dlemoal@kernel.org>
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

The call to rockchip_pcie_prog_ep_ob_atu() used to map the PCI address
of MSI data to the memory window allocated on probe for IRQs is done
in rockchip_pcie_ep_send_msi_irq() assuming a fixed alignment to a
256B boundary of the PCI address.  This is not correct as the alignment
constraint for the RK3399 PCI mapping depends on the number of bits of
address changing in the mapped region. This leads to an unstable system
which sometimes work and sometimes does not (crashing on paging faults
when memcpy_toio() or memcpy_fromio() are used).

Similar to regular data mapping, the MSI data mapping must thus be
handled according to the information provided by
rockchip_pcie_ep_align_addr(). Modify rockchip_pcie_ep_send_msi_irq()
to use rockchip_pcie_ep_align_addr() to correctly program entry 0 of
the ATU for sending MSI IRQs.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index f6959f9b94b7..dcd1b5415602 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -379,9 +379,10 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 {
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 	u32 flags, mme, data, data_mask;
+	size_t irq_pci_size, offset;
+	u64 irq_pci_addr;
 	u8 msi_count;
 	u64 pci_addr;
-	u32 r;
 
 	/* Check MSI enable bit */
 	flags = rockchip_pcie_read(&ep->rockchip,
@@ -417,18 +418,21 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 				       PCI_MSI_ADDRESS_LO);
 
 	/* Set the outbound region if needed. */
-	if (unlikely(ep->irq_pci_addr != (pci_addr & PCIE_ADDR_MASK) ||
+	irq_pci_size = ~PCIE_ADDR_MASK + 1;
+	irq_pci_addr = rockchip_pcie_ep_align_addr(ep->epc,
+						   pci_addr & PCIE_ADDR_MASK,
+						   &irq_pci_size, &offset);
+	if (unlikely(ep->irq_pci_addr != irq_pci_addr ||
 		     ep->irq_pci_fn != fn)) {
-		r = rockchip_ob_region(ep->irq_phys_addr);
-		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
-					     ep->irq_phys_addr,
-					     pci_addr & PCIE_ADDR_MASK,
-					     ~PCIE_ADDR_MASK + 1);
-		ep->irq_pci_addr = (pci_addr & PCIE_ADDR_MASK);
+		rockchip_pcie_prog_ep_ob_atu(rockchip, fn,
+					rockchip_ob_region(ep->irq_phys_addr),
+					ep->irq_phys_addr,
+					irq_pci_addr, irq_pci_size);
+		ep->irq_pci_addr = irq_pci_addr;
 		ep->irq_pci_fn = fn;
 	}
 
-	writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MASK));
+	writew(data, ep->irq_cpu_addr + offset + (pci_addr & ~PCIE_ADDR_MASK));
 	return 0;
 }
 
-- 
2.47.0


