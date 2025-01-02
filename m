Return-Path: <linux-pci+bounces-19156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301E9FF889
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 12:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1DC3A2BC5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 11:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B56619D07C;
	Thu,  2 Jan 2025 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQFLItGZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E897B219FF
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735816438; cv=none; b=tJ+g/9vIq3Epo53jEbgjdgARTIf/VGMCxzXDyTYUGuTSVj4WfyZkHh64YqCafxr11TEEPrIeVeW72n3gJVPq0ZSIiNdCoBl87D5Zrcc/FRXNsZnp3XuAZhLyzdHjgAycgafE6eyyqeWq4t6uN0L1aQQFSXMlnX7qkGozpngkOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735816438; c=relaxed/simple;
	bh=SIPTwBfOR8bPRMZ5Gxi66zad8YdydJ5Bp00gV7bEcGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OBnqX6+IoV9XaoKOT/k7dcUu1vzTVYYFiP7cn3/en1TadNjkt6Q6yWPrUre0VVIuXo90+Dnir/Fd913uNFjxYfNwuqGhCgdlO/9/zn+WD8a/3G00OCmjFiV8miZZJ7X/K0fdeVv4cmdpUn+Irbg2YwUyBerCWX8q+e7ukHi92dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQFLItGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F039C4CED0;
	Thu,  2 Jan 2025 11:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735816437;
	bh=SIPTwBfOR8bPRMZ5Gxi66zad8YdydJ5Bp00gV7bEcGM=;
	h=From:To:Cc:Subject:Date:From;
	b=JQFLItGZI+2l2TVJ3iTxk+NRmy9Anyug7zEy7TI3GXSZbYvOGd5ydl21Cey0WjGkU
	 tU21GCOza+Ax2gTqDfEMQ2HQAZZDGSHbM+/YbJG76vrASajJ8x2pdHCKrjz16KUAxV
	 hWhoEwe1RE3PVgQ/AbSpIhTY0opfiEhMn2CTN0knA5mp02gLLztEZYUBuE6WHCJxuS
	 VUwkKB5Z8p1ovwQ/zX1H8AU3TuzFsl1MW6vYbndV2QfBM/2g6hyp+sxhUPVDKTU4l7
	 SnP8FYZ4nbUuLmZaq377hkXK17D8yM7VNRWW2XbLgVr63gSvq6HHhEv2S+GuwZVKCE
	 L9AWOhU/flE+w==
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
Subject: [PATCH v2] PCI: dwc: Fix W=1 build warning in dw_pcie_edma_irq_verify()
Date: Thu,  2 Jan 2025 12:13:40 +0100
Message-ID: <20250102111339.2233101-2-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=cassel@kernel.org; h=from:subject; bh=SIPTwBfOR8bPRMZ5Gxi66zad8YdydJ5Bp00gV7bEcGM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLLSh7/zxZLbd5r88o336OkvGj/q4hvwasfr8lbcOXQn EITC+6OjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExk4jyG/76yscuDLQ4u+GXS wrxm1uR0O/kOxpTFivxF3elt/2Web2f47yNnNKWhh+Hdvs5dV1ybN+9t7WbMPrdFjfVm1pm27eY 32QA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Change dw_pcie_edma_irq_verify() to print the dma channel as %u.

While a DWC glue driver could theoretically initialize nr_irqs to a
negative value, doing so would obviously be incorrect, and the later
dw_edma_probe(struct dw_edma_chip *chip) call would fail, since while
the dw_edma_probe() call expects the caller to initialize chip->nr_irqs,
dw_edma_probe() verifies nr_irqs and returns failure if nr_irqs is < 1.

This fixes the following build warning when compiling with W=1:

drivers/pci/controller/dwc/pcie-designware.c: In function ‘dw_pcie_edma_detect’:
drivers/pci/controller/dwc/pcie-designware.c:989:50: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Wformat-truncation=]
  989 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
      |                                                  ^~

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since V1:
-Do not reject negative nr_irqs value in dw_pcie_edma_irq_verify(),
 as this will already be done by dw_edma_probe().

 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3c683b6119c3..0a13fb4336f4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -986,7 +986,7 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
 	}
 
 	for (; pci->edma.nr_irqs < ch_cnt; pci->edma.nr_irqs++) {
-		snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
+		snprintf(name, sizeof(name), "dma%u", pci->edma.nr_irqs);
 
 		ret = platform_get_irq_byname_optional(pdev, name);
 		if (ret <= 0)
-- 
2.47.1


