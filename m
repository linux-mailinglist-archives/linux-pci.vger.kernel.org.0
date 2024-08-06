Return-Path: <linux-pci+bounces-11371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB7B9495AD
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 18:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463F9282603
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85172770B;
	Tue,  6 Aug 2024 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="On5a8zHM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1F2C697
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962320; cv=none; b=cK+6lT6rYwWtK6+0y/Xiu517b8RWNN9bQRClSdfZk/yKul8JGLrrsBZc7tDEJoRH20Rk5Qy7HtydRo/7Pg76oSIKvm2yDsqv4eSNOkwy3S+mPswTx+DLYcY71moB1yEClDYGNBxl7RHbPmRIxPwFtPOg88YkQcHm51Y8nZZa8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962320; c=relaxed/simple;
	bh=tdU6d2flBqVFC6ux+28JYg1pD54WQPjLdIoyakyCYeY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QNsBmSz0Hf6P3NRo6L9yBCGiQFpu34x+nChpyq4CkDZICaDmuFnqJtfHZVzJoZlcJ9Cnx2XjCRPzrq7ekIojyfYuVFxkgxJ9MsFVf/cyKC9kXh1qbDUgHccH+hqk/y0HEFiVmxMc2ZYvCaJzaWGbCJEtxDcALYZ8WOc9ssOlXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=On5a8zHM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722962318; x=1754498318;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tdU6d2flBqVFC6ux+28JYg1pD54WQPjLdIoyakyCYeY=;
  b=On5a8zHMr+RWRz5K3hWcnksdWbT7R24wes8If9G21pqd6EsGKn0qhyxH
   qRuBjU1mJ7ygzyWxSp+Xy7nldgqYaiUofTkOaSWq1AW8cA+kRqZRxK5mR
   O5s5+OiZLmR2Mcj6lklm8gOLfb5m0ZSfvoN6DuyeX0CQ6OShYLl26ccXC
   dM4r1jWBTzj/LUJxifu8dhLVDdit0wctb108KA3aZ0JCe/CdutRF2g3vr
   YjaJn9wZiImpcKHeQ02Owrks75+Lchhlk9d+b+4xqYljTuqtOuk99E0qF
   iesl1uFksj2ito3TthjBa/5rhxB7x9tKfu9m6cWV1qVUUEe/YWh5NjH9m
   A==;
X-CSE-ConnectionGUID: gU9PoXzIQbmVrbQTkMAAhA==
X-CSE-MsgGUID: /DK58cWsSN6zpTqnDMfF5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31626914"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31626914"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 09:38:33 -0700
X-CSE-ConnectionGUID: sttUn/QqT2exNoytQMDNPA==
X-CSE-MsgGUID: z3kMirD6SBaxxUgxBSF1mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56220235"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 09:38:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Aug 2024 19:38:27 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Jay Fang <f.fangjian@huawei.com>, Ding Hui <dinghui@sangfor.com.cn>, 
    bhelgaas@google.com, linux-pci@vger.kernel.org, 
    jonathan.cameron@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [PATCH] PCI/ASPM: Update ASPM sysfs on MFD function removal to
 avoid use-after-free
In-Reply-To: <20240801171103.GA107989@bhelgaas>
Message-ID: <1bd06c63-f97a-1608-d291-c34e8d357973@linux.intel.com>
References: <20240801171103.GA107989@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 1 Aug 2024, Bjorn Helgaas wrote:

