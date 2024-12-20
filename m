Return-Path: <linux-pci+bounces-18859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46D9F8D39
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 08:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4322D1896567
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 07:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84C318A6D3;
	Fri, 20 Dec 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWraBeln"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A122217FAC2
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679448; cv=none; b=D+TH3QgYNU2G7rPVd4Jo56gQaJnzO1N73lYxjzJMb1hYT0CSslhki4jknurU2OrBLc86TvXEZSikMWl46hd2ED+01Fb0lNjoz2ZY8Ci6TmOZ22XS9TujooHf08a8r3EzPgXdEhqTHmWBlT5zQXuPGllDP8pcgf3tznVO9aXooK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679448; c=relaxed/simple;
	bh=fRLLBH23QC/DarwvX5ERdkM9z/RIFAr9cuImi11cLQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=usrFfWVHMPz5y+aAvK5yabWuiNDy4Sv96KCjIuAb/W9caQfT2trIxUjl7xT5PfvYe4RoZPdd20eXHL/3dqDRPZUhrRnqe4hvCL30uQP75GjaceLews5wJuc3BuQWvCKFpLNCL/Dugt2LY57tkh6/6aVrKFL+mLugqqml7N3Y3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWraBeln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB9FC4CECD;
	Fri, 20 Dec 2024 07:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734679448;
	bh=fRLLBH23QC/DarwvX5ERdkM9z/RIFAr9cuImi11cLQE=;
	h=From:To:Cc:Subject:Date:From;
	b=iWraBelnEEVFXrUfISsZ+rq1f8248TvyXrb1DvgEjy+pLflyAB7So9SoURnFBmm0g
	 XCrZaAffVkS/nryXtFfX544AtZdDWl3oKWA/7PvSC1F9OgsqQqUtUtnEpAw4wVCzTC
	 /9jvy+LdlwPJEn5JXiS3Wahmgoqg/wFOWUtZ2KHjpkQRD+Uqjj1GuI2iC7Wcmtziv+
	 YpKPIhLcvaae79OTkYLniDeE8WTY+flwPX5o5aQ45oZ9Sua7UlrOU1Ewru27hn+dGE
	 IG/Yb6bR89kKijBp03gu75xZ2AQ/fklkspzvTod9W6QE2/UX+8zMyFB94A+lEV95+8
	 0vLLQ4kaE7z8Q==
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
Subject: [PATCH] PCI: dwc: Reject a negative nr_irqs value in dw_pcie_edma_irq_verify()
Date: Fri, 20 Dec 2024 08:23:29 +0100
Message-ID: <20241220072328.351329-2-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=cassel@kernel.org; h=from:subject; bh=fRLLBH23QC/DarwvX5ERdkM9z/RIFAr9cuImi11cLQE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJTpQtUFnd9UnEOmZUvPnFhc265ReUZ5x0n1zw9vuFum OHV538ZOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRpRUM/+tNHGw4zbi2t6+b +6VdcuvOletnTMhgjtPYc/7YVd2ty3wYGda4uE3nbGHdXnvsT2/qvDUxF/ojKoJnGPV9+B6o3BC hxQoA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Platforms that do not have (one or more) dedicated IRQs for the eDMA
need to set nr_irqs to a non-zero value in their DWC glue driver.

Platforms that do have (one or more) dedicated IRQs do not need to
initialize nr_irqs. DWC common code will automatically set nr_irqs.

Since a glue driver can initialize nr_irqs, dw_pcie_edma_irq_verify()
should verify that nr_irqs, if non-zero, is a valid value. Thus, add a
check in dw_pcie_edma_irq_verify() to reject a negative nr_irqs value.

This fixes the following build warning when compiling with W=1:

drivers/pci/controller/dwc/pcie-designware.c: In function ‘dw_pcie_edma_detect’:
drivers/pci/controller/dwc/pcie-designware.c:989:50: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Wformat-truncation=]
  989 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
      |                                                  ^~

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3c683b6119c3..d7f695d5dbc4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -978,6 +978,8 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
 		return 0;
 	else if (pci->edma.nr_irqs > 1)
 		return pci->edma.nr_irqs != ch_cnt ? -EINVAL : 0;
+	else if (pci->edma.nr_irqs < 0)
+		return -EINVAL;
 
 	ret = platform_get_irq_byname_optional(pdev, "dma");
 	if (ret > 0) {
-- 
2.47.1


