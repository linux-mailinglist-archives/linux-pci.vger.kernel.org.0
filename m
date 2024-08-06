Return-Path: <linux-pci+bounces-11375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90154949743
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 20:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46154284D4E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4F554FAD;
	Tue,  6 Aug 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+D90PX5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EC41C85
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967243; cv=none; b=S+IFe89y9KjVBJ2yOcr5gVv1YKnvYApnWDiInZweIOyVKuj2MAnwJ/7BdbqGbtJESp+y24Iom87jaMZjYnME/hqHaXHR53Go1A16VwzmJdb6LoCVWEgk8p/yuZPGAEiNg2mZOlj3vNJURPyJ90frW2Znq3tDmHXDtSMwcHI7rng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967243; c=relaxed/simple;
	bh=HcZRgKCvbpS5ATqTFaTPK4WAzIscpRPd+oYFZhl/kk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Uv1qskl3IagEPSOf8PFbzw6bzV3JIO8wZ0B5gVTJX886ewLlJt58Ro2poVeGMgUyQbbuSFZYWdr83HYAemuQF7+i5noCJMycqkBHupwzZfE7rzN+xrb0ZusWkWPHbzQ0Mk+1CS1fsEirEPaJdR8VDagsQYk26Q8WbKjyzxP0vk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+D90PX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED90CC32786;
	Tue,  6 Aug 2024 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722967243;
	bh=HcZRgKCvbpS5ATqTFaTPK4WAzIscpRPd+oYFZhl/kk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=l+D90PX5//B9g+gq9MQaUpXezMEOKGb9E+8s4SCm/8lzKC+S8EEYVLynouNqXp/+E
	 s3oaMkJVGn86MTM+Mlz4QobKbJvXUXhe84UsBp3abJvmEjv9BelCLY/37meEJgOoqu
	 Gc+rojTz5MdI2JSyvL3HshcQWIS/ucdv1Io189U19VFmva5dfKDsSEjjD7Yjtbn/nS
	 FnArNhZHGfsrKO7/xP5pt5/cT5sYjZrmmd8uQKLmA75pu3M7iGMOo5oR0oZAs41Mtx
	 1Y/kVTzPC/DipIqZUx6X2aMAc6ECPDj8iGIqKK4rxJlcLQ5ZFjGj2jD/Ztdb6bzTYR
	 JgYnjcwJ6ltqA==
Date: Tue, 6 Aug 2024 13:00:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Jay Fang <f.fangjian@huawei.com>, Ding Hui <dinghui@sangfor.com.cn>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [PATCH] PCI/ASPM: Update ASPM sysfs on MFD function removal to
 avoid use-after-free
Message-ID: <20240806180040.GA71065@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bd06c63-f97a-1608-d291-c34e8d357973@linux.intel.com>

