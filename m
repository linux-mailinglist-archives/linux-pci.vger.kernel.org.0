Return-Path: <linux-pci+bounces-34591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B2EB31D75
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD081C84B9A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9703451CE;
	Fri, 22 Aug 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egxSwexT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76405343D98;
	Fri, 22 Aug 2025 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874784; cv=none; b=IjJs9DKyXbYFKWvQjzzEIcdQhBOdlEqknTsHv/1/138VqA/Sc6zt4/HiR/JPgGkrkiWCKUkZxhwN8yhw2qdzhHZteZieQhjGQizG4yNu5y+zT39H1wJOYVmlVI4DULKbuOJS53PgiI6eDF8EDI/yR4rGSLq9oTt8bhF9b1InF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874784; c=relaxed/simple;
	bh=HTxHAiNuvyuD34kLb+03Rz07JtALaQ3E9pcuMeDZoEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLz/8dUF4NmDoiM26s6SIkADUKJMr+wMPn5sZr7aBSLY8+POhRGCd8c79Y6/ZVJ6cIdwXp4mFA9x9fVgRkHJX9FCmtSww2StBI9cFsd+PQ7Zcjcly9fZ1RnG9ROlefk7D36EwjBc3Vjv6iSWi7kwYpFQZo0K2bt0m6hpIVWRlKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egxSwexT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874784; x=1787410784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTxHAiNuvyuD34kLb+03Rz07JtALaQ3E9pcuMeDZoEE=;
  b=egxSwexTshS15NVuSKQ7h9aupKsw6nWFFQyvpaV2ADiF721uWhW3NI7l
   nnUmZdPwBUe0MjVbuB7I+vDIc/6fJO++WvqC/pTLczr4G+UO/N9gcUTBv
   Vc3Rm/WvKOPdWoOP6xoSaEnx5ckH2AjfcjGTZ51NZdbQDy9lW++PkOwTN
   XX5NS23RLkWSmZJkXhRwhJM+aD8iBZ3EqQT3Md/dagwqSmViwzPDhyU99
   aYwTiXrYI4PD2mFYIBBAqlub/QH1/oufYpgJoqV4xxAgFt/BSs3EEgv+x
   3GpFl3UyN+VeWlBvAGa+NZynjzQm71nC+cVmzNePdAcAp9SNqiyFwNUYc
   A==;
X-CSE-ConnectionGUID: eGRF8F5DQ6WqOVMbGfPwJg==
X-CSE-MsgGUID: raz9YQbWQiyr5TYICPpJcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="75640737"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="75640737"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:59:44 -0700
X-CSE-ConnectionGUID: iZNsZnZnSe2zaHcSW5F1PA==
X-CSE-MsgGUID: s8iZ9QfNSsyPmEDxoDG8qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172986954"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:59:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 22/24] PCI: Add pci_setup_one_bridge_window()
Date: Fri, 22 Aug 2025 17:56:03 +0300
Message-Id: <20250822145605.18172-23-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
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
 drivers/pci/setup-bus.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ece533181ff1..f5b0274bde0a 100644
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
@@ -1839,10 +1844,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	if (ret)
 		return;
 
-	/* Avoiding touch the one without PREF */
-	if (type & IORESOURCE_PREFETCH)
-		type = IORESOURCE_PREFETCH;
-	__pci_setup_bridge(bus, type);
+	pci_setup_one_bridge_window(dev, PCI_BRIDGE_RESOURCES + idx);
 }
 
 enum release_type {
-- 
2.39.5


