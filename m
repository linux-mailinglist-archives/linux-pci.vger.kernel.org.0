Return-Path: <linux-pci+bounces-4140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF8869D4F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 18:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713121C218AE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613FF47F60;
	Tue, 27 Feb 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K0wFK2/o"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A877D3D541;
	Tue, 27 Feb 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054106; cv=none; b=JzqYJsGcmeqhDb05K4HL4k1XoMe/okxxeRGQyh9noC3WvOSixEV+sySoS7cesGPDjgEyxj1R37YxxDAU4ZYGiRe/5l8PNv6hix996l1GIFZwtI/az7iZ91TWOl3EM17Z2zGTHH9KXKBjZBRl/OKbDAtQ1bbHdATtuMXmTzpqe1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054106; c=relaxed/simple;
	bh=1eYNs5SUzgfSO0lk9HtW9FXBv2A7D6CN5IoJH0GiPXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvHTza3Gf05XKiiFiHnqP11xE0P8g/d3IenFRyOzTS+kKK70FtwXankqQ7SvWT1vlLKNoXO1k6dtxchdVFsvWti1VAizDkGp3CHsYrl1C4i2A2hwIZQsuzi+pon1TlU3FlfuIpmrNdPst5vTIE9ugatB1Ih+2JOnNqMQMhURlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K0wFK2/o; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 78AE020B74C0; Tue, 27 Feb 2024 09:14:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 78AE020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709054098;
	bh=sVQhoz05/SIJfw6ySoLVCiEoCygMOf2DJanFXiU9yq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0wFK2/oo3l0x2R7a6BDUwkSEAJO/+Y/nrkJrcS2/c3ZDFC5r5drtIsoXfq7/wIVm
	 0C+x3V6iHUtSxdS/uzOnZ4y+ovhAYoTn2GtaFJLk1vZ4V38E3IQNhRLoZ6ur4/unp3
	 hI+NJ2W0I7fuIPXkkWZHSEiWALts7tHiqVFiVo4Y=
Date: Tue, 27 Feb 2024 09:14:58 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexander.stein@ew.tq-group.com,
	decui@microsoft.com,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Message-ID: <20240227171458.GA16664@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com>
 <20240206220715.GA884075@bhelgaas>
 <20240207163027.GA13964@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207163027.GA13964@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 07, 2024 at 08:30:27AM -0800, Saurabh Singh Sengar wrote:
