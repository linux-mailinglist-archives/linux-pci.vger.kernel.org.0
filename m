Return-Path: <linux-pci+bounces-23639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890F2A5F7EA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0785619C3BDD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A667267B9C;
	Thu, 13 Mar 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTjMwdTG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F1267B9A;
	Thu, 13 Mar 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875852; cv=none; b=f/gdgsPY7f8OCS6JyomjH7h9wB8zeNCO48ph7PD0rPe3k/P+mPHb9fOk/9TMZAKXSJS2YLz+ORrfJwtiwtJyVVkChbOEMINL53etCPYYydDI0HQuBF/ZiBKJBs6NMs16Hd8pE9HCdT07NnQ0B/qPV2YxzzN9ZmKykMmaV8CLgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875852; c=relaxed/simple;
	bh=Q/hARVlIDQ7wvoTPwqEz66axIZ5MlN2sqEe7w/dugaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPUWLFwZzv4apaDpZtWZhdUuz2P6Z5ByNyw2DlbWsBdCJKaETJQhq6IkrnhJvkXjVfgLggXMrRSwHN/UuKqsWC4MFXNd/qyq8yC5iIHw/yNVlqIr8uruG4tK9kQmx/eMHG8HiCcBKZuf21aGoKfClst4P+HO5keY9PF6/iqRprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTjMwdTG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741875851; x=1773411851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q/hARVlIDQ7wvoTPwqEz66axIZ5MlN2sqEe7w/dugaY=;
  b=fTjMwdTG1L0/6TBzaivmvBFsG90xqAaqvpOIAOZAENGbytE3xF/fvR0u
   z8iy4ULEFYOok5Z6lfViiwbwYBknCbtsYLWCQw1UiaeKmYmWRvm6X1jue
   rdOF+4sF4BCwA2MVSwjktmTPnRPsjlokt8edUwAWZxeOQt2CmW266CImg
   LO+Qderc3SVcOhJS8k3cPnaDX7rRnPxJ9lsGuFxLFZeYjVmP46CO/mDQ0
   TSaPypc9Q/syBVDCvcIachi5qkKT4SZGQteQuwCgQs2bqepgZun/kkE0q
   +bvXPIiVkt+zl3MB1YbSgtAsSNIy/LDYdcIONC24Ud6HU8zV61DlszYHv
   Q==;
X-CSE-ConnectionGUID: s8eEGxRWQuSreRXEBe2wZg==
X-CSE-MsgGUID: dD6n79AYTo6B8td4XfSyMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43173562"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43173562"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:24:10 -0700
X-CSE-ConnectionGUID: 2WqtBt/zR6mt+8n4R/qu2w==
X-CSE-MsgGUID: rQcfhDgWSsipDlTGBKLqIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126027390"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:24:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Guenter Roeck <groeck@juniper.net>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/4] PCI/hotplug: Clearing HPIE for the duration of reset is enough
Date: Thu, 13 Mar 2025 16:23:31 +0200
Message-Id: <20250313142333.5792-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313142333.5792-1-ilpo.jarvinen@linux.intel.com>
References: <20250313142333.5792-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The previous change cleared HPIE (Hot-Plug Interrupt Enable) in
pciehp_reset_slot(). Clearing HPIE should be enough to synchronize with
the interrupt and event handling so that clearing PDCE (Presence Detect
Changed Enable) and DLLSCE (Data Link Layer State Changed Enable) is
not necessary. However, the commit be54ea5330d ("PCI: pciehp: Disable
Data Link Layer State Changed event on suspend") found out that under
some circumstances, clearing also DLLSCE is necessary.

While this is logically part of the previous change, remove PDCE and
DLLSCE clearing in now separately to allow bisect pinpoint it better if
removing their clearing causes some issues.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index c487e274b282..634cf5004f76 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -915,11 +915,8 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
 
 	if (!pciehp_poll_mode)
 		ctrl_mask |= PCI_EXP_SLTCTL_HPIE;
-	if (!ATTN_BUTTN(ctrl)) {
-		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
+	if (!ATTN_BUTTN(ctrl))
 		stat_mask |= PCI_EXP_SLTSTA_PDC;
-	}
-	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
 	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
 
 	pcie_write_cmd(ctrl, 0, ctrl_mask);
-- 
2.39.5


