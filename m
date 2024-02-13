Return-Path: <linux-pci+bounces-3377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3652D8524EF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 02:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3D81F210DE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 01:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5790D12B175;
	Tue, 13 Feb 2024 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfXvGtuJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B712AAD2;
	Tue, 13 Feb 2024 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783837; cv=none; b=dBIfM7tWVMfo0MaLEG6C6U3arQDyXtbuCgCK2ecRtrHDCd0yYfpvPo5Cowaf+LCnH7ijsIboBjfO0/R06LXOaBNtYmc2iQsIMAcFAatsweeTRC+aO6hqY8XP21SqndRqjnJN5nS+rhnMn95A/aB5OGbhqtAP6XgWmclEgfih9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783837; c=relaxed/simple;
	bh=cGnwOzX+aiGruEG2g9GK4yp9SIuVfxIBg7VGjZPBWcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNRWeenJMZ5E8KViZ0qV7P0Y904fYWJz8M9cAyVt5DX1OxhBTfksBoMoW0Wa8iAdykCPiSdB8HdfwYqUSMZdEizOx6xk0WgVea1RpSVOpz7KRjDrTi5kAE3yh60SLg6elJcIIDOpBuvg6Ps0ngL2tNrZ2pUzrgOH1spxiU5xt4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfXvGtuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87374C433F1;
	Tue, 13 Feb 2024 00:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783837;
	bh=cGnwOzX+aiGruEG2g9GK4yp9SIuVfxIBg7VGjZPBWcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfXvGtuJm9lfWY2WemooVicM02spo9uBkEXoKMHNL9KxQORtTiqnlv7xIlYs/mQ34
	 RXBOAKmNL6qFXo4wy6d+nph8MrMovi+cDbDjKWRpGp+rqRg7xx0LFqiRFwwQO8pJ88
	 UqqHcByqaQYmARu9D79nF5vPkkolJhBxYOGty3PVlGRlpRZ9g4W/MD8G00FXOntgBR
	 Uh17gg1cJJPzvAFlQTD+J89s4E/Sfj0n7rOhk5LpDl6OFIlL728hbCF8gVNp7YqyLr
	 2+r2pDb78hRJXnHCu+zAMlI4++nzl9PVbWI3tRdSm1qzmhP9JPRw5aaYKtaNA1mWtk
	 OFpZm6uhTuIoA==
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
Subject: [PATCH AUTOSEL 5.15 19/22] PCI: dwc: Clean up dw_pcie_ep_raise_msi_irq() alignment
Date: Mon, 12 Feb 2024 19:23:21 -0500
Message-ID: <20240213002331.672583-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002331.672583-1-sashal@kernel.org>
References: <20240213002331.672583-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 61a0f33c59cf..a88dd254a714 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -518,9 +518,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
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


