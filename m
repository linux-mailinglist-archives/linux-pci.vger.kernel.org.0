Return-Path: <linux-pci+bounces-43437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB19CD150B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 19:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 645BE300EA38
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEFB34D3A6;
	Fri, 19 Dec 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOUWxROk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E5C349B1B;
	Fri, 19 Dec 2025 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166231; cv=none; b=s+Ex8ZCjAVewCTkgq6QoyqfaQVgmJoSsEd5FLW4E86N0A+nUoh6BvcdLLAwEjZKCKvrgulsCreRps89LNQvytqGmH71DxVPZutE/OrClSa7UNCQ93HXdGYop0cAc1F9XDQKJENYpYzL4cFcGiOZ91CpiqeydBX7IVtema+xxE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166231; c=relaxed/simple;
	bh=LKgq5POWoOr2QKvv6yIIviBYjXFtIsOiSs27ptwH+H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3uDuOBdhiGUF0oKM+0Hi4HZCh9OdgJ3le0dMdyINBzRSfk5Q4ajKmuYj4RXiHiHXwQVim7JAj0YbmUC/ThiDTfnTJM5EnuCzIQpKO6D2ediMhDqdfmU7xFWYLVYjB/i3Jw53iUSdhINWkol9HaNweUCrM9aMNPaJZLGVmkM5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOUWxROk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166230; x=1797702230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKgq5POWoOr2QKvv6yIIviBYjXFtIsOiSs27ptwH+H4=;
  b=ZOUWxROkVr3cB/hbdm9LoAAUbmvOpnxJLUzUVHZd0nFPG5DAIaExcpnl
   sPyl91N6Ne8dtq91/Ab/CboPM2IvRZt7fREOW+diTsqFzpupSVDIrTlIX
   vPYS9bL/7tWZGR6czafdXE5xvrRzv+WP1l9J5O0UnfDLi6s5GRWaXjOaA
   boDiiaUZhtRLaIb2E+XPGE5gjGaoJAoJLr/hKyBMLbJ/XhIZY4B/QTdpI
   xBkw3bTTt51T92pH+il5cPfmJ7hyqeM/agyyul2p+SjIlAqiiKLSeNVCe
   OmimCq274DaA11uf7CG4M5Bu/u11XKrSIN0+aqkJUojnIPjNTi+6LWUi4
   w==;
X-CSE-ConnectionGUID: 2tTtwlSsRY+35OzxWP3GRA==
X-CSE-MsgGUID: 0Diz3iLzQ6Gr7e/FHFbTXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68174101"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68174101"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:46 -0800
X-CSE-ConnectionGUID: EIl401OETwWVSgvtYBSxRg==
X-CSE-MsgGUID: RwHcTT/RS2K8Zu+4+TFFbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="203072226"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 22/23] PCI: Add pbus_validate_busn() for Bus Number validation
Date: Fri, 19 Dec 2025 19:40:35 +0200
Message-Id: <20251219174036.16738-23-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_scan_bridge_extend() validates bus numbers but upcoming changes
that separate CardBus code into own function need to call that the
same validation.

Thus, add pbus_validate_busn for validating the Bus Numbers.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h   |  1 +
 drivers/pci/probe.c | 33 +++++++++++++++++++++------------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index dbea5db07959..b20ff7ef20ff 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -501,6 +501,7 @@ static inline int pci_resource_num(const struct pci_dev *dev,
 	return resno;
 }
 
+void pbus_validate_busn(struct pci_bus *bus);
 struct resource *pbus_select_window(struct pci_bus *bus,
 				    const struct resource *res);
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1781a0a39f4a..49468644e730 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1314,6 +1314,26 @@ static void pci_enable_rrs_sv(struct pci_dev *pdev)
 
 static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 					      unsigned int available_buses);
+
+void pbus_validate_busn(struct pci_bus *bus)
+{
+	struct pci_bus *upstream = bus->parent;
+	struct pci_dev *bridge = bus->self;
+
+	/* Check that all devices are accessible */
+	while (upstream->parent) {
+		if ((bus->busn_res.end > upstream->busn_res.end) ||
+		    (bus->number > upstream->busn_res.end) ||
+		    (bus->number < upstream->number) ||
+		    (bus->busn_res.end < upstream->number)) {
+			pci_info(bridge, "devices behind bridge are unusable because %pR cannot be assigned for them\n",
+				 &bus->busn_res);
+			break;
+		}
+		upstream = upstream->parent;
+	}
+}
+
 /**
  * pci_ea_fixed_busnrs() - Read fixed Secondary and Subordinate bus
  * numbers from EA capability.
@@ -1579,18 +1599,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		  (is_cardbus ? "PCI CardBus %04x:%02x" : "PCI Bus %04x:%02x"),
 		  pci_domain_nr(bus), child->number);
 
-	/* Check that all devices are accessible */
-	while (bus->parent) {
-		if ((child->busn_res.end > bus->busn_res.end) ||
-		    (child->number > bus->busn_res.end) ||
-		    (child->number < bus->number) ||
-		    (child->busn_res.end < bus->number)) {
-			dev_info(&dev->dev, "devices behind bridge are unusable because %pR cannot be assigned for them\n",
-				 &child->busn_res);
-			break;
-		}
-		bus = bus->parent;
-	}
+	pbus_validate_busn(child);
 
 out:
 	/* Clear errors in the Secondary Status Register */
-- 
2.39.5