On Tue, Aug 06, 2024 at 07:38:27PM +0300, Ilpo Järvinen wrote:
> On Thu, 1 Aug 2024, Bjorn Helgaas wrote:
> > On Thu, Aug 01, 2024 at 08:05:23PM +0800, Jay Fang wrote:
> > > On 2024/8/1 5:46, Bjorn Helgaas wrote:
> > > > On Tue, Jul 30, 2024 at 05:57:43PM +0800, Ding Hui wrote:
> > > >> On 2024/7/30 9:16, Jay Fang wrote:
> > > >>>  From 'commit 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal
> > > >>> to avoid use-after-free")' we know that PCIe spec r6.0, sec 7.5.3.7,
> > > >>> recommends that software program the same ASPM Control(pcie_link_state)
> > > >>> value in all functions of multi-function devices, and free the
> > > >>> pcie_link_state when any child function is removed.
> > > >>>
> > > >>> However, ASPM Control sysfs is still visible to other children even if it
> > > >>> has been removed by any child function, and careless use it will
> > > >>> trigger use-after-free error, e.g.:
> > > >>>
> > > >>>    # lspci -tv
> > > >>>      -[0000:16]---00.0-[17]--+-00.0  Device 19e5:0222
> > > >>>                              \-00.1  Device 19e5:0222
> > > >>>    # echo 1 > /sys/bus/pci/devices/0000:17:00.0/remove       // pcie_link_state will be released
> > > >>>    # echo 1 > /sys/bus/pci/devices/0000:17:00.1/link/l1_aspm // will trigger error
> > > >>>
> > > >>>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> > > >>>    Call trace:
> > > >>>     aspm_attr_store_common.constprop.0+0x10c/0x154
> > > >>>     l1_aspm_store+0x24/0x30
> > > >>>     dev_attr_store+0x20/0x34
> > > >>>     sysfs_kf_write+0x4c/0x5c
> > > >>>
> > > >>> We can solve this problem by updating the ASPM Control sysfs of all
> > > >>> children immediately after ASPM Control have been freed.
> > > >>>
> > > >>> Fixes: 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free")
> > > >>> Signed-off-by: Jay Fang <f.fangjian@huawei.com>
> > > >>> ---
> > > >>>   drivers/pci/pcie/aspm.c | 2 ++
> > > >>>   1 file changed, 2 insertions(+)
> > > >>>
> > > >>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > >>> index cee2365e54b8..eee9e6739924 100644
> > > >>> --- a/drivers/pci/pcie/aspm.c
> > > >>> +++ b/drivers/pci/pcie/aspm.c
> > > >>> @@ -1262,6 +1262,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
> > > >>>   		pcie_config_aspm_path(parent_link);
> > > >>>   	}
> > > >>> +	pcie_aspm_update_sysfs_visibility(parent);
> > > >>> +
> > > >>
> > > >> To be more rigorous, is there still a race window in
> > > >> aspm_attr_{show,store}_common or clkpm_{show,store} before updating
> > > >> the visibility, we can get an old or NULL pointer by
> > > >> pcie_aspm_get_link()?
> > > > 
> > > > Yeah, I think we still have a problem even with this patch.
> > >
> > > If so, maybe we need a new solution to completely sovle this problem.
> > 
> > I think so.  The pcie_link_state struct is kind of problematic to
> > begin with.  It basically encodes the PCI hierarchy again, even though
> > the hierarchy is already completely described via struct pci_dev.
> > 
> > IMO only the ASPM and clock PM state is really new information.  I'm
> > not convinced that we even need all of that (how can
> > supported/enabled/capable/default/disabled *all* be useful and
> > understandable?).  But even if we *do* need all of that, it's only 39
> > bits of information per device.
> 
> Hi all,
> 
> To me, the most natural place for the link-related information such as 
> ASPM state would be inside struct pci_bus.

Good point, that probably would make sense.

> I actually did already take a look into migrating ASPM data there but the
> way pcie_link_state is currently looked up through pci_dev (from both 
> ends of the link) seemed to make the conversion somewhat messy so I 
> postponed creating the patch for the migration.
> 
> But it's certainly a change I'd like to see if somebody wants to look into 
> it.
> 
> > > > For one thing, aspm_attr_store_common() captures the pointer from
> > > > pcie_aspm_get_link() before the critical section, so by the time it
> > > > *uses* the pointer, pcie_aspm_exit_link_state() may have freed the
> > > > link state.
> > > > 
> > > > And there are several other callers of pcie_aspm_get_link() that
> > > > either call it before a critical section or don't have a critical
> > > > section at all.
> > > > 
> > > > I think it may be a mistake to alloc/free the link state separately
> > > > from the pci_dev itself.
> > > > 
> > > >>>   	mutex_unlock(&aspm_lock);
> > > >>>   	up_read(&pci_bus_sem);
> > > >>>   }
> > > >>
> > > >> -- 
> > > >> Thanks,
> > > >> - Ding Hui
> > > >>
> > > > 
> > > > .
> > > > 
> > > 
> > 

