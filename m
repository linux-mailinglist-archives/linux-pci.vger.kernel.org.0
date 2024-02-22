Return-Path: <linux-pci+bounces-3887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72828603C0
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 21:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FEE1F28048
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 20:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C54671730;
	Thu, 22 Feb 2024 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJDRr7Pc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCDE7175E;
	Thu, 22 Feb 2024 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634458; cv=none; b=FTENMGEmwlL1rPIopQn1PTFUkd7sVmJVqILozSiqyWJ6TwKqEUQlb7enUmgK7LoyRtooMCCOIeeafIEmS6uksBowY3U2QRCAE98HgIBCGI87G5g/PuxzABCb0GlzcGwQNW4DZ6WdPvgT9jB8pTtNYe4S4ebSfIYbA2fpmMCDaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634458; c=relaxed/simple;
	bh=VU7eFjyMMwj2wha596144IVFoZku7WK0IDQNMvyYawg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7J3tYZWs2uhYQutGox9N3DTt6ychvozblzWoQK//oDU3+deByrK8pZSSP6Dqxir+3NYyEvgA5C/D8gBlPWc5/FV2xnTLcC05CUlUc8qtd+LAoSro8P+9DFC/TlUURbR9E0/wzT3KVZ2CmAcpfqpZxeLZZiGcMKLiCeLl3ebwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJDRr7Pc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708634456; x=1740170456;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VU7eFjyMMwj2wha596144IVFoZku7WK0IDQNMvyYawg=;
  b=BJDRr7Pcb6cEA+VTqFzLFNR7BdtA+P3xs4ApFPZwR/HKMCMFlY/urv+B
   yW6c+riVRoDZjr3O3rYKR0jZKBpBPALr4Ou191q4KZ8TzGj0CrXud4hQr
   ICEq/T5FFRQEWS4O3nt4xjEeJ3vV5436IIW3O7JcmSlQCZUAclUIn3zt+
   IFVWX/u9tqzgGE2Xt2Ju+mhK9muEM4CGTQxx0wWZl8ElL/jJelBzzsltt
   2AALjZm+rC2rruixOQ5ODzed8hE7Bh0VRphJhPp899wTVCenhx/rNRgIX
   oQdWa1FHH10owNU9/uLUSe/63u9U4W+XGyalNU5CzYhFIMdU1xg5jm09w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="25358647"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="25358647"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:40:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913585389"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913585389"
Received: from wyeh-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.77.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:40:55 -0800
Subject: [PATCH 1/3] sysfs: Fix crash on empty group attributes array
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Marc Herbert <marc.herbert@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev, alsa-devel@alsa-project.org
Date: Thu, 22 Feb 2024 12:40:54 -0800
Message-ID: <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

It turns out that arch/x86/events/intel/core.c makes use of "empty"
attributes.

	static struct attribute *empty_attrs;

	__init int intel_pmu_init(void)
	{
	        struct attribute **extra_skl_attr = &empty_attrs;
	        struct attribute **extra_attr = &empty_attrs;
	        struct attribute **td_attr    = &empty_attrs;
	        struct attribute **mem_attr   = &empty_attrs;
	        struct attribute **tsx_attr   = &empty_attrs;
		...

That breaks the assumption __first_visible() that expects that if
grp->attrs is set then grp->attrs[0] must also be set and results in
backtraces like:

    BUG: kernel NULL pointer dereference, address: 00rnel mode
    #PF: error_code(0x0000) - not-present ] PREEMPT SMP NOPTI
    CPU: 1 PID: 1 Comm: swapper/IP: 0010:exra_is_visible+0x14/0x20
     ? exc_page_fault+0x68/0x190
     internal_create_groups+0x42/0xa0
     pmu_dev_alloc+0xc0/0xe0
     perf_event_sysfs_init+0x580000000000 ]---
    RIP: 0010:exra_is_visible+0x14/0

Check for non-empty attributes array before calling is_visible().

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Closes: https://github.com/thesofproject/linux/pull/4799#issuecomment-1958537212
Fixes: 70317fd24b41 ("sysfs: Introduce a mechanism to hide static attribute_groups")
Cc: Marc Herbert <marc.herbert@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/sysfs/group.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index ccb275cdabcb..8c63ba3cfc47 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -33,10 +33,10 @@ static void remove_files(struct kernfs_node *parent,
 
 static umode_t __first_visible(const struct attribute_group *grp, struct kobject *kobj)
 {
-	if (grp->attrs && grp->is_visible)
+	if (grp->attrs && grp->attrs[0] && grp->is_visible)
 		return grp->is_visible(kobj, grp->attrs[0], 0);
 
-	if (grp->bin_attrs && grp->is_bin_visible)
+	if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible)
 		return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
 
 	return 0;


