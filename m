Return-Path: <linux-pci+bounces-34580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F63B31DA8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DC96068EF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582131352D;
	Fri, 22 Aug 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTStVWHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FC1313552;
	Fri, 22 Aug 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874683; cv=none; b=Id5OKt8jSzP5hNS1SAuLytu9rRpE4rDvkTIRHczqbe0RRCQ/rCugR0Y/ZveCrzalw8o0F2lYGnvdiIGHHiDtHDWL4NQSkNkGbL44MLmYyDPf/FWsEYTBMfhm1jbhnBlthjZwzwhG3B88JNQOy/PImPdv/99FLuTIpjFITRcluDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874683; c=relaxed/simple;
	bh=nKDUWjSDj08uKyvTX9DBKESYugIunl4wAuN3dhOg4bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+B+mc6h+oBNOu6FxQGFgNUT5gJ2i3WLBPjqCIMUqXfJCYR19+ICCWvk87y02zzJqtrSyWjanVjaLiuLqE5pB+wvXS0yu6w3BsqfnnrZ9jila5kEdyht0YcaVIjhBu76q7IOMhXDJNYNBvJ6+uSSbMS8cwIqtDu9NZn0lsfBQnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTStVWHs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874681; x=1787410681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nKDUWjSDj08uKyvTX9DBKESYugIunl4wAuN3dhOg4bY=;
  b=LTStVWHs5GQ1Du/aFIIuUItNXjuhalqPmF9OSkY8L6tYx08A9VnULVcJ
   9T+HFEsccIQutkLf//B+dmJMZ7w7v9YJbTkh9elZiG2wjH56DYFAbYrWi
   cvIsqNP0mmsNIr76O2WErXfXljsWtGK0wj5RNT58cYwZjIhR3H9WImfu6
   DkkP6Y4EPECYoLDTOm8Z9GKiDqpj9lfOHNq5a1oJ9P6CyC4Qeg1knWv0p
   z+hxM+JSLZbnvfFuNSheehv56UlaEZgbxPJW5emU4+x06l8mF4O+cf7Kk
   Tf31223tAgOGize9ZlGbo0ZGPrnVxCB3YiD/3oCYkyysI7np5ok9vaht3
   w==;
X-CSE-ConnectionGUID: u/oUO8feRRW8tJQUY1kA8w==
X-CSE-MsgGUID: 8A+jIZkrRUKOnpEwqldvQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57201412"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57201412"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:57:59 -0700
X-CSE-ConnectionGUID: C0xJ1+zrQqykpRB+mZXlLg==
X-CSE-MsgGUID: wUiykzbVSkaqn73XadpgDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168920545"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:57:54 -0700
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
Subject: [PATCH 11/24] PCI: Add defines for bridge window indexing
Date: Fri, 22 Aug 2025 17:55:52 +0300
Message-Id: <20250822145605.18172-12-ilpo.jarvinen@linux.intel.com>
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

include/linux/pci.h provides PCI_BRIDGE_{IO,MEM,PREF_MEM}_WINDOW
defines, however, they're based on the resource array indexing in the
pci_dev struct. The struct pci_bus also has pointers to those same
resource but they start from zeroth index.

Add PCI_BUS_BRIDGE_{IO,MEM,PREF_MEM}_WINDOW defines to get rid of
literal indexing.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h   |  4 ++++
 drivers/pci/probe.c | 10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e..1dc8a8066761 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -81,6 +81,10 @@ struct pcie_tlp_log;
 #define PCIE_MSG_CODE_DEASSERT_INTC	0x26
 #define PCIE_MSG_CODE_DEASSERT_INTD	0x27
 
+#define PCI_BUS_BRIDGE_IO_WINDOW	0
+#define PCI_BUS_BRIDGE_MEM_WINDOW	1
+#define PCI_BUS_BRIDGE_PREF_MEM_WINDOW	2
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f31d27c7708a..eaeb66bec433 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -598,9 +598,13 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
-	pci_read_bridge_io(child->self, child->resource[0], false);
-	pci_read_bridge_mmio(child->self, child->resource[1], false);
-	pci_read_bridge_mmio_pref(child->self, child->resource[2], false);
+	pci_read_bridge_io(child->self,
+			   child->resource[PCI_BUS_BRIDGE_IO_WINDOW], false);
+	pci_read_bridge_mmio(child->self,
+			     child->resource[PCI_BUS_BRIDGE_MEM_WINDOW], false);
+	pci_read_bridge_mmio_pref(child->self,
+				  child->resource[PCI_BUS_BRIDGE_PREF_MEM_WINDOW],
+				  false);
 
 	if (!dev->transparent)
 		return;
-- 
2.39.5


