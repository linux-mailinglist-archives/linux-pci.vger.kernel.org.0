Return-Path: <linux-pci+bounces-4957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3C98810FE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B648B282FD7
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5B03D961;
	Wed, 20 Mar 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reTeiKrb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD833D566
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934343; cv=none; b=YdiaxrACD3HQoTBfSnyQDiO+1sqWBRCEJroZPSYEKDK1EsWJpGeSCSIoeOKn2J47SSWj3pvN2Lo0WmL9WO5t7mfwon0j6sg3myK2UuA++yOevWudKf28CtrtnO3fgtiDhzalqNYA2j2tyGb/P5TjLNX2U8yGVcNT1SyEwDSdqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934343; c=relaxed/simple;
	bh=qlo8LE8aYFDw5YRRHFlCNqf9qXT2c3WiS0hz4pZjpUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvtkyLby/eRPD+AEc61FlDPXBNtzV/0S9mLErY4NkTDVbnRZYk6VtPHeLnXAA3ps3ISlfbpe4/K6l2QY0Qx3p/jYoFi1plCA+hoM5lckcLjOxdO0QvCnSwlIiGNU6B4MhkyTptObHAOxWF8y9e2kjubjOSOMfuGhcyGCVxYzDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reTeiKrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19080C433B1;
	Wed, 20 Mar 2024 11:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710934343;
	bh=qlo8LE8aYFDw5YRRHFlCNqf9qXT2c3WiS0hz4pZjpUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=reTeiKrboGTvlQY8Y1Wi3KZfzRh2S7Sqj/G+3Ybxl7cfxar8tV+B60t4248sYWPWD
	 wy6uKv6I0srIqengbB6SDLMXMxgBzSUOkOqSW5FLOX/Ejl/AwtMqH4TbGhcRc+LQ1E
	 PWoA0JGk0CO6IQ5Tb+y//j07cf+mUcnofds74yO1/Wyn4q7qUeuEQYyYRTXEIqzqRx
	 xDmQKazQon4t0zmgf3v9gMp0FMinPUStepmGg4akkbeME7cYtsyLnJZLS2KVvys6aY
	 XRCppTBfqxBgXWY8yHatTYsDzgs3OmPccMLizfXOhz4VriVpMxwhnTvzzkLQPMhJ8A
	 7Etq+zUe6Wpbw==
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
Subject: [PATCH v4 4/7] PCI: endpoint: pci-epf-test: Simplify pci_epf_test_set_bar() loop
Date: Wed, 20 Mar 2024 12:31:51 +0100
Message-ID: <20240320113157.322695-5-cassel@kernel.org>
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
index 0a83a1901bb7..faf347216b6b 100644
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
 
-	epc_features = epf_test->epc_features;
-
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


