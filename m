Return-Path: <linux-pci+bounces-27243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3B4AAB2C7
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 06:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B743B188C232
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2620A36D439;
	Tue,  6 May 2025 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlaStX4p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDAB2D9DA4;
	Mon,  5 May 2025 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485855; cv=none; b=kXl+Kc3KCZ4RU2GJgSB15yS52leL9DhO2/5qg5GK3wXdVAJv7wjh4iMOdFIvqRwBS8PGfEpZIVkuNW6/vhIRLSol6PmDoY222n7Eh8dmiIDQ6CAoMEtIfVEZI2GkPie37lOfKKmjFmGpZflp8o4gkIjPIaNBnjIJ4ssw21nrcjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485855; c=relaxed/simple;
	bh=3VTvkgWlhG6cml0I+iMJ5YstdI9lUTyy+ZFjdKg1mLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YqMzw6VU4nQQfMXwBgKItwFDgeEBhCGHT6uirPie2pSIeddezBbgx5Z/6xGepJQYOl17B/dbbahwpdmGjN1cmvCtCWVX55C8He4mqKmWWJbgfxHdjAohTfqnjmkVMKakSpyziLaMl+oIE2Fw1E51plqL+EoI2p+HJpR50XqO2p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlaStX4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186FCC4CEEE;
	Mon,  5 May 2025 22:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485855;
	bh=3VTvkgWlhG6cml0I+iMJ5YstdI9lUTyy+ZFjdKg1mLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlaStX4pzLwK20c4jdajXDiGCl7tBMBSxvU0gtZPTwyvnWRA2HWTCLp2uD5UmLOq+
	 IlCLDETIbf44tCuOuQ4vuZl6C1eBj5LJRU9ckMQmpfQe55tNLR/Bd3KKzqto/RtgTW
	 ZLm1XPj8fGgCXlZQKFuNZXux0xJ/qKvsqW0uKFtT61ZBNnM61g52/Ag9+0QaDhHZDN
	 sLEeHjTHs6mnNuGB7yY6jbUsjXe2pHw2yiusKnSefw8OEtotqXSrnhKw0Vh9eq8gFF
	 Y6gUIPKSDLMwh4sED50KrtIDaxuvhCUrprBh0LdyrNJIjKm/uDhAG81cQqga5tU3GH
	 K7a1Rmn1VdS+A==
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
Subject: [PATCH AUTOSEL 6.6 031/294] PCI: dwc: ep: Ensure proper iteration over outbound map windows
Date: Mon,  5 May 2025 18:52:11 -0400
Message-Id: <20250505225634.2688578-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index f2e5feba55267..26ad643fb4248 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -281,7 +281,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	u32 index;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	for (index = 0; index < pci->num_ob_windows; index++) {
+	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
 		if (ep->outbound_addr[index] != addr)
 			continue;
 		*atu_index = index;
-- 
2.39.5


