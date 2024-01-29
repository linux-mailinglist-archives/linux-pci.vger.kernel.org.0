Return-Path: <linux-pci+bounces-2716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A198403CE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 12:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FCD2858E9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 11:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EDB5D8FE;
	Mon, 29 Jan 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvXzSg6W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C65BAD2;
	Mon, 29 Jan 2024 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527702; cv=none; b=O9A///ks9hxO2aRlNSiEafpWG7tkdsI4j9wwwmj9p5nN01QqwDBETrjqnoDvEK7grDn1Pb9Lz8nrIZYncKVWlZvqAqIC8VJxCqAH15fuHeKdBTeenSaHguSp88OnY0ocPetGISyr/inyQYmeNfmGOYtr9DHlqAS6lP1FdQH94LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527702; c=relaxed/simple;
	bh=vj5fBWYj/huccK5UtSPMJRYI869/VeBvWXPwIF4xpbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYErmWoRvuLQ8b7KgiSsxfsaihWwHQixHN8MnToJ0ka6MiCU7bjQ0WCzDXRUdFRjWGA9VVhTVou/tVTuhDF9jlbfv7JSPGJV40K3WTv9UZ02J2TmckNf5cjiq4TbfwyMpTTHInwYyMxfQxapaZclqyQU2lxhyBsPpUn8QbER07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvXzSg6W; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706527700; x=1738063700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vj5fBWYj/huccK5UtSPMJRYI869/VeBvWXPwIF4xpbo=;
  b=HvXzSg6We+qdRerhxyjxwDP6mDeU1GO8EmlP4GocUIKNavC/a+ciyVCT
   XtrBz54t12k1P3yo2Lol8vGN+r5HtopeA/m3mWJm9fQutvSoRZ6XF8atb
   +cWwvlK5ZaqvRmHO7BYVXZmOsu4ZQ3+havEmVJNC1kR+1BdFcwAtqr5aP
   tKq1bX87yiA6fU8o6mukVPS5GhhbXAy1lc04nxsbLp21ZK+jLquhTN88D
   TyrOocQ3NZXeHSgBciMh8BwVe2LT/90Wvb2U8rx/TUA5NTaa0EbHmVhtA
   trvfDzJ1UK0RMxSzzju2X5boxUUM/HzdVDkm2l6UBe4HQaApd1NcBHZFn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="1857085"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="1857085"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 03:28:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="858070352"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="858070352"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.253.213])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 03:28:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed quirk
Date: Mon, 29 Jan 2024 13:27:09 +0200
Message-Id: <20240129112710.2852-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129112710.2852-1-ilpo.jarvinen@linux.intel.com>
References: <20240129112710.2852-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While a device is runtime suspended along with its PCIe hierarchy, the
device could get disconnected. Because of the suspend, the device
disconnection cannot be detected until portdrv/hotplug have resumed. On
runtime resume, pcie_wait_for_link_delay() is called:

  pci_pm_runtime_resume()
    pci_pm_bridge_power_up_actions()
      pci_bridge_wait_for_secondary_bus()
        pcie_wait_for_link_delay()

Because the device is already disconnected, this results in cascading
failures:

  1. pcie_wait_for_link_status() returns -ETIMEDOUT.

  2. After the commit a89c82249c37 ("PCI: Work around PCIe link
     training failures"), pcie_failed_link_retrain() spuriously detects
     this failure as a Link Retraining failure and attempts the Target
     Speed trick, which also fails.

  3. pci_bridge_wait_for_secondary_bus() then calls pci_dev_wait() which
     cannot succeed (but waits ~1 minute, delaying the resume).

The Target Speed trick (in step 2) is only used if LBMS bit (PCIe r6.1
sec 7.5.3.8) is set. For links that have been operational before
suspend, it is well possible that LBMS has been set at the bridge and
remains on. Thus, after resume, LBMS does not indicate the link needs
the Target Speed quirk. Clear LBMS on resume for bridges to avoid the
issue.

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..05a114962df3 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -574,6 +574,12 @@ static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
 {
 	int ret;
 
+	/*
+	 * Clear LBMS on resume to avoid spuriously triggering Target Speed
+	 * quirk in pcie_failed_link_retrain().
+	 */
+	pcie_capability_write_word(pci_dev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
+
 	ret = pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
 	if (ret) {
 		/*
-- 
2.39.2


