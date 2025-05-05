Return-Path: <linux-pci+bounces-27203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD9AAA161
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 00:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF10F7A7C57
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 22:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A28D2BD5B4;
	Mon,  5 May 2025 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9Kgy+FM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8392BD5AB;
	Mon,  5 May 2025 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483588; cv=none; b=FX4vMbi7AHa9qmz34QnzxdYO/eqoAgZpAyMPleFfEQ4cUzT1V96qHJyqoTAjcWmMB7od0QId+KNgJrUrYEGzi5MmJ8nbpCdFubAhSIwEa9Lpq/pkdI3vBkU5kg+zqLUFQGROUcpRg0nBvzjGRDtOC9JdYl0NfmTNvwu8+9qssRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483588; c=relaxed/simple;
	bh=T/HTdu5aMwCE9xVjkLAR9Aie5d4Wne/Va6+lOdvQZX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0b4YU5cRtThOG8851e3Pajrc3KRimrqR8VxRCW2RPA2p/FPV+8XIxY500LyJSmdIwBApGglQQarJmy73GKbpzJrzXCZcdsO/zxKD3V1LKgEVdSXvRPd+2/5i+v0i8V0ZQ+ZEd6PPJslm0IGzE3PCKRl6gLsc1bGUSmAOGNGLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9Kgy+FM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ED4C4CEEF;
	Mon,  5 May 2025 22:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483587;
	bh=T/HTdu5aMwCE9xVjkLAR9Aie5d4Wne/Va6+lOdvQZX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9Kgy+FMWuxE07KLdDyejyyYQg25NPMoZW/eBMApAgnaAH+7E5YyDyn13/qJvo/bj
	 sNEhBbNZQr8wvDCwGJ5pQlRzC+vwPTE40IthUeqIIHYMgk+fVZlvJoa77WLQPYDGsD
	 Q9ueMA5xubcrC1NzblME7AQ5gJQAWSBier76HQDfjri+Cc+PlaRCRRuvha82Ab23Xx
	 Upb+t5j/RCUQyWUp5ca1Kx7Ycc0v+bFQaoXmXciX+ldl7bgPECk8SNfdCF7wFEO/Nc
	 Whtv78+DJPHbtWrWIVD/ZnbmkGWTwaaioeH56osiDvf3PRy0X1XN/9ensmtuDjQ0XR
	 5qo1izdzXoHrA==
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
Subject: [PATCH AUTOSEL 6.14 128/642] PCI: dwc: Use resource start as ioremap() input in dw_pcie_pme_turn_off()
Date: Mon,  5 May 2025 18:05:44 -0400
Message-Id: <20250505221419.2672473-128-sashal@kernel.org>
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

[ Upstream commit 8f4a489b370e6612700aa16b9e4373b2d85d7503 ]

The msg_res region translates writes into PCIe Message TLPs. Previously we
mapped this region using atu.cpu_addr, the input address programmed into
the ATU.

"cpu_addr" is a misnomer because when a bus fabric translates addresses
between the CPU and the ATU, the ATU input address is different from the
CPU address.  A future patch will rename "cpu_addr" and correct the value
to be the ATU input address instead of the CPU physical address.

Map the msg_res region before writing to it using the msg_res resource
start, a CPU physical address.

Link: https://lore.kernel.org/r/20250315201548.858189-2-helgaas@kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7b..ae3fd2a5dbf85 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -908,7 +908,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	mem = ioremap(atu.cpu_addr, pci->region_align);
+	mem = ioremap(pci->pp.msg_res->start, pci->region_align);
 	if (!mem)
 		return -ENOMEM;
 
-- 
2.39.5