> On Tue, Feb 06, 2024 at 04:07:15PM -0600, Bjorn Helgaas wrote:
> > [+cc Krzysztof]
> > 
> > On Fri, Dec 08, 2023 at 07:46:16PM -0800, Saurabh Sengar wrote:
> > > Currently there is a race in calling pci_create_resource_files function
> > > from two different therads, first therad is triggered by pci_sysfs_init
> > > from the late initcall where as the second thread is initiated by
> > > pci_bus_add_devices from the respective PCI drivers probe.
> > > 
> > > The synchronization between these threads relies on the sysfs_initialized
> > > flag. However, in pci_sysfs_init, sysfs_initialized is set right before
> > > calling pci_create_resource_files which is wrong as it can create race
> > > condition with pci_bus_add_devices threads. Fix this by setting
> > > sysfs_initialized flag at the end of pci_sysfs_init and direecly call the
> > > pci_create_resource_files function from it.
> > > 
> > > There can be an additional case where driver probe is so delayed that
> > > pci_bus_add_devices is called after the sysfs is created by pci_sysfs_init.
> > > In such cases, attempting to access already existing sysfs resources is
> > > unnecessary. Fix this by adding a check for sysfs attributes and return
> > > if they are already allocated.
> > > 
> > > In both cases, the consequence will be the removal of sysfs resources that
> > > were appropriately allocated by pci_sysfs_init following the warning below.
> > > 
> > > [    3.376688] sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:07/VMBUS:01/47505500-0001-0000-3130-444531454238/pci0001:00/0001:00:00.0/resource0'
> > > [    3.385103] CPU: 3 PID: 9 Comm: kworker/u8:0 Not tainted 5.15.0-1046-azure #53~20.04.1-Ubuntu
> > > [    3.389585] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
> > > [    3.394663] Workqueue: events_unbound async_run_entry_fn
> > > [    3.397687] Call Trace:
> > > [    3.399312]  <TASK>
> > > [    3.400780]  dump_stack_lvl+0x38/0x4d
> > > [    3.402998]  dump_stack+0x10/0x16
> > > [    3.406050]  sysfs_warn_dup.cold+0x17/0x2b
> > > [    3.408476]  sysfs_add_file_mode_ns+0x17b/0x190
> > > [    3.411072]  sysfs_create_bin_file+0x64/0x90
> > > [    3.413514]  pci_create_attr+0xc7/0x260
> > > [    3.415827]  pci_create_resource_files+0x6f/0x150
> > > [    3.418455]  pci_create_sysfs_dev_files+0x18/0x30
> > > [    3.421136]  pci_bus_add_device+0x30/0x70
> > > [    3.423512]  pci_bus_add_devices+0x31/0x70
> > > [    3.425958]  hv_pci_probe+0x4ce/0x640
> > > [    3.428106]  vmbus_probe+0x67/0x90
> > > [    3.430121]  really_probe.part.0+0xcb/0x380
> > > [    3.432516]  really_probe+0x40/0x80
> > > [    3.434581]  __driver_probe_device+0xe8/0x140
> > > [    3.437119]  driver_probe_device+0x23/0xb0
> > > [    3.439504]  __driver_attach_async_helper+0x31/0x90
> > > [    3.442296]  async_run_entry_fn+0x33/0x120
> > > [    3.444666]  process_one_work+0x225/0x3d0
> > > [    3.447043]  worker_thread+0x4d/0x3e0
> > > [    3.449233]  ? process_one_work+0x3d0/0x3d0
> > > [    3.451632]  kthread+0x12a/0x150
> > > [    3.453583]  ? set_kthread_struct+0x50/0x50
> > > [    3.456103]  ret_from_fork+0x22/0x30
> > > 
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > > There has been earlier attempts to fix this problem, below are the patches
> > > for reference of these attempts.
> > > 1. https://lore.kernel.org/linux-pci/20230316103036.1837869-1-alexander.stein@ew.tq-group.com/T/#u
> > > 2. https://lwn.net/ml/linux-kernel/20230316091540.494366-1-alexander.stein@ew.tq-group.com/
> > > 
> > > Bug details: https://bugzilla.kernel.org/show_bug.cgi?id=215515
> > > 
> > >  drivers/pci/pci-sysfs.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index f2909ae93f2f..a31f6f2cf309 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -1230,6 +1230,10 @@ static int pci_create_resource_files(struct pci_dev *pdev)
> > >  		if (!pci_resource_len(pdev, i))
> > >  			continue;
> > >  
> > > +		/* Check if resource already allocated and proceed no further */
> > > +		if (pdev->res_attr[i] || pdev->res_attr_wc[i])
> > > +			return 0;
> > > +
> > >  		retval = pci_create_attr(pdev, i, 0);
> > >  		/* for prefetchable resources, create a WC mappable file */
> > >  		if (!retval && arch_can_pci_mmap_wc() &&
> > > @@ -1411,9 +1415,8 @@ static int __init pci_sysfs_init(void)
> > >  	struct pci_bus *pbus = NULL;
> > >  	int retval;
> > >  
> > > -	sysfs_initialized = 1;
> > >  	for_each_pci_dev(pdev) {
> > > -		retval = pci_create_sysfs_dev_files(pdev);
> > > +		retval = pci_create_resource_files(pdev);
> > >  		if (retval) {
> > >  			pci_dev_put(pdev);
> > >  			return retval;
> > > @@ -1423,6 +1426,8 @@ static int __init pci_sysfs_init(void)
> > >  	while ((pbus = pci_find_next_bus(pbus)))
> > >  		pci_create_legacy_files(pbus);
> > >  
> > > +	sysfs_initialized = 1;
> > > +
> > >  	return 0;
> > >  }
> > >  late_initcall(pci_sysfs_init);
> > 
> > Sorry for the delay in looking at this.  Consider the following
> > sequence where thread A is executing pci_sysfs_init() at the same time
> > as thread B enumerates and adds device X:
> > 
> >   Thread A:
> > 
> >     pci_sysfs_init
> >       for_each_pci_dev(pdev) {                  # device X not included
> >         pci_create_resource_files(pdev);
> >       }
> > 
> >   Thread B:
> > 
> >     pci_bus_add_device                          # add device X
> >       pci_create_sysfs_dev_files
> >         if (!sysfs_initialized)                 # sysfs_initialized still zero
> >           return -EACCES;
> >         pci_create_resource_files(pdev);        # not executed
> > 
> >   Thread A:
> > 
> >     while ((pbus = pci_find_next_bus(pbus)))
> >       pci_create_legacy_files(pbus);
> > 
> >     sysfs_initialized = 1;
> > 
> > Doesn't this have a similar race where instead of the duplicate
> > filename from having two threads try to create the resource files,
> > neither thread creates them and device X ends up with no resource
> > files at all?
> > 
> > Krzysztof has done a ton of work to convert these files to static
> > attributes, where the device model prevents most of these races:
> > 
> >   506140f9c06b ("PCI/sysfs: Convert "index", "acpi_index", "label" to static attributes")
> >   d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
> >   f42c35ea3b13 ("PCI/sysfs: Convert "reset" to static attribute")
> >   527139d738d7 ("PCI/sysfs: Convert "rom" to static attribute")
> >   e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute")
> > 
> > and he even posted a series to do the same for the resource files:
> > 
> >   https://lore.kernel.org/linux-pci/20210910202623.2293708-1-kw@linux.com/
> > 
> > I can't remember why we didn't apply that at the time, and it no
> > longer applies cleanly, but I think that's the direction we should go.
> > 
> > Bjorn
> 
> 
> Thanks for you review.
> 
> Krzysztof,
> 
> Please inform me if there's existing feedback explaining why this
> series hasn't been merged yet. I am willing to further improve it
> if necessary.

Krzysztof Wilczyński,

Let us know your opinion so that we can move ahead in fixing this
long pending bug.

- Saurabh
> 
> - Saurabh

