Return-Path: <linux-pci+bounces-4757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CB587927D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 11:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773901C224C7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3C59160;
	Tue, 12 Mar 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC2hvPJv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3C2572
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240765; cv=none; b=Nb46bKrhvmvyXLSoVgAdk8xKlgH/7jMowB+ndpoH4/T0a0vfFew3+aFPu/YyCY7/UFsEcML/8Jg1MA6dOCZHQ+9YoNK47PBkrC0hDI9XZD3bECsMRKudaiRPP1yImKfxcvqfQjxNUwzT7b8r6PlePqt0wp21FQCduxvFyp/u4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240765; c=relaxed/simple;
	bh=dGFFmN2l74ZRPdhvtM1elVvNv6B/6afZhy1KjLAVKI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+eIKSbiOb6Ed0HPSXyMCgSwkAAYzKy6wU8RqKl1xuWjZmAK4NCTgS+nhtuGMsMqkvf4r1qyZH9S/y8HkhBQAixnI55LT0CVvvj+FJvzscBtNP2dzawkFgeO7pGDApH9qu89N32A2Cu70EOCXQm4TgrUjPWJUuJ7C3hVW98h29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC2hvPJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9F0C43399;
	Tue, 12 Mar 2024 10:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240765;
	bh=dGFFmN2l74ZRPdhvtM1elVvNv6B/6afZhy1KjLAVKI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CC2hvPJvR7rycjcZq7kK7yUdwuhk2Ziq7YDKKllT24mB8/cYI45uGcUdVkAN/k9JS
	 TsTjCue/CjzSHJXtNBl2JWBADMgIKlnEGyuVNGeVnbK1JdjTFdVIngcRn2RdFPjlER
	 SSLgwnG8tVKgq+kKUSgmR7qr0t22buNwJKZ0Q9Mm+XtHuxruOccth8lp9kRujOzMeV
	 D3r7DPR/G+/h/TB/Lhh2nPidU7FSTr6rVYnz9AQ+p7YRJK8988F4ddxGVHIodD6Eux
	 C98kkDYy/FJELFA14Mqr/RXfmgqeRqX1saC23E2/ggwfps1CCTIeNKLGg3JT8+AJ19
	 fTvDiy6+o72ww==
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
Subject: [PATCH v2 7/9] PCI: cadence: Set a 64-bit BAR if requested
Date: Tue, 12 Mar 2024 11:51:47 +0100
Message-ID: <20240312105152.3457899-8-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312105152.3457899-1-cassel@kernel.org>
References: <20240312105152.3457899-1-cassel@kernel.org>
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


