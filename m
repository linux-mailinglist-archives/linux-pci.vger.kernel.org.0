Return-Path: <linux-pci+bounces-3376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BAC852499
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 01:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F782831C9
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 00:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E8F81AB2;
	Tue, 13 Feb 2024 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3N7p0nV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F80A81755;
	Tue, 13 Feb 2024 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783789; cv=none; b=NcGzfTkkYiAXE9NTWVF0dO2kFe4UJxjwcWZ5qg2kgbjacd0K/CYzl2OwYgHXb1+yNEYOOk8BqPcFPlBoqLOdQ3Zpi+8DB/5fym2GCZmyiC9Qy8QFfjgbBlsMH2iLunSlnqHyiA/SllKZQwSteJlwkC+HbFuOe992CoA70v2ltHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783789; c=relaxed/simple;
	bh=h2R2cYRyDIUhPm+TMUvSPSOvLAZTtewgg5O8+FSt1JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdXEQA6oBLgsiKZkDux+tQk+DErpiUP604MYIQaRPDjZIBcuy4emqmgjsmYHj7qnkNN4DHZd0S5UgIbsmNnJDhv3a4bS5G/XZ8/0VGzP0voxUeYI7xs7XxKrePlo3225SfMuNj9Bv1FuDLA72x1t5E8/WyrVRwzbRh/Fo/ef66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3N7p0nV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA7C433B2;
	Tue, 13 Feb 2024 00:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783789;
	bh=h2R2cYRyDIUhPm+TMUvSPSOvLAZTtewgg5O8+FSt1JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3N7p0nVRlKdQT3pBF2V6j4c4YATLvYuSFD6Dh3wGKx7N+9nVLIbXqStGsAb8Jpls
	 UAG3WQunfY3K15gsZxu3FzU/IUUG7w9S0SybdrL6GdOF8DTrZzNVAM9qEYrghOCV2I
	 HxOhkKIZzWAz3z6SLDzUMaPtmbFFn+1aV0z+ohNcvjvo668XM29QGQNmQSDKIQdwM3
	 mQa1O3qiX9/iGnzRk+WAWktZmKVRQZ7Ho9tnl/WzolnaAL0eYnha1rIGRNklpVy0oD
	 exaf+vjROj/SDj03Vz/BmYVVtitzF6tXVRe1sQSpWBhkfp/L6Sbilli9/dqQ82GvQf
	 nbzPRpF0B1Lrg==
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
Subject: [PATCH AUTOSEL 6.1 23/28] PCI: dwc: Clean up dw_pcie_ep_raise_msi_irq() alignment
Date: Mon, 12 Feb 2024 19:22:21 -0500
Message-ID: <20240213002235.671934-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index 59c164b5c64a..cfdeb1e2935c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -528,9 +528,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
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


