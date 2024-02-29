Return-Path: <linux-pci+bounces-4239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A86F86C747
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 11:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA24A28AF67
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 10:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD6C7A703;
	Thu, 29 Feb 2024 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYuYvNMs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061167A700
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203765; cv=none; b=nvScKaC0wi/lNhqCruw65eBjqxe3NsYJGjbtr2UnYTpwb4u9K7lioqjTtz6CkQuaJVXKnSqF/iVWZzActL7jK6clTYufY7lB/L28EsjRhx5gR5yT2iCucZU4wQ+zTvNdAvjPmHix0Zf4X4dk+uqQLY/IPlnVnYXDosYyzzz1OqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203765; c=relaxed/simple;
	bh=roKdtuLhwaJZnyD6Vz3K9fl9O1TAHQM3ub5kVhHjXdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwis6jU04W+655qRjDEjlAp1NtRfXM78LpP7rhgRXcS6OCMYKnJNkFH4v1IgIBqLl2HgXA2q9kdbEFyuaBbR1NZEfajXUTbSOeJH+FGnpRSMV85SvGExX1pHQO84eeReDRP7RmH7ew+hdxHDMMz0wKLrZ3HelmQtn9mZ1r8TK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYuYvNMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B47C43390;
	Thu, 29 Feb 2024 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709203764;
	bh=roKdtuLhwaJZnyD6Vz3K9fl9O1TAHQM3ub5kVhHjXdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYuYvNMsKBppWh1u4QdpXurCsqoWMSiVyyPk1jg4p91OTsgU0YjOtUy1/ZZqtZEyJ
	 tk2OykIvsENx76UNIl5k2q6jgdRgk/Ow9Wo1Ez0y83+aTqIbXmPaaDEi3MqvoMK+hK
	 RiYeOuhOufQdbYYd7ZaGiukIQxPUmGSalCVdNNuswbAMcKUhWfnc6edPFmmF4Znz28
	 B3vFepTFk1aRCUyTt9SFOWRNRqDW9K4mUgEQ0YRDETh4kV/gjgR3CufjbypUVKZEXT
	 Km/lKkOsuBqLj7A9gPRL+xHonRSYudSZ3PllCBh/jeTNurWeBNoLqSu5B4dM2MAI1A
	 BzwwSYAhHjRVA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: endpoint: Move .only_64bit check to core
Date: Thu, 29 Feb 2024 11:48:58 +0100
Message-ID: <20240229104900.894695-2-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229104900.894695-1-cassel@kernel.org>
References: <20240229104900.894695-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the .only_64bit check to pci-epf-core, such that this check does
not need to be duplicated in all endpoint function drivers.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 14 --------------
 drivers/pci/endpoint/pci-epf-core.c           |  7 ++++---
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index cd4ffb39dcdc..a7f0b5ebc1e8 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -870,19 +870,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
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
@@ -907,7 +894,6 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
 	if (test_reg_bar < 0)
 		return -EINVAL;
-	pci_epf_configure_bar(epf, epc_features);
 
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 0a28a0b0911b..e7dbbeb1f0de 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -304,9 +304,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
 	epf_bar[bar].barno = bar;
-	epf_bar[bar].flags |= upper_32_bits(size) ?
-				PCI_BASE_ADDRESS_MEM_TYPE_64 :
-				PCI_BASE_ADDRESS_MEM_TYPE_32;
+	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	else
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
 
 	return space;
 }
-- 
2.44.0


