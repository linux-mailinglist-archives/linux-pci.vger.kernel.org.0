Return-Path: <linux-pci+bounces-8106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB1F8D5784
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 03:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B281F25B50
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 01:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660BA5258;
	Fri, 31 May 2024 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDBEGZ6R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A11D29E;
	Fri, 31 May 2024 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117477; cv=none; b=sek4ggtSby2/YJc8WdDdDEjQVcvWLZJOyrtHWXxxZah1Rk9ILdszcqlmwy5L1zlXDFfpt10uWFZtPdDW/uQt7mTYVqxRJqVhGlBJgx1gQpPdPGAqmn5vvRWpIqzOrp8fqzYOFHSl6mQTYrI9LG/ZjaMQMm9jChJa+QE2PbzrJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117477; c=relaxed/simple;
	bh=nCcgVAgKWEB3T5hFSMRFjSNKAig4iLQCOjbRl2/uRHA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMSEcBCAoo75nWwQ+Ie4KymF0u90aAwrvn02KlJpc+RHCv963TX7MGBSwX0HAHrjDJzNnvN37kkuk4cnuDy5s8NQxrBL+aZmOQLfU2+bJhWv9a2BLZvea8MRv7zdNyRFqI3TDyvRxEZb/zT68GTw0iLx+suQoTHkoirpTNpffdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDBEGZ6R; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717117475; x=1748653475;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nCcgVAgKWEB3T5hFSMRFjSNKAig4iLQCOjbRl2/uRHA=;
  b=gDBEGZ6RejLeQxU63ZfoBRXC0P4mh7tn4ycqpZNh5OgOsFxuEMsgqQM2
   tv6V2lhbTCWAVU5MUCSDIrFr4ePX5rMfJ2W/CaDSTwdQ41jNtVdE89p6+
   V04SpRtyQtmaUUXmDnS+ucdEQ/23QQ+cAKStrm1IXm3I5E6thDItINi1V
   IC5ccNOUI5x8OSNECR/3JQzhhtN8My2QeeQd0FkAeVoPKy8dp8ZFIbYIh
   qEJwYu13P+E3vJMVDpdArqX+byVuq+sj+tF4/ynN5UXHqqfaJZ9MlKcEV
   YEyFYuI2rFATadmZxX3oUP8z9T3YCt+lGdF1HNoIHKp5YGF/QfxVRdncn
   A==;
X-CSE-ConnectionGUID: oqBSrPFJSnG26iIcF7PewA==
X-CSE-MsgGUID: 7miudoaXQ9mLPjRWuBGnew==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24308775"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24308775"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:04:35 -0700
X-CSE-ConnectionGUID: +AhVYoxFSIyVylr3XtmN5Q==
X-CSE-MsgGUID: UfXOXKRGRNyW4yDlUh0kIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36624122"
Received: from spittala-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.84.244])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:04:36 -0700
Subject: [PATCH v2 3/3] PCI: Add missing bridge lock to pci_bus_lock()
From: Dan Williams <dan.j.williams@intel.com>
To: bhelgaas@google.com
Cc: Imre Deak <imre.deak@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Date: Thu, 30 May 2024 18:04:35 -0700
Message-ID: <171711747501.1628941.15217746952476635316.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
References: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

One of the true positives that the cfg_access_lock lockdep effort
identified is this sequence:

 WARNING: CPU: 14 PID: 1 at drivers/pci/pci.c:4886 pci_bridge_secondary_bus_reset+0x5d/0x70
 RIP: 0010:pci_bridge_secondary_bus_reset+0x5d/0x70
 Call Trace:
  <TASK>
  ? __warn+0x8c/0x190
  ? pci_bridge_secondary_bus_reset+0x5d/0x70
  ? report_bug+0x1f8/0x200
  ? handle_bug+0x3c/0x70
  ? exc_invalid_op+0x18/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? pci_bridge_secondary_bus_reset+0x5d/0x70
  pci_reset_bus+0x1d8/0x270
  vmd_probe+0x778/0xa10
  pci_device_probe+0x95/0x120

Where pci_reset_bus() users are triggering unlocked secondary bus
resets. Ironically pci_bus_reset(), several calls down from
pci_reset_bus(), uses pci_bus_lock() before issuing the reset which
locks everything *but* the bridge itself.

For the same motivation as adding:

    bridge = pci_upstream_bridge(dev);
    if (bridge)
            pci_dev_lock(bridge);

...to pci_reset_function() for the "bus" and "cxl_bus" reset cases, add
pci_dev_lock() for @bus->self to pci_bus_lock().

Reported-by: Imre Deak <imre.deak@intel.com>
Closes: http://lore.kernel.org/r/6657833b3b5ae_14984b29437@dwillia2-xfh.jf.intel.com.notmuch
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/pci.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8df32a3a0979..aac5daad3188 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5444,6 +5444,7 @@ static void pci_bus_lock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pci_dev_lock(dev);
 		if (dev->subordinate)
@@ -5461,6 +5462,7 @@ static void pci_bus_unlock(struct pci_bus *bus)
 			pci_bus_unlock(dev->subordinate);
 		pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 }
 
 /* Return 1 on successful lock, 0 on contention */
@@ -5468,6 +5470,7 @@ static int pci_bus_trylock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (!pci_dev_trylock(dev))
 			goto unlock;
@@ -5486,6 +5489,7 @@ static int pci_bus_trylock(struct pci_bus *bus)
 			pci_bus_unlock(dev->subordinate);
 		pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 	return 0;
 }
 


