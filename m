Return-Path: <linux-pci+bounces-4755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E112087927B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 11:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961601F22C9A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5923559160;
	Tue, 12 Mar 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TO8vaneg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512F2572
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240760; cv=none; b=NRUdbZNZDrZ2LtlrYCAQxzcvwQezyvcuf0zw81ad80qUhrQaV4+RNDe9oGjm14ThBoIzfcCQooh2VcinGu1EB/bJpNwOOVu3BVWnxzQuvcpGHiTmMkLdX71CQuSgR2AYIEHgZ5ReQpAzI37Oh48sv0QSIugzHZgSN2jiEGodeE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240760; c=relaxed/simple;
	bh=CZP1SmJ3NdT7dYuSrBTvbK/1KoVHf+6io4nxAOt3bXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkOQNHhmxKyom2MD+5wNP+KgZc2JkDmoEsNFJvIFhjEjgVgFfkBR8lr4e3MHawr1cxNyvIuktztG4rzUzxoT0pOHiKV/fgiUjLL+LuiqNy0k/WNQVApwW0qPppl2X/dXPzWXelFNgLlcL3jFMkC02jpCAdb8pIWQW+vFfOmda5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TO8vaneg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F223C433F1;
	Tue, 12 Mar 2024 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240760;
	bh=CZP1SmJ3NdT7dYuSrBTvbK/1KoVHf+6io4nxAOt3bXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TO8vanegyFZd1VGw5/xkeiYSRHLwP3ESs4VER92PLoMINQWVEArcPEiDB3c0zmxFT
	 bGVqs+K4JA8MDUEnw9I7exhN7c/H2+Nwnc3X9EELy1uFkSkXUlt7cdIqCT4u/fq3NV
	 vNFRv0VxRTB7mt14k4MAMw+NJkJZh3DYynRW0gqJP+L+Pm8HRQTP13PE6a7JmHce0q
	 1pmENCSrTJJaw7Ysgr4hchFKrVGob3jNK74ZZze7aT6gKkmFJSChJ3EaKYymDbJYS9
	 bo4+zSEFhFxf7DvQDkv/P5P9FAJzMQQwyWEY6cWmOOvoH6oovkxxoCy3JG36SYuYDT
	 CYO859pep44JQ==
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
Subject: [PATCH v2 5/9] PCI: endpoint: pci-epf-test: Simplify pci_epf_test_set_bar() loop
Date: Tue, 12 Mar 2024 11:51:45 +0100
Message-ID: <20240312105152.3457899-6-cassel@kernel.org>
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
 drivers/pci/endpoint/functions/pci-epf-test.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 20c79610712d..05b9bc1e89cd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -709,9 +709,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 static int pci_epf_test_set_bar(struct pci_epf *epf)
 {
-	int bar, add;
-	int ret;
-	struct pci_epf_bar *epf_bar;
+	int bar, ret;
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -720,20 +718,12 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 
 	epc_features = epf_test->epc_features;
 
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


