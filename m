Return-Path: <linux-pci+bounces-27245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC8AAB3B3
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 06:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA837160C5E
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3F537A165;
	Tue,  6 May 2025 00:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWNqmwSh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246DF2EC021;
	Mon,  5 May 2025 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486435; cv=none; b=b4foMfTSAaSeAH0+KzfPsyfJ+guEzz/jDm2l7lUhSPvZk+PHtK9qVSDKNBS52gRNhDi8NyAUNMemR7X621gYn+xIGT6ZT/sai1WFNvVIt06lAI4GMauUYc5Z20Sn/JTpkOudOrE6E7JGjogaYEE018oivtnw+Ml+w0rAYbpJksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486435; c=relaxed/simple;
	bh=vqNjH4ATfpQ08Pe88bJRoPmVBc6V+zOOggseBrzp5lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1mfdXahWnZH6OB46La4LB+cVebqTkmM+Lo2MV6HZsiDnoQFZlFTn/6mS8r0UjHDQmjVTwnuV7Hf/UJtQw7iKi501tXwbQMzotm4S3qRLB52BXuzHqQ4hdAJ6li46xFiyCHUMnJqFPEH/DR+c6NO/X6wf0EqmPZ6iJoNcPyKqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWNqmwSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0E1C4CEEF;
	Mon,  5 May 2025 23:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486434;
	bh=vqNjH4ATfpQ08Pe88bJRoPmVBc6V+zOOggseBrzp5lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWNqmwShq2eSuVqq7T+7/Fh3kLDvr8p1lf5Adbis/MCfttEBula/G1SMSgmC1gYXO
	 y0IYCbSYuxt67kmEX2LCf4NpM5pa5RnzlZdHC2IWOagzihxVtDLm5ilQDBuO8+z7+c
	 4BxXK3cSXx/F8aVq3Kv89504DdVO/lE/rynMiTAdT1/68RvW4wYksdnXNzmhdiDonW
	 Q8iS1zhqt4Ra4XrplidAM1HRFA4atajmBv5f+Osh1ccr3a36BFk+Cb5IE9dNYquAWb
	 bDqhXgv8umUnL24auw7xojlNGKlWvnDVTVJkumfRv1/GOR+AGKEesDA4/POx6xJbQ7
	 aYb1FQW6XxruA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 025/212] PCI: dwc: ep: Ensure proper iteration over outbound map windows
Date: Mon,  5 May 2025 19:03:17 -0400
Message-Id: <20250505230624.2692522-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit f3e1dccba0a0833fc9a05fb838ebeb6ea4ca0e1a ]

Most systems' PCIe outbound map windows have non-zero physical addresses,
but the possibility of encountering zero increased after following commit
("PCI: dwc: Use parent_bus_offset").

'ep->outbound_addr[n]', representing 'parent_bus_address', might be 0 on
some hardware, which trims high address bits through bus fabric before
sending to the PCIe controller.

Replace the iteration logic with 'for_each_set_bit()' to ensure only
allocated map windows are iterated when determining the ATU index from a
given address.

Link: https://lore.kernel.org/r/20250315201548.858189-12-helgaas@kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 449ad709495d3..3b3f079d0d2dd 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -283,7 +283,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	u32 index;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	for (index = 0; index < pci->num_ob_windows; index++) {
+	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
 		if (ep->outbound_addr[index] != addr)
 			continue;
 		*atu_index = index;
-- 
2.39.5


