Return-Path: <linux-pci+bounces-14778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BC49A238B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA8F1C26971
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4C81DD552;
	Thu, 17 Oct 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiOaIIMX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666251D414F
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171268; cv=none; b=tgdJWDu8eN7CDG86+Dmpd6zAlRc5RudMYVrTXxLbOzzRrXHyoVykyI7xwmP4es4jJWFp3syHpwxVLHLEorMwrly6rlhx6SE2YUp56jN14l715mTXaScCfduFNoCmh4muAhAwBCpFqU0Lz/DK5VlzoPdNM9EbD3P3L6r5BNXASwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171268; c=relaxed/simple;
	bh=P1ZmGdvNRNOCVcnRImmu9iHgcJfCp5HtG3O6go/+hAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkJl2+/N1n0Trdl1eblbYNb0fmT/hSfpY6TckJdpLpGopyV8Wd/trt0IQ804hgitiQ6x/pXRa9Pl6IFUnMySGg7jgMs8A1yiSSa3pxX3mnPUn1tdiWWQOe5zzVlXGEI5lOF02cVmdrMeqNnbOsUL7zSU3DILsOW+hsuC3DQ9ses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiOaIIMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65DDC4CEC5;
	Thu, 17 Oct 2024 13:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729171267;
	bh=P1ZmGdvNRNOCVcnRImmu9iHgcJfCp5HtG3O6go/+hAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kiOaIIMX+C0lkvU6c1Al/VYuHHPoiNhS8e7NRy4gG18c7wc+sM2N2v03X1KU5RHNr
	 ZV/lkTBhs3l8TwoBNnN3NhEmzgaj31G9O14njrkzmgn6W2393tmhoBjxa8YPg37mEP
	 S76V5u1eSnxWeW1Jqwb9SVFoKMZQD9WURKBh0supxR/mj85958HhTrr0Wm4a71jSUm
	 c0ldYIvoKqnEbytu9/KnTp5uhrpzbNnN0s+x6Ii3FWps1aCDz3H1t2LUtu1prYQR0V
	 bg7YQwbyZNFgNh/JxCtKH28sboTqB2yPJH6aCCzHH0M8mLVu8I1yJIELK17eVnvEWu
	 Ao7WITksSWIeg==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: dwc: ep: Fix dw_pcie_ep_align_addr()
Date: Thu, 17 Oct 2024 15:20:54 +0200
Message-ID: <20241017132052.4014605-5-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017132052.4014605-4-cassel@kernel.org>
References: <20241017132052.4014605-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510; i=cassel@kernel.org; h=from:subject; bh=P1ZmGdvNRNOCVcnRImmu9iHgcJfCp5HtG3O6go/+hAQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIF+U0mn9jG+pjB/f7RCea+6xMdo7ac7Gy6sTh5UvvMZ 6uyexes7ihlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEbhkzMszkivTs1WPS6Di7 9P3/TawrJmsYKf7UsPj3aV97g8OmkOMMv9m3c2Y1zuFMmPZePzf7fcfvIt3pZ9dUr5K6eKrvtbi VCj8A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ep->page_size is defined by the EPC drivers.
Some drivers e.g. pci-imx6.c defines this to 4K for imx95.

dw_pcie_ep_init() will call pci_epc_mem_init() with ep->page_size.
pci_epc_mem_init() will call pci_epc_multi_mem_init().

pci_epc_multi_mem_init() will initialize mem->window.page_size.
If the provided page_size (ep->page_size) is smaller than PAGE_SIZE,
it will initialize mem->window.page_size to PAGE_SIZE rather than
ep->page_size.

Thus, mem->window.page_size can be larger than ep->page_size, e.g.
for a platform built with PAGE_SIZE == 64K, while using a EPC driver
that defines ep->page_size to 4k.

Therefore, modify dw_pcie_ep_align_addr() to use
epc->mem->window.page_size rather than ep->page_size.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2d0e7bf17919..20f67fd85e83 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -276,7 +276,7 @@ static u64 dw_pcie_ep_align_addr(struct pci_epc *epc, u64 pci_addr,
 	u64 mask = pci->region_align - 1;
 	size_t ofst = pci_addr & mask;
 
-	*pci_size = ALIGN(ofst + *pci_size, ep->page_size);
+	*pci_size = ALIGN(ofst + *pci_size, epc->mem->window.page_size);
 	*offset = ofst;
 
 	return pci_addr & ~mask;
-- 
2.47.0


