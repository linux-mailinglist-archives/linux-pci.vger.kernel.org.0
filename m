Return-Path: <linux-pci+bounces-3374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AA88523BC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 01:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2488D1C23420
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 00:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F295A7A3;
	Tue, 13 Feb 2024 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ92ATqz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678AF5A78D;
	Tue, 13 Feb 2024 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783599; cv=none; b=UZ0q3FLH5Hh2ubafCBSOqzyEDGQicTBJNi2s0olauv43s0fVjZmMrd5CHKczquBeUi9woEMozbk2KVM6ccL+7rh166sXF9btI7WEG2S0zuVM0GR1DvIkc56DlkEHJ4ra83V4n2pUgVC+EXr7A9sJbd/Tbf6qQF1hSZ1fIfi35sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783599; c=relaxed/simple;
	bh=3R2GBK0UQeUIj72mGeL46TWEE0siVHiYu9Fl4XuSuS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ay1rSJ3E5VzdtBQg1hDp3We9UU1o+Fmw7etUNEOJ1RkpEn5G/3uNc3dY8GR1WPEJ+bQi2Cjl7+FUwLuTYF6cpmLD6iPEtEj06f59CmpOkQ3Qdpwf15+Hys7uqZCbTgPHo40h6c3MKOdPnRsymRMFZcbODRb5/WcO2+qsTNY5XXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ92ATqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41BCC433A6;
	Tue, 13 Feb 2024 00:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783599;
	bh=3R2GBK0UQeUIj72mGeL46TWEE0siVHiYu9Fl4XuSuS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZ92ATqznkZEswfFRNkgj3TiIpI7jv/ATzM2iDtz+gX5+QsRD80nktG+Z4YVOX1on
	 ZlO13yCHwlm6ANF7RUdrm0tyYfwk7iZYPRmKy9uWukAlzG2Fg5m7q7P3B6PG+jx9ck
	 9bAMLr6a3ULGnKSN9Zc/dSadtyXP+fcqFrAprU77ebUwV6xcYPpY7aa3SifdAXMqiT
	 eFyt7HV/Jpe3rhv4X6EqAW0U8/jffOuJZrrtolPM8A0nlf1stIxsmFO20rb9IYh9NX
	 6+BgnuGdCxFXx61wkGtOIzJrJ71kWDNPCHG3SwKUqJlR8XR13x/j+OLh03U0lUaajE
	 YmaUdBrBlcQBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 49/58] PCI: dwc: Clean up dw_pcie_ep_raise_msi_irq() alignment
Date: Mon, 12 Feb 2024 19:17:55 -0500
Message-ID: <20240213001837.668862-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 67057f48df79a3d73683385f521215146861684b ]

I recently changed the alignment code in dw_pcie_ep_raise_msix_irq().  The
code in dw_pcie_ep_raise_msi_irq() is similar, so update it to match, just
for consistency.  (No effect on runtime, just a cleanup).

Link: https://lore.kernel.org/r/184097e0-c728-42c7-9e8a-556bd33fb612@moroto.mountain
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bc94d7f39535..6d1cd4fc3d1e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -543,9 +543,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 		reg = ep_func->msi_cap + func_offset + PCI_MSI_DATA_32;
 		msg_data = dw_pcie_readw_dbi(pci, reg);
 	}
-	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
-	msg_addr = ((u64)msg_addr_upper) << 32 |
-			(msg_addr_lower & ~aligned_offset);
+	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
+
+	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
+	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
-- 
2.43.0


