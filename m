Return-Path: <linux-pci+bounces-23641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94836A5F7EE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D2017FD9A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551A267F6A;
	Thu, 13 Mar 2025 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtMBj6Fw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E475267F50;
	Thu, 13 Mar 2025 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875873; cv=none; b=k2Zu2T1biXMBdzuJiGFWp35Dk76spmLHDTLk233lPEB+QR1nH72LG23eZEwSak9j/mJD51paO/5N/eO5Yc3dDbElVgxbxOKQe5PWyIjdwc1HNWQgaFRnuEasAASO8GRb215nC2kDIkondoOj9LcohAMP6IjZ2j3RVtWfG9/kMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875873; c=relaxed/simple;
	bh=0FxnfcYBhT+cVr2BAwoxmIHH0W1Uu+mQyjkUQszWQkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8fUDQm2p5dT/0Qw/mrjSXvvDQFmbrNr8QMLxKiBsqRKxOyftdUPepmPKPD84vyUrY8NrEmF8yLRMgYMK4rXA0UR+iLdvpVrOWm9Snmsfl+EwRLZJFwJS2J9Hf8ZSiaxTMoBbPqP84yc580PbgALhv4qpFva28zY0vXkvoHTrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtMBj6Fw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741875873; x=1773411873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0FxnfcYBhT+cVr2BAwoxmIHH0W1Uu+mQyjkUQszWQkE=;
  b=XtMBj6FwzLBJmzia9DlorgYCdrkGdhEp5aOL4fltbIGDdpX3G6RyCuRk
   TA+xxhY1/PmtrPlf0BSL0r8jZQIXeTWZ+a5/2GOuW1wY6LjsucEq0EBt3
   HznpuYnrXQvWtvKipk70DAp5StyOdxjqLPfvwReotlCCSHkv1yuV5xaXr
   jvuhOrcAbEHNVTDZMQX4Z8VCA0TZStUMB+zcKLlpxCwtJuDTZa05uN6Hp
   b0j4WcByB1McPkZfs3QPFp7YVIzZJrdi0mIUANgbXT4PswRD8tDL2ewlb
   3VU3OwXsaxmHiKCHKSOzWhh2Zz/T3rp54PQ6pM0dhgkCaa0Ps6H8FGOTE
   Q==;
X-CSE-ConnectionGUID: 5NP5LecaSgafuDpTu9wXNw==
X-CSE-MsgGUID: RUJolReCSBu2QfPQGdJUcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43173625"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43173625"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:24:32 -0700
X-CSE-ConnectionGUID: JkwN5/auRf+iKsiHt2VPRw==
X-CSE-MsgGUID: pRVvhwE5T9Sw8DRNhlwXCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126027481"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:24:27 -0700
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
Subject: [PATCH 4/4] PCI/hotplug: Don't enabled HPIE in poll mode
Date: Thu, 13 Mar 2025 16:23:33 +0200
Message-Id: <20250313142333.5792-5-ilpo.jarvinen@linux.intel.com>
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

PCIe hotplug can operate in poll mode without interrupt handlers using
a polling kthread only. The commit eb34da60edee ("PCI: pciehp: Disable
hotplug interrupt during suspend") failed to consider that and enables
HPIE (Hot-Plug Interrupt Enable) unconditionally when resuming the
Port.

Only set HPIE if non-poll mode is in use. This makes
pcie_enable_interrupt() match how pcie_enable_notification() already
handles HPIE.

Fixes: eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 26150a6b48f4..7e1ed179c7f3 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -846,7 +846,9 @@ void pcie_enable_interrupt(struct controller *ctrl)
 {
 	u16 mask;
 
-	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+	mask = PCI_EXP_SLTCTL_DLLSCE;
+	if (!pciehp_poll_mode)
+		mask |= PCI_EXP_SLTCTL_HPIE;
 	pcie_write_cmd(ctrl, mask, mask);
 }
 
-- 
2.39.5


