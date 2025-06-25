Return-Path: <linux-pci+bounces-30612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C731AAE7F1E
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBEB3AD675
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36228EA69;
	Wed, 25 Jun 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqaIejeF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2711828E607
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847070; cv=none; b=ohP7fPSJCtNe+TbOODLGx7gpkByty9f0V5wNV0teThkNJuAqHpXA95qX9pV2chWJdqcgNHvb2quPRsZFY83WH3mPjabGw7wPbY2hq2pl22WNZkSNZ+rahwto8RT+huVIYrTuu7UEE7R3EkKRQgOGCSUfvT8rTPeJ7A4vwSGTr6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847070; c=relaxed/simple;
	bh=1YXSrdovigk47TTYj+a1Yr4855F1h7YJUNB8w0qI8po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alvOBVYdyQ+wnnHCZy/WKC5uSLsadOAif6qAaw6yuYnc/qYymV4MGguFclKDQvTvb3VIQs+QGu+A+goEQSc18jJubkiCCMCXQ7+xz+zC5tfVRf+oXjwVUCFPk8u0VBx3E50UeZK8fmWqeGXcGr8Zxoo8/hqPs7+C33GsRIL34xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqaIejeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B63C4CEEA;
	Wed, 25 Jun 2025 10:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750847069;
	bh=1YXSrdovigk47TTYj+a1Yr4855F1h7YJUNB8w0qI8po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqaIejeFx9Fz8tC6WDzINCMjW5yOwrBhX8pEXCgSZ1LyyVIkTyP6Vk2CVvlTjdN/N
	 M7/xDEjaqyfmisIeUxOyz1HIKFEwEYHYucTwdsdRUG18t3vp2gFVzgEqdbGU/NbmUh
	 uVMRKWYcU2LUySzykGyFkTnTj80GSoB6AEuGSOTlvbL5Y0QdXlKy7NOF7wwJMeFUKn
	 JZvp9QXPu4HmxFuaUNhcLuQs1lnNsOzZEuDtGWNXYSH/hsJ9v0W7P7TuKgsDJq4j1n
	 3+jYSdptEm0E12ZFd5IE2FIXUCo8oq7tZ4sIsHky9NPi5JZ9MWtRig/zh61C+/MbiK
	 ChZ/Wrygz1gZw==
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
Subject: [PATCH v4 7/7] PCI: Reduce PCIE_LINK_WAIT_SLEEP_MS
Date: Wed, 25 Jun 2025 12:23:53 +0200
Message-ID: <20250625102347.1205584-16-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625102347.1205584-9-cassel@kernel.org>
References: <20250625102347.1205584-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2505; i=cassel@kernel.org; h=from:subject; bh=1YXSrdovigk47TTYj+a1Yr4855F1h7YJUNB8w0qI8po=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKiz1mVL54saBf+4PDCo+VpGnUXMhfz8v4vORQw3yq8v jZ2x8fAjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExk71+Gf+qdT40y20/un5f0 p/3TPYP1LlnssYqWvT5Zol31XHarahn+1/P096hvZdexF9fODexYk58551/MF6fVf0+zulxl/HC RAwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

There is no reason for the delay, in each loop iteration, while polling for
link up (PCIE_LINK_WAIT_SLEEP_MS), to be so long as 90 ms.

PCIe r6.0, sec 6.6.1, still require us to wait for up to 1.0 s for the link
to come up, thus the number of retries (PCIE_LINK_WAIT_MAX_RETRIES) is
increased to keep the total timeout to 1.0 s.

PCIe r6.0, sec 6.6.1, also mandates that there is a 100 ms delay, after the
link has been established, before performing configuration requests (this
delay already exists in dw_pcie_wait_for_link() and is unchanged).

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c |  6 +++++-
 drivers/pci/pci.h                            | 11 ++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..d7278f6b84c1 100644
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
 	for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
 		if (dw_pcie_link_up(pci))
 			break;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 43cb77c27ac0..9d20f0222fb1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -56,9 +56,14 @@ struct pcie_tlp_log;
  */
 #define PCIE_RESET_CONFIG_WAIT_MS	100
 
-/* Parameters for the waiting for link up routine */
-#define PCIE_LINK_WAIT_MAX_RETRIES	10
-#define PCIE_LINK_WAIT_SLEEP_MS		90
+/*
+ * Parameters for waiting for a link to be established. As per PCIe r6.0,
+ * sec 6.6.1, software must allow at least 1.0 s following exit from a
+ * Conventional Reset of a device, before determining that the device is broken.
+ * Therefore LINK_WAIT_MAX_RETRIES * LINK_WAIT_SLEEP_MS should equal 1.0 s.
+ */
+#define PCIE_LINK_WAIT_MAX_RETRIES	100
+#define PCIE_LINK_WAIT_SLEEP_MS		10
 
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
-- 
2.49.0


