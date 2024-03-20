Return-Path: <linux-pci+bounces-4956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6FD8810FC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377F82826F4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C443D961;
	Wed, 20 Mar 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7Rx+bfD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28B13D566
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934340; cv=none; b=EToFengQfHWdI5BpFPF/BcRe8PP9cDrQ6ZoH7m6vYdsR02bsMJTdOdh7TfbZ9X/0JiJ9r95+7yYMD7QJmTAwmjU+mSSOswK46p/kkNfWkgaEndQnXtLa2nC61vSQBjl9YfDpskNxnceqNr8UaGxaolY7M19B4L8dsexncSSxSyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934340; c=relaxed/simple;
	bh=DcG2wqFhyHctYhrJ0dTWozI4m+2msmP4B5/Lk5nblKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SswUYteLIu8xPAXLNUEW2BQdlSgzdi1FFIC7z5kTW6YpkQg5x9NkxonUEGNzV/CrO9iPS2cExiHvwMUMHzXBFLBSy3C0PzxL3qoOk5HJm/80Y/zxouwBWKrd1mA2/Z98S10z5Tr+wqmfsu0UvdIeFYnFmKTMNNXIUlBzs9E8YFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7Rx+bfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560DAC43394;
	Wed, 20 Mar 2024 11:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710934340;
	bh=DcG2wqFhyHctYhrJ0dTWozI4m+2msmP4B5/Lk5nblKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7Rx+bfDZxyapbxwHzeW/i187E4eNMQSoCWyMmLlkkdGMvtfeRb12ur9MMCIEg4XS
	 3h0TmK9B3RQZkIo3b2nHumhuoFwr8XgdPS3XMemp5jjlFa6iKHQI6Yp6JW8daq2jgc
	 DZTAINcTXXFhHBDnkvmOxDjvkA8v8fvM78eYfKa0zGmrorXInuZFxdgcoAHEtLjLsP
	 NSjUGlXlCe/Sr4p/nT6ChsH85UTZ1FrpdVUyRa+9EH5pcG4TUNhhgeUoPG0FMRvaOk
	 Omoq5CX7h7xNtjofnEakjwAO59iGwT6LJw9a1zX43A/rvP9yNhJVX0aK/1gxEZb1Rg
	 ZiYE241SV5mMA==
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
Subject: [PATCH v4 3/7] PCI: endpoint: pci-epf-test: Remove superfluous code
Date: Wed, 20 Mar 2024 12:31:50 +0100
Message-ID: <20240320113157.322695-4-cassel@kernel.org>
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

The only reason why we call pci_epf_configure_bar() is to set
PCI_BASE_ADDRESS_MEM_TYPE_64 in case the hardware requires it.

However, this flag is now automatically set when allocating a BAR that
can only be a 64-bit BAR, so we can drop pci_epf_configure_bar()
completely.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 16dfd61cd9fb..0a83a1901bb7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -867,19 +867,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
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
@@ -904,7 +891,6 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
 	if (test_reg_bar < 0)
 		return -EINVAL;
-	pci_epf_configure_bar(epf, epc_features);
 
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
-- 
2.44.0


