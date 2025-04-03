Return-Path: <linux-pci+bounces-25257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4665DA7AED5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 22:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568AF178544
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076C5224250;
	Thu,  3 Apr 2025 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6tAQPp5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD922422C;
	Thu,  3 Apr 2025 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707877; cv=none; b=fhUJDaSs8XOT03LhR6DTztqfRtAjVC32Y7IqbBKvnfXwQxjHgY0bGzXd4Ft4yaUXXiDdIzy0201HVQKwhoo4daedTtWbeGTiUlncit/Vdojh+BIOoyCpMhlEdLDAcaON0YcOG3KvjXmUJQKeuRIYR3DtagDVK8MLOf4SgDxnCgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707877; c=relaxed/simple;
	bh=icKnX0AHeCC4uL6XXIqqr1srD+3rCKvvh8Uu9AT73u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hm/IREyS9+W7g0J13V5lNEz6pIHNCvgLYgxPG4yg55da/jYlcwrOt892PwfRnb/73qxDa0ScdCuwf2JIn4FFNY4ydW2K1d8ozspZvJxU18gIEYvLRRaR91uu7QQnGZZ2MS4NnZMLgRJINLLrLbwTVdz7ireaNYkDU7jULbz5nv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6tAQPp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2073DC4CEE3;
	Thu,  3 Apr 2025 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707877;
	bh=icKnX0AHeCC4uL6XXIqqr1srD+3rCKvvh8Uu9AT73u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6tAQPp5okI+lyfINItnecRbPDUNIrqWUES0KpgMQ5oSek81sVN+i1j9sdKPUpTAv
	 FvgiAvy/844UWL4QquFMYKpNrv4kSxXhPmj6KaD+GdoYs2+Gb8lUm9DPFTrfjC0KC5
	 EPyMSGn8dWncJAs47PyV8jzpj8FjJKTGOvmH6WD4EEmGgMr37JPoKHmpVQUsAIkS47
	 6pr83Efek9e8iRMGDqrYwriherLklWA2dxnyAmV46TUs37a/xJpb3mI5Qte1bvGtup
	 zaTDR5tzK1QippZj3Q1h6eXsBw5GOPhZJH/BaXH5w40L6PGuLme1NMmuQO7qMZrazX
	 yy0cFJEPlYI1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 24/33] PCI: Enable Configuration RRS SV early
Date: Thu,  3 Apr 2025 15:16:47 -0400
Message-Id: <20250403191656.2680995-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 3f8c4959fc18e477801386a625e726c59f52a2c4 ]

Following a reset, a Function may respond to Config Requests with Request
Retry Status (RRS) Completion Status to indicate that it is temporarily
unable to process the Request, but will be able to process the Request in
the future (PCIe r6.0, sec 2.3.1).

If the Configuration RRS Software Visibility feature is enabled and a Root
Complex receives RRS for a config read of the Vendor ID, the Root Complex
completes the Request to the host by returning PCI_VENDOR_ID_PCI_SIG,
0x0001 (sec 2.3.2).

The Config RRS SV feature applies only to Root Ports and is not directly
related to pci_scan_bridge_extend().  Move the RRS SV enable to
set_pcie_port_type() where we handle other PCIe-specific configuration.

Link: https://lore.kernel.org/r/20250303210217.199504-1-helgaas@kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ebb0c1d5cae25..a4330ad7cdfdf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1328,8 +1328,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	pci_enable_rrs_sv(dev);
-
 	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
 	    !is_cardbus && !broken) {
 		unsigned int cmax, buses;
@@ -1570,6 +1568,11 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_cap = pos;
 	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
 	pdev->pcie_flags_reg = reg16;
+
+	type = pci_pcie_type(pdev);
+	if (type == PCI_EXP_TYPE_ROOT_PORT)
+		pci_enable_rrs_sv(pdev);
+
 	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
 	pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
 
@@ -1586,7 +1589,6 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	 * correctly so detect impossible configurations here and correct
 	 * the port type accordingly.
 	 */
-	type = pci_pcie_type(pdev);
 	if (type == PCI_EXP_TYPE_DOWNSTREAM) {
 		/*
 		 * If pdev claims to be downstream port but the parent
-- 
2.39.5


