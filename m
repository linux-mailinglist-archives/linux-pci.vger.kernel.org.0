Return-Path: <linux-pci+bounces-27141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93141AA8F85
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147D6175584
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43248200BB2;
	Mon,  5 May 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/TxDQOq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19092200132;
	Mon,  5 May 2025 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437188; cv=none; b=VBpsL1AI/uLeTzGh5J7y9lyobMnoKHCVccdr1iaXmvwxE894t5fyWgGpF+cNVqq4zNcpl9ZqthX9VVswCnWy+dlvWCZDTyBG2LSvIclvlOgCOHbCUtdxS42aS5c+5UPr7AvTsDokcA1edVdlP48FL4GLMQLlddK9XWJFibEm6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437188; c=relaxed/simple;
	bh=pCXgUjLWANgCjPVU4iwtz5hk0Bd35lQGLhmptLCW2vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELQz2KLoC2DJJgZWhW5SHkN55y/ytn3y0Jy5XePr00aK/ctjZot1ACLG7IG5uRu0Ygh1mnFWEEB1uLLj3u6neyFX1Y1cudWUDri2OEQslg/4QNjfXDIfBUC35W65OfP9RMsUFiOkv5q/i8Bnjd+MKqv5wbGN+cEfXOw//DTAhh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/TxDQOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC47BC4CEE9;
	Mon,  5 May 2025 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746437187;
	bh=pCXgUjLWANgCjPVU4iwtz5hk0Bd35lQGLhmptLCW2vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/TxDQOqcM5WLt83A1MO5glFnrZSWi5hOCGwfN/7oAANzpIZ+bM6SsLrkJTQ6/oMV
	 yiNPt4o6tmpBu9Rndq4hq+DBBJ6y/t/09QhwhKHtDrrB3vpe3hjhWP9vhF0BgPZZxL
	 rpA1WndSrrJy6MQXHe516mJlU8mA8ETjK4CfkGP7pLQi7KyQXFMt5kLe+JNxExtviQ
	 ViCg9PjKB7HF8JJGyeDt35HIsjQQThjE4GCG93snS8shPauISB0aH9TndtcDOGJIV2
	 QtSjaXR6HOddGGASNnCzl7/Ngl+mJs3GlOGt2IvN99ofBhZaxr/yqeKShMXYUY85V0
	 +xww2ajv/Rlnw==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/4] PCI: qcom: Do not enumerate bus before endpoint devices are ready
Date: Mon,  5 May 2025 11:26:06 +0200
Message-ID: <20250505092603.286623-8-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505092603.286623-6-cassel@kernel.org>
References: <20250505092603.286623-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=cassel@kernel.org; h=from:subject; bh=pCXgUjLWANgCjPVU4iwtz5hk0Bd35lQGLhmptLCW2vc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIkWnRYZ8U1ZhTsTDmfkph0Y8HZa6dWSP1ZqZTvKe1n/ WtFRNjmjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExk/Q2Gv2L3fZ7fMT8ssJ7r tPKkQ80cLpJzZuUV5J567lr9NWL/8n6G/6Ubedb5Rz+bf3gtR/ZnDvlrE3gVugXKDPpq5HqEq9l TuAE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Link
Up") changed so that we no longer call dw_pcie_wait_for_link(), and instead
enumerate the bus when receiving a Link Up IRQ.

Before 36971d6c5a9a, we called dw_pcie_wait_for_link(), and in the first
iteration of the loop, the link will never be up (because the link was just
started), dw_pcie_wait_for_link() will then sleep for LINK_WAIT_SLEEP_MS
(90 ms), before trying again.

This means that even if a driver was missing a msleep(PCIE_T_RRS_READY_MS)
(100 ms), because of the call to dw_pcie_wait_for_link(), enumerating the
bus would essentially be delayed by that time anyway (because of the sleep
LINK_WAIT_SLEEP_MS (90 ms)).

While we could add the msleep(PCIE_T_RRS_READY_MS) after deasserting PERST
(qcom already has an unconditional 1 ms sleep after deasserting PERST),
that would essentially bring back an unconditional delay during probe (the
whole reason to use a Link Up IRQ was to avoid an unconditional delay
during probe).

Thus, add the msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
IRQ handler. This way, for qcom SoCs that has a link up IRQ, we will not
have a 100 ms unconditional delay during boot for unpopulated PCIe slots.

Fixes: 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Link Up")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6b18a2775e7f..5cef5e92b173 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1646,6 +1646,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 
 	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
+		msleep(PCIE_T_RRS_READY_MS);
 		/* Rescan the bus to enumerate endpoint devices */
 		pci_lock_rescan_remove();
 		pci_rescan_bus(pp->bridge->bus);
-- 
2.49.0


