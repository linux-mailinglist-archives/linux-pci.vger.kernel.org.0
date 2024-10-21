Return-Path: <linux-pci+bounces-14930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E631B9A59DD
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 07:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A821C208FA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 05:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E75319340D;
	Mon, 21 Oct 2024 05:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkReh8Oo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3D7462
	for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 05:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489568; cv=none; b=CtuTp8QwwhVl22ht9K/hZnSs8wkncPLlQdxcnwYE/6iLo7DFzl0tsfEXElb4lmioQi4DbBL9cq5ufL2LuNfRlLCFmwm/2mqvuAYfOE5WC8mV0HyGRG+AGEWw+dVn0oQJjj8dYbnpzbjcKGDJOW9dngYhg0GMAczedlruPDM5L+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489568; c=relaxed/simple;
	bh=uV5snUpY10mY+ieUbO0PLEKGL0amDrpA0hEcIDbiYHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSWVu5MICCC4MEyczyXO1xJ+ylX3Q9YGrgKXuG5S4cMM1cP4dSfORv56eCWdORwyInqSxWRLjz9bL0SgY7/JMBvwu2wA882F2oBKX8VksbU38I4nI4vONioWfgvk8JVDq1cN2ilOKjdVTeheqfQkQ9EEWwq12YcYiZfeJhNNGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkReh8Oo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729489567; x=1761025567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uV5snUpY10mY+ieUbO0PLEKGL0amDrpA0hEcIDbiYHY=;
  b=MkReh8OotBBxz0d84whsE4Hpi89f9Kd7pAayxcsEqUEFbcKz/UTriK3b
   m28A+/RDlatP6rxPrCg7y5e6mnzHHMspqJ5jUrCJ5OKQECwHpkpNFBY0f
   dW/Jtf9oLFjH1OA1kW4vOBLUpM0j3P1Ok+oMJSe4bY+YKav6bCm3kOKww
   /fnsuqHgpcvHhVcfDz18sHReN9BJotdAWP/v2qjtijP7Tj/3X6TcDoEQn
   4P1gYbDDwAgrsI4XjwSjrqOzFhVKlKqS8pplS+DYdMcAwBhboy6SPf7xG
   hlCvqCOIT6YkYfStO/xTRp+5JEFvgQPyciRqsyWSf8UeNpwD0lHWbuGrn
   w==;
X-CSE-ConnectionGUID: PI4wWdeWQkGv7ssih5lbQg==
X-CSE-MsgGUID: AVUk/ghdSU2WhwFDWxSoxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="40345939"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="40345939"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 22:46:06 -0700
X-CSE-ConnectionGUID: UcI3brXwTsOUey9oPpOkNQ==
X-CSE-MsgGUID: ER72puDBRjKLn/Fy7mxSSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="110180207"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 22:46:05 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for functions of same device
Date: Sun, 20 Oct 2024 22:21:29 -0700
Message-ID: <20241021052236.1820329-2-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241021052236.1820329-1-vivek.kasireddy@intel.com>
References: <20241021052236.1820329-1-vivek.kasireddy@intel.com>
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
pci_devs_are_p2pdma_compatible() to determine if the provider and
client belong to the same device and facilitate P2P DMA between
them by not enforcing the ACS check.

v2:
- Relax the enforcment of ACS check only for Intel GPU functions
  as they are P2PDMA compatible given the way the PF provisions
  the resources among multiple VFs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: <linux-pci@vger.kernel.org>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 drivers/pci/p2pdma.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4f47a13cb500..a230e661f939 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -535,6 +535,17 @@ static unsigned long map_types_idx(struct pci_dev *client)
 	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
 }
 
+static bool pci_devs_are_p2pdma_compatible(struct pci_dev *provider,
+					   struct pci_dev *client)
+{
+	if (provider->vendor == PCI_VENDOR_ID_INTEL) {
+		if (pci_is_vga(provider) && pci_is_vga(client))
+			return pci_physfn(provider) == pci_physfn(client);
+	}
+
+	return false;
+}
+
 /*
  * Calculate the P2PDMA mapping type and distance between two PCI devices.
  *
@@ -634,7 +645,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 
 	*dist = dist_a + dist_b;
 
-	if (!acs_cnt) {
+	if (!acs_cnt || pci_devs_are_p2pdma_compatible(provider, client)) {
 		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
 		goto done;
 	}
@@ -696,7 +707,9 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
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
2.45.1


