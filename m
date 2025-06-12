Return-Path: <linux-pci+bounces-29544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194BDAD6F76
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF75176E76
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E2E223714;
	Thu, 12 Jun 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl1m4zpW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E96220F2A
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729001; cv=none; b=bVi3oDrPaMsB56sIjbhA2hS2iuWyy0v8NiBsULMKrShOEdv2hcVVm7GUJnfRvT9ryu7JsOY4S9eFpDNHNAZ3SkWJEIZaFnRYdiQmHbn0FQ/BeT01uPMBe2W9w10akOzk0KVhQ9vJ0wO2XMnEPLoFIh/daWsGVCHV91nPWlZFhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729001; c=relaxed/simple;
	bh=j5b6iqcFnushaTPpySFewupcHWNGITdJ4vKmVuhyeUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwVmlWDpp6MQtJY8MWZYsnX7HSH+TtEcU8nq54Rl8Lia57T1ykmcV+n32Whzq9RzAW2r0el9u9Xnn6Jtoo+uaU+qBcG/YQMgduf3oMST6KoRodIIFbJ9fY93h8wfIZFO1WjwEsRNg/A9fReZIiV+6YuNLQVq4LgmeW3MZI/FT4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl1m4zpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1283BC4CEF1;
	Thu, 12 Jun 2025 11:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749729001;
	bh=j5b6iqcFnushaTPpySFewupcHWNGITdJ4vKmVuhyeUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sl1m4zpWwcGmuBt2WKecLAj+cshJbqTdEpHPtcSR1OMT4KbgTm+xolHu4iNvBx6ov
	 USM1n27OWoudsEm7uUHAl9u0aAatv4QlXGSeLS63A+/PcG1qrr30I1Sm5biPcwIEY+
	 kDFEWFjdn631/DT0u2++xSZ7QNtjNN5npi8T86cDJxsBqrXJ+3xo5/UipebzG60Dr6
	 4y/DpO0JIaG2b4kAZoTEyVMmAXkPjXVdN2qnYPKC7zw047Vd4mf6I6nzkwVezV78bg
	 2yknybAmwLqo7kISiro8rU16CGCJU3FAJWXnVhGEYECD/7t+Mat3pTA99tRAEqVld5
	 iwKaq3r2Im7ew==
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
Subject: [PATCH v2 4/5] PCI: dwc: Reduce LINK_WAIT_SLEEP_MS
Date: Thu, 12 Jun 2025 13:49:27 +0200
Message-ID: <20250612114923.2074895-11-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612114923.2074895-7-cassel@kernel.org>
References: <20250612114923.2074895-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=cassel@kernel.org; h=from:subject; bh=j5b6iqcFnushaTPpySFewupcHWNGITdJ4vKmVuhyeUo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK89p28E5+zInWl6zbXn9Y9jhmvnIN2zc+8l1T28rNE3 65NHKyfO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCR8uWMDLsPrQ8+fa1qTcRD brmVhYIr3GYcW/bbVuZtxrRVaty7lrYwMnzwumkUtyHlzKEPolnb8zfpr5tWIHD77LusMJdY17C f75kA
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

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c |  6 +++++-
 drivers/pci/controller/dwc/pcie-designware.h | 13 +++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 7fd3e926c48d..5dab3d668ab3 100644
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
index ce9e18554e42..b225c4f3d36a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -62,11 +62,16 @@
 #define dw_pcie_cap_set(_pci, _cap) \
 	set_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_SLEEP_MS		90
+/*
+ * Parameters for waiting for a link to be established. As per PCIe r6.0,
+ * sec 6.6.1, software must allow at least 1.0 s following exit from a
+ * Conventional Reset of a device, before determining that the device is broken.
+ * Therefore LINK_WAIT_MAX_RETRIES * LINK_WAIT_SLEEP_MS should equal 1.0 s.
+ */
+#define LINK_WAIT_MAX_RETRIES		100
+#define LINK_WAIT_SLEEP_MS		10
 
-/* Parameters for the waiting for iATU enabled routine */
+/* Parameters for waiting for iATU enabled routine */
 #define LINK_WAIT_MAX_IATU_RETRIES	5
 #define LINK_WAIT_IATU			9
 
-- 
2.49.0


