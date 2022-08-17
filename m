Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78059771C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 21:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiHQTtz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 15:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHQTty (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 15:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3056AA4B09;
        Wed, 17 Aug 2022 12:49:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92D2461348;
        Wed, 17 Aug 2022 19:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41C4C433C1;
        Wed, 17 Aug 2022 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660765789;
        bh=a6yNCOlCXbSKLl7iQsjrIR9DzIi926gIXfQwrRDpQGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O3oMA+E7HqBocJBYV4nczlTt3vsMY7qQyv2Ubf0Pi47TQX2tiefVv+rEGg0DBNu/R
         S4lwfhjIMAkQlHCVDFsLc2A/JdpAY5vMDQK0aSolJAyA4vwT0N6L3wYHMI58oR5KKH
         CVefl1SJvIP6CNNLpUxvighGhgzQh2MqGVA4gDrYCXZiZw2n3Iav896BgrI6ybFkN7
         sPtcZjTMEx/kKvyMp4dfSD9lisu4vEq5SJoX1FYMo4L6L2Po3LJPk49Z2C4nhoGE3B
         imn97+k3ke4nWlD5iaue7YBTCLm7gfLSOXizk6ZAl6ToOE49dAkhZB5TTXCm7rKZNh
         I5MH2G5NdBmPQ==
Date:   Wed, 17 Aug 2022 14:49:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        zhuangshengen <zhuangshengen@huawei.com>
Subject: Re: [Question] Any plan to support enable PCI SRIOV concurrently in
 kernel side?
Message-ID: <20220817194947.GA2270629@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a8ce5714e2d4eed909cb096d4832036@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 17, 2022 at 07:43:34AM +0000, Zhoujian (jay) wrote:
> Hi,
> 
> Enable SRIOV concurrently with many different PFs in userspace seems workable.
> I'm trying to do it with 8 PFs(each one with 240+ VFs), but get some warnings,
> here is the backtrace:

This definitely seems like a problem that should be fixed.  If you
have a script that can reproduce it, that might help people work on
it.  If you can reproduce it in qemu, that would be even better.

Some comments on the patch below.

> Warning 1:
> ---
> sysfs: cannot create duplicate filename '/devices/pci0000:30/0000:30:02.0/pci_bus/0000:32'
> Call Trace:
>  dump_stack+0x6f/0xab
>  sysfs_warn_dup+0x56/0x70
>  sysfs_create_dir_ns+0x80/0x90
>  kobject_add_internal+0xa0/0x2b0
>  kobject_add+0x71/0xd0
>  device_add+0x126/0x630
>  pci_add_new_bus+0x17c/0x4b0
>  pci_iov_add_virtfn+0x336/0x390
>  sriov_enable+0x26e/0x450
>  virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]
> ---
> The reason is that different VFs may create the same pci bus number
> and try to add new bus concurrently in virtfn_add_bus.
> 
> Warning 2:
> ---
> proc_dir_entry 'pci/33' already registered
> WARNING: CPU: 71 PID: 893 at fs/proc/generic.c:360 proc_register+0xf8/0x130
> Call Trace:
>  proc_mkdir_data+0x5d/0x80
>  pci_proc_attach_device+0xe9/0x120
>  pci_bus_add_device+0x33/0x90
>  pci_iov_add_virtfn+0x375/0x390
>  sriov_enable+0x26e/0x450
>  virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]
> ---
> The reason is that different VFs may create '/proc/bus/pci/bus_number'
> directory using the same bus number in pci_proc_attach_device concurrently.
> 
> Mutex lock can avoid potential conflict. With the patch below the warnings above
> are no longer appear.
> 
> My question is that any plan to support enable PCI SRIOV concurrently in kernel side?
> 
> Thanks
> 
> ---
> drivers/pci/iov.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 952217572113..6a8a849298c4 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -16,6 +16,12 @@
>  
>  #define VIRTFN_ID_LEN    16
>  
> +static struct mutex add_bus_mutex;
> +static int add_bus_mutex_initialized;
> +
> +static struct mutex add_device_mutex;
> +static int add_device_mutex_initialized;
> +
>  int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
>  {
>      if (!dev->is_physfn)
> @@ -127,13 +133,24 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
>      if (bus->number == busnr)
>          return bus;
>  
> +    if (!add_bus_mutex_initialized) {
> +        mutex_init(&add_bus_mutex);
> +        add_bus_mutex_initialized = 1;
> +    }

I assume this patch works around the warning.  I see the intent here,
but I think would need some rework before merging it.  These locks
protect pci_add_new_bus() and pci_bus_add_device(), but only for the
callers in iov.c.  These interfaces are both called from places other
than iov.c, and any mutual exclusion should cover all of them.

I'm actually not sure how the other callers are protected.  I assume
we're holding a device_lock for some device farther up the chain.  Or,
I see that acpi_pci_root_add() and rescan_store() hold
pci_rescan_remove_lock while calling these.  We don't seem to hold
that uniformly though, which bothers me, because I think there are
many other paths, e.g., pci_host_probe() and its callers.

> +    mutex_lock(&add_bus_mutex);
> +
>      child = pci_find_bus(pci_domain_nr(bus), busnr);
> -    if (child)
> +    if (child) {
> +        mutex_unlock(&add_bus_mutex);
>          return child;
> +    }
>  
>      child = pci_add_new_bus(bus, NULL, busnr);
> -    if (!child)
> +    if (!child) {
> +        mutex_unlock(&add_bus_mutex);
>          return NULL;
> +    }
> +    mutex_unlock(&add_bus_mutex);
>  
>      pci_bus_insert_busn_res(child, busnr, busnr);
>  
> @@ -339,8 +356,16 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>      if (rc)
>          goto failed1;
>  
> +    if (!add_device_mutex_initialized) {
> +        mutex_init(&add_device_mutex);
> +        add_device_mutex_initialized = 1;
> +    }
> +    mutex_lock(&add_device_mutex);
> +
>      pci_bus_add_device(virtfn);
>  
> +    mutex_unlock(&add_device_mutex);
> +
>      return 0;
>  
>  failed1:
> ---
