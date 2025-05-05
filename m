Return-Path: <linux-pci+bounces-27248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C2AAB75D
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 08:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284B11653F5
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 06:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF160482D36;
	Tue,  6 May 2025 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOyQhXyO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076237A169;
	Mon,  5 May 2025 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486835; cv=none; b=J8IB/ki32bE9zRKlGxUH0zd5RajS6ba/NWmkvilqx2pxGUchiYODgWwfDKlNiPDEAsIsMcDoir3UnWImDhEbPvVRsVCirraqIv7+WKA/R77RSIgE7h724kPqGL8CtINRPhHd1Sz9rbqGBt7m4JkmHrXKD1YHZNJuHsEesdXUioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486835; c=relaxed/simple;
	bh=ZBM7Xs0E5/X1Ecotb3orabUKV9kUJ/5IMYlY2V1o/xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PE7MYFL395a50dnNWPlAYHuZy9h8aEnTC0CL4m8x/lYhza6TS1xC4VzJI7CU+lhmrl15ZYPDdZEKpljazRfzz7LuRMRiKWU6t73AZmfihQGBdRj/APeEmJ0dInpvWw7fn/xLpOMZ5jymMAFmJU3pU08JyuR4kiW33FqHU2DKP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOyQhXyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69605C4CEF2;
	Mon,  5 May 2025 23:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486834;
	bh=ZBM7Xs0E5/X1Ecotb3orabUKV9kUJ/5IMYlY2V1o/xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOyQhXyOM5oKbYi2cxS6VW0df/8UfYh4ge09s2ShWkVNq5s97HAoxtl/yRLXThDjK
	 DnVi2WDf2Qo3KJ55eGnMOufJ6FhsNpAgAoonvorgGtjMDiD0kX0durJWNj0ReWeMHY
	 MFbTcdHYJW2cwVc2XsOvJgLRtEYDPxyYF8hTVLkrNl7NaDQ3XWE9w1wBee1HDRIwgD
	 PnToTUQZc1rtmC1Byop8e6UGcwPNsaB+xihjDRqcWPeeU2lmw+MlenGkUrvPD3+NW5
	 Vws1d+br/+id2PDgiDo3vOeeNlanEYePUBLxL/G3cej6+AKxvX4XG6TzkCJ1C+1ydd
	 vIxniYI9Qo8ow==
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
Subject: [PATCH AUTOSEL 5.15 015/153] PCI: dwc: ep: Ensure proper iteration over outbound map windows
Date: Mon,  5 May 2025 19:11:02 -0400
Message-Id: <20250505231320.2695319-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index fc92d30a0ad99..5502751334cc6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -267,7 +267,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	u32 index;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	for (index = 0; index < pci->num_ob_windows; index++) {
+	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
 		if (ep->outbound_addr[index] != addr)
 			continue;
 		*atu_index = index;
-- 
2.39.5


