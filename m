Return-Path: <linux-pci+bounces-29310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE74AD342F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 12:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900AF3B0D9A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1D428D84E;
	Tue, 10 Jun 2025 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8tXEoui"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6521CFEC;
	Tue, 10 Jun 2025 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553110; cv=none; b=m+I8JNAeaHbZ9RT73eJsGlxRm3GcLBK78tWi0OHT1l7/6dka45c+hjA5XSd40UTtcYBjn6z5F7kkhf7fIa6KesXPA8PUlyj3CzNtAtxkYleQit9W6XkZ+7tRgypIOJk7yt0zKEvjNOw3QXT39Q4B2oCNur4gAJlWZe7Bu72iUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553110; c=relaxed/simple;
	bh=a4+81zQ8vV3QZgCtHHG/DA2BdXYdxERYc7wEaY++cd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pNx/YArHLRBtfbfsYkde2Efi0Ia6pxGVmhPZtD8p0ElxyD9zlThPIUOAbDTBd0rVlvp4Gw+3zsffmGuT8ZtpMNExHyyZ0dWEhPAxMTwuqOXQHXv3PnNalOcznBIVFsPxV2ipWOh4ciFEy6GqAmlmcOhmKMnFp5AoptOwpTzhx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8tXEoui; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749553109; x=1781089109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a4+81zQ8vV3QZgCtHHG/DA2BdXYdxERYc7wEaY++cd8=;
  b=f8tXEouiDINsC9XsQa3avpxAf2GQMsBFGTbauvP7UcW4+NXZWJOpalTS
   quyRYiun3XOpVTsO/B4Qx9Z+hMVrd4cEWPJ4MSsLE2AaXfwjXVT9X/FgO
   O+GMX3KKCbjYqtsfJ8LwegpdmomXftS8YFNofyPGPM/22tUMFWFM0HPXg
   R784HmTK2gSkAsyOX4lS3viYS3WHKMfhrcVyvfOLCdzS98lMDY9uc/fdF
   Ao7VHMs/+c2SDoMfPrdyZ/S5Cgz98QTRij8r5g5CrtU1dGK9IF7KVGt6r
   zrLVqydAmFhstwIHCqvZ7xD+5168PpB3KPKkGkskOyrLDpJzLs1F/O0ji
   A==;
X-CSE-ConnectionGUID: FIzXkLRoRn2pO6HFVIH/Cg==
X-CSE-MsgGUID: mr+PlbovRGenBAKIb5lMqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62270174"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="62270174"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:58:29 -0700
X-CSE-ConnectionGUID: AalOm7jGRUK7R51pQdZUeQ==
X-CSE-MsgGUID: EfCCZNN8QGyrM7wMoBNo6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="147163261"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:58:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] PCI: Use header type defines in pci_setup_device()
Date: Tue, 10 Jun 2025 13:58:18 +0300
Message-Id: <20250610105820.7126-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace literals with PCI_HEADER_TYPE_* defines in pci_setup_device().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..c00634e5a2ed 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1985,8 +1985,8 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->sysdata = dev->bus->sysdata;
 	dev->dev.parent = dev->bus->bridge;
 	dev->dev.bus = &pci_bus_type;
-	dev->hdr_type = hdr_type & 0x7f;
-	dev->multifunction = !!(hdr_type & 0x80);
+	dev->hdr_type = FIELD_GET(PCI_HEADER_TYPE_MASK, hdr_type);
+	dev->multifunction = FIELD_GET(PCI_HEADER_TYPE_MFD, hdr_type);
 	dev->error_state = pci_channel_io_normal;
 	set_pcie_port_type(dev);
 

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.39.5


