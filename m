Return-Path: <linux-pci+bounces-18379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A929F0F2C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF0516445B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEE31E1C0F;
	Fri, 13 Dec 2024 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EytmmJsX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821F1E1023;
	Fri, 13 Dec 2024 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100413; cv=none; b=YfJYFgYfq9YDxxZJoaQ3CLIg7PCYCbrnSQZiBzPopLT66CxN40+4BfnlJuwzkUaKmRIpv+ZchE5esOrvZ1aoGuz7E4BN0cziZX9+8DMMOsGkqWysEiwf4aHSKxuZvQBg/44zYgg/DFNnpLfFVWEpVmwz0dHiqXYHREYwFhM4ZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100413; c=relaxed/simple;
	bh=hUIuEzkuObWfcaT7ire0dHFb9zefHWiHTHS+omNaE1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvVOFCYjSw/DRm8AXE7eOPfMN+iwtB2TjKUe6EI6MYnY54e76rud557B+/xYg8sK4JH6CyE3jJcoZWagxtvA9I4Goqbw87f0YjFysCUtIFaVEgN1Wu1yBKVdG0lt21qgo2ZOuk2WHkeHLn+iTJdPKmTKjZxjdtz0dkE7QPrYiTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EytmmJsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DB0C4CED0;
	Fri, 13 Dec 2024 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100413;
	bh=hUIuEzkuObWfcaT7ire0dHFb9zefHWiHTHS+omNaE1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EytmmJsXkE4HcNPe3IraDR0GQetCebSuTsl8lfOgp9K7kY9Vkvy8poSYLDwJBMho6
	 uYOUZBUhkhqbDysSqvbAbUcOjwfIbJ53WXCjKfSJpTitgjkPNW6lu8wFwuGsKunkJf
	 EQ3+AyNdmFlDPagYawrTH9wEtJvwu3ZF57HmrWbVW2CD9UO3f/KMD51QoVa4g+mFNN
	 fzoBouiNVImy5tzkRcQJpZ5eMz7NMeKfa1aWCUC6hbcmunYLvEPMQrzAYaoYdEs8aN
	 ZKqE5FwrSpWVSfZz7AsArR89fUDcY8SsNP3uO+GUMnOx7zZDoCA8vSElnMobBzlAk5
	 HpMNocudVmd8w==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jon Mason <jdmason@kudzu.us>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v6 2/6] PCI: dwc: ep: Prevent changing BAR size/flags in pci_epc_set_bar()
Date: Fri, 13 Dec 2024 15:33:03 +0100
Message-ID: <20241213143301.4158431-10-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213143301.4158431-8-cassel@kernel.org>
References: <20241213143301.4158431-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2690; i=cassel@kernel.org; h=from:subject; bh=hUIuEzkuObWfcaT7ire0dHFb9zefHWiHTHS+omNaE1g=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJjXBdp3btlsFNz323lvfOmG1lzc9fe+LL+7NwpLyvuN EzestPkTkcpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAmYt7E8D/sWktlgbOY1MeD TzT06y7fUyn+2bOQZ41Tt4ZG9LzF7Q0M/3RD1ibNVs7iubpwlmyf+f74CNGlVyRlZ4hvWWWk9yr AhhsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

In commit 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update
inbound map address") set_bar() was modified to support dynamically
changing the backing physical address of a BAR that was already configured.

This means that set_bar() can be called twice, without ever calling
clear_bar() (as calling clear_bar() would clear the BAR's PCI address
assigned by the host).

This can only be done if the new BAR size/flags does not differ from the
existing BAR configuration. Add these missing checks.

If we allow set_bar() to set e.g. a new BAR size that differs from the
existing BAR size, the new address translation range will be smaller than
the BAR size already determined by the host, which would mean that a read
past the new BAR size would pass the iATU untranslated, which could allow
the host to read memory not belonging to the new struct pci_epf_bar.

While at it, add comments which clarifies the support for dynamically
changing the physical address of a BAR. (Which was also missing.)

Cc: stable@vger.kernel.org
Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bad588ef69a4..44a617d54b15 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -222,8 +222,28 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
 		return -EINVAL;
 
-	if (ep->epf_bar[bar])
+	/*
+	 * Certain EPF drivers dynamically change the physical address of a BAR
+	 * (i.e. they call set_bar() twice, without ever calling clear_bar(), as
+	 * calling clear_bar() would clear the BAR's PCI address assigned by the
+	 * host).
+	 */
+	if (ep->epf_bar[bar]) {
+		/*
+		 * We can only dynamically change a BAR if the new BAR size and
+		 * BAR flags do not differ from the existing configuration.
+		 */
+		if (ep->epf_bar[bar]->barno != bar ||
+		    ep->epf_bar[bar]->size != size ||
+		    ep->epf_bar[bar]->flags != flags)
+			return -EINVAL;
+
+		/*
+		 * When dynamically changing a BAR, skip writing the BAR reg, as
+		 * that would clear the BAR's PCI address assigned by the host.
+		 */
 		goto config_atu;
+	}
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
 
-- 
2.47.1


