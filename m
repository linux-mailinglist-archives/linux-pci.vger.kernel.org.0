Return-Path: <linux-pci+bounces-25253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F538A7AE74
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 22:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8E5189DA8F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 20:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99802063FD;
	Thu,  3 Apr 2025 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCpV3rgC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ECF2063EF;
	Thu,  3 Apr 2025 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707797; cv=none; b=d5xsaauXSn+BxJGGg3Gdq0DvxeaCFuyo/HrW7yBC3W9/zkm0FnpjwENCqiqymfrgheVKW27m6FTsafpST9WwsibmX0Tw7ORBtEe8HuMnYvOwf6FNWRbWbYFmDKe3sNVsPQI/dNRAQIteO9BF0BjN0a4iyY62UYPhOz+VNkVm/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707797; c=relaxed/simple;
	bh=ctBEI2ZBS0CtqznxxJ/yh2BNhEj8WfOONRgpeABLBpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OSEmzKkthkAo6atrIlo6/jxNb6iK6x4eJVsmzLAK0WOe1e9/b9veMQjTlj3FsbledMtpYRyhQXKFjRdf0RnPTnmmZF01lb6sNJAjMyb1S4Bucbzm+pg3jOnGDZzA+L21fIlvAOtGsjMVwSrBQ+F1cGQXlsTykb5wL9OytgD35Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCpV3rgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5EDC4CEE9;
	Thu,  3 Apr 2025 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707797;
	bh=ctBEI2ZBS0CtqznxxJ/yh2BNhEj8WfOONRgpeABLBpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XCpV3rgCENfronZFjXx37yAx/Y8qjR4RDFQD0+SQb4LJF0yJ847p9Gh/mlePQEho3
	 GIDfrlqvA2DnuA22YZRMnUzdxlgSZ3nGo6fufrLvE8fGDKnYjocdmSg5kkL+w1K4NB
	 nMcg+jjaTODktZG5+TG87GALWXdmo3VoXom5Z1qCqIHcJI11+0wQdT1LqirOiXgUeI
	 AjXxfwSnS8NSGQA+dIJtu96efzjHK0YwiupODw7u2gRmFzeyL1FSURzXPEPSkSDU4W
	 lkHmviwYf3w0tQ/difkljLnJhSs1HgX5HinaBgp0OaLDqSzIvqMHbXURXqjfgaPFkZ
	 KZe7wI0RLocYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 28/37] PCI: Enable Configuration RRS SV early
Date: Thu,  3 Apr 2025 15:15:04 -0400
Message-Id: <20250403191513.2680235-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 2e81ab0f5a25c..e894a77223f44 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1330,8 +1330,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	pci_enable_rrs_sv(dev);
-
 	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
 	    !is_cardbus && !broken) {
 		unsigned int cmax, buses;
@@ -1572,6 +1570,11 @@ void set_pcie_port_type(struct pci_dev *pdev)
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
 
@@ -1588,7 +1591,6 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	 * correctly so detect impossible configurations here and correct
 	 * the port type accordingly.
 	 */
-	type = pci_pcie_type(pdev);
 	if (type == PCI_EXP_TYPE_DOWNSTREAM) {
 		/*
 		 * If pdev claims to be downstream port but the parent
-- 
2.39.5


