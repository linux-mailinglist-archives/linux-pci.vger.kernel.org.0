Return-Path: <linux-pci+bounces-14707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C39A1836
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314291F27173
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8923D224F6;
	Thu, 17 Oct 2024 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJT4uRLJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6EF4ED;
	Thu, 17 Oct 2024 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130338; cv=none; b=nFVuwx020r0ePw3a6Zg6J4naDLCEwp/oZhU+Dp2+uBWhAi+EmXrL0V18s9VpCBKXJoUnrN09FZVrBFdPnwBkjE9KDd5f0N8pWuQMZNZbRIf8t2k+SejqqceijGfJGwE6R32GRhA5vOcqrGvCtrAXliZeWejRxME4XbMARgEZ8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130338; c=relaxed/simple;
	bh=pSHsBhnbjSj04jRr4dxkMJFuwUPFncYPKlMS7obkf/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RY5AWVm4IRngYOl+6ABS367kZYAIOYiH3jUsy7+KFmJjQO9O9oZ/wm6E3hSb+ERcbeXwOzgzcii5hvs30kryJtgXaXBX6mOhOKD69AdUG+PA3gOdGC6Fr2FQkGbSK2XlSNQzm3nE5th6ciji6jxQhNslZTArzqhMQZi13f8S2Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJT4uRLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8184DC4CED1;
	Thu, 17 Oct 2024 01:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130338;
	bh=pSHsBhnbjSj04jRr4dxkMJFuwUPFncYPKlMS7obkf/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJT4uRLJMCcJrfcWJbb9Vtf91JmvWWBwMg3fdndwwUFo1kRIJJ9vhMN1iWRH7wZvH
	 XDa5mz/cb06/gjnLpiP8J7fJPeIBdyQMp0a5wCaqCKJlbONbfULruA02HkMGpu6WcS
	 KeVlI5fZIHtoMiLt63MXZjkYnZ33/zXBQ7N9vQXHcZxOCNZtVl/k7TKyzLW+fYGvTJ
	 vhubomFAkPthxQPxDIXX8GMa8obGGATo+L06212lJ4eckdill45hT38sraZ2JIXECs
	 VmLr/eJi4Pc1FqF+abIUlm6rFD11WAJ1loEB32cirqIeFVlN9eHyWEoNa4KUMv8g4z
	 RUAGUsIVIjzaA==
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
Subject: [PATCH v5 03/14] PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
Date: Thu, 17 Oct 2024 10:58:38 +0900
Message-ID: <20241017015849.190271-4-dlemoal@kernel.org>
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

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

There is no need to loop over all regions to find the memory window used
to map an address. We can use rockchip_ob_region() to determine the
region index, together with a check that the address passed as argument
is the address used to create the mapping. Furthermore, the
ob_region_map bitmap should also be checked to ensure that we are not
attempting to unmap an address that is not mapped.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 5a07084fb7c4..89ebdf3e4737 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -256,13 +256,9 @@ static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u32 r;
-
-	for (r = 0; r < ep->max_regions; r++)
-		if (ep->ob_addr[r] == addr)
-			break;
+	u32 r = rockchip_ob_region(addr);
 
-	if (r == ep->max_regions)
+	if (addr != ep->ob_addr[r] || !test_bit(r, &ep->ob_region_map))
 		return;
 
 	rockchip_pcie_clear_ep_ob_atu(rockchip, r);
-- 
2.47.0


