Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A995E84D9
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 23:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiIWV1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 17:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIWV07 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 17:26:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560BF131F54;
        Fri, 23 Sep 2022 14:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEBF2B8217C;
        Fri, 23 Sep 2022 21:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAD0C433D6;
        Fri, 23 Sep 2022 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663968415;
        bh=04KQIkXnh94NK+tAFDcCptRSPSkYo2UqQNx1lc+btls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AYsmqRU1VyVR6C8ewVKqr5nQ+Mo/qxecG/6jNp82D87GrqcHiTNOUcsTxhsm5IZ00
         U1huroVqTUIG58/1aXy2FxX6L5yYXzPE4ScLBxs4d8fsh+qsPF0UbTv4OPpxkpEs5c
         rBNJD/5Qy1JLV1mazFLZAuelDrpjxBGJi4/Scjik1fPjjlKdadLV4GnIuUQvFv+n63
         G0ux1bRK5yccU+izGzhYxaSxEftZxoV6NSPT5Ki7nD/tDYHg4uoURRKiAhQ4eM8Urq
         rDJlmY/bAGfthqPx+y1i7OpNd0dap8grTkGhMOI8fj2F8qYhy7dKRHfg916gnFmVD5
         yFKomgHpLaO/Q==
Date:   Fri, 23 Sep 2022 16:26:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     zhuangshengen <zhuangshengen@huawei.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhoujian (jay)" <jianjay.zhou@huawei.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "Wangjing(Hogan)" <hogan.wang@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUXVlc3Rpb25dIEFu?= =?utf-8?Q?y?= plan to
 support enable PCI SRIOV concurrently in kernel side?
Message-ID: <20220923212653.GA1419675@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d32d9c974b6f4922b1fcf9299b367af1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 21, 2022 at 11:25:34AM +0000, zhuangshengen wrote:
> > On Wed, Aug 17, 2022 at 07:43:34AM +0000, Zhoujian (jay) wrote:
> > > Enable SRIOV concurrently with many different PFs in userspace seems workable.
> > > I'm trying to do it with 8 PFs(each one with 240+ VFs), but get some 
> > > warnings, here is the backtrace:
> > 
> > This definitely seems like a problem that should be fixed.  If you have a script that can reproduce it, that might help people work on it.  If you can reproduce it in qemu, that would be even better.
> >
> 
>   I am enclosing a demo that will echo sriov_totalvfs > /sys/bus/pci/devices/$PF_BDF/sriov_numvfs concurrently, which can help reproduce the problem, please find attached.

I see the patch below, but it needs to be tweaked into the usual
format for kernel patches.  See
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
for more details.  You can also browse the mailing list at
https://lore.kernel.org/linux-pci/ to see how other patches have been
posted.

