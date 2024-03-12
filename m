Return-Path: <linux-pci+bounces-4754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B8D87927A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 11:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD831F22A1A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7169D19;
	Tue, 12 Mar 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF46aNex"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C278288
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240757; cv=none; b=Oqv7fGEKN5XMl3n4Zlyy6nXceEfEoKMKOPZ632Kw9VO6feyslC3A0RfO1TNT93Btto3JB2kOs+55vt8gONtry86pon9RTO6FG6ziFA1ob22tq+elPQfLqNYRFQGJ+kncTVIliOzjcMSWDLk+DtwocrnAZDD04oad+PTO2x0AKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240757; c=relaxed/simple;
	bh=VqxAnMdNBCPq0LcAygy6XAAssDYODbeSUV3wclX9NVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6WC1Xh+QJwrXa3kp7KhfgXL+b/Krk3UyFahXBivMr5F1tpZMM6Y4grOIN7T9oGRhdURaCGOP2v9JXbsjA7eogaXvb0nN2ws7db1nJ1bZkyGxDM6MJW04VJSL0guwosG3UlTciuiMJpx0Idud9bH1VtvevVDK7D8w8sBDS55+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF46aNex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FCAC43390;
	Tue, 12 Mar 2024 10:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240757;
	bh=VqxAnMdNBCPq0LcAygy6XAAssDYODbeSUV3wclX9NVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bF46aNex5rM0tcBGNmilpgoaIGb4d7GgCYhrA9sLwIYAqn47oA+prnWvaybwD1/ms
	 AH/OZRYm9Q/7QYRFWBsJjldc9fi7YEowYqj+9sTq4TntKTIL+kBEU2vHnvyO0aN56B
	 AK7dpIVDz03EhPc9PIA8yV5NLLSOoZMnr1G9QssZ8w6aDN6khrND+Fx+yRz2nA8vYh
	 db4kTMsujSetDJhzXZCuZRUr8u6Qhgkvfb/SChWGr6tPlQxmtuXYnTdvQZQKYFoNGn
	 t9xJBCLfhy/t4sQ+jm1GH58U+kZ0K0J5RJJobEmtJx0JOXYrB0L6+FU/KzXdgsmMYA
	 8KWWevuJ8QFXw==
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
Subject: [PATCH v2 4/9] PCI: endpoint: pci-epf-test: Simplify pci_epf_test_alloc_space() loop
Date: Tue, 12 Mar 2024 11:51:44 +0100
Message-ID: <20240312105152.3457899-5-cassel@kernel.org>
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


