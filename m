Return-Path: <linux-pci+bounces-4958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60888810FF
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636031F215EC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B8B3D964;
	Wed, 20 Mar 2024 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8rLxR+J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A73D566
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934346; cv=none; b=qAktlsIO21XQUckqxfudjjUNYsYQEyodUotm2fRx0pS4JQW2UX2r85oeC7SgY6+rxD15Oxfh7okri1Epy818N4kxmvD8KQH/7bnY+6wXYINBDqAHQA8CQi/v+4UtP/tPfkLzHpKtoazIwRod6DlkziQWMisCoDRiawscVdls9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934346; c=relaxed/simple;
	bh=tVAqwOdolhcvEOaLQbkQAkdXLif+OLVmPn3t1h9ZWBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5LJxjd9BqWxnnaEQo05dr3yPNVc8ZeyuGvzBX6pNFbHkWqEPPPbZXMvpCFLKhbbQu7VDdMy52q2ny551g51xFfsd0DYfbY/GagOdZaDY137SIxGDQEXVM//5wIi9ZVbO5bICve6f5u7kGJnzWe35YouWUarFBRPVF6Deydr8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8rLxR+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2D9C433F1;
	Wed, 20 Mar 2024 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710934345;
	bh=tVAqwOdolhcvEOaLQbkQAkdXLif+OLVmPn3t1h9ZWBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q8rLxR+JG1VBO/fmY46p/WNwWSwLzcCJzyQyR6ybrxFzm6JgmWN13VN2vOuXS5bAI
	 IHmXHOL+w8KKZq+cgwbk/TJbSNCKjGy2Carz4RPk2WWze2SQuzL7gsWIbCebmRNFnq
	 JFaQCfDm7+Nsas6Dm5ISUW9sWQ5+7U925e6qrITImxU/G2dBaA1f/AkUqabxu3vJqG
	 g+OMW3amlyiP1Efrz/0EsxJ/lgS/UoQSZfgKRNOhQc+MEiSczwJf8WL/88heSXagKr
	 M2PndR+xO0knzE2ezl94H6ABKkYcR/176baS+0C3CEqMFtShiMNNarj4Ii2YkLPZ2N
	 1IhQK8D2BmItg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 5/7] PCI: endpoint: pci-epf-test: Clean up pci_epf_test_unbind()
Date: Wed, 20 Mar 2024 12:31:52 +0100
Message-ID: <20240320113157.322695-6-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320113157.322695-1-cassel@kernel.org>
References: <20240320113157.322695-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up pci_epf_test_unbind() by using a continue if we did not allocate
memory for the BAR index. This reduces the indentation level by one.

This makes pci_epf_test_unbind() more similar to pci_epf_test_set_bar().

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index faf347216b6b..d244a5083d04 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -690,20 +690,18 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epc *epc = epf->epc;
-	struct pci_epf_bar *epf_bar;
 	int bar;
 
 	cancel_delayed_work(&epf_test->cmd_handler);
 	pci_epf_test_clean_dma_chan(epf_test);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		epf_bar = &epf->bar[bar];
+		if (!epf_test->reg[bar])
+			continue;
 
-		if (epf_test->reg[bar]) {
-			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
-					  epf_bar);
-			pci_epf_free_space(epf, epf_test->reg[bar], bar,
-					   PRIMARY_INTERFACE);
-		}
+		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+				  &epf->bar[bar]);
+		pci_epf_free_space(epf, epf_test->reg[bar], bar,
+				   PRIMARY_INTERFACE);
 	}
 }
 
-- 
2.44.0


