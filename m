Return-Path: <linux-pci+bounces-27200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E13AA9FCD
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 00:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0635F3A7BF9
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 22:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F9A28A1D6;
	Mon,  5 May 2025 22:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jb2IXOXQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C728A1D0;
	Mon,  5 May 2025 22:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483358; cv=none; b=Zw4vwXqlTdBnYIFtiG1u6nobP/YVfyJBGf/gIdpYWdoJunsIW+ECQaJssxNs9hrjgC4Rqqg+X9Syijo3AZbj55m0P6xGDIphpTrLpsmW/nRKXbj4Y/uc7mJHI2ehISA0HK5oVhgGpue+2N+Brv9UQiXkSDuRC4xsnrOrGd4cAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483358; c=relaxed/simple;
	bh=2q3vS6AQ3hPr40XwsuLBriIiJTefqSzZqKAIcmdb4sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hd7sqcGoH2/eH1qzWCCx8t1K5mp0zT3emxP7dyrqaMv7z8G/MO+O6fDn6uCkIRnRvhO5DGDSV/QgNNzV8iT09qmDQ+ljFwxLy1L/6PqM03+yA//4eqiH7IXzmkX1Yc5lcozqVGX51MyT5opENnn1sEglyY3KMgGKntaQ/zPc5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jb2IXOXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5FDC4CEEE;
	Mon,  5 May 2025 22:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483358;
	bh=2q3vS6AQ3hPr40XwsuLBriIiJTefqSzZqKAIcmdb4sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jb2IXOXQTHwRiII6W/PgpyhqCJpZzIqC/qI5KrIdTuU4VSJNKCOYn/MTQd2jycxXa
	 C7ARCzOZ05E8SAR0De3FehMfo3/qjD5VvKnp9eXkI9veI8A8PO/NzeA14HbwHchFg7
	 I1R35O2QTt6W0EKWAAium7kVBJfo6rQk7mvEevyNEaMVzmdASR/gk/Db1DZCrt7dc4
	 vuLvociMl1aTnhjrqyhg4a1iRcfT0rR72UFASurJlGt5asKsifetbsJPtL+Znc/T8O
	 6DuvdUzsSptY0O71a/ID9u8UvGETDK2e8do8UF7ivgs2E32XrUEnnYZEuxm/DhEZIC
	 SyuCCQroLn20Q==
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
Subject: [PATCH AUTOSEL 6.14 052/642] PCI: dwc: ep: Ensure proper iteration over outbound map windows
Date: Mon,  5 May 2025 18:04:28 -0400
Message-Id: <20250505221419.2672473-52-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index e41479a9ca027..c91d095024689 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -282,7 +282,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	u32 index;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	for (index = 0; index < pci->num_ob_windows; index++) {
+	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
 		if (ep->outbound_addr[index] != addr)
 			continue;
 		*atu_index = index;
-- 
2.39.5


