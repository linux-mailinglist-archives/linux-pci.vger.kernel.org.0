Return-Path: <linux-pci+bounces-4779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8DE87A644
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 11:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550741F2219A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 10:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911CC3EA6C;
	Wed, 13 Mar 2024 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjmfze8K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14B3E49C
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327515; cv=none; b=j0LwRIhk9NaEZTEzxlp3ANCau2ERhQgb4x4xUzUCitpSRXQQuvz03JGIGycZLn+HXsIT+9soSm1IcF8UZuT+HZVUz/JWYdRMfQlptAMr7iRTGWi6lGBsEOkV0/6d+igBcMTv3Li6A0vVkKKMN+voI1PIn4H6kgoLViebC3qjkXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327515; c=relaxed/simple;
	bh=Vqj8+GnBzaE6qzFK9gXIlH1ngsSVLxJdaREWh9jJJa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdXTGVdC+CT/Y9aYB0UetAgVnl5DzLDoTrCSEdjyWdXXiPsAOqIn6qknm9IZiFSGtxCXu6O+9wS2Yi7gRFbZM4HFFK+0tH3pP7hQT4tJnsS6o5aXP9KbtrL/z1v9heT5/Xm+J+ukG3moA8eS0KdkqByJ1oxWm9EIGCV/+KA67GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjmfze8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02DFC43330;
	Wed, 13 Mar 2024 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710327515;
	bh=Vqj8+GnBzaE6qzFK9gXIlH1ngsSVLxJdaREWh9jJJa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjmfze8K0EL1StHxQdnU7UilpynDQKLy9jrueD6zoy/xRfWpyHJRuvmMR7Sc5imne
	 Xx+OjEJtEb6bGeqMDZ5t+AibL66nhbECZCb7ZdgO5+8euXX2NyjGz7eVud6srE3kl0
	 DbJ+2zDr62Ivd+JOIOOJ7m26G2+sN6Qb6Ngu4MZBsE6H2IV7IWGEdgf8m0yxYM9HdR
	 jfoWZpVtvZ0QuNDgCu6VV41MnYkFJAH/qEO4kyk2X7rl2UWdBYe4bxR7QpS8nnCeVN
	 GoRYg5ei0B70jGkXFxcB9twVvtSmRXiagKMTnhuGFM7MGO20WbPGM1V0OmcZ2bi3Pk
	 3t1HXx7/AgmvQ==
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
Subject: [PATCH v3 5/9] PCI: endpoint: pci-epf-test: Simplify pci_epf_test_set_bar() loop
Date: Wed, 13 Mar 2024 11:57:57 +0100
Message-ID: <20240313105804.100168-6-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313105804.100168-1-cassel@kernel.org>
References: <20240313105804.100168-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the loop in pci_epf_test_set_bar().
If we allocated memory for the BAR, we need to call set_bar() for that
BAR, if we did not allocated memory for that BAR, we need to skip.
It is as simple as that. This also matches the logic in
pci_epf_test_unbind().

A 64-bit BAR will still only be one allocation, with the BAR succeeding
the 64-bit BAR being null.

While at it, remove the misleading comment.
A EPC .set_bar() callback should never change the epf_bar->flags.
(E.g. to set a 64-bit BAR if we requested a 32-bit BAR.)

A .set_bar() callback should do what we request it to do.
If it can't satisfy the request, it should return an error.

If platform has a specific requirement, e.g. that a certain BAR has to
be a 64-bit BAR, then it should specify that by setting the .only_64bit
flag for that specific BAR in epc_features->bar[], such that
pci_epf_alloc_space() will return a epf_bar with the 64-bit flag set.
(Such that .set_bar() will receive a request to set a 64-bit BAR.)

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 21 ++++---------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 20c79610712d..91bbfcb1b3ed 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -709,31 +709,18 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 static int pci_epf_test_set_bar(struct pci_epf *epf)
 {
-	int bar, add;
-	int ret;
-	struct pci_epf_bar *epf_bar;
+	int bar, ret;
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
-	const struct pci_epc_features *epc_features;
-
-	epc_features = epf_test->epc_features;
 
-	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
-		epf_bar = &epf->bar[bar];
-		/*
-		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
-		 * if the specific implementation required a 64-bit BAR,
-		 * even if we only requested a 32-bit BAR.
-		 */
-		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
-
-		if (epc_features->bar[bar].type == BAR_RESERVED)
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!epf_test->reg[bar])
 			continue;
 
 		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
-				      epf_bar);
+				      &epf->bar[bar]);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar,
 					   PRIMARY_INTERFACE);
-- 
2.44.0


