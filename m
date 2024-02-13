Return-Path: <linux-pci+bounces-3375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D2085243B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 01:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200731C23645
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 00:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5176D64CEC;
	Tue, 13 Feb 2024 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaFB/0mK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2464CD9;
	Tue, 13 Feb 2024 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783718; cv=none; b=VZttJfJOg7vX16u8voO2kMCYlk/V4SBNNnbegnfyoXaC6PY9WQS+YcOY+Tg40iQLbd5PewpuaXBhuHLeFAJAhpTI9A/0SVoZbLRF8Q+pcCMp4C2A+WCkzTK8+Avlf+O0jghRpea2+qgovT8XPj9FOjApukx2MfGaWfF7ec+hIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783718; c=relaxed/simple;
	bh=7qZhNTtqRlrI+0MTl24AYtu48Ljc7ZKtqhdVHQQopGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xwc2Ur/Hf7NyWMjth6LXE2fl42RdEL5msuIc8Vu6O/d+ADPd6KCn44XaQofE8qWfqAm+38M66LA4JVQl4+giz5wAHWytM+shbeW1M9umyZUTUwHsce6JrYXyaEYwPQul/kmQqWj6HSNnnnflNLFgQYiZFQNsLoEUH0sm8llWckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaFB/0mK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE68C43394;
	Tue, 13 Feb 2024 00:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783718;
	bh=7qZhNTtqRlrI+0MTl24AYtu48Ljc7ZKtqhdVHQQopGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaFB/0mK71jpVYwUArbPD2X4KmMCUYrYIhTnK5Z5L0TIdUWimQ1LtEU2Q1FQhTAXn
	 8Whc1Vtx3PdAxftyKQUQq99nHEPRCZ2zoyuZqNJU4B2u8nTVLo8P6MFNMbF5iwF3bM
	 aSLDtq6ElCAlyZpeoFMcO10ri+Uq/I8NSJFYGFadVN4qziTFEajfcO9w6qZc7+Ooj4
	 pfv3Dj/Jx8NWsQ9vUDVbJGdTFeO/r48zzULTgB8KPitA6P/IsEgiK8k0v00Tha+NOO
	 TuVcdaWeAAgWyvfNRZOQipKAm6QaqWsMEV7P2tpAqtdp+VCs5LFCNmZqSgnm11D4de
	 cO8IYcKZuQ69Q==
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
Subject: [PATCH AUTOSEL 6.6 42/51] PCI: dwc: Clean up dw_pcie_ep_raise_msi_irq() alignment
Date: Mon, 12 Feb 2024 19:20:19 -0500
Message-ID: <20240213002052.670571-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index 8d79dd0e1d60..51f340663260 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -526,9 +526,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
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


