Return-Path: <linux-pci+bounces-23310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2D7A59257
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 12:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23273A5C17
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06273227BAD;
	Mon, 10 Mar 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ/TorEI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A8226CFB
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605063; cv=none; b=VlQcnF+szpbvSI/GxBxeP0E1CEQlpQVkR2HTU3PAv9s3gN7BzbHUuumb/c8NsLOrLoID45g75xiXI0HmE6zfVHohJOkrsDFkxEtdcm2qkJZeYlh3Dp19QSxIhe6C1nEg2zRy1Cf2WUzYnFBF9V1wfLCxqUXVF6KdQkvppc9N8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605063; c=relaxed/simple;
	bh=RygVxF9ieAoeCObdAaR8pPAuiCKcUgyM0R5/ztnFkTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBuTQN3MZ5dulTUhAEDgnuACDOEKfjDtxo20/rX70eSDcww04ZL7wmIH1opM1/K6sUtU1g+9NRgeRuo2C11gY3CpjWQtfdP9ZRVqr48T/x/SDOFe3wgGKXcnEqAaz0hTikF2pKIbcd/h5oChoi+hA+vwTAc02v7srAjA8qDdKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ/TorEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA66C4CEEF;
	Mon, 10 Mar 2025 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741605063;
	bh=RygVxF9ieAoeCObdAaR8pPAuiCKcUgyM0R5/ztnFkTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQ/TorEISR+/JipfbaU0I4pxRg44XmBZwSbqavGhg/10DUPBXX52m4E33CYifuGC+
	 d3dXGGCr3qLnjShmI6cCLSUMnO3Rq+J6yoE6Bk+Zj/q7uA4xfm9zU49l4YEAwEb14k
	 URyI9JXgkiF2QbWkEWEqyt6C1PRmbmDPlphE0FuTEJJpKZGrNmHq0K6YDOjZvajz9T
	 wdDAvQLfBFhjCrYIWiJnwqSFpvP19mdIv1vE7dRMY9HfGsoW/sK0JHoz15Xrug1/PA
	 kD0mno88oGXH3brhJlyFp7gMDeT5q4FAEVUKXeHokonBZ8MnRNu9dhQejGhvu7eX6a
	 iQsROpG+jYlkA==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6/7] PCI: endpoint: pci-epf-test: Expose supported IRQ types in CAPS register
Date: Mon, 10 Mar 2025 12:10:23 +0100
Message-ID: <20250310111016.859445-15-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310111016.859445-9-cassel@kernel.org>
References: <20250310111016.859445-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=cassel@kernel.org; h=from:subject; bh=RygVxF9ieAoeCObdAaR8pPAuiCKcUgyM0R5/ztnFkTU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLPnZjHMf2Uzndv9qLOo4ee55Q91Nl9Wbw5tobppVmgo 0GFoqNzRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbiX8jwT2/z/6+FE10s2h+W Z25Se6Gu9nJ5XPjqry3RYSIrO/fO383IMPf9fs2PE8tTFZnnrQh4ecj6/uXomOb+HW3yRWIZytN c2AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Expose the supported IRQ types in the CAPS register.

This way, the host side driver (drivers/misc/pci_endpoint_test.c) can know
which IRQ types that the endpoint supports.

The host side driver will make use of this information in a follow-up
commit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 58ac19fcdd63..50eb4106369f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -45,6 +45,9 @@
 #define TIMER_RESOLUTION		1
 
 #define CAP_UNALIGNED_ACCESS		BIT(0)
+#define CAP_MSI				BIT(1)
+#define CAP_MSIX			BIT(2)
+#define CAP_INTX			BIT(3)
 
 static struct workqueue_struct *kpcitest_workqueue;
 
@@ -774,6 +777,15 @@ static void pci_epf_test_set_capabilities(struct pci_epf *epf)
 	if (epc->ops->align_addr)
 		caps |= CAP_UNALIGNED_ACCESS;
 
+	if (epf_test->epc_features->msi_capable)
+		caps |= CAP_MSI;
+
+	if (epf_test->epc_features->msix_capable)
+		caps |= CAP_MSIX;
+
+	if (epf_test->epc_features->intx_capable)
+		caps |= CAP_INTX;
+
 	reg->caps = cpu_to_le32(caps);
 }
 
-- 
2.48.1


