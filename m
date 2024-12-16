Return-Path: <linux-pci+bounces-18550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6C19F3858
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A152A7A68B0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC3212B3E;
	Mon, 16 Dec 2024 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXu2VPbE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24CF212B24;
	Mon, 16 Dec 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371934; cv=none; b=lsRr0qzQo2SWkxNX4VcDxQIPseuLxnr7K0qVBQE1rECJvqrs7hFjmyIbfdESElJH4XCKhKrGEFeb0fWRvqJLjQ56KULdSsDtgjssx5crp7cWslt02kYhuijdntb+op9I9P6qZNob/b0S0oFGVo26AMomNmuO0G9ngFjNNjSw2eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371934; c=relaxed/simple;
	bh=qxjdLtGg9wi8sOhMm2LUb34fwpRe2kP0942VB67C8fY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUiu710SrbrfPWTbJsyhXTqIYpuunHEIw13TspxtCzrqHJfnOh0bxGoIyLpETPlb5LH0PeZDD+Yn36iu8vwp+iXgY/ly6ZZ1La+NWN+AA+uAmF5+0Mngmdg+UvUxM7ofsqLxqP/FQWx7yymSnMGj2eL2/QzdKT7Gq8oKOo+mrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXu2VPbE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371933; x=1765907933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qxjdLtGg9wi8sOhMm2LUb34fwpRe2kP0942VB67C8fY=;
  b=MXu2VPbEG8PrnpHo1JVvcPV8P/33XRbzWcrP6VTbc3VsGwTIW93fg7uH
   /QjNPNprcJVDo5usyzvfPgP5yia4/ioAF5cK13hL4tmdFgdQZvM5HUsUt
   z0RizgJZMR/fMCbaUJeeTizhgB+muF/qvZCy0FWz4RdLoZS4R+QEsZYUT
   +Bht5Z/65G2U8Xa920IKePQVsAJAyWbCq4VdhdVqLvjqaKmwWafOsqh8V
   aoVgG99zZWQax8WmJPPDhkLm7WbwPPmgxo44LeCz4KghUfcHn70BYW5i0
   YF9VnhGxashIMze/1EqjHst7benjXb02bT6gncJfU5fi5ow0dEX4h7iZh
   A==;
X-CSE-ConnectionGUID: pVIdbCpiTi+lrT6jCGV7Vg==
X-CSE-MsgGUID: YZAZMuVlTv6jg6/IcBojSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57251024"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="57251024"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:47 -0800
X-CSE-ConnectionGUID: M8Wh41GbT8Orn+vw8ctELA==
X-CSE-MsgGUID: /5k4MtgmRIqxGUnEsPqVdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101419085"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 15/25] PCI: Rename retval to ret
Date: Mon, 16 Dec 2024 19:56:22 +0200
Message-Id: <20241216175632.4175-16-ilpo.jarvinen@linux.intel.com>
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

Rename 'retval' to 'ret' in pci_assign_unassigned_bridge_resources().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bbe3472cfba9..38dbe8b99910 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2256,11 +2256,10 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 	struct pci_bus *parent = bridge->subordinate;
 	/* List of resources that want additional resources */
 	LIST_HEAD(add_list);
-
 	int tried_times = 0;
 	LIST_HEAD(fail_head);
 	struct pci_dev_resource *fail_res;
-	int retval;
+	int ret;
 
 	while (1) {
 		__pci_bus_size_bridges(parent, &add_list);
@@ -2317,9 +2316,9 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 		free_list(&fail_head);
 	}
 
-	retval = pci_reenable_device(bridge);
-	if (retval)
-		pci_err(bridge, "Error reenabling bridge (%d)\n", retval);
+	ret = pci_reenable_device(bridge);
+	if (ret)
+		pci_err(bridge, "Error reenabling bridge (%d)\n", ret);
 	pci_set_master(bridge);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
-- 
2.39.5


