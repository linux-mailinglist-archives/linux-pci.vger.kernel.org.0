Return-Path: <linux-pci+bounces-6776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6452D8B55C1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97061B2327F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CA3B1AB;
	Mon, 29 Apr 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcPGcGF9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4333B295;
	Mon, 29 Apr 2024 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387690; cv=none; b=Fo8xaF7NZOTe4+tLpbh0O04/FGYViDgvCL5iWSG1SWmgh4apdDvTfsi7NjGmLReqYfCDftN+woUDScSYeOxsDpNNJMH5y2pQq1vQ9P/0Eg6yleyJngTHFRVg3JHwXyIbU6Np0xvAZ/jWJUfiftaG0eHKTNC3P7CFwSbt4b/SVt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387690; c=relaxed/simple;
	bh=tqeeFaSWoH51snX4RlgEW30pWGpLH600kN4A4Ggy4L8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hf2UN4kjXEF7pdy8wQzRkvrV22YG5Fj/bacgfrp8sVGBUm4ECATTDqiQ/BoD+ndL2tI7koiv9lbClS39MpaXBJvt8ovqXI+JgI4htvjvXXnqDIB4ly5K5QhGRCHkS6bXNOkNHuqOYTxNH39v5pGdK1ZDOwVjPAYirltqTfh5oUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcPGcGF9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387689; x=1745923689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tqeeFaSWoH51snX4RlgEW30pWGpLH600kN4A4Ggy4L8=;
  b=KcPGcGF9gq8eaRkOL5XfzW6QnWGV8QPdZjZIlY5gpBQQBmRhYbdiY88G
   Igbdu0CGzbKzaDUzy/eG9o4ILTiOFspq3SS4NU9qc2wyK0UuZIT2MyGiV
   jyKhAyJq2EDrZ+g1PI/IScg/0iVGAKWFLAx6xaQlaps1RszUsEjhV/2K4
   8bx3EkVzZCsiB7R5O6DsdHOoS9X+xvOXqGOj4azgfsx55C3YQvNjZyZpT
   CujcKdF8/8dtRt8vkFAUeWGnFbtNjfobVj4ZZ4HFTX1czxfdKwTu2DGW1
   a6Oqgd9giaVURRBRG7v66XOFMDB3GhVznGdy1lYLtRD/pphMA+frX4m5N
   A==;
X-CSE-ConnectionGUID: i4XZuEK3QheesmEM+KMfIw==
X-CSE-MsgGUID: vpFNrnG4SLy+Q+h7PEsUPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27559079"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="27559079"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:48:08 -0700
X-CSE-ConnectionGUID: bOPtYgLLRmirNCTAizYk1Q==
X-CSE-MsgGUID: 0IPQ+Z+tQTiB4Q/+A6EYGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30896807"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:48:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/10] PCI: mvebu: Use generic PCI Conf Type 1 helper
Date: Mon, 29 Apr 2024 13:46:32 +0300
Message-Id: <20240429104633.11060-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert mvebu to use the pci_conf1_ext_addr() helper from PCI core
to calculate PCI Configuration Space address for Type 1 access.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pci-mvebu.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 29fe09c99e7d..1908754ee6fd 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -45,15 +45,6 @@
 #define PCIE_WIN5_BASE_OFF	0x1884
 #define PCIE_WIN5_REMAP_OFF	0x188c
 #define PCIE_CONF_ADDR_OFF	0x18f8
-#define  PCIE_CONF_ADDR_EN		0x80000000
-#define  PCIE_CONF_REG(r)		((((r) & 0xf00) << 16) | ((r) & 0xfc))
-#define  PCIE_CONF_BUS(b)		(((b) & 0xff) << 16)
-#define  PCIE_CONF_DEV(d)		(((d) & 0x1f) << 11)
-#define  PCIE_CONF_FUNC(f)		(((f) & 0x7) << 8)
-#define  PCIE_CONF_ADDR(bus, devfn, where) \
-	(PCIE_CONF_BUS(bus) | PCIE_CONF_DEV(PCI_SLOT(devfn))    | \
-	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where) | \
-	 PCIE_CONF_ADDR_EN)
 #define PCIE_CONF_DATA_OFF	0x18fc
 #define PCIE_INT_CAUSE_OFF	0x1900
 #define PCIE_INT_UNMASK_OFF	0x1910
@@ -361,7 +352,7 @@ static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 
 	conf_data = port->base + PCIE_CONF_DATA_OFF;
 
-	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
+	mvebu_writel(port, pci_conf1_ext_addr(bus->number, devfn, where, true),
 		     PCIE_CONF_ADDR_OFF);
 
 	switch (size) {
@@ -397,7 +388,7 @@ static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
 
 	conf_data = port->base + PCIE_CONF_DATA_OFF;
 
-	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
+	mvebu_writel(port, pci_conf1_ext_addr(bus->number, devfn, where, true),
 		     PCIE_CONF_ADDR_OFF);
 
 	switch (size) {
-- 
2.39.2


