Return-Path: <linux-pci+bounces-31166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C893BAEF7E5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DBE3AFC19
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DDC26E6FE;
	Tue,  1 Jul 2025 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAihkcUB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92B26C3A3;
	Tue,  1 Jul 2025 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371752; cv=none; b=UfpxY0vpUJfAn8dk8+u1NI5sgOHgk1xjLfjli7Fl7TCWliN0Sph4mWLlA9/gzqBdSeXEZHeurcLK9OY389tO4AfPD12cQdeKLKvM/rQLRA5Zq1Ph1x7myAR818rle+qREi41DG0grWGwaH4Artdzfy1UuMahBewERdfPVu4NBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371752; c=relaxed/simple;
	bh=d/8YSWqDAttPxhALnCv0hSHOr6sy2qbciex+/jHshJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4AwEq3TQNljOxf6eC/t2JmLcIo+4R/ngT1UtsndfrkOH3rxkbeTv+mrcpXGgaiO9LJacccZgQTxWxESATvBcK1zSUkB4lkVOSFmZAd7tqtfRx6QxzglxAVmHex6rPb+tyiQgHfhfUCw/5tPjdyyVGs+ljzd0z+LpHo/DTXG7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAihkcUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38580C4CEEB;
	Tue,  1 Jul 2025 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751371752;
	bh=d/8YSWqDAttPxhALnCv0hSHOr6sy2qbciex+/jHshJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RAihkcUBay3YfiWN9az3Psg1wmuIjASF610l1PU0n+fIZbjf17Q4wzpak7x60G3n0
	 lv3A9ASXDsHGVUjX9EvoJjRkNOCkLLmNXvtMuvvgttcbHJ4DUvoD/JT//JdPaRakAB
	 H1aflA4XO0DPw9u7gexiri4YkzjKStTZoWvGTv/opG1fc22aH4rTo09qvCKTl4/efh
	 UEfaXU1sOdN3o1609GZwWdKwTlJ7rx48l/Ms3mbIMmozJNI4WAWH4seTgxa/Lw86TZ
	 I+hONd3c+vv4y9psG9mQCVfTWy3wxCCHTsCcrILaU/IlcWVMNqlqWNYcWb4lMXYdYB
	 h0HQEGMVpWGKA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org,
	jingoohan1@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] PCI: dwc: Make dw_pcie_ptm_ops static
Date: Tue,  1 Jul 2025 17:38:56 +0530
Message-ID: <20250701120856.15839-1-mani@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dw_pcie_ptm_ops is not used outside of this file, so make it static. This
also fixes the sparse warning:

  drivers/pci/controller/dwc/pcie-designware-debugfs.c:868:27: warning: symbol 'dw_pcie_ptm_ops' was not declared. Should it be static?

Fixes: 852a1fdd34a8 ("PCI: dwc: Add debugfs support for PTM context")
Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20250617231210.GA1172093@bhelgaas
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index c67601096c48..7356b0f6a2ad 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -865,7 +865,7 @@ static bool dw_pcie_ptm_t4_visible(void *drvdata)
 	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
 }
 
-const struct pcie_ptm_ops dw_pcie_ptm_ops = {
+static const struct pcie_ptm_ops dw_pcie_ptm_ops = {
 	.check_capability = dw_pcie_ptm_check_capability,
 	.context_update_write = dw_pcie_ptm_context_update_write,
 	.context_update_read = dw_pcie_ptm_context_update_read,
-- 
2.45.2


