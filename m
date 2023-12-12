Return-Path: <linux-pci+bounces-789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D280E5B2
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 09:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C74281ACD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 08:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B62182A8;
	Tue, 12 Dec 2023 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oWJe1wAr"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CCF5CF;
	Tue, 12 Dec 2023 00:21:21 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id C18D420B74C0; Tue, 12 Dec 2023 00:21:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C18D420B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702369280;
	bh=vEgT5Vx3QJOmfVLsCktFuAcxLJotqUz7j9rpr/6mWpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWJe1wAr2HexS2fWMEHskBZ6wg0mSzobc7mbn3A2E7/cZKKQjzm4d7MYJXKrArVvI
	 SQ5RqW0LE0hGav+GU13PSFOursQHzDrzEHxOMw75qjmY1FGVyLapxCjUi0CLcllrR7
	 Dhr/XhRPymethVcdzGBky3VFQiVYhkavRBaZjQ4E=
Date: Tue, 12 Dec 2023 00:21:20 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, decui@microsoft.com
Subject: Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Message-ID: <20231212082120.GA2800@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com>
 <5736414.DvuYhMxLoT@steina-w>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5736414.DvuYhMxLoT@steina-w>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Dec 12, 2023 at 08:19:11AM +0100, Alexander Stein wrote:
> Hi Saurabh,
> 
> thanks for the patch.
> 
> Am Samstag, 9. Dezember 2023, 04:46:16 CET schrieb Saurabh Sengar:
> > Currently there is a race in calling pci_create_resource_files function
> > from two different therads, first therad is triggered by pci_sysfs_init
> > from the late initcall where as the second thread is initiated by
> > pci_bus_add_devices from the respective PCI drivers probe.
> > 
> > The synchronization between these threads relies on the sysfs_initialized
> > flag. However, in pci_sysfs_init, sysfs_initialized is set right before
> > calling pci_create_resource_files which is wrong as it can create race
> > condition with pci_bus_add_devices threads. Fix this by setting
> > sysfs_initialized flag at the end of pci_sysfs_init and direecly call the
> 
> Small typo here: direecly -> directly

thanks

> 
> > pci_create_resource_files function from it.
> > 
> > There can be an additional case where driver probe is so delayed that
> > pci_bus_add_devices is called after the sysfs is created by pci_sysfs_init.
> > In such cases, attempting to access already existing sysfs resources is
> > unnecessary. Fix this by adding a check for sysfs attributes and return
> > if they are already allocated.
> > 
> > In both cases, the consequence will be the removal of sysfs resources that
> > were appropriately allocated by pci_sysfs_init following the warning below.
> 
> I'm not sure if this is the way to go. Unfortunately I can't trigger this 
> error on my imx6 platform at the moment (apparently timing is off).

The first case in the commit message is the issue which motivated me to write
this patch. The additional case I am explaining in the commit message is not
happening for me as well, I have hacked my driver to add a big sleep (10 second)
before pci_bus_add_devices to create this scenario. Probably you can try the
same as well.

The check added for "resource already allocated" is for this additional case only.

> But reading [1] again, the most expressive way is that pci_bus_add_devices() 
> needs to wait until pci_sysfs_init() has passed.

For the first case I agree with you. This patch is doing exactly the same by moving
sysfs_initialized flag setting at the end of pci_sysfs_init function.
Is there anything I might be ovelooking ?

- Saurabh


