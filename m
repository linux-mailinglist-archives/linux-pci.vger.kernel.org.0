Return-Path: <linux-pci+bounces-19271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E87CA01149
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 01:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0367E164CF6
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 00:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB273D66;
	Sat,  4 Jan 2025 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOq9emER"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E28F77
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735950096; cv=none; b=YSe4QmausWBw3v9NH7jfuQkh4U8jF3gub42yPiUDe3fBudtpV/Dean8dzGKGqZFuGzGsF5aMnhEizsvhHjQzaTihafnRunbFWwub9o8Pu5fvd3iVBPt0r1fWqvzHHK51DSN+YAQgdsZWvdnl+Et6UaVbKnYe6uN0vaEjIW0uGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735950096; c=relaxed/simple;
	bh=kubRnj5mvwSHwk8mLuo4g1N2jXWg39zGJozb06L1IfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k85xT9v6/1Gy34S5QxZFFJp5qN7o9BKWVUNl2SDLn5OzgnRWoAZDKlfs/xl0FjImo5RXS8FPYrro0JKaoFZ8RJ8123vpExlaCeIaaqjfR/AvzPTHwUBU83KezXkyrXwkLo7YKniW7sKq7+cXjS/WQ3+2sfizC7Z21JJzGJ87JAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOq9emER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF852C4CEDD;
	Sat,  4 Jan 2025 00:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735950095;
	bh=kubRnj5mvwSHwk8mLuo4g1N2jXWg39zGJozb06L1IfY=;
	h=From:To:Cc:Subject:Date:From;
	b=nOq9emERJltx6iWXV8v1mIF6fIk5CG7+hHHPFfdWwX2IT7i33WNgY1ZgTeQxX3+lF
	 RPtZ8F+GX8j2q+hia0PXOsxFOkZW35VFFxjCN0UJGMYdFB2WMm+nQjeXNnuhz5hVAP
	 IRAD5cC+TMUOCcTEcbcJEr+3AxZqALKKir6mfZFeJ9WJ/i2F87s+OF2MEtZVnsU1j0
	 4DDME2UcQLW+pDf2QAQcirDLDzIBtG4pfjbKr+TlHnlVeOvomL4hwZAZPczTv21T3C
	 7UWd7tKsoEHJW2gw+X0C12G76oKVo2itV4EuJ0wZpC/Jbf7/06eF/kCMZVjqL3NYtd
	 N3Ko/0VP+vS1A==
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
Subject: [PATCH v3] PCI: dwc: Fix potential truncation in dw_pcie_edma_irq_verify()
Date: Sat,  4 Jan 2025 01:21:20 +0100
Message-ID: <20250104002119.2681246-2-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=cassel@kernel.org; h=from:subject; bh=kubRnj5mvwSHwk8mLuo4g1N2jXWg39zGJozb06L1IfY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIr6v4r/ZhuynGyUqyCY2euT3jR1a1O+47MtChKnP0r0 Fn/2EqnjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzEUo7hn63Ncv/3zDP3KAkb CPemrmD5NOv0qucOjQcMzFuaN9joWDD8r3SfETvxwLJ9HuV7C+Zue9Tkycloanfyt9fBuSEdvwR W8wIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Increase the size of the string buffer to avoid potential truncation in
dw_pcie_edma_irq_verify().

This fixes the following build warning when compiling with W=1:

drivers/pci/controller/dwc/pcie-designware.c: In function ‘dw_pcie_edma_detect’:
drivers/pci/controller/dwc/pcie-designware.c:989:50: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Wformat-truncation=]
  989 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
      |                                                  ^~

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v2:
-Simply increase the size of the string buffer instead of chaning the
 print format specifier.

 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3c683b6119c3..145e7f579072 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -971,7 +971,7 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
 {
 	struct platform_device *pdev = to_platform_device(pci->dev);
 	u16 ch_cnt = pci->edma.ll_wr_cnt + pci->edma.ll_rd_cnt;
-	char name[6];
+	char name[15];
 	int ret;
 
 	if (pci->edma.nr_irqs == 1)
-- 
2.47.1


