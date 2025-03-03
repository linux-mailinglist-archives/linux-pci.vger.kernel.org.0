Return-Path: <linux-pci+bounces-22790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A2A4CD21
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 22:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0009418953CC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC481E7C20;
	Mon,  3 Mar 2025 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiVmv4Zd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500817CA1B;
	Mon,  3 Mar 2025 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035741; cv=none; b=Tg9j8S4CvpSb68mTZ8jneEvQh2x+ZS/i1uoqLLIbng06satzJpeYeNItHjx0vEjzX5TAe1dRfPdm+h0RYuudr6cxvruly6LXQhj6I35FUDNqQf4garV+EXEVNr/uA3FNYXt65RSVv/ghEt+niWDMoGf4vsY3gIHCxAsdVxQvuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035741; c=relaxed/simple;
	bh=/dvqDPy/gu2wN4BIq6RQWbjM3nOGum0OPt/YKSg58gk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I/rSGRMjjadx34zQ2BUkuyio/Jw+cspBMwblJywnaRQn+BPhvP1Hw78ZMxGMFypf0ixZhj0qcgefeWoHOQoQL4u3xqyO4UeZfMXnDeoguyFfv+HxH3RolOizxZA7t3zuCrm2qFC3MFNHWy4g60l2SfIgUD88tFJpvCLlpPOCO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiVmv4Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C81C4CED6;
	Mon,  3 Mar 2025 21:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741035740;
	bh=/dvqDPy/gu2wN4BIq6RQWbjM3nOGum0OPt/YKSg58gk=;
	h=From:To:Cc:Subject:Date:From;
	b=eiVmv4Zd0boJl887h60rSn7npsrveGehKZnnl4tbi6Q83ZfMXBr+nwBmkxWleZ2MX
	 vD53zrS+kOrrVg3/U8s5Z9ezuyu2nTMBArpUm0didRVzTvDIT/zs7J5V4VXYxo6ja1
	 2mWZ35FsYakZ3w/1LX6vKcfufxmVKpgqB4272Gbbhdav5LT/65yy/HL84Yov9rt9ID
	 hK8hJ+13MAodCqubtP/HhsRWk+eSnOizuhpLzrYsQ8D/cLjUxbXodwgPvL8QQYTWV9
	 KLj32uMU9NYo9dIldGQrqHpD8nTqrdYiplcJhCXmDh9OFax20Z5ic2L3YsNTh1KIDV
	 6hwOcBiBozYqA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Enable Configuration RRS SV early
Date: Mon,  3 Mar 2025 15:02:17 -0600
Message-Id: <20250303210217.199504-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

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

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..0b013b196d00 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1373,8 +1373,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	pci_enable_rrs_sv(dev);
-
 	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
 	    !is_cardbus && !broken) {
 		unsigned int cmax, buses;
@@ -1615,6 +1613,11 @@ void set_pcie_port_type(struct pci_dev *pdev)
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
 
@@ -1631,7 +1634,6 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	 * correctly so detect impossible configurations here and correct
 	 * the port type accordingly.
 	 */
-	type = pci_pcie_type(pdev);
 	if (type == PCI_EXP_TYPE_DOWNSTREAM) {
 		/*
 		 * If pdev claims to be downstream port but the parent
-- 
2.34.1


