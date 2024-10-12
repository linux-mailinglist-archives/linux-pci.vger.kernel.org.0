Return-Path: <linux-pci+bounces-14350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5468799B052
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 05:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0409C284F09
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 03:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19889839F4;
	Sat, 12 Oct 2024 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgQOSMFK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7083224D7
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 03:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728702579; cv=none; b=To3VK/gLOX2SDNNSlAlqKLvrywTFh3EPytWe/u22ScmoGH2+PqoyojsvqK3KRfrwkbjpGT0LxR+WYto0vx5cZGWzyTXNCVchvkYWyuJSHkw9tTpCbS4FwJaMaF0v2Je/+gB4rUzcT+iXlvDYWxdO1qgyVmEZD5P4305LbywY9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728702579; c=relaxed/simple;
	bh=pQNMKXIhNUvqskCGGddSIwZWuzf8Xr6bq3qxHY1VKO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT/0i5d522qg3cfD9v5O/GBHJFYcBC30drayVtMqds/Gdfqqqu84UaiTPBrODPjrQaRTWYx/rI9OmC9wbFUVNoNiWmCY5O6b0shTM6pOxQf+UhlVvdQHN5tOnS5oSfxScr2iIZrACbbARntAos4npNtVrrinCd8Z2w7Iwu1qqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgQOSMFK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728702576; x=1760238576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pQNMKXIhNUvqskCGGddSIwZWuzf8Xr6bq3qxHY1VKO4=;
  b=ZgQOSMFK9c1fq25sguONzyzxivt5uWtRzJe2D8bokOZOki6bDsI9m0lu
   JiIxlvE+i5nr7foD5+h2czPJe4J+iFCCctI18Yhy2Yey+uwf2WLo3nzfj
   U++eQBRsEPTj6pm3E1nZ9wMg4oXCKDm5YkhJ5CeBkHacqn/oYvkc3GfRr
   9mv6ZrMDsORWTC+5srnBh//U8M7AuieIVCFRizrIEhgh9+P8iQ016YJMt
   +bHhSsM9TmsVeHDpJhyxbAUbSWDshQjMTzHXFZ+2qbdGfnabOzvR0vbps
   biVsl39hCLF6iOIZHW97F6YKo3caBaTQ9xFtPf3HXisjndmR/Cujm0Rbr
   A==;
X-CSE-ConnectionGUID: Q+oKnl8DTA2oJ7wHsTwwQg==
X-CSE-MsgGUID: a/08zsRRQDeMdDIws4lrVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38687319"
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="38687319"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 20:09:36 -0700
X-CSE-ConnectionGUID: 3tn12sxdR+u8jy3DVPIi0Q==
X-CSE-MsgGUID: TYNtCv92QCKIIykql8TfUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="77278458"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 20:09:36 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v1 1/5] PCI/P2PDMA: Don't enforce ACS check for functions of same device
Date: Fri, 11 Oct 2024 19:40:23 -0700
Message-ID: <20241012024524.1377836-2-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241012024524.1377836-1-vivek.kasireddy@intel.com>
References: <20241012024524.1377836-1-vivek.kasireddy@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Functions of the same PCI device (such as a PF and a VF) share the
same bus and have a common root port and typically, the PF provisions
resources for the VF. Therefore, they can be considered compatible
as far as P2P access is considered.

Currently, although the distance (2) is correctly calculated for
functions of the same device, an ACS check failure prevents P2P DMA
access between them. Therefore, introduce a small function named
same_pci_device_functions() to determine if the provider and
client belong to the same device and facilitate P2P DMA between
them by not enforcing the ACS check.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: <linux-pci@vger.kernel.org>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 drivers/pci/p2pdma.c | 12 ++++++++++--
 include/linux/pci.h  |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4f47a13cb500..34bee1ac94f2 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -535,6 +535,12 @@ static unsigned long map_types_idx(struct pci_dev *client)
 	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
 }
 
+static bool same_pci_device_functions(struct pci_dev *provider,
+				      struct pci_dev *client)
+{
+	return pci_physfn(provider) == pci_physfn(client);
+}
+
 /*
  * Calculate the P2PDMA mapping type and distance between two PCI devices.
  *
@@ -634,7 +640,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 
 	*dist = dist_a + dist_b;
 
-	if (!acs_cnt) {
+	if (!acs_cnt || same_pci_device_functions(provider, client)) {
 		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
 		goto done;
 	}
@@ -696,7 +702,9 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 		return -1;
 
 	for (i = 0; i < num_clients; i++) {
-		pci_client = find_parent_pci_dev(clients[i]);
+		pci_client = dev_is_pf(clients[i]) || dev_is_vf(clients[i]) ?
+				pci_dev_get(to_pci_dev(clients[i])) :
+				find_parent_pci_dev(clients[i]);
 		if (!pci_client) {
 			if (verbose)
 				dev_warn(clients[i],
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..a9b07a15f5aa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1183,6 +1183,7 @@ void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type);
 void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
+#define dev_is_vf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_virtfn : false))
 
 /* Generic PCI functions exported to card drivers */
 
-- 
2.45.1


