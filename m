Return-Path: <linux-pci+bounces-4753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F9A879279
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 11:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46021C220CA
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491BD69D19;
	Tue, 12 Mar 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcTY8tgH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511D59160
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240755; cv=none; b=i6ISOwrv9IE3pNn61uVtWBAD8veG/P4t2r7AuyEl0OYGmfmrwYQEagQUTFUOC48svMjKLDkFYqr6HFL8wmY558Brsl8jU7N+JJ+Bke1sknElBbpAs/m4lFLNZC298VimcwTpbtbiqwKm5RcHolwO8sVD5xr1TaPJL+QLii9rKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240755; c=relaxed/simple;
	bh=e/qH9cmUPYUotD/eAIW0sRrL9XefNgAmZxzo/zRfOXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9XCE+AsAEiX7x8mv6n3JmIPQo9n0SYOl8+4xLhzhlUZK5gEZN8Qt0IvonE67b2CV7P9BRJdjbkiLcykb0vhBLOJWIEryxpjl8ep+rfjvdUZa/R4AoYQagJCpX4CFvABxcHuZ+hPrf1tCjHxSA9gf4ZP7srH6SxwleW3Nj2mPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcTY8tgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935A2C433C7;
	Tue, 12 Mar 2024 10:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240754;
	bh=e/qH9cmUPYUotD/eAIW0sRrL9XefNgAmZxzo/zRfOXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FcTY8tgHFmhfs63xzdwx1ePs1/NjxuUWXvWj8mxl3GPDdVr5XG8USjcCJ22YJeyOA
	 MJjGmfBTOmcMCWhG6ITu1wKoXy8RnCujPNABYCnoWQDE5WvI7MTUqUzDzrCn5HCsH1
	 EM5dmEdA1QKTheq1vhIoiN/P5+WPRxeRq7H8ZL1OKTUBMnFqS7y5zgeAW5bXuouN7V
	 gs2EHkqXWA/onHgxvNYTcON+bg4aY6Ni0h9TGdy56RUzb7EM9VsDdgsrXCsasD0DF5
	 3PgZbQQXgPvVF9f4S1JQvKzqZB6OsR/e5Ks89t3qbSewS6fbfThNR057WA7m2HqNul
	 oDqsR1PaCnDyw==
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
Subject: [PATCH v2 3/9] PCI: endpoint: pci-epf-test: Remove superfluous code
Date: Tue, 12 Mar 2024 11:51:43 +0100
Message-ID: <20240312105152.3457899-4-cassel@kernel.org>
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

The pci-epf-test does no special configuration at all, it simply requests
a 64-bit BAR if the hardware requires it. However, this flag is now
automatically set when allocating a BAR that can only be a 64-bit BAR,
so we can drop pci_epf_configure_bar() completely.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 8c9802b9b835..7dc9704128dc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -877,19 +877,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	return 0;
 }
 
-static void pci_epf_configure_bar(struct pci_epf *epf,
-				  const struct pci_epc_features *epc_features)
-{
-	struct pci_epf_bar *epf_bar;
-	int i;
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		epf_bar = &epf->bar[i];
-		if (epc_features->bar[i].only_64bit)
-			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
-	}
-}
-
 static int pci_epf_test_bind(struct pci_epf *epf)
 {
 	int ret;
@@ -914,7 +901,6 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
 	if (test_reg_bar < 0)
 		return -EINVAL;
-	pci_epf_configure_bar(epf, epc_features);
 
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
-- 
2.44.0


