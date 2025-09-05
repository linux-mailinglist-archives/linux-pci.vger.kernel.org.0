Return-Path: <linux-pci+bounces-35529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35DBB45769
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 14:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4AC5C18AC
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 12:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865DC34A334;
	Fri,  5 Sep 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nyhJmFF6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XxedlOd2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3192D595B;
	Fri,  5 Sep 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074404; cv=none; b=OlbwwGV4t8SFTXiX6Q21J4sdwnHWIB8/ESovW51wx2VW8SRMuDA56xMzN7ap/8282bceTaa7XNo4N1IQjsFMS6sknhXv39HPo3RsQ4tMvP0OHaqcnETy1+JtrTbP5qM90V2GEX5Hy8BnYC6DABVQ3HeEo9vl35DMnuRm5qqRfxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074404; c=relaxed/simple;
	bh=csjHK8PoOisMbnu7P8iLdFCxGu9TmO9YhQI56Bglkl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nv5D0xid8NYCDI7HAUKSxvikmyD+r0tZps1cMgXW78aIeaj6kyDEwkgXnwdTnE27ddFbzvt3cLZKiT1JHRvdzIqa81Isq6K5T9J7namtHE1Ut9KWY5/A5KwA4anclY2xz2Ss74CPh2HeySJ792vMigaWBX6RTAlgMUNDw+GygUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nyhJmFF6; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XxedlOd2; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cJFcH3CmPz9sbL;
	Fri,  5 Sep 2025 14:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757074399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oEMdT5xWzO1hbI9Xaxw82eQEzXMf3KhV/c5Xfg9jCXc=;
	b=nyhJmFF6Tv0nyJNL7QJJepUc+Z1xvIm8YpoG1PlQsSM/fhUtAh6fqBPv+F946IkLdNxVid
	E1wZdUr7fuKcLYHYXfiY5Lkh+c8/s0+3O6bw04RunDP2YXCKW/bpp2dSm6Hkyul2FKbOnE
	nCigxaM4CvhdokD9KPfAkwswRdnlCoYxkzMe4C5sZ3jmPV6Tl00WB4iCEHac2RwWhw6p+6
	xMHYkxYd6t+bvMqo90YvymtdqBojwTkjtJpVgCcgXrUAE+FJDfim/CGhy5dVjXAXzNEHAx
	ZjcxcKIBQNswch+0YJQ6+Ibg8In9VtP1Ru18Bv9HeHRLqUwOim3t3bvwfkwS/g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757074397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oEMdT5xWzO1hbI9Xaxw82eQEzXMf3KhV/c5Xfg9jCXc=;
	b=XxedlOd2EHqPvf5TagP2AgPnKHEyT9zuW3kVHkSuEuGAXnwZ50GnE3/sgFZ0pQBSR24uDC
	YggclyS4dVkGoLW7FUdzrixyPPdBKASqMluVUg8ylV0ZDmvdBKDgzyGM6ko3ayWSiVM++y
	/Z8x1IPua8PwYmPiAqbFgulv/AxANn3zJjeFy0TEpst9Uv5vJ6KXDVLqDAaWH0/QvJaIEk
	h0UA+7tABZKRznL3OsD8N5inJFwI7wIfk4ihf8JDkJNe8vTTyOlQ9LllUKFBXvQ/0O7fDF
	Lo/VKY9x8W0y2j5rggwT6rvGW5CflNss/qvmIDXW76J46sPFHLjSCMp+vSAlmw==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Wang Jiang <jiangwang@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for fixed BARs
Date: Fri,  5 Sep 2025 14:12:43 +0200
Message-ID: <20250905121259.9378-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4eis68otftdeswfckfrm4yza3shqrujy
X-MBO-RS-ID: 3ee001c26907758ab67

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
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: Wang Jiang <jiangwang@kylinos.cn>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Simplify the conditional to always use fixed size BAR size for test
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e091193bd8a8a..2418add64104a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -1050,7 +1050,12 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		if (bar == test_reg_bar)
 			continue;
 
-		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
+		if (epc_features->bar[bar].type == BAR_FIXED)
+			test_reg_size = epc_features->bar[bar].fixed_size;
+		else
+			test_reg_size = bar_size[bar];
+
+		base = pci_epf_alloc_space(epf, test_reg_size, bar,
 					   epc_features, PRIMARY_INTERFACE);
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
-- 
2.50.1


