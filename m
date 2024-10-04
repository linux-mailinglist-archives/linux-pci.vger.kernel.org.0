Return-Path: <linux-pci+bounces-13827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8C09905DC
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAF11C21828
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C62521790B;
	Fri,  4 Oct 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz1EBCTw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EC21B43F
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051178; cv=none; b=jL7qfluLwYWx9yrBnHZSgJshTZF2/Pawj2Vdo2zTAaduldKnRrXCUDhDcw+ZtIZr/7s+m91z2JKtcGOtIukhUS7gv1CDe/2dJcTvLrwfyEvNiQToSxv3fbiomvuSWSG3aM3hS/u7lYGQJod7oNKTFXi3yCa5Wian0Kmqx5cXHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051178; c=relaxed/simple;
	bh=2jbwNr+Km7bY+5z6wNvcfg1Qf3Wwv0DBrnbLhpWBZmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTLx1Wy2sIl9S7H2aNgbr9zhPKMwkWSJrJiNwKuf6Okdw6oLEinGYxd7C+tVL4WfqS9xqaQVStycxmyUL7l+9jtAf7Ppz3u09sAzsZEe3z1UJUsUh3wJYSoqV2A2ZLlEIMKlnMxMFHrmVTwVp0t0TvkZXiyzzAlzWtI6AVEHpyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz1EBCTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBB4C4CECF;
	Fri,  4 Oct 2024 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728051177;
	bh=2jbwNr+Km7bY+5z6wNvcfg1Qf3Wwv0DBrnbLhpWBZmE=;
	h=From:To:Cc:Subject:Date:From;
	b=gz1EBCTw9QDS00sr9wYx/0mq9T3SC60khp7eh3BoKq1vrvSOtLtdWsakier+asiIr
	 hicNLnxURPu90X50kj8sH4jPSQZtRxOCBFHdVSJKSN6H7d3wrL2kMwXNePJ4UEHsxA
	 MEzbL0F7F8gPxfG7YApnTf6iCzzdZsMEbMsi1nxeXyquO2Dis4eSqFR8ooGVnKwKwF
	 p892dJDDvI+2wAepKSMeXoByxcR4GSCRuZ8n3ToNV6K9bdYUzrWc3MO4fL9acnwAeC
	 5jvCENdDn54r8qNhvQ9ESb2TJ0IQFu5mleQufC5o79qP2X1/p1RjbwSQAuo/CUPWHP
	 XerumqSvC3RHQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH] PCI: endpoint: test: Synchronously cancel command handler work
Date: Fri,  4 Oct 2024 23:12:55 +0900
Message-ID: <20241004141255.5202-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use cancel_delayed_work_sync() in pci_epf_test_epc_deinit() to ensure
that the command handler is really stopped when proceeding with dma
and bar cleanup.

The same change is also done in pci_epf_test_link_down() to ensure that
the link down handling completes with the command handler fully stopped.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
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
2.46.2