> > Some comments on the patch below.
> > 
> > > Warning 1:
> > > ---
> > > sysfs: cannot create duplicate filename '/devices/pci0000:30/0000:30:02.0/pci_bus/0000:32'
> > > Call Trace:
> > >  dump_stack+0x6f/0xab
> > >  sysfs_warn_dup+0x56/0x70
> > >  sysfs_create_dir_ns+0x80/0x90
> > >  kobject_add_internal+0xa0/0x2b0
> > >  kobject_add+0x71/0xd0
> > >  device_add+0x126/0x630
> > >  pci_add_new_bus+0x17c/0x4b0
> > >  pci_iov_add_virtfn+0x336/0x390
> > >  sriov_enable+0x26e/0x450
> > >  virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]
> > > ---
> > > The reason is that different VFs may create the same pci bus number 
> > > and try to add new bus concurrently in virtfn_add_bus.
> > > 
> > > Warning 2:
> > > ---
> > > proc_dir_entry 'pci/33' already registered
> > > WARNING: CPU: 71 PID: 893 at fs/proc/generic.c:360 
> > > proc_register+0xf8/0x130 Call Trace:
> > >  proc_mkdir_data+0x5d/0x80
> > >  pci_proc_attach_device+0xe9/0x120
> > >  pci_bus_add_device+0x33/0x90
> > >  pci_iov_add_virtfn+0x375/0x390
> > >  sriov_enable+0x26e/0x450
> > >  virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]
> > > ---
> > > The reason is that different VFs may create '/proc/bus/pci/bus_number'
> > > directory using the same bus number in pci_proc_attach_device concurrently.
> > > 
> > > Mutex lock can avoid potential conflict. With the patch below the 
> > > warnings above are no longer appear.
> > > 
> > > My question is that any plan to support enable PCI SRIOV concurrently in kernel side?
> > > 
> > > Thanks
> > > 
> > > ---
> > > drivers/pci/iov.c | 29 +++++++++++++++++++++++++++--
> > >  1 file changed, 27 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index 
> > > 952217572113..6a8a849298c4 100644
> > > --- a/drivers/pci/iov.c
> > > +++ b/drivers/pci/iov.c
> > > @@ -16,6 +16,12 @@
> > >  
> > >  #define VIRTFN_ID_LEN    16
> > >  
> > > +static struct mutex add_bus_mutex;
> > > +static int add_bus_mutex_initialized;
> > > +
> > > +static struct mutex add_device_mutex; static int 
> > > +add_device_mutex_initialized;
> > > +
> > >  int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)  {
> > >      if (!dev->is_physfn)
> > > @@ -127,13 +133,24 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
> > >      if (bus->number == busnr)
> > >          return bus;
> > >  
> > > +    if (!add_bus_mutex_initialized) {
> > > +        mutex_init(&add_bus_mutex);
> > > +        add_bus_mutex_initialized = 1;
> > > +    }
> > 
> > I assume this patch works around the warning.  I see the intent here, but I think would need some rework before merging it.  These locks protect pci_add_new_bus() and pci_bus_add_device(), but only for the callers in iov.c.  These interfaces are both called from places other than iov.c, and any mutual exclusion should cover all of them.
> > 
> > I'm actually not sure how the other callers are protected.  I assume we're holding a device_lock for some device farther up the chain.  Or, I see that acpi_pci_root_add() and rescan_store() hold pci_rescan_remove_lock while calling these.  We don't seem to hold that uniformly though, which bothers me, because I think there are many other paths, e.g., pci_host_probe() and its callers.
> > 
> > > +    mutex_lock(&add_bus_mutex);
> > > +
> > >      child = pci_find_bus(pci_domain_nr(bus), busnr);
> > > -    if (child)
> > > +    if (child) {
> > > +        mutex_unlock(&add_bus_mutex);
> > >          return child;
> > > +    }
> > >  
> > >      child = pci_add_new_bus(bus, NULL, busnr);
> > > -    if (!child)
> > > +    if (!child) {
> > > +        mutex_unlock(&add_bus_mutex);
> > >          return NULL;
> > > +    }
> > > +    mutex_unlock(&add_bus_mutex);
> > >  
> > >      pci_bus_insert_busn_res(child, busnr, busnr);
> > >  
> > > @@ -339,8 +356,16 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> > >      if (rc)
> > >          goto failed1;
> > >  
> > > +    if (!add_device_mutex_initialized) {
> > > +        mutex_init(&add_device_mutex);
> > > +        add_device_mutex_initialized = 1;
> > > +    }
> > > +    mutex_lock(&add_device_mutex);
> > > +
> > >      pci_bus_add_device(virtfn);
> > >  
> > > +    mutex_unlock(&add_device_mutex);
> > > +
> > >      return 0;
> > >  
> > >  failed1:
> > > ---
> 
> I write a new patch can fix the problem above. I add a new function pci_add_new_bus_locked which will do find bus and add new bus with mutex locked. at most case in virtfn_add_bus, vf will find exiting bus and return, this is a fast path and no need mutex protect; if bus is not exiting, and different vf in a race will add the same bus, they should call pci_add_new_bus_locked, this is the slower patch but safe; 
> 
> I alse add a device_lock in pci_proc_attach_device when create bus->procdir, this will fix the conflict when different VFs may create '/proc/bus/pci/bus_number' directory using the same bus number concurrently
> 
> ---
>  drivers/pci/iov.c   |  7 ++++++-
>  drivers/pci/probe.c | 26 ++++++++++++++++++++++++++
>  drivers/pci/proc.c  |  6 +++++-
>  include/linux/pci.h |  2 ++
>  4 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 952217572113..cde0155749c5 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -127,11 +127,16 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
>  	if (bus->number == busnr)
>  		return bus;
>  
> +	/*
> +	 * here vf will find existing bus at most case; if not existing, it should
> +	 * go through slow path to create new bus with locked to support enable SRIOV
> +	 * concurrently with many different PFs in userspace.
> +	 */
>  	child = pci_find_bus(pci_domain_nr(bus), busnr);
>  	if (child)
>  		return child;
>  
> -	child = pci_add_new_bus(bus, NULL, busnr);
> +	child = pci_add_new_bus_locked(bus, NULL, busnr);
>  	if (!child)
>  		return NULL;
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c5286b027f00..5dc2a6774fa9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -25,6 +25,8 @@
>  #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
>  #define CARDBUS_RESERVE_BUSNR	3
>  
> +DEFINE_MUTEX(add_bus_mutex);
> +
>  static struct resource busn_resource = {
>  	.name	= "PCI busn",
>  	.start	= 0,
> @@ -1170,6 +1172,30 @@ struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
>  }
>  EXPORT_SYMBOL(pci_add_new_bus);
>  
> +struct pci_bus *pci_add_new_bus_locked(struct pci_bus *parent, struct pci_dev *dev,
> +                                int busnr)
> +{
> +        struct pci_bus *child;
> +
> +        mutex_lock(&add_bus_mutex);
> +        child = pci_find_bus(pci_domain_nr(parent), busnr);
> +        if (child) {
> +                mutex_unlock(&add_bus_mutex);
> +                return child;
> +        }
> +
> +        child = pci_alloc_child_bus(parent, dev, busnr);
> +        if (child) {
> +                down_write(&pci_bus_sem);
> +                list_add_tail(&child->node, &parent->children);
> +                up_write(&pci_bus_sem);
> +        }
> +        mutex_unlock(&add_bus_mutex);
> +
> +        return child;
> +}
> +EXPORT_SYMBOL(pci_add_new_bus_locked);
> +
>  static void pci_enable_crs(struct pci_dev *pdev)
>  {
>  	u16 root_cap = 0;
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index f967709082d6..f927263c2fe0 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -421,6 +421,7 @@ int pci_proc_attach_device(struct pci_dev *dev)
>  	if (!proc_initialized)
>  		return -EACCES;
>  
> +	device_lock(&bus->dev);
>  	if (!bus->procdir) {
>  		if (pci_proc_domain(bus)) {
>  			sprintf(name, "%04x:%02x", pci_domain_nr(bus),
> @@ -429,9 +430,12 @@ int pci_proc_attach_device(struct pci_dev *dev)
>  			sprintf(name, "%02x", bus->number);
>  		}
>  		bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
> -		if (!bus->procdir)
> +		if (!bus->procdir) {
> +			device_unlock(&bus->dev);
>  			return -ENOMEM;
> +		}
>  	}
> +	device_unlock(&bus->dev);
>  
>  	sprintf(name, "%02x.%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
>  	e = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR, bus->procdir,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 060af91bafcd..ec5b68b4c63d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1112,6 +1112,8 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
>  int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge);
>  struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
>  				int busnr);
> +struct pci_bus *pci_add_new_bus_locked(struct pci_bus *parent, struct pci_dev *dev,
> ++                                int busnr);
>  struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  				 const char *name,
>  				 struct hotplug_slot *hotplug);
> --

> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <dirent.h>
> #include <pthread.h>
> #include <sys/stat.h>
> 
> #include <fcntl.h>
> #include <string.h>
> 
> #define MAX_PATH_SIZE  1024
> #define MAX_PF_NUM     20
> #define VF_PATH   64
> #define VF_LEN    10
> #define DEVICE_DIR     "/sys/bus/pci/devices"
> #define STREQ(a, b) (strcmp(a, b) == 0)
> 
> typedef struct SriovEnableThread {
>     pthread_t thread;
>     char bdf[VF_PATH];
>     char totalVfs[VF_LEN];
> } SriovEnableThread;
> 
> static int FileWriteString(const char *path, const char *str)
> {
>     int fd = open(path, O_WRONLY | O_TRUNC);
>     if (fd == -1) {
>         return -1;
>     }
> 
>     if (write(fd, str, strlen(str)) < 0) {
>         close(fd);
>         return -1;
>     }
> 
>     if (close(fd) != 0) {
>         return -1;
>     }
> 
>     return 0;
> }
> 
> static int FileReadString(const char *file, char *buf, int len)
> {
>     int fd;
>     ssize_t sz;
> 
>     fd = open(file, O_RDONLY);
>     if (fd < 0) {
>         return -1;
>     }
> 
>     sz = read(fd, buf, len);
>     close(fd);
>     if (sz < 0) {
>         return -1;
>     }
> 
>     if (sz == len) {
>         printf("String len '%d' is too short to save %s\n", len, file);
>         buf[len - 1] = '\0';
>         return -1;
>     }
> 
>     buf[sz] = '\0';
>     return sz;
> }
> 
> static void *DeviceSriovEnable(void *arg)
> {
>     char numVfsPath[VF_PATH] = { 0 };
>     SriovEnableThread *sriovThread = (SriovEnableThread *)arg;
>     const char *bdf = sriovThread->bdf;
>     const char *totalVfs = sriovThread->totalVfs;
> 
>     printf("echo %s > /sys/bus/pci/devices/%s/sriov_numvfs\n", totalVfs, bdf);
> 
>     if (snprintf(numVfsPath, sizeof(numVfsPath) - 1,
>                    "%s/%s/sriov_numvfs", DEVICE_DIR, bdf) < 0) {
>         printf("Get device sriov_numvfs fail\n");
>         pthread_exit(NULL);
>     }
> 
>     if (FileWriteString(numVfsPath, totalVfs)) {
>         printf("enable '%s' sriov fail\n", bdf);
>         pthread_exit(NULL);
>     }
>     pthread_exit(NULL);
> }
> 
> static int DeviceCheckSriovEnable(const char *bdf)
> {
>     char path[VF_PATH] = { 0 };
>     int ret;
> 
>     ret = snprintf(path, sizeof(path) - 1,
>                      "%s/%s/sriov_totalvfs", DEVICE_DIR, bdf);
>     if (ret < 0) {
>         return ret;
>     }
> 
>     if (access(path, R_OK) != 0) {
>         return 0;
>     }
> 
>     return 1;
> }
> 
> static int DeviceReadValue(const char *bdf, const char *pattern, char *buffer, size_t len)
> {
>     char path[VF_PATH] = {0};
>     int ret;
> 
>     ret = snprintf(path, sizeof(path) - 1, "%s/%s/%s", DEVICE_DIR,
>                      bdf, pattern);
>     if (ret < 0) {
>         printf("Set devicePath fail\n");
>         return ret;
>     }
> 
>     if (FileReadString(path, buffer, len) < 0) {
>         printf("Read data from devicePath %s fail\n", path);
>         return -1;
>     }
> 
>     return 0;
> }
> 
> void main(int argc, char **argv)
> {
>     int ret;
>     DIR* dirp;
>     int i = 0;
>     struct dirent *dp = NULL;
>     char buffer[VF_LEN] = { 0 };
>     int sriovThreadLen = sizeof(SriovEnableThread) * MAX_PF_NUM;
> 
>     dirp = opendir(DEVICE_DIR);
>     if (!dirp) {
>         printf("Can not find %s\n", DEVICE_DIR);
>         return;
>     }
> 
>     SriovEnableThread *sriovThread = (SriovEnableThread *)malloc(sriovThreadLen);
>     if (!sriovThread) {
>         printf("Can not alloc sriovThread\n");
>         closedir(dirp);
>         return;
>     }
>     memset(sriovThread, 0, sriovThreadLen);
> 
>     while ((dp = readdir(dirp)) != NULL) {
>         if (STREQ(dp->d_name, ".") || STREQ(dp->d_name, "..")) {
>             continue;
>         }
> 
>         if (DeviceCheckSriovEnable(dp->d_name) <= 0) {
>             continue;
>         }
> 
>         if (DeviceReadValue(dp->d_name, "sriov_totalvfs", buffer, sizeof(buffer)) < 0) {
>             continue;
>         }
> 
>         if (i >= MAX_PF_NUM) {
>             printf("pf num is exceed max %d\n", MAX_PF_NUM);
>             break;
>         }
> 
>         strcpy(sriovThread[i].bdf, dp->d_name);
>         strcpy(sriovThread[i].totalVfs, buffer);
>         ret = pthread_create(&sriovThread[i].thread, NULL, DeviceSriovEnable,
>                              (void *)&sriovThread[i]);
>         if (ret) {
>             printf("create sriov thread %d for %s failed, ret : %d\n", i, sriovThread[i].bdf, ret);
>             break;
>         }
>         i++;
>     }
> 
>     closedir(dirp);
>     /* wait until all sriov enable thread finish */
>     for (int j = 0; j < i; j++) {
>         pthread_join(sriovThread[j].thread, NULL);
>     }
> 
>     printf("sriov enable finish\n");
>     free(sriovThread);
> }

