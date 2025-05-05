Return-Path: <linux-pci+bounces-27215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D10AAA8E2
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 03:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F6B3AEBF6
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 00:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D81352B26;
	Mon,  5 May 2025 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6C7Q1sj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667A352B24;
	Mon,  5 May 2025 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484848; cv=none; b=BYxHQEl17RXTB496hVqAxsAx8h6vs71nilvUU7c/mcf/2LjODDRubYg2Pmf8GQt3NjfwqjTARHM0wvb2EIKt/bgCTmUkUlGs36hf4SpXHYs6bYtD7P9D8O86XVa99VTiHY+pHURfS+75l5M2zry94WXnqzRcAhBPUZH4pzGYWhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484848; c=relaxed/simple;
	bh=Nn+k2O3KiZfds+/gnPxgvf3gReiBOL7mLJffpIll8XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m420vBJfF56NibHzhmnM5jz6ikO+HHEXtJf+dE2J+Os2vM3jfHyNE//F38thYsIYP/CTeSTShQhpWMrJ0RwhnkaqQsPEimPch2Tv7nomweHLD0N6oXt3QoWpgt7c4XfuXWoalQaQLrCZhAefRJh1Lf8GwoapbhO7QGqxu+n00iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6C7Q1sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB26C4CEED;
	Mon,  5 May 2025 22:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484847;
	bh=Nn+k2O3KiZfds+/gnPxgvf3gReiBOL7mLJffpIll8XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6C7Q1sjoi9SNE9Q+eN6UoWpqu5J7ymTffWlNDUTnLbYbG97+fIhlLNO2dJdlcqm9
	 liiQHGcsTLA4rMjTz6mw10O4cUGkfDX9u2EOdo1HABrPV1t2iW93VL2Y3bWNL2rTzR
	 bZj7UYBUXegV4TZ1Ox87YxRGPlT0is7R71rl7kp28gusmSJJafrWXi919HidOSrQ2P
	 U7PAOUtoiqpwCCvPTZJ9N6hZ71NNG2AX6PbdXJR1W4GRS5aYAO4Qd9qbubvXUS/7JL
	 9WEhCv3Tx6GbU1n1l/o+D8OQd02+2iIJsFOjGxMVrclofw//M1UwayMFEh9kOuggl5
	 xHw1+RDR/Kcmg==
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
Subject: [PATCH AUTOSEL 6.12 045/486] PCI: dwc: ep: Ensure proper iteration over outbound map windows
Date: Mon,  5 May 2025 18:32:01 -0400
Message-Id: <20250505223922.2682012-45-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index dea19250598a6..9e7e94f32b436 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -280,7 +280,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	u32 index;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	for (index = 0; index < pci->num_ob_windows; index++) {
+	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
 		if (ep->outbound_addr[index] != addr)
 			continue;
 		*atu_index = index;
-- 
2.39.5


