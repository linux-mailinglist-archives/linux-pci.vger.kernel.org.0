Return-Path: <linux-pci+bounces-4778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD487A63F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 11:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4951C21055
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884F13D3B7;
	Wed, 13 Mar 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulpOr27T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF33D38F
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327512; cv=none; b=L1thTL2TIx1cHEMZH8iIld1pjShbJyuqw5LI+/SIBCRyeF0EaQn0HxZXLVP0gpvr/CrTMnOYkA/XkoElb2K+MDIypc1Q+ZUAG4zwFOPflFegyJabdCCtfkOR3/OirCORbiatxaWBitGtWAKfxbS/tatqH4dS8g5FlHjwdEWY71M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327512; c=relaxed/simple;
	bh=VqxAnMdNBCPq0LcAygy6XAAssDYODbeSUV3wclX9NVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpqmgDKiQhc4jjZwmBAOS4m+r+QMuLwF0rUissMf9eWmhdNKkGzMGBXPblDsQXqNrvfQgnQl7hMp1WcB9Es2Vgi5aeC35vMynlNKJRSxKjfhlmEErmopXS7tbUWzW+CoXQ8g/aEsWLv4Rp1cKPsGzjcax/Odn7d5p1QgrJfFaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulpOr27T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF15C433C7;
	Wed, 13 Mar 2024 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710327512;
	bh=VqxAnMdNBCPq0LcAygy6XAAssDYODbeSUV3wclX9NVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulpOr27ThfXzlr/o3EAx3AUq5KHXjCvFW365/7ePdl0jCFSt3SmP1wZWqiua9QjqP
	 5lETzoeBm09HpxFtatvFBIevQ6tonsy5o7GtOY2ABKOGo0fvXPtR0xiqbHgfFsWjvk
	 MEoLtO5aVlw4AskAxoyTrcMx0C+VcdaTsx26OeIdAYvAmRTjogYEROMsf4cudY1TuP
	 0fatvStapjxPxmIX70a10fz1xnfomCGuNAQlsaZxno7Nwl9vXjy9y37ss5kRGkx3Ba
	 80HpZIxB6Hl9S+2gb0NwHS9ic6wVkd4EnZwFyezUf32mB/0k/FUkZ0Obcf2e9syB1y
	 +sZP6xNIXkJxQ==
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
Subject: [PATCH v3 4/9] PCI: endpoint: pci-epf-test: Simplify pci_epf_test_alloc_space() loop
Date: Wed, 13 Mar 2024 11:57:56 +0100
Message-ID: <20240313105804.100168-5-cassel@kernel.org>
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

Make pci-epf-test use pci_epc_get_next_free_bar() just like pci-epf-ntb.c
and pci-epf-vntb.c.

Using pci_epc_get_next_free_bar() also makes it more obvious that
pci-epf-test does no special configuration at all.

This way, the code is more consistent between EPF drivers, and pci-epf-test
does not need to explicitly check if the BAR is reserved, or if the index
belongs to a BAR succeeding a 64-bit only BAR.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7dc9704128dc..20c79610712d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -823,8 +823,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	size_t pba_size = 0;
 	bool msix_capable;
 	void *base;
-	int bar, add;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	enum pci_barno bar;
 	const struct pci_epc_features *epc_features;
 	size_t test_reg_size;
 
@@ -849,16 +849,14 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	}
 	epf_test->reg[test_reg_bar] = base;
 
-	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
-		epf_bar = &epf->bar[bar];
-		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
+		bar = pci_epc_get_next_free_bar(epc_features, bar);
+		if (bar == NO_BAR)
+			break;
 
 		if (bar == test_reg_bar)
 			continue;
 
-		if (epc_features->bar[bar].type == BAR_RESERVED)
-			continue;
-
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
 					   epc_features, PRIMARY_INTERFACE);
 		if (!base)
@@ -871,7 +869,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		 * either because the BAR can only be a 64-bit BAR, or if
 		 * we requested a size larger than 4 GB.
 		 */
-		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
+		epf_bar = &epf->bar[bar];
+		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
+			bar++;
 	}
 
 	return 0;
-- 
2.44.0


