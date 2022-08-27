Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5775A35C6
	for <lists+linux-pci@lfdr.de>; Sat, 27 Aug 2022 10:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiH0IB7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sat, 27 Aug 2022 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiH0IBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Aug 2022 04:01:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2732B5;
        Sat, 27 Aug 2022 01:01:47 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MF8Fv1sfRzkWVt;
        Sat, 27 Aug 2022 15:58:11 +0800 (CST)
Received: from dggpemm100006.china.huawei.com (7.185.36.196) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 16:01:45 +0800
Received: from canpemm500001.china.huawei.com (7.192.104.163) by
 dggpemm100006.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 16:01:45 +0800
Received: from canpemm500001.china.huawei.com ([7.192.104.163]) by
 canpemm500001.china.huawei.com ([7.192.104.163]) with mapi id 15.01.2375.024;
 Sat, 27 Aug 2022 16:01:45 +0800
From:   "Zhoujian (jay)" <jianjay.zhou@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        zhuangshengen <zhuangshengen@huawei.com>,
        "Wangjing(Hogan)" <hogan.wang@huawei.com>
Subject: RE: [Question] Any plan to support enable PCI SRIOV concurrently in
 kernel side?
Thread-Topic: [Question] Any plan to support enable PCI SRIOV concurrently in
 kernel side?
Thread-Index: AdiyDNZvspPz1b9KT9CKr88dkJbU8gAIpySAAeyWw1A=
Date:   Sat, 27 Aug 2022 08:01:44 +0000
Message-ID: <47c749ec933549b687bd0acfbb4e89f7@huawei.com>
References: <0a8ce5714e2d4eed909cb096d4832036@huawei.com>
 <20220817194947.GA2270629@bhelgaas>
In-Reply-To: <20220817194947.GA2270629@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.254]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Thursday, August 18, 2022 3:50 AM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; bhelgaas@google.com;
> Gonglei (Arei) <arei.gonglei@huawei.com>; zhuangshengen
> <zhuangshengen@huawei.com>
> Subject: Re: [Question] Any plan to support enable PCI SRIOV concurrently in
> kernel side?
> 
> On Wed, Aug 17, 2022 at 07:43:34AM +0000, Zhoujian (jay) wrote:
> > Hi,
> >
> > Enable SRIOV concurrently with many different PFs in userspace seems workable.
> > I'm trying to do it with 8 PFs(each one with 240+ VFs), but get some
> > warnings, here is the backtrace:
> 
> This definitely seems like a problem that should be fixed.  If you have a script that
> can reproduce it, that might help people work on it.  If you can reproduce it in
> qemu, that would be even better.

The script has posted by zhuangshengen.

> 
> Some comments on the patch below.
> 
> > Warning 1:
> > ---
> > sysfs: cannot create duplicate filename
> '/devices/pci0000:30/0000:30:02.0/pci_bus/0000:32'
> > Call Trace:
> >  dump_stack+0x6f/0xab
> >  sysfs_warn_dup+0x56/0x70
> >  sysfs_create_dir_ns+0x80/0x90
> >  kobject_add_internal+0xa0/0x2b0
> >  kobject_add+0x71/0xd0
> >  device_add+0x126/0x630
> >  pci_add_new_bus+0x17c/0x4b0
> >  pci_iov_add_virtfn+0x336/0x390
> >  sriov_enable+0x26e/0x450
> >  virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]
> > ---
> > The reason is that different VFs may create the same pci bus number
> > and try to add new bus concurrently in virtfn_add_bus.
> >
> > Warning 2:
> > ---
> > proc_dir_entry 'pci/33' already registered
> > WARNING: CPU: 71 PID: 893 at fs/proc/generic.c:360
> > proc_register+0xf8/0x130 Call Trace:
> >  proc_mkdir_data+0x5d/0x80
> >  pci_proc_attach_device+0xe9/0x120
> >  pci_bus_add_device+0x33/0x90
> >  pci_iov_add_virtfn+0x375/0x390
> >  sriov_enable+0x26e/0x450
> >  virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]
> > ---
> > The reason is that different VFs may create '/proc/bus/pci/bus_number'
> > directory using the same bus number in pci_proc_attach_device concurrently.
> >
> > Mutex lock can avoid potential conflict. With the patch below the
> > warnings above are no longer appear.
> >
> > My question is that any plan to support enable PCI SRIOV concurrently in kernel
> side?
> >
> > Thanks
> >
> > ---
> > drivers/pci/iov.c | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index
> > 952217572113..6a8a849298c4 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -16,6 +16,12 @@
> >
> >  #define VIRTFN_ID_LEN    16
> >
> > +static struct mutex add_bus_mutex;
> > +static int add_bus_mutex_initialized;
> > +
> > +static struct mutex add_device_mutex; static int
> > +add_device_mutex_initialized;
> > +
> >  int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)  {
> >      if (!dev->is_physfn)
> > @@ -127,13 +133,24 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus
> *bus, int busnr)
> >      if (bus->number == busnr)
> >          return bus;
> >
> > +    if (!add_bus_mutex_initialized) {
> > +        mutex_init(&add_bus_mutex);
> > +        add_bus_mutex_initialized = 1;
> > +    }
> 
> I assume this patch works around the warning.  I see the intent here, but I think

