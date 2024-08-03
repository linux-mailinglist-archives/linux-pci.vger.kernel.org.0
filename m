Return-Path: <linux-pci+bounces-11235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89AC946987
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 13:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83622B213B9
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 11:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCE523CB;
	Sat,  3 Aug 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzUTj6ti"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BFD1ABEB3
	for <linux-pci@vger.kernel.org>; Sat,  3 Aug 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722685404; cv=none; b=l2PnjlD0zXwoINSN6n1/TgkbpwHKzePqvDrMamPMHj+m18L1+bwk7RS7nfZB7itYRhi/XCQb8FgyDdf3ko1+2hWxUX314n9U5QeNNNaZhxHOBBjHTFiC8+f+24r7/O0bAlyrgdClH+m5Rej8zxma0Igyr4iBpTLoE0VR2q/Tvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722685404; c=relaxed/simple;
	bh=W5OIL+MmvgR3ChZnochmEjHn12QPcLk3l3puGwo1Jv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oekqsuB/7ZrorDw8ZJAU60idiDUbEaCz/pHUy0wp4+t73y2ax/OIBPwLCNf4PQx4XQHGHLbDcwbQVtO6VFLzLS2Sj5gi01ATHQd2VsI2Wcs9fUHs1anMhOcCdZTYYAdmq+eMRhTNINNeJWTL1LJZALSQKqGNfjtHQGm6TjZgsnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzUTj6ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C52C116B1;
	Sat,  3 Aug 2024 11:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722685404;
	bh=W5OIL+MmvgR3ChZnochmEjHn12QPcLk3l3puGwo1Jv0=;
	h=From:To:Cc:Subject:Date:From;
	b=NzUTj6tiSyTg13h/T8juYmt2f0RqjEaWVm/opRhqv+iBL6+HAxDoSrYlt2QSWhctI
	 muKLFL/4WYJQgQoW48nZ/PN/917Ci/Udy50Cs+spYEMGUDK6L+iXSkWhbwGmQqpjsG
	 oqo9/HKf70IJ3mGRk7yJ2TXeEaLuP1QMeZW1hu/VtYE51+NXcAv9mbU+faKIfFqPfr
	 QybX4cfGKYou2LfUUJ1tAlqqFO2hlvJ1pwlnQ4AR1F6SxisFY2V0T9QYRM/lyCu29d
	 KSTu3YW1ga0HaMR8DvRW9sa0W1DpS9nKr2lbyW8xJclVCAEXrWItmbK3bJ1NJxDcVQ
	 6YPD0JTfSqFzA==
From: Jisheng Zhang <jszhang@kernel.org>
To: stable@kernel.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH stable 5.15.y] PCI: dwc: Restore MSI Receiver mask during resume
Date: Sat,  3 Aug 2024 19:28:52 +0800
Message-ID: <20240803112852.2263-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 815953dc2011ad7a34de355dfa703dcef1085219 upstream

If a host that uses the IP's integrated MSI Receiver lost power
during suspend, we call dw_pcie_setup_rc() to reinit the RC. But
dw_pcie_setup_rc() always sets pp->irq_mask[ctrl] to ~0, so the mask
register is always set as 0xffffffff incorrectly, thus the MSI can't
work after resume.

Fix this issue by moving pp->irq_mask[ctrl] initialization to
dw_pcie_host_init() so we can correctly set the mask reg during both
boot and resume.

Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
Link: https://lore.kernel.org/r/20211226074019.2556-1-jszhang@kernel.org
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f561e87cd5f6..962e700f90f5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -352,6 +352,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			if (ret < 0)
 				return ret;
 		} else if (pp->has_msi_ctrl) {
+			u32 ctrl, num_ctrls;
+
+			num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
+				pp->irq_mask[ctrl] = ~0;
+
 			if (!pp->msi_irq) {
 				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
 				if (pp->msi_irq < 0) {
@@ -550,7 +556,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 		/* Initialize IRQ Status array */
 		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-			pp->irq_mask[ctrl] = ~0;
 			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
 					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
 					    pp->irq_mask[ctrl]);
-- 
2.45.2


