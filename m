Return-Path: <linux-pci+bounces-12697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E2A96A8CF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 22:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9553285D1A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9073C1DB530;
	Tue,  3 Sep 2024 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZHsAacW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631BC1DB532
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396175; cv=none; b=ETsz2ZScsn43wQGba8fVHnb6w6hWYZcZ+VMGyTg4F+lkY9nSs8ekYHXeZ05mm5xhrEFF/OeIZDKSIME+U1qfJnhh/JyzCvVTnnCMEiQk0coJbwOSB/svzEMkalB+Gbs4AJjrnWI2oRlMbwE1RdS0Hf2t5ovdHknnDni724tCNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396175; c=relaxed/simple;
	bh=d801y6XH8hFE9wgCwtbQSx82WgeDTt/xspUlIH18n/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RMWQqIqEZ98PcW3Ia4xWOXAR3T6fUuT2SQ/HOt5GjKJ8E6KR4Iw7byLzehMlwDCmHUOoHe7GmBx31GDsZD9qku4Y9bb4hDZgbI4KTK5xWKDcVPKR9aZ1VCEgu8qgaXvm8hRt7/FOvh31Otsg5w7goh6zZb9HFdcUNAvALXx7LCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZHsAacW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7AAC4CEC4;
	Tue,  3 Sep 2024 20:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396174;
	bh=d801y6XH8hFE9wgCwtbQSx82WgeDTt/xspUlIH18n/s=;
	h=From:To:Cc:Subject:Date:From;
	b=cZHsAacW5oua4a+e86S7lSKccbfqUCqyT0nd8Lko3tAexYMrQPct3f3K+iPc7XI3F
	 dkUWd6Jc9VrbKZmMTpNkauhdUftj4ZoBHX/52MEEldwxWYGmS9M8w0nN9kqrEIZKvp
	 k/zhsg4nV/N/Q1CbM1yT/frG73xVBmejTd2L8ywtnS8+S5qF8LgJi+qS3uYPuG98J8
	 cZqMunZtm8vh4sw6JQ2kvgSml+m9uh5AIgGh7Y488R7aZqZD5s3bCYCPMWEtmKgRHH
	 hDDOtwL3kauZYvfxBob3b2Z6MDBnuWXqifQyG7IY2Hot1BxpTpR+zUYK7BicUcidpd
	 jlQS2N4mvs4aw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>
Cc: linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: mediatek: Drop excess mtk_pcie.mem description
Date: Tue,  3 Sep 2024 15:42:44 -0500
Message-Id: <20240903204244.276482-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Struct mtk_pcie.mem was removed by 8a26f861b815 ("PCI: mediatek: Use
pci_parse_request_of_pci_ranges()"), but the kerneldoc was left.  Remove
the extra kerneldoc.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pcie-mediatek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 7fc0d7709b7f..20c638ca532e 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -211,7 +211,6 @@ struct mtk_pcie_port {
  * @base: IO mapped register base
  * @cfg: IO mapped register map for PCIe config
  * @free_ck: free-run reference clock
- * @mem: non-prefetchable memory resource
  * @ports: pointer to PCIe port information
  * @soc: pointer to SoC-dependent operations
  */
-- 
2.34.1