Yes, it is. We have tested for a few weeks and no new problems have found.

> would need some rework before merging it.  These locks protect
> pci_add_new_bus() and pci_bus_add_device(), but only for the callers in iov.c.
> These interfaces are both called from places other than iov.c, and any mutual
> exclusion should cover all of them.

I agree.

> 
> I'm actually not sure how the other callers are protected.  I assume we're holding a
> device_lock for some device farther up the chain.  Or, I see that
> acpi_pci_root_add() and rescan_store() hold pci_rescan_remove_lock while calling
> these.  

The pci_rescan_remove_lock is added since 2014, see the commit below.

commit 9d16947b75831acd317ab9a53e0e94d160731d33
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Fri Jan 10 15:22:18 2014 +0100

    PCI: Add global pci_lock_rescan_remove()
    
    There are multiple PCI device addition and removal code paths that may be
    run concurrently with the generic PCI bus rescan and device removal that
    can be triggered via sysfs.  If that happens, it may lead to multiple
    different, potentially dangerous race conditions.
    
    The most straightforward way to address those problems is to run
    the code in question under the same lock that is used by the
    generic rescan/remove code in pci-sysfs.c.  To prepare for those
    changes, move the definition of the global PCI remove/rescan lock
    to probe.c and provide global wrappers, pci_lock_rescan_remove()
    and pci_unlock_rescan_remove(), allowing drivers to manipulate
    that lock.  Also provide pci_stop_and_remove_bus_device_locked()
    for the callers of pci_stop_and_remove_bus_device() who only need
    to hold the rescan/remove lock around it.
    
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Its purpose is to avoid PCI device addition and removal happen concurrently.
IMHO it is suitable to use this lock to enable SRIOV here to avoid creating a
new lock.

> We don't seem to hold that uniformly though, which bothers me, because
> I think there are many other paths, e.g., pci_host_probe() and its callers.

I have checked the other code paths. Most of the callers have hold the
pci_rescan_remove_lock. Some did missing. In order to hold the lock
uniformly, it may need to add the pci_rescan_remove_lock to the missing
place one by one(if it exists the possibility of concurrency). So what do we
need to do now? (1) fix all of them (2) only add pci_rescan_remove_lock in iov.c
as a start.

Thanks

> 
> > +    mutex_lock(&add_bus_mutex);
> > +
> >      child = pci_find_bus(pci_domain_nr(bus), busnr);
> > -    if (child)
> > +    if (child) {
> > +        mutex_unlock(&add_bus_mutex);
> >          return child;
> > +    }
> >
> >      child = pci_add_new_bus(bus, NULL, busnr);
> > -    if (!child)
> > +    if (!child) {
> > +        mutex_unlock(&add_bus_mutex);
> >          return NULL;
> > +    }
> > +    mutex_unlock(&add_bus_mutex);
> >
> >      pci_bus_insert_busn_res(child, busnr, busnr);
> >
> > @@ -339,8 +356,16 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> >      if (rc)
> >          goto failed1;
> >
> > +    if (!add_device_mutex_initialized) {
> > +        mutex_init(&add_device_mutex);
> > +        add_device_mutex_initialized = 1;
> > +    }
> > +    mutex_lock(&add_device_mutex);
> > +
> >      pci_bus_add_device(virtfn);
> >
> > +    mutex_unlock(&add_device_mutex);
> > +
> >      return 0;
> >
> >  failed1:
> > ---
