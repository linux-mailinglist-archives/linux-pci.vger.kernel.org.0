Return-Path: <linux-pci+bounces-14989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D299A9E04
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 11:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F3E1F23547
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 09:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D06198A39;
	Tue, 22 Oct 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qj5PGvVL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E1194C9E;
	Tue, 22 Oct 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588318; cv=none; b=RLnwVh2Y7pGAcz48bDuXXsLA9+vJAvglDOu3M7++eNe0+PJ+cHgfmPyRzx5zD/kUe6DCao1MtP3Bz+P9KVTxKzUfLUxhnSbznkvZHMRFCuGjHZ0P8nC8ZFS8jEHgGJnsQjIbxvwoFiX/UwA9jPUXLE4qO57S5oa9xEr9yKw6yFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588318; c=relaxed/simple;
	bh=SKDmrC6wxkBh0QMo8rcm+HsLNB4sdnUMvZwopu+gpCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UICsRtXsc32PuvcGH5ttkM/rDm6usm3mdfjHBIvv0JffVEbV3gKHQuGfb4ovtkdfH6SqBcKlkmaaDRZf1GdHvetbeg8IWQ7fD1sXiMo326I3Y0/c9hswbwOnPY9hMVKzuWAJ9if3CzTV+losgEqScZ2/J6k55/qo+lvvVurMzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qj5PGvVL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729588317; x=1761124317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SKDmrC6wxkBh0QMo8rcm+HsLNB4sdnUMvZwopu+gpCw=;
  b=Qj5PGvVLnCcYIBAkwL3ej7aDjVUI+XiS8geeeJWSfCXapjvEsxUE2tCy
   ZmIK+6duzIpnyoziGNgSBzgnULAgcAY0fNLd5jHcPAAlvTK5bkvl4HmAa
   tM+45iqSygsmmUZgCC33nFqCh64YWHwpNtrH+9gaB1mGjyRK8XFBdK9DK
   hLW4/oLNXegq9FMvZWVXG5jnhyv+Llpm7mUySiYq1fPK3bXYppsGHN7XS
   dg4dnQwAvSK7EhWWi8F5PCwbiP8CpBs6Utr0qOJYSMmJOX1r56U/jhKiL
   B25TE5tcSk/nYizeimVYZZzAGYHSsrYqccol/1S/KzPV3K9JliaRec5x/
   w==;
X-CSE-ConnectionGUID: HAhCNeqwTmSC5Y7vkAuDhQ==
X-CSE-MsgGUID: 1qNBjOsOSka/DaVMHB7uww==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28885654"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28885654"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:11:57 -0700
X-CSE-ConnectionGUID: Im9MGC4zTW+5l/RHao6Q4g==
X-CSE-MsgGUID: g3viHYcdQfan0VTNUcCnVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80157937"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:11:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/4] PCI: cpqphp: Fix PCIBIOS_* return value confusions
Date: Tue, 22 Oct 2024 12:11:37 +0300
Message-Id: <20241022091140.3504-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022091140.3504-1-ilpo.jarvinen@linux.intel.com>
References: <20241022091140.3504-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Code in and related to PCI_RefinedAccessConfig() has 3 types of return
type confusion:
 - PCI_RefinedAccessConfig() tests pci_bus_read_config_dword() return
   value against -1.
 - PCI_RefinedAccessConfig() returns both -1 and PCIBIOS_* return codes.
 - Callers of PCI_RefinedAccessConfig() only test for -1.

Make PCI_RefinedAccessConfig() return PCIBIOS_* codes consistently and
adapt callers accordingly.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/cpqphp_pci.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 718bc6cf12cb..974c7db3265b 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -135,11 +135,13 @@ int cpqhp_unconfigure_device(struct pci_func *func)
 static int PCI_RefinedAccessConfig(struct pci_bus *bus, unsigned int devfn, u8 offset, u32 *value)
 {
 	u32 vendID = 0;
+	int ret;
 
-	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &vendID) == -1)
-		return -1;
+	ret = pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &vendID);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
 	if (PCI_POSSIBLE_ERROR(vendID))
-		return -1;
+		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_read_config_dword(bus, devfn, offset, value);
 }
 
@@ -202,13 +204,15 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
 {
 	u16 tdevice;
 	u32 work;
+	int ret;
 	u8 tbus;
 
 	ctrl->pci_bus->number = bus_num;
 
 	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
 		/* Scan for access first */
-		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
+		ret = PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work);
+		if (ret)
 			continue;
 		dbg("Looking for nonbridge bus_num %d dev_num %d\n", bus_num, tdevice);
 		/* Yep we got one. Not a bridge ? */
@@ -220,7 +224,8 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
 	}
 	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
 		/* Scan for access first */
-		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
+		ret = PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work);
+		if (ret)
 			continue;
 		dbg("Looking for bridge bus_num %d dev_num %d\n", bus_num, tdevice);
 		/* Yep we got one. bridge ? */
-- 
2.39.5


