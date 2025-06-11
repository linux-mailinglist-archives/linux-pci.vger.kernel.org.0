Return-Path: <linux-pci+bounces-29429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34B7AD533D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62441BC82E8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F3A28466D;
	Wed, 11 Jun 2025 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUq9sHMp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662B2E6132
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639232; cv=none; b=Y+MZYd7xA1+8AvoE+wsrTK+hXa1AfTuKUsAB/oxLwO4tWGlWsaXSlLDsn9RrjKArZq/R0NshbCaeSFwauZaNU8+APCkesOLuBYkUbmhOK+BOIcGT74gcXraefHH7Qre2+8hYiAyB8EFAHkxU84745EhdeBmC+0BKFnj0aItkLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639232; c=relaxed/simple;
	bh=qzVpEC+8ToPD7nNyFbEC7slCRORFr6VdbvmIAw4Q2u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLFidufWCVIdUym/IKv0XEkgRkJSKsxCazgZAiOwPGtGCgfLlWltH5Ny4E9CYQMZkpjgA47cDCoW17nyrISrrbFGJf/lm0dIZolw6x19Ol3IJHGcw4o7zFl4B0liHEh8DzCE3YRKYoma5Rm7fZf6ogfHc9oOX68XO7An0Dl2P50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUq9sHMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A74C4CEEE;
	Wed, 11 Jun 2025 10:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639231;
	bh=qzVpEC+8ToPD7nNyFbEC7slCRORFr6VdbvmIAw4Q2u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HUq9sHMpgt/ViJHSmU09GmHOJVVvIsyWri7D8KdCWpfGo79KZliNJs1M//FmLLc4B
	 yrShtiWNboIpknnOWG+GWfSxrA3OnE5w3bff5eoYEP/31j4HfzMR6WCmENWxGwWKfy
	 s4vIy846x7jN0Q2/wjmpzMXXSMLr3orHaxJMAYjKBQ8i6tAUxVB303CAbWtQSN05K+
	 JZciaJVS9YfCi1Ku0dRtCqlOjVeyXGQBVpZbNfrpPyet/PD8aPSI8YB9+aCGjvYA7t
	 TmMpH5RAN7ZvysggCQb4Lln1b+T/biOKrDbIabiRvvyP7dsXc9Eat/q6D/Vawnn7F9
	 PZpNBMT4qIxPA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/4] PCI: dwc: Reduce LINK_WAIT_SLEEP_MS
Date: Wed, 11 Jun 2025 12:51:45 +0200
Message-ID: <20250611105140.1639031-10-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611105140.1639031-6-cassel@kernel.org>
References: <20250611105140.1639031-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503; i=cassel@kernel.org; h=from:subject; bh=qzVpEC+8ToPD7nNyFbEC7slCRORFr6VdbvmIAw4Q2u8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI84/f5L/ysUsBtJ35h/rMTaq6iJyQWM+uHJrwziO8Oc T2fdtm0o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPh28HwP+fi5GgD9tMu09bd kS15stFyclTLphAL/oSjbTK3CvcJczAynP/UfUa2zXSZ4P81If0xR29cF/kYmTaB41S4he5xo2f GnAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

There is no reason for the delay, in each loop iteration, while polling for
link up (LINK_WAIT_SLEEP_MS), to be so long as 90 ms.

PCIe r6.0, sec 6.6.1, still require us to wait for up to 1.0 s for the link
to come up, thus the number of retries (LINK_WAIT_MAX_RETRIES) is increased
to keep the total timeout to 1.0 s.

PCIe r6.0, sec 6.6.1, also mandates that there is a 100 ms delay, after the
link has been established, before performing configuration requests (this
delay already exists in dw_pcie_wait_for_link() and is unchanged).

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c |  6 +++++-
 drivers/pci/controller/dwc/pcie-designware.h | 11 ++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index dbb21a9c93d7..8ef1e42b7168 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -701,7 +701,11 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	u32 offset, val;
 	int retries;
 
-	/* Check if the link is up or not */
+	/*
+	 * Check if the link is up or not. As per PCIe r6.0, sec 6.6.1, software
+	 * must allow at least 1.0 s following exit from a Conventional Reset of
+	 * a device, before determining that the device is broken.
+	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
 		if (dw_pcie_link_up(pci))
 			break;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ce9e18554e42..52daf9525bae 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -62,9 +62,14 @@
 #define dw_pcie_cap_set(_pci, _cap) \
 	set_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_SLEEP_MS		90
+/*
+ * Parameters for the waiting for link up routine. As per PCIe r6.0, sec 6.6.1,
+ * software must allow at least 1.0 s following exit from a Conventional Reset
+ * of a device, before determining that the device is broken.
+ * Therefore LINK_WAIT_MAX_RETRIES * LINK_WAIT_SLEEP_MS should equal 1.0 s.
+ */
+#define LINK_WAIT_MAX_RETRIES		100
+#define LINK_WAIT_SLEEP_MS		10
 
 /* Parameters for the waiting for iATU enabled routine */
 #define LINK_WAIT_MAX_IATU_RETRIES	5
-- 
2.49.0


