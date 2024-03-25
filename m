Return-Path: <linux-pci+bounces-5109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7947188A910
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3448438074F
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3721131E3C;
	Mon, 25 Mar 2024 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv/mLE2Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC312C804
	for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376643; cv=none; b=PBLcMImhF8kgWgVO4qY5PF3mFGUjffZA6W3gG1S9ITzcPZXrRvkYhrMiqXIfrUw5HofGfUeUvhLk6ygVj9/uLJm08uSvAw+hOOCQ7bfNl6vYCye1RKg7oF7bVhptNNVQQQC3PbWB2PUiJzfLPRhUAD3+8awg941nijfLFHADAOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376643; c=relaxed/simple;
	bh=cPGbjvBSv83ENlF4mJQb+LncGW00JLmpOXmHHbbpMDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8KIel37Xyi3AOTkogsouPjhN+xCTS7vmPnWQqzKxcgtXaGVMW8LOHT1ONDooMODJUe2mfhsAk1UfNrs1Hh9N3QwbsvORfuip4nWKBDZObC1gfQcfu0h6YFdvAR01v4KMMQeodDjs2dEHgbeRDzsJ4caZxZE9RU5yqCi+fSvbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mv/mLE2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE55C433F1;
	Mon, 25 Mar 2024 14:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711376643;
	bh=cPGbjvBSv83ENlF4mJQb+LncGW00JLmpOXmHHbbpMDs=;
	h=From:To:Cc:Subject:Date:From;
	b=Mv/mLE2ZJb4NB+FCLdrlfjDPC0K9LB9oeqCNLYqpz/RNlR2jyq5L2DUPpA6WRQWis
	 97XZ7dsP10ZK7WtVDclJlsDT333RhYxhdNUVQPZRobFhgEbsUEyHSuwW1yGaTM9f/I
	 od7c6G87QFjcr+rLiIPEU6KrbXvVPBMOFe/obeFx+dFOdMfDLcVD+ATe/H3k/trj++
	 qOWYQmCKKqmzH8N21f0Qjg4CWvxfFyCrlZgWhTEUKRDWicjJb3UiNw3gb4x5RdCjOu
	 gj/F0F7fDgKV+UhoZmoJqLIAJjnZwlDN6RAZ4qG2VGf7lZ1kirNWX8IoRRAp+i+qqz
	 jSx0IzH4VLXeA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] misc: pci_endpoint_test: Remove superfluous code
Date: Mon, 25 Mar 2024 15:23:55 +0100
Message-ID: <20240325142356.731039-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two things that made me read this code multiple times:

1) There is a parenthesis around the first conditional, but not
around the second conditional. This is inconsistent, and makes
you assume that the return value should be treated differently.

2) There is no need to explicitly write != 0 in a conditional.

Remove the superfluous parenthesis and != 0.

No functional change intended.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index bf64d3aff7d8..1005dfdf664e 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -854,8 +854,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	init_completion(&test->irq_raised);
 	mutex_init(&test->mutex);
 
-	if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) != 0) &&
-	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) &&
+	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
 		dev_err(dev, "Cannot set DMA mask\n");
 		return -EINVAL;
 	}
-- 
2.44.0


