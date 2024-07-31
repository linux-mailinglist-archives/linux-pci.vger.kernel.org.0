Return-Path: <linux-pci+bounces-11074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01978943835
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 23:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B740128598B
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 21:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3662B143C7E;
	Wed, 31 Jul 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ2wDGRa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124371AA3CC
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462369; cv=none; b=CQrDtTZlLAICvhYKYmZs2Bz564GRpxifJ94YFODfyu5Kp089YhE4yXMAunpw/sYwbnjTZUsW0wfY+JlBCa0wKn7sTUJqe8+dQYzfkvr+amKI+DmPFCxBnkaTacIqiVJ4SxwTWH2vE4msUtUxpywHUs/5vOLoqAqWSqBGv8vpVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462369; c=relaxed/simple;
	bh=6UFMCEELYNpC/ibOauoGEwDYL3pfXM+1syUJQA81glQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hf0Rco+F4/IA3ApBh4ZuLIVoef+xRkG6lAfBheG+PylDLyFi9ndDha0pjd3ofcfnfBzY6LtruT55lAvc03FfqlF65iuKJSgKbDgtSBf9l/DhEzwY/xA2AdGtg4qzuCVeST81PiTEKrSuX86lSFylHQMei2TJd9Ge9XtshWyDmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ2wDGRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AD9C116B1;
	Wed, 31 Jul 2024 21:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722462368;
	bh=6UFMCEELYNpC/ibOauoGEwDYL3pfXM+1syUJQA81glQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pJ2wDGRazK9zM3TLF4/aTB+NsGjZUbsnye484gTtFh1BVfbGJef/wGABGhCQjxQZI
	 WOmJ+x2svmCC3NU7+g3AimrWg5b0JyYxLc5cISwR6N8jJFy9C3GVjrJFvhmnq6pOxQ
	 ZgyZErJBb+ZUHxY+v0Y8YbMu/fqqBPvw9hmJXR7ure5q2ZtkRX+9E4+/W+P5e+VUzz
	 Ibdx3Zi69Y2JHhbx/T73rrpE3INbnzczDTnF4ktOP4bnv+0qNfNiOQggCwRcilfyXj
	 YfVwVEkjMbS2thYPhRh9Mfmt0uEJJV6yhalaIO2tadUOzIn3TuE+DVOEp3hzWRNNJQ
	 NetBexMOACzHA==
Date: Wed, 31 Jul 2024 16:46:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ding Hui <dinghui@sangfor.com.cn>
Cc: Jay Fang <f.fangjian@huawei.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com
Subject: Re: [PATCH] PCI/ASPM: Update ASPM sysfs on MFD function removal to
 avoid use-after-free
Message-ID: <20240731214606.GA83038@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580700a-95e6-45cc-a461-68fa1cc1b50c@sangfor.com.cn>

On Tue, Jul 30, 2024 at 05:57:43PM +0800, Ding Hui wrote:
> On 2024/7/30 9:16, Jay Fang wrote:
> >  From 'commit 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal
> > to avoid use-after-free")' we know that PCIe spec r6.0, sec 7.5.3.7,
> > recommends that software program the same ASPM Control(pcie_link_state)
> > value in all functions of multi-function devices, and free the
> > pcie_link_state when any child function is removed.
> > 
> > However, ASPM Control sysfs is still visible to other children even if it
> > has been removed by any child function, and careless use it will
> > trigger use-after-free error, e.g.:
> > 
> >    # lspci -tv
> >      -[0000:16]---00.0-[17]--+-00.0  Device 19e5:0222
> >                              \-00.1  Device 19e5:0222
> >    # echo 1 > /sys/bus/pci/devices/0000:17:00.0/remove       // pcie_link_state will be released
> >    # echo 1 > /sys/bus/pci/devices/0000:17:00.1/link/l1_aspm // will trigger error
> > 
> >    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> >    Call trace:
> >     aspm_attr_store_common.constprop.0+0x10c/0x154
> >     l1_aspm_store+0x24/0x30
> >     dev_attr_store+0x20/0x34
> >     sysfs_kf_write+0x4c/0x5c
> > 
> > We can solve this problem by updating the ASPM Control sysfs of all
> > children immediately after ASPM Control have been freed.
> > 
> > Fixes: 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free")
> > Signed-off-by: Jay Fang <f.fangjian@huawei.com>
> > ---
> >   drivers/pci/pcie/aspm.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index cee2365e54b8..eee9e6739924 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1262,6 +1262,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
> >   		pcie_config_aspm_path(parent_link);
> >   	}
> > +	pcie_aspm_update_sysfs_visibility(parent);
> > +
> 
> To be more rigorous, is there still a race window in
> aspm_attr_{show,store}_common or clkpm_{show,store} before updating
> the visibility, we can get an old or NULL pointer by
> pcie_aspm_get_link()?

Yeah, I think we still have a problem even with this patch.

For one thing, aspm_attr_store_common() captures the pointer from
pcie_aspm_get_link() before the critical section, so by the time it
*uses* the pointer, pcie_aspm_exit_link_state() may have freed the
link state.

And there are several other callers of pcie_aspm_get_link() that
either call it before a critical section or don't have a critical
section at all.

I think it may be a mistake to alloc/free the link state separately
from the pci_dev itself.

> >   	mutex_unlock(&aspm_lock);
> >   	up_read(&pci_bus_sem);
> >   }
> 
> -- 
> Thanks,
> - Ding Hui
> 

