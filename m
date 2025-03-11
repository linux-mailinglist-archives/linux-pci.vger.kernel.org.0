Return-Path: <linux-pci+bounces-23433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F23A5C42C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5B8170687
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A99E238172;
	Tue, 11 Mar 2025 14:46:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE461E4929
	for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704375; cv=none; b=EVHx2MobYiiOcTGddBEqZNcT+StVsUCdziBocPOMhzcvOPUpteVofhbsBmHYtprBwnGJweSQmLnjaNN0vO7u0fYuYP0danGdQA7/RojqbIzRXkeJ/GRvq46DjJd3KhoZnHUEvHgclHJS565U8hpEXkmLEXt+5+swZ8E5eoRffZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704375; c=relaxed/simple;
	bh=79BsNtSAsW7bKNhzjIoMW2jacgh6A6YolnMiKtdpPvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANBSfZUdK5kI+U8JQ9f4z9t2fmMrHf9T2yfnxuNegSGFkk3bxTQ3eRmDm+hA/i6lfj045Xr6sQmbuW2K+RaZexDL3P56fSzcLKmEBLxOyckZmVqYs/wMesCESk56o749GSARR0RUlBlj4P8Qke/xPbRhp/BtygAiVyg2xySh92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 334F527B5;
	Tue, 11 Mar 2025 07:46:24 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A26F33F694;
	Tue, 11 Mar 2025 07:46:11 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: lpieralisi@kernel.org,
	robin.murphy@arm.com,
	aneesh.kumar@kernel.org,
	linux-coco@lists.linux.dev,
	bhelgaas@google.com,
	lukas@wunner.de,
	sameo@rivosinc.com,
	aik@amd.com,
	yilun.xu@linux.intel.com,
	linux-pci@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RESEND RFC PATCH 2/3] pci: generic-domains: Add helpers to alloc/free dynamic bus numbers
Date: Tue, 11 Mar 2025 14:46:00 +0000
Message-ID: <20250311144601.145736-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311144601.145736-1-suzuki.poulose@arm.com>
References: <20250311141712.145625-1-suzuki.poulose@arm.com>
 <20250311144601.145736-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helpers to allocate/free useable PCI domain numbers at runtime.
This will be later used by sample devsec code.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/pci/pci.c   | 16 ++++++++++++++--
 include/linux/pci.h |  3 +++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..729bc57e025b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6685,6 +6685,18 @@ static void pci_no_domains(void)
 static DEFINE_IDA(pci_domain_nr_static_ida);
 static DEFINE_IDA(pci_domain_nr_dynamic_ida);
 
+int pci_alloc_dynamic_domain(void)
+{
+	return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(pci_alloc_dynamic_domain);
+
+void pci_free_dynamic_domain(int domain)
+{
+	ida_free(&pci_domain_nr_dynamic_ida, domain);
+}
+EXPORT_SYMBOL_GPL(pci_free_dynamic_domain);
+
 static void of_pci_reserve_static_domain_nr(void)
 {
 	struct device_node *np;
@@ -6733,7 +6745,7 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
 	 * dynamic allocations to prevent assigning them to other DT nodes
 	 * without static domain.
 	 */
-	return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
+	return pci_alloc_dynamic_domain();
 }
 
 static void of_pci_bus_release_domain_nr(struct device *parent, int domain_nr)
@@ -6745,7 +6757,7 @@ static void of_pci_bus_release_domain_nr(struct device *parent, int domain_nr)
 	if (of_get_pci_domain_nr(parent->of_node) == domain_nr)
 		ida_free(&pci_domain_nr_static_ida, domain_nr);
 	else
-		ida_free(&pci_domain_nr_dynamic_ida, domain_nr);
+		pci_free_dynamic_domain(domain_nr);
 }
 
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c2f18f31f7a7..c040c1d49632 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1934,6 +1934,9 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 #endif
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
 void pci_bus_release_domain_nr(struct device *parent, int domain_nr);
+int pci_alloc_dynamic_domain(void);
+void pci_free_dynamic_domain(int domain);
+
 #endif
 
 /* Some architectures require additional setup to direct VGA traffic */
-- 
2.43.0


