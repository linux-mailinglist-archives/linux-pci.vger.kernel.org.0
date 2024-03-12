Return-Path: <linux-pci+bounces-4756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B487927C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 11:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A010283E59
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EDD7867B;
	Tue, 12 Mar 2024 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psl+/qzz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539842572
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240763; cv=none; b=rH+lP4VkI8ra+bRksyACH5FdKg1dXuLQJBlkZ9LxMxQfhJPkHzdBcUpQFkMA0np4EYIUyQ/E37jK5/PK4TREJOf9JNJyI9iLYIbmW0v6foUcYhfFLBytrua+g+3RSMVlHwlW6gSTMODqfYF+IgRyZRbUhEFqiPp7UiYJ1VNAwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240763; c=relaxed/simple;
	bh=G1N/c3EO3NoutU+UHBk1yIOjocdyugM1oztq12+z1ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYUJic8uRITRsFUstk/lZRavg9a7iHdioycUT4ILfYeGcaaijAlHLiKHJhtD2ZbJMsMMubeTTD7iDFmsMCM6s641xQVByPBATor3ZMFBOB5+8bDadNGGISbed3fezcMfuH5eX2zYQZFVy3MIvl6nYCGapMHzSyxYYItJX1Crm2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psl+/qzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C02C43394;
	Tue, 12 Mar 2024 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240762;
	bh=G1N/c3EO3NoutU+UHBk1yIOjocdyugM1oztq12+z1ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psl+/qzzwpM7rCGIt+TeNU3qqfwoTRux7MnVC+8PJiquCIQPiBI4KqzB/FQJr77oj
	 yYI1bbsmArua5Wmom4YGckKa3FiFDK0an6htA2Cr67i/Cv4QBNSllRJ05Z1Whkedh0
	 +T/nQxPxuotK4ShpRDdPyr4J/5jK5EvmkXDrW3YgvLcY6gJyUDDiYwpwW1sHsLgAQK
	 BnELLuyfWM+Wt6ku1nn1fWC0hpvqdcFMPwhU2YInHbqTksyW9O5Jj9FREB6IGPqa+D
	 wsunjDcR7pRfEsb1R5pgTmoPynvDur1gqvVWSPGTEqfWXjv/HLsiKMQR97ClFrTvNf
	 PgkVsleayC6/w==
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
Subject: [PATCH v2 6/9] PCI: endpoint: pci-epf-test: Clean up pci_epf_test_unbind()
Date: Tue, 12 Mar 2024 11:51:46 +0100
Message-ID: <20240312105152.3457899-7-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312105152.3457899-1-cassel@kernel.org>
References: <20240312105152.3457899-1-cassel@kernel.org>
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
index 05b9bc1e89cd..2c1d10afb1ae 100644
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


