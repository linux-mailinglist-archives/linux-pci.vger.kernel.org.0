Return-Path: <linux-pci+bounces-35417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70286B42FD4
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 04:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD871BC671D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267F51F7098;
	Thu,  4 Sep 2025 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sS4tqdLc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="U/e93ogn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD42628D;
	Thu,  4 Sep 2025 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953510; cv=none; b=gu2hVbg4rIRXB2iNkzZgoUbpfuIj528KzCClj50x8TccPJCZGDGArHXwCiMDxWRfB1eaUpkIQnPvPMn8MjRPmS/sO8qCCa7jR2MH6rVJsOnk3aiy57YjFbCCQCixGiE1uOfSqI+oln0nG7vtk/RlLRf7Q4IgOzy3mzvGPEqtKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953510; c=relaxed/simple;
	bh=FdbeB+yV5/C5kxBua8uMen1dPsCyQQKz7pW1D60oLSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZBanICEgeQ7qlrLedlxdLxHPdmMosaSMQ/iEfmBdYzfw/0EbG6BvVTYkdfnMOehiTmuAOGRnvnJI/gVjg5wGJAE6oilH2RObtv/n2dPcXzK4pZLi5t6qBIk7xiSM/f9R2hqztfkCyURXN//t0pEdToaNdxEWOAEGRXZvmZl83AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sS4tqdLc; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=U/e93ogn; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cHNvN4nBrz9srJ;
	Thu,  4 Sep 2025 04:38:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756953504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Avc2qjUFUbqIM0SvA74SfMpAPpoaNpwHHVCU9A6Trc=;
	b=sS4tqdLcv+7ouTuTra9c+WTMdY0zY15kmf3vsZwDEQ8+g4acYHHS7H+xu7EuEvj9HsCWOU
	LurUPa50lRyvR3fVj15YQZeliAmqp9js1hCAfAAD5vh+NUtELHAgIiDMTKKz8xj+7cuOA4
	DCUbOR5Ec1xpzIUuyV7e7H56336m6Af7YPDwwcEPDbixRlbLwkgjkOLQxycqbe08+6Acsr
	m1ePCGZWslF9/oCKlNV8aggcRTyohtTMf0cWkqyoxw/y/RYgSQ9kX/MvTHBzmUn5Fj9EGC
	yLxQ/IJV0yH/WIsK2uai835nbouP4IDrXPniXYTWqYpUc0xvgmW70iZxhOkg7w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756953502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Avc2qjUFUbqIM0SvA74SfMpAPpoaNpwHHVCU9A6Trc=;
	b=U/e93ognuVVrfaawXGDYkNx5uyoeBH2ynAR9Jql4MsYVl0KWzHzeaFZI94ewyIMjyvVmzT
	OkPFyQD37C+cpBkocHxdzLoB2SITf+Lrdp1NJQrLQU4R1fsoZtWwoK2nWnjh++fDciG7vG
	p8J5feVSqew3tKl2hUyT0mP5YkE9ls9jNVIAUDqMBXEr0T8Yt/oFr5k0lOAzTnfRTdtW/n
	dLmOySqwiWd+B3qo5jAfREdkPnrKIQ9td5CYa1W4oMoW53rfeS31pN24VOEQ+oZUNeEDjL
	DWYCvRSg08OzifnMGdHtxIQbz17WipUyqy2CpajYCcA9YRVsIo2nZbhky1B05A==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Wang Jiang <jiangwang@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for fixed BARs
Date: Thu,  4 Sep 2025 04:37:39 +0200
Message-ID: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7ba099bd9488c476be4
X-MBO-RS-META: um6ezw575iyqc6idttayuar7n9fmxtpx

Currently, the test allocates BAR sizes according to fixed table
bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 } . This
does not work with controllers which have fixed size BARs, like
Renesas R-Car V4H PCIe controller, which has BAR4 size limited
to 256 Bytes, which is much less than 131072 currently requested
by this test.

Adjust the test such, that in case a fixed size BAR is detected
on a controller, minimum of requested size and fixed size BAR
size is used during the test instead.

This helps with test failures reported as follows:
"
pci_epf_test pci_epf_test.0: requested BAR size is larger than fixed size
pci_epf_test pci_epf_test.0: Failed to allocate space for BAR4
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: Wang Jiang <jiangwang@kylinos.cn>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e091193bd8a8a..d9c950d4c9a9e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -1022,7 +1022,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	enum pci_barno bar;
 	const struct pci_epc_features *epc_features = epf_test->epc_features;
-	size_t test_reg_size;
+	size_t test_reg_size, test_bar_size;
+	u64 bar_fixed_size;
 
 	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
 
@@ -1050,7 +1051,13 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		if (bar == test_reg_bar)
 			continue;
 
-		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
+		test_bar_size = bar_size[bar];
+
+		bar_fixed_size = epc_features->bar[bar].fixed_size;
+		if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size)
+			test_bar_size = min(bar_size[bar], bar_fixed_size);
+
+		base = pci_epf_alloc_space(epf, test_bar_size, bar,
 					   epc_features, PRIMARY_INTERFACE);
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
-- 
2.50.1


