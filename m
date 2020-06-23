Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BC320450F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 02:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgFWAN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 20:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731000AbgFWAN1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 20:13:27 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2794920842;
        Tue, 23 Jun 2020 00:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871206;
        bh=d5xAr8TB5Ztb8xg3QmZTtbiblzCIdsENBQxTKmkulbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oKjnC4kx8Gdy3hmPcU1cFKM3b/+bCU+SyIHeRwQ4PgGjvWLpjoLWIqgsOXjxagctt
         UU5cehoCveiPDas0pmW24ROHR/qGQdOcXfJQAutwEQMfOsOtYgFLS0NckPONr9DvPy
         eWHcjjwNV4822iDtjUFrJsfBPu1ZmzdbWCV6Sx/g=
Date:   Mon, 22 Jun 2020 19:13:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, kernel-team@android.com
Subject: Re: [PATCH] PCI/IOV: Plug VF bus creation race
Message-ID: <20200623001324.GA2339302@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607094348.162660-1-maz@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 07, 2020 at 10:43:48AM +0100, Marc Zyngier wrote:
> On a system that creates VFs for multiple PFs in parallel (in
> this case, network bringup at boot time), and when these VFs
> end-up on the same bus, bad things sometimes happen:
> 
> [   12.755534] sysfs: cannot create duplicate filename '/devices/platform/soc/fc000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/pci_bus/0000:04'
> [   12.755700] pci 0000:04:10.1: [8086:10ca] type 00 class 0x020000
> [   12.763785] CPU: 1 PID: 581 Comm: vfs Tainted: G            E     5.7.0-00033-g002d24ebd695 #1119
> [   12.770402] igb 0000:03:00.1: 1 VFs allocated
> [   12.778493] Hardware name: amlogic w400/w400, BIOS 2020.01-rc5 03/12/2020
> [   12.778496] Call trace:
> [   12.778506]  dump_backtrace+0x0/0x1d0
> [   12.778511]  show_stack+0x20/0x30
> [   12.778516]  dump_stack+0xb8/0x100
> [   12.778520]  sysfs_warn_dup+0x6c/0x88
> [   12.778530]  sysfs_create_dir_ns+0xe8/0x100
> [   12.778535]  kobject_add_internal+0xe0/0x3a0
> [   12.778541]  kobject_add+0x94/0x100
> [   12.817654]  device_add+0x104/0x7b8
> [   12.821100]  device_register+0x28/0x38
> [   12.824810]  pci_add_new_bus+0x1f8/0x488
> [   12.828692]  pci_iov_add_virtfn+0x2c8/0x360
> [   12.832830]  sriov_enable+0x200/0x458
> [   12.836452]  pci_enable_sriov+0x20/0x38
> [   12.840282]  igb_enable_sriov+0x148/0x290 [igb]
> [   12.844745]  igb_pci_sriov_configure+0x40/0x80 [igb]
> [   12.849650]  sriov_numvfs_store+0xb0/0x1a0
> [   12.853703]  dev_attr_store+0x20/0x38
> [   12.857327]  sysfs_kf_write+0x4c/0x60
> [   12.860947]  kernfs_fop_write+0x104/0x220
> [   12.864916]  __vfs_write+0x24/0x50
> [   12.868279]  vfs_write+0xec/0x1d8
> [   12.871556]  ksys_write+0x74/0x100
> [   12.874919]  __arm64_sys_write+0x24/0x30
> [   12.878802]  el0_svc_common.constprop.0+0x7c/0x1f8
> [   12.883544]  do_el0_svc+0x2c/0x98
> [   12.886824]  el0_svc+0x18/0x48
> [   12.889841]  el0_sync_handler+0x120/0x290
> [   12.893808]  el0_sync+0x158/0x180
> [   12.897143] kobject_add_internal failed for 0000:04 with -EEXIST, don't try to register things with the same name in the same directory.
> [   12.897634] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
> 
> It turns out that virtfn_add_bus() doesn't hold any lock, which
> means there is a potential race between checking that the bus
> exists already, and adding it if it doesn't.
> 
> A per-device lock wouldn't help, as this happens when multiple
> PFs insert their respective VFs concurrently.
> 
> Instead, let's introduce new mutex, private to the IOV subsystem,
> that gets taken when dealing with a virtfn bus (either creation
> or destruction). This ensures that these operations get serialized.

Definitely a problem, but I don't think it's really specific to IOV,
is it?  I see a similar pattern of pci_find_bus() followed by
pci_add_new_bus() other places, too:

  virtfn_add_bus()
  of_scan_pci_bridge()         # powerpc, but not sparc
  pci_scan_bridge_extend()

It kind of feels like we should do something that solves this problem
for everybody.  Maybe the other places aren't susceptible to the race,
but I'm not sure how one would prove that.

Maybe we could make it so pci_add_new_bus() returns NULL if the
desired bus already exists (with the appropriate internal locking, of
course), so pci_find_bus() wouldn't be needed in those cases?

> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/iov.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4d1f392b05f9..d92d1930b96c 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -76,6 +76,9 @@ static int compute_max_vf_buses(struct pci_dev *dev)
>  	return rc;
>  }
>  
> +static DEFINE_MUTEX(pci_iov_bus_lock);
> +
> +/* pci_iov_bus_lock must be held */
>  static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
>  {
>  	struct pci_bus *child;
> @@ -96,6 +99,7 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
>  	return child;
>  }
>  
> +/* pci_iov_bus_lock must be held */
>  static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
>  {
>  	if (physbus != virtbus && list_empty(&virtbus->devices))
> @@ -144,6 +148,8 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	struct pci_sriov *iov = dev->sriov;
>  	struct pci_bus *bus;
>  
> +	mutex_lock(&pci_iov_bus_lock);
> +
>  	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
>  	if (!bus)
>  		goto failed;
> @@ -195,6 +201,8 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  
>  	pci_bus_add_device(virtfn);
>  
> +	mutex_unlock(&pci_iov_bus_lock);
> +
>  	return 0;
>  
>  failed2:
> @@ -205,6 +213,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  failed0:
>  	virtfn_remove_bus(dev->bus, bus);
>  failed:
> +	mutex_unlock(&pci_iov_bus_lock);
>  
>  	return rc;
>  }
> @@ -231,7 +240,10 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
>  		sysfs_remove_link(&virtfn->dev.kobj, "physfn");
>  
>  	pci_stop_and_remove_bus_device(virtfn);
> +
> +	mutex_lock(&pci_iov_bus_lock);
>  	virtfn_remove_bus(dev->bus, virtfn->bus);
> +	mutex_unlock(&pci_iov_bus_lock);
>  
>  	/* balance pci_get_domain_bus_and_slot() */
>  	pci_dev_put(virtfn);
> -- 
> 2.26.2
> 
