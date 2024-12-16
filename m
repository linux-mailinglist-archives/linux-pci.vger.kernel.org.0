Return-Path: <linux-pci+bounces-18543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABD49F382D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7661D16B7B4
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3592207663;
	Mon, 16 Dec 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEPsEHig"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40694207662;
	Mon, 16 Dec 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371874; cv=none; b=uPjom5XNoi25OUo/sKvzkOJ3X4lwmWpqDBTqIUV+aaAU/O4Yppm4hSW8eQUMBSH4DEjlFs1YccEA5OR2Gh4VzK1BMG3bhYPt4KYFUF4AuQRASMlbzDdDKDtfsKCXBEbHYCzlV17VShxhWQMiutm/ycM7oKt9OefV8pJQxzv1fE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371874; c=relaxed/simple;
	bh=udVAkX2/Hr8h38COf9498Y/kMOJOw55GihxUuADn5Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scBvMUqNSNgUl7dNvan5x/mAoP9ahgClVQC5JRRT0Bhvm2QF0KOIpYzZvq8z2XJocrxYLWgZ/Lr023HPmLjhTzfeOlTOpKTRQWcfJqhXatjoH3j/V+ng/hbTaJ6te9wtuHrNd553l/+64aoW8ciBRGzmoQL4Kvs1kbg0oWDTzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEPsEHig; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371874; x=1765907874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=udVAkX2/Hr8h38COf9498Y/kMOJOw55GihxUuADn5Ew=;
  b=GEPsEHigLsgnGHtbcvOUdUzRyh4ukT0fl0wZsyycBH1xP2TgRATylu2P
   5L+Bk+bi/WpFhVjVQV/RlxLpCbKZQOrJcHpMALjxivTHMgmjNsnpbmDa4
   u+1G/NnFKNUKL5hFncVFBayNngqPNcFZ+u/jD0RUx1QhKWH/A3N8byXky
   nShK9MLAONlvSMw8Hy4y8teOBT/zwUOrjGh4ljBPbzjagf5qhnww/PHku
   sb+CjdE3DkC0rB2EgyLxO7TSi6iE1UqFq46PdngWn3rJAhMFxb7b9sy+P
   hQVGfeYo7T6Uozu0FA48O4eUpn9pSTObRWENVEEXgFvd+EuJVAvgqfwCo
   w==;
X-CSE-ConnectionGUID: 2LCWezDPTvCFJ/c2/E9NnA==
X-CSE-MsgGUID: tyjtpBf6RgaAiknQT0EO6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38543998"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="38543998"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:53 -0800
X-CSE-ConnectionGUID: neOtWnoGStO0aM7YPIGroA==
X-CSE-MsgGUID: J09FEm7QQKSzY8lXeKklmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97149687"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 08/25] PCI: Add a helper to identify IOV resources
Date: Mon, 16 Dec 2024 19:56:15 +0200
Message-Id: <20241216175632.4175-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Winiarski <michal.winiarski@intel.com>

There are multiple places where special handling is required for IOV
resources.

Extract it to pci_resource_is_iov() helper and drop a few ifdefs.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/pci.h       | 19 +++++++++++++++----
 drivers/pci/setup-bus.c |  7 +++----
 drivers/pci/setup-res.c |  4 +---
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..25bae4bfebea 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -621,6 +621,10 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
+static inline bool pci_resource_is_iov(int resno)
+{
+	return resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END;
+}
 extern const struct attribute_group sriov_pf_dev_attr_group;
 extern const struct attribute_group sriov_vf_dev_attr_group;
 #else
@@ -630,12 +634,21 @@ static inline int pci_iov_init(struct pci_dev *dev)
 }
 static inline void pci_iov_release(struct pci_dev *dev) { }
 static inline void pci_iov_remove(struct pci_dev *dev) { }
+static inline void pci_iov_update_resource(struct pci_dev *dev, int resno) { }
+static inline resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev,
+							   int resno)
+{
+	return 0;
+}
 static inline void pci_restore_iov_state(struct pci_dev *dev) { }
 static inline int pci_iov_bus_range(struct pci_bus *bus)
 {
 	return 0;
 }
-
+static inline bool pci_resource_is_iov(int resno)
+{
+	return false;
+}
 #endif /* CONFIG_PCI_IOV */
 
 #ifdef CONFIG_PCIE_TPH
@@ -669,12 +682,10 @@ unsigned long pci_cardbus_resource_alignment(struct resource *);
 static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 						     struct resource *res)
 {
-#ifdef CONFIG_PCI_IOV
 	int resno = res - dev->resource;
 
-	if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END)
+	if (pci_resource_is_iov(resno))
 		return pci_sriov_resource_alignment(dev, resno);
-#endif
 	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
 		return pci_cardbus_resource_alignment(res);
 	return resource_alignment(res);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index dd9b06947621..3907930da00d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1093,17 +1093,16 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			     (r->flags & mask) != type3))
 				continue;
 			r_size = resource_size(r);
-#ifdef CONFIG_PCI_IOV
+
 			/* Put SRIOV requested res to the optional list */
-			if (realloc_head && i >= PCI_IOV_RESOURCES &&
-					i <= PCI_IOV_RESOURCE_END) {
+			if (realloc_head && pci_resource_is_iov(i)) {
 				add_align = max(pci_resource_alignment(dev, r), add_align);
 				resource_set_size(r, 0);
 				add_to_list(realloc_head, dev, r, r_size, 0 /* Don't care */);
 				children_add_size += r_size;
 				continue;
 			}
-#endif
+
 			/*
 			 * aligns[0] is for 1MB (since bridge memory
 			 * windows are always at least 1MB aligned), so
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index ca14576bf2bf..79c7ef349856 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -127,10 +127,8 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 {
 	if (resno <= PCI_ROM_RESOURCE)
 		pci_std_update_resource(dev, resno);
-#ifdef CONFIG_PCI_IOV
-	else if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END)
+	else if (pci_resource_is_iov(resno))
 		pci_iov_update_resource(dev, resno);
-#endif
 }
 
 int pci_claim_resource(struct pci_dev *dev, int resource)
-- 
2.39.5


