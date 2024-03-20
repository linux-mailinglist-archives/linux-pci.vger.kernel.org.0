Return-Path: <linux-pci+bounces-4954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A8A8810FB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC4228423F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944103D978;
	Wed, 20 Mar 2024 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S89AANju"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708593D566
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934335; cv=none; b=pO788GSy6Xo0FZblzJaLI9tJWQlSmUxj3wdlaJjzxuCKHu8V69Je7gt7MCqf9JHWlBudrgYWQnlenDKnY1oJ6Rue/ADIbhr0mExaCZDjbW+duA1Qf8XlGqGnsfHzrFRrbhDt/v45VNhgbuJYlbyvQpSIoHQ0z7i5+UmRDObMUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934335; c=relaxed/simple;
	bh=xucd+rDP+hLOY+Yk3qc1JEjN9Y3Q1WAwyxHnk72d2pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NO3WayTlXz0q89RrPi6az4bN6ITrAHZEgdytwNKer9jql/0wcC9loXVaeKM8el+xxmLO+v62tOHBg8k22iD8xacqZNXuoCk6YMPyohNJ6S2leYEs2fDhMr4MBYBnzB64j5fLxgVVinq/TktghcYDAKLRhkv40Cv3S+Ux6aCHHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S89AANju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA371C433C7;
	Wed, 20 Mar 2024 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710934334;
	bh=xucd+rDP+hLOY+Yk3qc1JEjN9Y3Q1WAwyxHnk72d2pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S89AANjuMTQ9UJoxRMgeiRFpZvu2nbGulkDF/tkoxIS/WyovVkXD/drsXDbIZYGQh
	 wvw5tNe2E9yWdYtWhb5MlATVVegL7kkCVdPThe4mqCG5Sgo/Q+JCL1eRhHNtNR3u7G
	 EKWwhai/aboy/MI6MEWGmT4fM4z9l6bY6nskgh44aGWrxIivcS2W0SlbqzEH6v3x3X
	 ts63/n//sLM1XK/sIJzS1w8reYJ/TsGCuYR83EhxWD9PMp5P+njqKDP2e9nLsm6e+M
	 VgWYUo3ID7SI26TOYxlcw5AkBGLgFwzpiujlpkuIFGrnfZIna9+5uejulWceJVBJgH
	 OM1/4n1n+GL3A==
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
Subject: [PATCH v4 1/7] PCI: endpoint: pci-epf-test: Simplify pci_epf_test_alloc_space() loop
Date: Wed, 20 Mar 2024 12:31:48 +0100
Message-ID: <20240320113157.322695-2-cassel@kernel.org>
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

Make pci-epf-test use pci_epc_get_next_free_bar() just like pci-epf-ntb.c
and pci-epf-vntb.c.

Using pci_epc_get_next_free_bar() also makes it more obvious that
pci-epf-test does no special configuration at all.

(The only configuration pci-epf-test does is setting
PCI_BASE_ADDRESS_MEM_TYPE_64 if epc_features has marked the specific BAR
as only_64bit. pci_epc_get_next_free_bar() already takes only_64bit into
account when looping.)

This way, the code is more consistent between EPF drivers, and pci-epf-test
does not need to explicitly check if the BAR is reserved, or if the index
belongs to a BAR succeeding a 64-bit only BAR.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index cd4ffb39dcdc..16dfd61cd9fb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -817,14 +817,13 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct device *dev = &epf->dev;
-	struct pci_epf_bar *epf_bar;
 	size_t msix_table_size = 0;
 	size_t test_reg_bar_size;
 	size_t pba_size = 0;
 	bool msix_capable;
 	void *base;
-	int bar, add;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	enum pci_barno bar;
 	const struct pci_epc_features *epc_features;
 	size_t test_reg_size;
 
@@ -849,16 +848,14 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
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
-- 
2.44.0


