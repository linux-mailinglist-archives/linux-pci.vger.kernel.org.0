Return-Path: <linux-pci+bounces-35411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B75B42CD6
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 00:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC86A1740F4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 22:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8392D7DE1;
	Wed,  3 Sep 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jaKXL5Gl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20333E7
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938970; cv=none; b=UVVVtKgh71h3LmXBfzDRz9AhKYkmESZU5TCYriCHLVI15jvO4YOxad4G2cgNfG+aBKX1DUcS+8sePkb1UpiNu8WSM/C17L2huKEjfkPbVUDL96heVNvvd1i9cZKpZMVu6I73b7ITfUf8OooaUYIOc/wg51eylJh2ejnpFveaTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938970; c=relaxed/simple;
	bh=q6jbjKDI9nsCsNJFWRTcxs+Iv8N1MnmBEeqQ4uk8O6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaK11dyTaQV5zJYEzi857Bqp9EJnYQQp5J09nW5ZzJasl+6syt/1hoamnyfAX8TGy3uoYScmmyfX7POcDzp//S0QjA6MKW022/zlfGbsvYcIOYgZ0PCFPOjtURULH3yx3TFf0qntvW0DWGo93zoAUeEA77+dzdex/WCvlrrN1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jaKXL5Gl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756938969; x=1788474969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q6jbjKDI9nsCsNJFWRTcxs+Iv8N1MnmBEeqQ4uk8O6E=;
  b=jaKXL5GlbIEPLp+TIciL/z7tUnUQNgvmZa+pkGbfdzFJgwxr8AvA8pgd
   wFaq6TAsGLlNf5xv3WPTGiJBDytRQv1tghhEZ0qdCHD0C7hNxQ1hO10B8
   kasCUBRvDLs8wfRBHiCsmQejdKgM6Ukus6fA2pC789QB/1VrIIy58oU0o
   jeeTFhjPaEiOLO6TgbN7I0d87F5U/Cpal4LDjp7rSd4w6unjFdBdbjM3w
   NrON7yCKmrYR/kT+rvvvNWWLB2a4C+6NJSgHQ3K5JPZ56kzdYdHbxj6RD
   0lSmIiiiLvOhfBYML/E6a+hZC4KtNTP6Ob6Oxug5HO3unGdF1nFxIzXU7
   g==;
X-CSE-ConnectionGUID: 5EZ5pSlSTd+Ww67a6wSjNQ==
X-CSE-MsgGUID: UiK9NX7+Ts6xf1EyrYoE6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="76715635"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="76715635"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 15:36:08 -0700
X-CSE-ConnectionGUID: cDNSDO/RTRuSzHTmtKU3tg==
X-CSE-MsgGUID: Cas7qhDrSt+k+H60t6fD4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="202570670"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 15:36:07 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 1/5] PCI/P2PDMA: Don't enforce ACS check for device functions of Intel GPUs
Date: Wed,  3 Sep 2025 15:30:54 -0700
Message-ID: <20250903223403.1261824-2-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903223403.1261824-1-vivek.kasireddy@intel.com>
References: <20250903223403.1261824-1-vivek.kasireddy@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Typically, functions of the same PCI device (such as a PF and a VF)
share the same bus and have a common root port and the PF provisions
resources for the VF. Given this model, they can be considered
compatible as far as P2PDMA access is considered.

Currently, although the distance (2) is correctly calculated for
functions of the same device, an ACS check failure prevents P2P DMA
access between them. Therefore, introduce a small function named
pci_devfns_support_p2pdma() to determine if the provider and client
belong to the same device and facilitate P2PDMA between them by
not enforcing the ACS check.

However, since it is hard to determine if the device functions of
any given PCI device are P2PDMA compatible, we only relax the ACS
check enforcement for device functions of Intel GPUs, specifically
the case where the provider is an Intel GPU VF and the client is
an Intel GPU PF. This is because the P2PDMA communication between
the PF and VF of Intel GPUs is handled internally and does not
typically involve the PCIe fabric.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: <linux-pci@vger.kernel.org>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
v1 -> v2:
- Relax the enforcment of ACS check only for Intel GPU functions
  as they are P2PDMA compatible given the way the PF provisions
  the resources among multiple VFs.

v2 -> v3:
- s/pci_devs_are_p2pdma_compatible/pci_devfns_support_p2pdma
- Improve the commit message to explain the reasoning behind
  relaxing the ACS check enforcement only for Intel GPU functions.
---
 drivers/pci/p2pdma.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index da5657a02007..9484991c4765 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -544,6 +544,18 @@ static unsigned long map_types_idx(struct pci_dev *client)
 	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
 }
 
+static bool pci_devfns_support_p2pdma(struct pci_dev *provider,
+				      struct pci_dev *client)
+{
+	if (provider->vendor == PCI_VENDOR_ID_INTEL) {
+		if ((pci_is_vga(provider) && pci_is_vga(client)) ||
+		    (pci_is_display(provider) && pci_is_display(client)))
+			return pci_physfn(provider) == pci_physfn(client);
+	}
+
+	return false;
+}
+
 /*
  * Calculate the P2PDMA mapping type and distance between two PCI devices.
  *
@@ -643,7 +655,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 
 	*dist = dist_a + dist_b;
 
-	if (!acs_cnt) {
+	if (!acs_cnt || pci_devfns_support_p2pdma(provider, client)) {
 		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
 		goto done;
 	}
@@ -705,7 +717,9 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 		return -1;
 
 	for (i = 0; i < num_clients; i++) {
-		pci_client = find_parent_pci_dev(clients[i]);
+		pci_client = dev_is_pf(clients[i]) ?
+				pci_dev_get(to_pci_dev(clients[i])) :
+				find_parent_pci_dev(clients[i]);
 		if (!pci_client) {
 			if (verbose)
 				dev_warn(clients[i],
-- 
2.50.1


