Return-Path: <linux-pci+bounces-23640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A968A5F7EC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE44C42039D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0EE267F5B;
	Thu, 13 Mar 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+YuMV1c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1C2267F77;
	Thu, 13 Mar 2025 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875863; cv=none; b=QaD8JhmOoSkFkpnfFNIEF1A8LdN/IhwumYBTkVCvy5jNRLauvWcXc7K1ijJPpeQ+0rIE3k2raeP86wX27mOakjoSOAlWo4swItvzfTQqFuZfCAVI3Zts3mc8Xn1OOHsiT9GqYgywCZ+K8V1BcnpSXeUMktGz8j9FXvkCAQgVmfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875863; c=relaxed/simple;
	bh=I8Al09f7wcLXoD3DPF6GNanA8tygpSAjedUh2Nvo+JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPkXZiRwOTuKZo4U7P/4d0hViZw6mirBGjMnQeVqq7elhfXL7yj/+ewMimYo/1Rwpuz5zDBSWbRYNn1Zd2OGQDIA1h4xWtmCxuV7q1zqU0fm8FjyS7xnqXlK7+t89mUUAN1ebHa1oA5nmxgte3rx/yYQkag5SouZMmaUIRI+6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+YuMV1c; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741875862; x=1773411862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I8Al09f7wcLXoD3DPF6GNanA8tygpSAjedUh2Nvo+JA=;
  b=l+YuMV1cRS16rsPakFdTux0t/mkF5w7H9rbVRNQzIKoaE0zp/sdVLZ5X
   oq+tplm8BV3Z68Qeq1WPWwW53ezkukXnFTdVzP/UY7Gt6SBhkpf2ECCUI
   pM1Q+qRmAT0IHn8am3BwnVqBwxB0uxBVjfc8NVMLZ3lkmFo3J08QbV4lJ
   Jfj9BO5ZrjnBjUNmJ5flM2/+mkbCHaWOR7A/sGvDddjRqKwhM4vWzooJH
   KMEZPeUUmK4x8SWDfTfOJ4WXRIGaFrMnR0Ez7oyoylQ+8Oeif/E8z+sHI
   npYI45NrKYLnvC++PPEw2AV1BBhpKlPy9rrg/A2+Neon7tizWqVG/ek19
   A==;
X-CSE-ConnectionGUID: i4X+S54WTF6hH6faokuRKg==
X-CSE-MsgGUID: WAiuR62gR+uk72EVlkOB2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43173604"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43173604"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:24:22 -0700
X-CSE-ConnectionGUID: HlD4va/lQkeubo96Tc+Qcg==
X-CSE-MsgGUID: kEFraZpzQpCWHZEyI0+KGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126027444"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:24:18 -0700
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
Subject: [PATCH 3/4] PCI/hotplug: reset_lock is not required synchronizing with irq thread
Date: Thu, 13 Mar 2025 16:23:32 +0200
Message-Id: <20250313142333.5792-4-ilpo.jarvinen@linux.intel.com>
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

Disabling HPIE (Hot-Plug Interrupt Enable) and synchronizing with irq
handling in pciehp_reset_slot() is enough to ensure no pending events
are processed during the slot reset. Thus, there is no need to take
reset_lock in the IRQ thread.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 634cf5004f76..26150a6b48f4 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -748,12 +748,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	 * Disable requests have higher priority than Presence Detect Changed
 	 * or Data Link Layer State Changed events.
 	 */
-	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 	if (events & DISABLE_SLOT)
 		pciehp_handle_disable_request(ctrl);
 	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
 		pciehp_handle_presence_or_link_change(ctrl, events);
-	up_read(&ctrl->reset_lock);
 
 	ret = IRQ_HANDLED;
 out:
-- 
2.39.5