> 
> Best regards,
> Alexander
> 
> [1] https://lore.kernel.org/lkml/a1cca367-52b6-a6b1-fb01-890cad39fd29@suse.com/
> 
> > 
> > [    3.376688] sysfs: cannot create duplicate filename
> > '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:07/VMBUS:01/47505500-00
> > 01-0000-3130-444531454238/pci0001:00/0001:00:00.0/resource0' [    3.385103]
> > CPU: 3 PID: 9 Comm: kworker/u8:0 Not tainted 5.15.0-1046-azure
> > #53~20.04.1-Ubuntu [    3.389585] Hardware name: Microsoft Corporation
> > Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018 [    3.394663]
> > Workqueue: events_unbound async_run_entry_fn
> > [    3.397687] Call Trace:
> > [    3.399312]  <TASK>
> > [    3.400780]  dump_stack_lvl+0x38/0x4d
> > [    3.402998]  dump_stack+0x10/0x16
> > [    3.406050]  sysfs_warn_dup.cold+0x17/0x2b
> > [    3.408476]  sysfs_add_file_mode_ns+0x17b/0x190
> > [    3.411072]  sysfs_create_bin_file+0x64/0x90
> > [    3.413514]  pci_create_attr+0xc7/0x260
> > [    3.415827]  pci_create_resource_files+0x6f/0x150
> > [    3.418455]  pci_create_sysfs_dev_files+0x18/0x30
> > [    3.421136]  pci_bus_add_device+0x30/0x70
> > [    3.423512]  pci_bus_add_devices+0x31/0x70
> > [    3.425958]  hv_pci_probe+0x4ce/0x640
> > [    3.428106]  vmbus_probe+0x67/0x90
> > [    3.430121]  really_probe.part.0+0xcb/0x380
> > [    3.432516]  really_probe+0x40/0x80
> > [    3.434581]  __driver_probe_device+0xe8/0x140
> > [    3.437119]  driver_probe_device+0x23/0xb0
> > [    3.439504]  __driver_attach_async_helper+0x31/0x90
> > [    3.442296]  async_run_entry_fn+0x33/0x120
> > [    3.444666]  process_one_work+0x225/0x3d0
> > [    3.447043]  worker_thread+0x4d/0x3e0
> > [    3.449233]  ? process_one_work+0x3d0/0x3d0
> > [    3.451632]  kthread+0x12a/0x150
> > [    3.453583]  ? set_kthread_struct+0x50/0x50
> > [    3.456103]  ret_from_fork+0x22/0x30
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > There has been earlier attempts to fix this problem, below are the patches
> > for reference of these attempts.
> > 1.
> > https://lore.kernel.org/linux-pci/20230316103036.1837869-1-alexander.stein@
> > ew.tq-group.com/T/#u 2.
> > https://lwn.net/ml/linux-kernel/20230316091540.494366-1-alexander.stein@ew.
> > tq-group.com/
> > 
> > Bug details: https://bugzilla.kernel.org/show_bug.cgi?id=215515
> > 
> >  drivers/pci/pci-sysfs.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index f2909ae93f2f..a31f6f2cf309 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1230,6 +1230,10 @@ static int pci_create_resource_files(struct pci_dev
> > *pdev) if (!pci_resource_len(pdev, i))
> >  			continue;
> > 
> > +		/* Check if resource already allocated and proceed no 
> further */
> > +		if (pdev->res_attr[i] || pdev->res_attr_wc[i])
> > +			return 0;
> > +
> >  		retval = pci_create_attr(pdev, i, 0);
> >  		/* for prefetchable resources, create a WC mappable file 
> */
> >  		if (!retval && arch_can_pci_mmap_wc() &&
> > @@ -1411,9 +1415,8 @@ static int __init pci_sysfs_init(void)
> >  	struct pci_bus *pbus = NULL;
> >  	int retval;
> > 
> > -	sysfs_initialized = 1;
> >  	for_each_pci_dev(pdev) {
> > -		retval = pci_create_sysfs_dev_files(pdev);
> > +		retval = pci_create_resource_files(pdev);
> >  		if (retval) {
> >  			pci_dev_put(pdev);
> >  			return retval;
> > @@ -1423,6 +1426,8 @@ static int __init pci_sysfs_init(void)
> >  	while ((pbus = pci_find_next_bus(pbus)))
> >  		pci_create_legacy_files(pbus);
> > 
> > +	sysfs_initialized = 1;
> > +
> >  	return 0;
> >  }
> >  late_initcall(pci_sysfs_init);
> 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 

