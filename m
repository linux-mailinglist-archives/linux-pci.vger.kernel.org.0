Return-Path: <linux-pci+bounces-4781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D47487A64D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398541C21607
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25A3FB07;
	Wed, 13 Mar 2024 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDLz/RXD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD53FB01
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327520; cv=none; b=npUl25e39VGuA9uLMoPn2jgBrBc49TAjT1J4BMp61hGaZYB5OwrSEdz5NLz0Gs7W9aCbEYByOpDmjBaHKYpfYRPo1vPSjUGMI9L2KjvHoqz6ftcCz9yw85Ty6tCs7aUGRV2sKM4lDq8phjXJFfyVsPA91Bqp2SO7or/tupou1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327520; c=relaxed/simple;
	bh=dGFFmN2l74ZRPdhvtM1elVvNv6B/6afZhy1KjLAVKI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQEwcaTgPwQN3/cHHijuHnWsDo5GzypWX2aUGIaF26bS5w9Q8BlZqrA31Cs9tnYb+6ftlNHFCqn21evjYYtqoC43v0us2X4H6RTUOJ7Mu39EiRtxd9qGFGRirfoWbhxiztitQ9H3ERgR3B6GJnJEOfigK7XErtIYSbDWjUP4/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDLz/RXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE5EC433F1;
	Wed, 13 Mar 2024 10:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710327520;
	bh=dGFFmN2l74ZRPdhvtM1elVvNv6B/6afZhy1KjLAVKI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDLz/RXDwDBDHx2XJTYwXG9zFbREf1z4sGQrFRo6kx9AQThsTkN9OBPtCnAqgkfSj
	 qiLBxQ+7tiz/DgFjVchMzkacQ+RD31tNIm4NImHc0mRsAecXHBum7F52hAHdIO8tx0
	 FTPTn296JSkEewDtVwtOim4nlOdBuGxK+Tr+J4b9ZReiAPoKg5tlvbjB02PMZpHDR7
	 Y8rTBfoCRVo6olNlGBpMKDf8owvLRARDiY5Ke81wfSoZsRpoL+2WAtJD8mexzxn+rD
	 t/iY/jXHSP8ejHJci9CH0GtFXywW2j+F5Ot/gwOVSm5BDokH+n51tBd1lpEHNEHfYT
	 xWsQzwiVJAxeA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 7/9] PCI: cadence: Set a 64-bit BAR if requested
Date: Wed, 13 Mar 2024 11:57:59 +0100
Message-ID: <20240313105804.100168-8-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313105804.100168-1-cassel@kernel.org>
References: <20240313105804.100168-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
is invalid if 64-bit flag is not set") it has been impossible to get the
.set_bar() callback with a BAR size > 4 GB, if the BAR was also not
requested to be configured as a 64-bit BAR.

Thus, forcing setting the 64-bit flag for BARs larger than 4 GB in the
lower level driver is dead code and can be removed.

It is however possible that an EPF driver configures a BAR as 64-bit,
even if the requested size is < 4 GB.

Respect the requested BAR configuration, just like how it is already
repected with regards to the prefetchable bit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 2d0a8d78bffb..de10e5edd1b0 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -99,14 +99,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 		ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
 	} else {
 		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
-		bool is_64bits = sz > SZ_2G;
+		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
 
 		if (is_64bits && (bar & 1))
 			return -EINVAL;
 
-		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
-			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
-
 		if (is_64bits && is_prefetch)
 			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
 		else if (is_prefetch)
-- 
2.44.0