> On Thu, Aug 01, 2024 at 08:05:23PM +0800, Jay Fang wrote:
> > On 2024/8/1 5:46, Bjorn Helgaas wrote:
> > > On Tue, Jul 30, 2024 at 05:57:43PM +0800, Ding Hui wrote:
> > >> On 2024/7/30 9:16, Jay Fang wrote:
> > >>>  From 'commit 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal
> > >>> to avoid use-after-free")' we know that PCIe spec r6.0, sec 7.5.3.7,
> > >>> recommends that software program the same ASPM Control(pcie_link_state)
> > >>> value in all functions of multi-function devices, and free the
> > >>> pcie_link_state when any child function is removed.
> > >>>
> > >>> However, ASPM Control sysfs is still visible to other children even if it
> > >>> has been removed by any child function, and careless use it will
> > >>> trigger use-after-free error, e.g.:
> > >>>
> > >>>    # lspci -tv
> > >>>      -[0000:16]---00.0-[17]--+-00.0  Device 19e5:0222
> > >>>                              \-00.1  Device 19e5:0222
> > >>>    # echo 1 > /sys/bus/pci/devices/0000:17:00.0/remove       // pcie_link_state will be released
> > >>>    # echo 1 > /sys/bus/pci/devices/0000:17:00.1/link/l1_aspm // will trigger error
> > >>>
> > >>>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> > >>>    Call trace:
> > >>>     aspm_attr_store_common.constprop.0+0x10c/0x154
> > >>>     l1_aspm_store+0x24/0x30
> > >>>     dev_attr_store+0x20/0x34
> > >>>     sysfs_kf_write+0x4c/0x5c
> > >>>
> > >>> We can solve this problem by updating the ASPM Control sysfs of all
> > >>> children immediately after ASPM Control have been freed.
> > >>>
> > >>> Fixes: 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free")
> > >>> Signed-off-by: Jay Fang <f.fangjian@huawei.com>
> > >>> ---
> > >>>   drivers/pci/pcie/aspm.c | 2 ++
> > >>>   1 file changed, 2 insertions(+)
> > >>>
> > >>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > >>> index cee2365e54b8..eee9e6739924 100644
> > >>> --- a/drivers/pci/pcie/aspm.c
> > >>> +++ b/drivers/pci/pcie/aspm.c
> > >>> @@ -1262,6 +1262,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
> > >>>   		pcie_config_aspm_path(parent_link);
> > >>>   	}
> > >>> +	pcie_aspm_update_sysfs_visibility(parent);
> > >>> +
> > >>
> > >> To be more rigorous, is there still a race window in
> > >> aspm_attr_{show,store}_common or clkpm_{show,store} before updating
> > >> the visibility, we can get an old or NULL pointer by
> > >> pcie_aspm_get_link()?
> > > 
> > > Yeah, I think we still have a problem even with this patch.
> >
> > If so, maybe we need a new solution to completely sovle this problem.
> 
> I think so.  The pcie_link_state struct is kind of problematic to
> begin with.  It basically encodes the PCI hierarchy again, even though
> the hierarchy is already completely described via struct pci_dev.
> 
> IMO only the ASPM and clock PM state is really new information.  I'm
> not convinced that we even need all of that (how can
> supported/enabled/capable/default/disabled *all* be useful and
> understandable?).  But even if we *do* need all of that, it's only 39
> bits of information per device.

Hi all,

To me, the most natural place for the link-related information such as 
ASPM state would be inside struct pci_bus.

I actually did already take a look into migrating ASPM data there but the
way pcie_link_state is currently looked up through pci_dev (from both 
ends of the link) seemed to make the conversion somewhat messy so I 
postponed creating the patch for the migration.

But it's certainly a change I'd like to see if somebody wants to look into 
it.

-- 
 i.

> > > For one thing, aspm_attr_store_common() captures the pointer from
> > > pcie_aspm_get_link() before the critical section, so by the time it
> > > *uses* the pointer, pcie_aspm_exit_link_state() may have freed the
> > > link state.
> > > 
> > > And there are several other callers of pcie_aspm_get_link() that
> > > either call it before a critical section or don't have a critical
> > > section at all.
> > > 
> > > I think it may be a mistake to alloc/free the link state separately
> > > from the pci_dev itself.
> > > 
> > >>>   	mutex_unlock(&aspm_lock);
> > >>>   	up_read(&pci_bus_sem);
> > >>>   }
> > >>
> > >> -- 
> > >> Thanks,
> > >> - Ding Hui
> > >>
> > > 
> > > .
> > > 
> > 
> 

