Return-Path: <linux-pci+bounces-2783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A77841F55
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 10:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF6E28E860
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D175C604C5;
	Tue, 30 Jan 2024 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6W9fy/1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C585257891
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606635; cv=none; b=hW7W/850/iuZPcu26mR7CgbVriz3/UnFZ+Uf6yIB2aU8PZEXExLTUB3dLfHAzg3NgbFyBxdIx7hcTDuz/EZqoHxlR391xDj9ySXiVYGrhUki26G6iImEZkscbhYmb8rylL7bKhLHVVhGfexmw5n33Tv+E81we0f56ovsSpa76cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606635; c=relaxed/simple;
	bh=6JmjlAh10q3aOYaRcDOCaKFrkNNigOHYiN88I3B3YjI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtCT/Mclumg6nPdZ3JHioKJ8CqL9uYKkL6dGYULSO0hTWEeLF6+4bgSiU3Qbuf/EJL+f2OwMGArHY8DSyAZuRhx/KeeQ1aqPuosJH3ommiErlTXafTurnsHxcHk6F4Xu/wAoehpP5gpG5nbNVrM8OsA4HJc4R/B9QexfB+Imn3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6W9fy/1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706606632; x=1738142632;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6JmjlAh10q3aOYaRcDOCaKFrkNNigOHYiN88I3B3YjI=;
  b=H6W9fy/1JvLWTDw5OvMwLhinjW5V8Qnen1CFrw6H1Cm4ULwPGoy5SEgc
   IbOmv5LLB2KTxRYZz18aR32r2sovRbFK3keYq3Nnrb30rCRgFN745SaGD
   mrTSzUQ82jjIaqsg1rIvvUreg62ZpAwSuyK8D6RMvKJ9/4ln1NpOv/YXu
   +WZ15ebs/z5VMvlrDkngR4ZTXacDwNvlQwgM9fJox8FCvqSNVpn5nJfDu
   D6/ZPlqzxvHulPs/dvllYYjBQR+kl/ccKZ/BYWjhk6N7VJeUo2PEWnkad
   z8AO8E+FqyO7PchBbQatn+sgp31cphUsAEoJXSkj2gHYCsaZ/f3D8YBQG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24699861"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="24699861"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:23:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3738922"
Received: from djayasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.72.104])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:23:52 -0800
Subject: [RFC PATCH 1/5] PCI/CMA: Prepare to interoperate with TSM
 authentication
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Date: Tue, 30 Jan 2024 01:23:51 -0800
Message-ID: <170660663177.224441.2104783746551322918.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

A TSM (TEE Security Manager) is a platform agent that facilitates TEE
I/O (device assignment for confidential VMs). It uses PCI CMA, IDE, and
TDISP to authenticate, encrypt/integrity-protect the link, and bind
device-virtual-functions capable of accessing private memory to
confidential VMs (TVMs).

Unlike native PCI CMA many of the details of establishing a connection
between a device (DSM) and the TSM are abstracted through platform APIs.
I.e. in the native case Linux picks the keys and validates the
certificates, in the TSM case Linux just sees a "success" from invoking
a "connect" API with the TSM.

SPDM only allows for one session-owner per transport (DOE), so the
expectation is that authentication will only ever be in the "native"
established case, or the "tsm" established case.

Convert the "authenticated" attribute to reflect {"none", "native"}
rather than {"0", "1"} in preparation for a follow-on {"none", "native",
"tsm"} possibility.

Note: Expect this patch gets folded into "PCI/CMA: Expose in sysfs
      whether devices are authenticated" and assume Linux never ships
      the binary authenticated ABI.

Cc: Wu Hao <hao.wu@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |   14 ++++++++------
 drivers/pci/cma.c                       |    7 ++++++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index bec7c197451e..35b0e11fd0e6 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -505,12 +505,14 @@ What:		/sys/bus/pci/devices/.../authenticated
 Date:		November 2023
 Contact:	Lukas Wunner <lukas@wunner.de>
 Description:
-		This file contains 1 if the device authenticated successfully
-		with CMA-SPDM (PCIe r6.1 sec 6.31).  It contains 0 if the
-		device failed authentication (and may thus be malicious).
-
-		Writing anything to this file causes reauthentication.
-		That may be opportune after updating the .cma keyring.
+		This file contains "native" if the device authenticated
+		successfully with CMA-SPDM (PCIe r6.1 sec 6.31). It contains
+		"none" if the device failed authentication (and may thus be
+		malicious).
+
+		Writing "native" to this file causes reauthentication with
+		kernel-selected keys and the kernel's certificate chain.  That
+		may be opportune after updating the .cma keyring.
 
 		The file is not visible if authentication is unsupported
 		by the device.
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index fb9bb5a637a5..be7d2bb21b4c 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -36,6 +36,9 @@ static ssize_t authenticated_store(struct device *dev,
 	    (pdev->cma_init_failed || pdev->doe_init_failed))
 		return -ENOTTY;
 
+	if (!sysfs_streq(buf, "native"))
+		return -EINVAL;
+
 	rc = pci_cma_reauthenticate(pdev);
 	if (rc)
 		return rc;
@@ -52,7 +55,9 @@ static ssize_t authenticated_show(struct device *dev,
 	    (pdev->cma_init_failed || pdev->doe_init_failed))
 		return -ENOTTY;
 
-	return sysfs_emit(buf, "%u\n", spdm_authenticated(pdev->spdm_state));
+	if (spdm_authenticated(pdev->spdm_state))
+		return sysfs_emit(buf, "native\n");
+	return sysfs_emit(buf, "none\n");
 }
 static DEVICE_ATTR_RW(authenticated);
 


