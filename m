Return-Path: <linux-pci+bounces-25248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8306A7ADDE
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 22:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F835173F4F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 20:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CC7296BF3;
	Thu,  3 Apr 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GId0DBmw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93BE296BF1;
	Thu,  3 Apr 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707688; cv=none; b=rd2f8b5n4SB8A14hkfJ1pxIld2jYgoc/qkBcw42ZfH7Wd45Id6ikESp/oF8qca54pRMxE5if7V2PqsCaBE8lwyB0bYP6IG1wIIT0xR9EZ/BEqIKTfdCh0ifsTs3DSufX167CGP6DWhxpDJDddSqBxkT2s9faESh30bcSTM9Pok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707688; c=relaxed/simple;
	bh=ZNwexitviy7NlhVq3AdcoS8b2uVehiHwlPIKoJZAgEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MlPfFnCdhbiJaz8PIDn+a5uqsy0JWsfA0xGONayHs7k1YHFjxeYR2/efi+QH+dfXrTg7OcE1WZu1jEqRKQ3pOFmRoTKZnf07FRr5ax4/bjGg+M5g9fZteUUDKlRSy5BuHjNRzS2xiix3pCQAvuSbGRUA1vmoX8OYzPzEmeI5Jkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GId0DBmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80DAC4CEEA;
	Thu,  3 Apr 2025 19:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707688;
	bh=ZNwexitviy7NlhVq3AdcoS8b2uVehiHwlPIKoJZAgEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GId0DBmwFHN6Fy8B/4Ug1vwu9riO/fqxik0xTc95c3NsBkdy7/A8fpnl7aO4C1DaG
	 fPfq0NqoLPF8o7XTY39qQlcYqiB3BVrcttu7zWgTrsuYwLPrUJBJ2seOEI+YOaI7uA
	 WEeIYoUK/eznk3ZBAQxwSyg+Vg/621FR71xCtApcpGUJ42oBfh0lv/W3Nijnf2JhTl
	 yLlRFW2e2sB6CgAqiRZql2zdJl7N4cADc3reFJESfzfph2iwnAOnGCajsZZ1l05Hpv
	 JnMWMtzZbcFkNm/sx/+uh6+AzOpoYf4b5t46J/UfZ6mm/0itB6/xKXr9DH+G8ok7pC
	 gg9KAh0xGtlhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 33/44] PCI: Enable Configuration RRS SV early
Date: Thu,  3 Apr 2025 15:13:02 -0400
Message-Id: <20250403191313.2679091-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index 246744d8d268a..1ca47ef892c6c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1374,8 +1374,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	pci_enable_rrs_sv(dev);
-
 	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
 	    !is_cardbus && !broken) {
 		unsigned int cmax, buses;
@@ -1616,6 +1614,11 @@ void set_pcie_port_type(struct pci_dev *pdev)
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
 
@@ -1632,7 +1635,6 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	 * correctly so detect impossible configurations here and correct
 	 * the port type accordingly.
 	 */
-	type = pci_pcie_type(pdev);
 	if (type == PCI_EXP_TYPE_DOWNSTREAM) {
 		/*
 		 * If pdev claims to be downstream port but the parent
-- 
2.39.5


