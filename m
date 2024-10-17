Return-Path: <linux-pci+bounces-14703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB99A1775
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0505E1C218DE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979A17BD9;
	Thu, 17 Oct 2024 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjoaL8LL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F031F111AD
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 01:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729127212; cv=none; b=L+4DsriA8gsomT1UHGtIYVq9MA4PPDRRed3/WZHqyF9aOrQwoLnNflPHxftGD9Vt0SpGWLzXHw1e5IPTi6g0rjpIO8igDmKp8fVqGyUr++uK/tqw5mqEDcRXswsYR8/Nq8wldQnV++gpwyaBKplw4MmZb7XG+0O6ifTNolpxQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729127212; c=relaxed/simple;
	bh=jCLPEdvHPfiZnF3o9+eZJu/DpoFZEMxFror4GYRDPs4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QEGE4MSG3p8wmds13GN5pO7wkyH24y+C/C6Ho91uvKs5zKgQJzOupVQTiipgS7QPP4m+8QvfvYl2zCcx+Nhhpu/A+IROK9IfXpfsjyYDM8kU0YkngvWnmfSRxypXtZrIvE9Xf6ZJrQQevBzqp52azAUCpyZikbi3h+jiqPyvKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjoaL8LL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D2AC4CECE;
	Thu, 17 Oct 2024 01:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729127211;
	bh=jCLPEdvHPfiZnF3o9+eZJu/DpoFZEMxFror4GYRDPs4=;
	h=From:To:Subject:Date:From;
	b=FjoaL8LLv05mAFLvbpOpp7O0icYx4rD7m+Dh6ylil3LDTtlnffyYp3TF54acln5pn
	 nkaLmp9cAm0C90cL2kZPDs9xwiygNKxfh6JmStvC5LD27CmiVkdooIzuP5f4z561A/
	 kaR4Tv3v0lmylPbUPcV1rgQxUYCjwNPep/ZMcrAqepVRYU8Hfyc4R6ZWTjURogBfVz
	 VtS+moHXPPzHmq/6NYYNld6VYnBGTrdwazHy/9dss7OsS8SWSK6yzHryh4zmicNTc2
	 O9xNj88NwEK3vmw0R1mgeNMMw0VVgVHEQXx/uuqrEGAeZ+NbZVya/YA9nQEKxrPN0+
	 DLImqRliRfAMA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: endpoint: test: Synchronously cancel command handler work
Date: Thu, 17 Oct 2024 10:06:48 +0900
Message-ID: <20241017010648.189889-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use cancel_delayed_work_sync() in pci_epf_test_epc_deinit() to ensure
that the command handler is really stopped before proceeding with DMA
and BAR cleanup.

The same change is also done in pci_epf_test_link_down() to ensure that
the link down handling completes with the command handler fully stopped.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
Changes from v1:
 - Corrected typos/grammar in commit message

 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index a73bc0771d35..c2e7f67e5107 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -800,7 +800,7 @@ static void pci_epf_test_epc_deinit(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 
-	cancel_delayed_work(&epf_test->cmd_handler);
+	cancel_delayed_work_sync(&epf_test->cmd_handler);
 	pci_epf_test_clean_dma_chan(epf_test);
 	pci_epf_test_clear_bar(epf);
 }
@@ -931,7 +931,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epc *epc = epf->epc;
 
-	cancel_delayed_work(&epf_test->cmd_handler);
+	cancel_delayed_work_sync(&epf_test->cmd_handler);
 	if (epc->init_complete) {
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
-- 
2.47.0


