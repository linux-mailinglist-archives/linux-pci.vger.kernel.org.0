Return-Path: <linux-pci+bounces-29692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18A0AD8C82
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8719E17D2F7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96844111BF;
	Fri, 13 Jun 2025 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFlld6i4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8B125B9
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818962; cv=none; b=g+6/jW4vsK2xobcqswYCb7TsQpAxs6TQQHIe3t9KBqfvGu3/GzUswKawfnjd83qcgiqYhePbOpWqFjnCn9xCebQq5sLegInspUmYOUGltP9EjoooFLR8YCpcLJIc02RQ3Dokx3Yr/OFUyU4us8qNLzsx029BldHQbYcmd0RmPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818962; c=relaxed/simple;
	bh=meFFjOHQ4ueW4w0JlU92QLWZ+3zZ5o6cGN7vEAfiUDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crihdere1jTfLMQxQBFLjMdp2gqcI97mUJkRRKMDtEm6JPK+qJcSFoPMjW8EIk/KnReJXKw9DYMcp8o8P+VtEzTbBIntOC7n8MQqV2yaNOkmf96Hbp/E6JmVTp5gg0jmuGFVddSjm5DMygeUqlg7GpNgmqa6KHmAZ7O9XIBQs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFlld6i4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA60DC4CEE3;
	Fri, 13 Jun 2025 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749818962;
	bh=meFFjOHQ4ueW4w0JlU92QLWZ+3zZ5o6cGN7vEAfiUDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFlld6i4aBSFPoSnGLzMbwyiD2yZtvZnD9UFCxKSJAgZImFzhPBuKlXFIMc5tiEJB
	 rZf3Z1tkB+9NzrTLlkcf7NDFBfZvXCFZhpVNFnONjJxJG+xPt28rY2WhmSu00BX4Ag
	 BOHUV0df0kMdVZ5/mLKbV05cR28jzgXEAo6aakD4ChJfsCp++dNTaCIzo9ADrnDMFH
	 vyokXKi+xa3D4JOPic6QaZFrctmryizdyRFlufqaei/rZl9ZdoF2TvPx3iQGflmWqG
	 DcBtTNSb1EK+WLaaXQ5Ib5VZb4sXhWmibtKA7bKCr3d6nj4uqO1pWNj1Nhi8GU3qqn
	 hXOFTypT32YGw==
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
Subject: [PATCH v3 6/6] PCI: dwc: Reduce LINK_WAIT_SLEEP_MS
Date: Fri, 13 Jun 2025 14:48:45 +0200
Message-ID: <20250613124839.2197945-14-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613124839.2197945-8-cassel@kernel.org>
References: <20250613124839.2197945-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=cassel@kernel.org; h=from:subject; bh=meFFjOHQ4ueW4w0JlU92QLWZ+3zZ5o6cGN7vEAfiUDg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ85HT7qkIsJyx3DhGSDDa5tO+6laFj9aFE4ZpFks9rm XzF+HU7SlkYxLgYZMUUWXx/uOwv7nafclzxjg3MHFYmkCEMXJwCMJGQG4wMjbsO6rwtYJjk4fT/ /EM901fs6rm3otatTbqo9W5p8/3/7xn+adxLkzskIH1vtvajH/x2P1idfW+ket2tSslcbbJP9aQ YEwA=
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
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c |  6 +++++-
 drivers/pci/controller/dwc/pcie-designware.h | 13 +++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 24903f67d724..ae6f0bfe3c56 100644
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


