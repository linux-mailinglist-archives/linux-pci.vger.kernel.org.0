Return-Path: <linux-pci+bounces-35119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDBCB3BC48
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED031CC29CC
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6105C31E118;
	Fri, 29 Aug 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESErvJ61"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18E322777;
	Fri, 29 Aug 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473246; cv=none; b=XDTNamPzXk3WHIFjqn6EzteajhWrPloG40Xy4PnRnEtpzQx8kJWrmxsxdMPdVSbSKvXkw5iYwbNUcvJhGr2EUY77nU3r0tXMo4BBDNuyeF3m8f+qo1TtFA/HqiUceEXO++PzSI/QdhR2NdBTmVKnkcgAL9XpRvuwwmUPV7hpCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473246; c=relaxed/simple;
	bh=rA6JAfN7+EEsAzQMJHpQWq+E7QCPa259KkSycF6mlUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDBFU42pxVLyeK2RIXmNET+uoMSFZW7ve1q3hDqAltcyX2TF+1yKoNRxAZLeQFZEakhxGLlHitss8mmDwltZWSYf218DOtkEWOOg+kSaZ9ZWNra6c8P3Xo3yPbEXHneBNPz3L5j2FkTDcR914CI8RLsYbTgf88X9MGGultFGspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESErvJ61; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473245; x=1788009245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rA6JAfN7+EEsAzQMJHpQWq+E7QCPa259KkSycF6mlUA=;
  b=ESErvJ61zSFyEE6IhG6tsOmo7afrsVIwaAX3YZ7sEdPzA100/u7KBImy
   /GHTue1lSeYVneHD6A/aEVC3cwgfHQJpHH+Km1Jl0a8ScVC3+oxpsltV/
   LJ6H5Non2tasakHP3R6DjZysskI1KjgBL+PHznd1AONCewV7t57R3hXQm
   zUIMSCOLsm/6ASn3MhW8RfPSnD7/OvyXDQLlACGm004a56QNFOikqHR2o
   Dyea9tKMUqNhvnXVaaWe55q0+3SYD5OtNxcXri2wINjPGTUjkn7HYzmM5
   1xvrcq8mPHv1bt0bIHWkL2ba6fIoNvMXdulk0AgIquyWrBB83FbWu/C26
   g==;
X-CSE-ConnectionGUID: sg+e/xL6TR237sYrMNUIFw==
X-CSE-MsgGUID: Z4JWtOXmSmChmscCoPrKLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58905344"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58905344"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:14:05 -0700
X-CSE-ConnectionGUID: DEElf8zUQXmdt01whkNJKg==
X-CSE-MsgGUID: cyaA9DSiRqCOebetSvsqMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169680071"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:14:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 22/24] PCI: Add pci_setup_one_bridge_window()
Date: Fri, 29 Aug 2025 16:11:11 +0300
Message-Id: <20250829131113.36754-23-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_bridge_release_resources() contains a resource type hack to work
around the unsuitable __pci_setup_bridge() interface. Extract the
switch statement that picks the correct bridge window setup function
from pci_claim_bridge_resource() into pci_setup_one_bridge_window() and
use it also in pci_bridge_release_resources().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index cb91c6cb4d32..031ad682aca1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -953,6 +953,23 @@ static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
 }
 
+static void pci_setup_one_bridge_window(struct pci_dev *bridge, int resno)
+{
+	switch (resno) {
+	case PCI_BRIDGE_IO_WINDOW:
+		pci_setup_bridge_io(bridge);
+		break;
+	case PCI_BRIDGE_MEM_WINDOW:
+		pci_setup_bridge_mmio(bridge);
+		break;
+	case PCI_BRIDGE_PREF_MEM_WINDOW:
+		pci_setup_bridge_mmio_pref(bridge);
+		break;
+	default:
+		return;
+	}
+}
+
 void __weak pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
 {
 }
@@ -987,19 +1004,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 	if (pci_bus_clip_resource(bridge, i))
 		ret = pci_claim_resource(bridge, i);
 
-	switch (i) {
-	case PCI_BRIDGE_IO_WINDOW:
-		pci_setup_bridge_io(bridge);
-		break;
-	case PCI_BRIDGE_MEM_WINDOW:
-		pci_setup_bridge_mmio(bridge);
-		break;
-	case PCI_BRIDGE_PREF_MEM_WINDOW:
-		pci_setup_bridge_mmio_pref(bridge);
-		break;
-	default:
-		return -EINVAL;
-	}
+	pci_setup_one_bridge_window(bridge, i);
 
 	return ret;
 }
@@ -1839,11 +1844,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	if (ret)
 		return;
 
-	type = r->flags & PCI_RES_TYPE_MASK;
-	/* Avoiding touch the one without PREF */
-	if (type & IORESOURCE_PREFETCH)
-		type = IORESOURCE_PREFETCH;
-	__pci_setup_bridge(bus, type);
+	pci_setup_one_bridge_window(dev, PCI_BRIDGE_RESOURCES + idx);
 }
 
 enum release_type {
-- 
2.39.5


