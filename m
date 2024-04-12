Return-Path: <linux-pci+bounces-6176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F38A2A2D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 11:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC118289FE0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89D4C3C3;
	Fri, 12 Apr 2024 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pf1PIvGb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF857863
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911923; cv=none; b=tw8u/BW+HVZmz9Dv4pSCknvRGC6bnkpYvBJXJaSJKPqgKZ8tx1MZWi3Y+u4mePhs9pvo0u7PH4Z6bfjdudA+FQxSKVDBToWnyYJ7FuSoPaP3O5aOp4AKEiHjS5rcJUhALOAGTtWbhMjvyR9ZNeW1ALisJfW/ITSsGmpHFygHIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911923; c=relaxed/simple;
	bh=UP+adu8/nViP0lk+cufiCPLixKjByMxjsnwQPd0RqKg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCmq8L0AIMwGyoBAG3YzRmpEXQtAe++TAHI4tXRlr2s8g+FrU324Z5LgUThS9JLhl3Y4Q8jjbvPheCa4kpTVGHcqX6dIIplyKUh1VQsSS3SkXwyRvQ70rSBEANg9OjbEyJwmotTU50/lhfdstOUcnjwUhANpWwEEjEEeKhwEjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pf1PIvGb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712911923; x=1744447923;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UP+adu8/nViP0lk+cufiCPLixKjByMxjsnwQPd0RqKg=;
  b=Pf1PIvGbSyIbQnK3h3bijbLCuY7YHmKtG3+JQ2mq4dQfvMg+eO1zjncB
   Jzp6Fq31/F0wpSXVpF/ocHEKWY8IouLJbJHkjJjpBVwReuooKwhSHMPC+
   AkkNy5Bt2xBA8WTr7a/4AQS/VPhY1/nGIsLcBDqRFcPcaGIP1Yg20JLN8
   cF1aNW1nbezuDh3t372uM4nPe1xiyY9TvmfHC4yfCQj8VAmxEL1YJ4rPJ
   gwk+91SW6hGusvmKmA3SZNWuoMF6gKErIQ9leD0M2Cb0+kH5gIB8ZXnBU
   iHOa79O/7mZm8P8rm9YtY08xvqqJ2xX0SPa8mGqJ+hQvIO5u1GjbgxQa6
   A==;
X-CSE-ConnectionGUID: RysSmZb5SgmworfTp14tTA==
X-CSE-MsgGUID: yaljyupnSyaLiPaHdGFFgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8468341"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8468341"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:52:02 -0700
X-CSE-ConnectionGUID: cg8Rj2L4QAyxQ+w/ik+Ajw==
X-CSE-MsgGUID: yJzBSvg9RQKWLBIXAH6nOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21226738"
Received: from aclausch-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.15.202])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:52:02 -0700
Subject: [RFC PATCH v2 3/6] x86/tdx: Introduce a "tdx" subsystem and "tsm"
 device
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: bhelgaas@google.com, kevin.tian@intel.com, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, lukas@wunner.de
Date: Fri, 12 Apr 2024 01:52:01 -0700
Message-ID: <171291192122.3532867.1355052748039000203.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

TDX depends on a platform firmware module that is invoked via
instructions similar to vmenter (i.e. enter into a new privileged
"root-mode" context to manage private memory and private device
mechanisms). It is a software construct that depends on the CPU vmxon
state to enable invocation of TDX-module ABIs. Unlike other
Trusted Execution Environment (TEE) platform implementations that employ
a firmware module running on a PCI device with an MMIO mailbox for
communication, TDX has no hardware device to point to as the "TSM".

The "/sys/devices/virtual" hierarchy is intended for "software
constructs which need sysfs interface", which aligns with what TDX
needs.

The new tdx_subsys will export global attributes populated by the
TDX-module "sysinfo". A tdx_tsm device is published on this bus to
enable a typical driver model for the low level "TEE Security Manager"
(TSM) flows that talk TDISP to capable PCIe devices.

For now, this is only the base tdx_subsys and tdx_tsm device
registration with attribute definition and TSM driver to follow later.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c |   63 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4d6826a76f78..e23bddf31daa 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -28,6 +28,8 @@
 #include <linux/acpi.h>
 #include <linux/suspend.h>
 #include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/cleanup.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -1097,9 +1099,56 @@ static int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+static const struct bus_type tdx_subsys = {
+	.name = "tdx",
+};
+
+struct tdx_tsm {
+	struct device dev;
+};
+
+static struct tdx_tsm *alloc_tdx_tsm(void)
+{
+	struct tdx_tsm *tsm = kzalloc(sizeof(*tsm), GFP_KERNEL);
+	struct device *dev;
+
+	if (!tsm)
+		return ERR_PTR(-ENOMEM);
+
+	dev = &tsm->dev;
+	dev->bus = &tdx_subsys;
+	device_initialize(dev);
+
+	return tsm;
+}
+
+DEFINE_FREE(tdx_tsm_put, struct tdx_tsm *,
+	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+static struct tdx_tsm *init_tdx_tsm(void)
+{
+	struct device *dev;
+	int ret;
+
+	struct tdx_tsm *tsm __free(tdx_tsm_put) = alloc_tdx_tsm();
+	if (IS_ERR(tsm))
+		return tsm;
+
+	dev = &tsm->dev;
+	ret = dev_set_name(dev, "tdx_tsm");
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = device_add(dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return no_free_ptr(tsm);
+}
+
 static int init_tdx_module(void)
 {
 	struct tdx_tdmr_sysinfo tdmr_sysinfo;
+	struct tdx_tsm *tsm;
 	int ret;
 
 	/*
@@ -1122,10 +1171,15 @@ static int init_tdx_module(void)
 	if (ret)
 		goto err_free_tdxmem;
 
+	/* Establish subsystem for global TDX module attributes */
+	ret = subsys_virtual_register(&tdx_subsys, NULL);
+	if (ret)
+		goto err_free_tdxmem;
+
 	/* Allocate enough space for constructing TDMRs */
 	ret = alloc_tdmr_list(&tdx_tdmr_list, &tdmr_sysinfo);
 	if (ret)
-		goto err_free_tdxmem;
+		goto err_unregister_subsys;
 
 	/* Cover all TDX-usable memory regions in TDMRs */
 	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &tdmr_sysinfo);
@@ -1149,6 +1203,11 @@ static int init_tdx_module(void)
 
 	pr_info("%lu KB allocated for PAMT\n", tdmrs_count_pamt_kb(&tdx_tdmr_list));
 
+	/* Register 'tdx_tsm' for driving optional TDX Connect functionality */
+	tsm = init_tdx_tsm();
+	if (IS_ERR(tsm))
+		pr_err("failed to initialize TSM device (%pe)\n", tsm);
+
 out_put_tdxmem:
 	/*
 	 * @tdx_memlist is written here and read at memory hotplug time.
@@ -1177,6 +1236,8 @@ static int init_tdx_module(void)
 	tdmrs_free_pamt_all(&tdx_tdmr_list);
 err_free_tdmrs:
 	free_tdmr_list(&tdx_tdmr_list);
+err_unregister_subsys:
+	bus_unregister(&tdx_subsys);
 err_free_tdxmem:
 	free_tdx_memlist(&tdx_memlist);
 	goto out_put_tdxmem;


