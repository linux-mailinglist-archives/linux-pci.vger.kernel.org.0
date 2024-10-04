Return-Path: <linux-pci+bounces-13804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6136C98FE02
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 09:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787CE1C20AC6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1414965B;
	Fri,  4 Oct 2024 07:45:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE971BDC8
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027948; cv=none; b=C2GmQtbhnr/m6/feWC1Z0Vlok1EjHjyyUNNdjAMWV0+tUOzQxc4ScTsuASPl9jSiDu4CbAPd7nNQCEBSMdJyZJr8Z8H3Ef7coFeayaDJCmN/JLAtee77mFErdMjtTg2GysQQ1g+jISgYXVa8diGOvVeo2dzKL5L+CTToQziLW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027948; c=relaxed/simple;
	bh=z49dwvUQ2xEsHA3orYC6yuXxckwT5hVRdj7QHCHGt2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARoNq5t/YMafECh2QzDujpgC8bB0gn9liE36pX/VbW2z9yf16RphCp5mArP7sf1W2KKblfeSN18KwkAH0ZT6/D89zWsPsd/oEm9CwoD23v++6mRwYz7wG71ZzuAy49SwNipM8ia3mt/+XS5T1Ufs0LGAtoLlu3p6EdggrwJ/4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 435712800F0A7;
	Fri,  4 Oct 2024 09:45:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2EE2E41BB23; Fri,  4 Oct 2024 09:45:36 +0200 (CEST)
Date: Fri, 4 Oct 2024 09:45:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
Cc: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"minipli@grsecurity.net" <minipli@grsecurity.net>
Subject: Re: UAF during boot on MTL based devices with attached dock
Message-ID: <Zv-dIHDXNNYomG2Y@wunner.de>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
 <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
 <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
 <Zv6gT96pHg2Jglxv@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6gT96pHg2Jglxv@wunner.de>

On Thu, Oct 03, 2024 at 03:46:55PM +0200, Lukas Wunner wrote:
> On Wed, Sep 25, 2024 at 03:38:34PM +0000, Wassenberg, Dennis wrote:
> > [    2.858063] Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] PREEMPT SMP NOPTI
> > [    2.858071] CPU: 13 UID: 0 PID: 137 Comm: irq/156-pciehp Not tainted 6.11.0-devel+ #3
> > [    2.858090] Hardware name: LENOVO 21LVS1CV00/21LVS1CV00, BIOS N45ET18W (1.08 ) 07/08/2024
> > [    2.858097] RIP: 0010:dev_driver_string+0x12/0x40
> > [    2.858111] Code: 5c c3 cc cc cc cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 47 68 48 85 c0 74 08 <48> 8b 00 c3 cc cc cc cc 48 8b 47 60 48 85 c0 75 ef 48 8b 97 a8 02
> > [    2.858123] RSP: 0000:ffff9493009cfa00 EFLAGS: 00010202
> > [    2.858132] RAX: 6b6b6b6b6b6b6b6b RBX: ffff8e53029cb918 RCX: 0000000000000000
> > [    2.858139] RDX: ffffffffa586b18a RSI: ffff8e53029cb918 RDI: ffff8e53029cb918
> > [    2.858144] RBP: ffff9493009cfb10 R08: 0000000000000000 R09: ffff8e5304f61000
> > [    2.858150] R10: ffff9493009cfb20 R11: 0000000000005627 R12: ffffffffa64db188
> > [    2.858156] R13: 6b6b6b6b6b6b6b6b R14: 0000000000000080 R15: ffff8e5302b1c0c0
> > [    2.858161] FS:  0000000000000000(0000) GS:ffff8e5a50140000(0000) knlGS:0000000000000000
> > [    2.858169] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    2.858175] CR2: 0000000000000000 CR3: 000000030162e001 CR4: 0000000000f70ef0
> > [    2.858182] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [    2.858187] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> > [    2.858193] PKRU: 55555554
> > [    2.858196] Call Trace:
> [...]
> > [    2.858258]  __dynamic_dev_dbg+0x170/0x210
> > [    2.858287]  pci_destroy_slot+0x59/0x60
> > [    2.858296]  pciehp_remove+0x2e/0x50
> > [    2.858304]  pcie_port_remove_service+0x30/0x50
> > [    2.858311]  device_release_driver_internal+0x19f/0x200
> > [    2.858322]  bus_remove_device+0xc6/0x130
> > [    2.858335]  device_del+0x165/0x3f0
> > [    2.858348]  device_unregister+0x17/0x60
> > [    2.858355]  remove_iter+0x1f/0x30
> > [    2.858361]  device_for_each_child+0x6a/0xb0
> > [    2.858368]  pcie_portdrv_remove+0x2f/0x60
> > [    2.858374]  pci_device_remove+0x3f/0xa0
> > [    2.858383]  device_release_driver_internal+0x19f/0x200
> > [    2.858392]  bus_remove_device+0xc6/0x130
> > [    2.858398]  device_del+0x165/0x3f0
> > [    2.858413]  pci_remove_bus_device+0x91/0x140
> > [    2.858422]  pci_remove_bus_device+0x3e/0x140
> > [    2.858430]  pciehp_unconfigure_device+0x98/0x160
> > [    2.858439]  pciehp_disable_slot+0x69/0x130
> > [    2.858447]  pciehp_handle_presence_or_link_change+0x281/0x4c0
> > [    2.858456]  pciehp_ist+0x14a/0x150
> 
> Could you try the patch below and report back if it fixes the issue?

So the patch I sent you yesterday was based on the insight that
in the stack trace above, pci_destroy_slot() accesses slot->bus
after bus has been destroyed.

The slot is not a child of bus, so doesn't implicitly hold a reference
on bus.  The only kobjects holding references on bus are the child
devices of the bus, and they're destroyed before the bus gets destroyed.
The logical conclusion was that slot needs to hold a reference on bus
to avoid a use-after-free.

However looking at the stacktrace with a fresh pair of eyeballs,
I notice there's an oddity here:  The kernel normally unbinds drivers
from PCI devices in pci_stop_dev().  The actual removal of the devices
happens in a separate step, pci_remove_bus_device().

I note that in your stacktrace, driver unbinding happens from
pci_remove_bus_device().  That's unexpected.  The driver should
have already been unbound earlier in pci_stop_dev().

Perhaps the pcieport driver was rebound to the device after it was
already unbound.  The patch below should prevent that.

There are no messages though that would prove rebinding of a hotplug port.

The unplug event happens at the top of the hierarchy (below the Root Port).
So pci_bus_add_devices() binds the Root Port, its driver starts stopping
and removing the hierarchy below, all the while pci_bus_add_devices()
continues binding drivers to the child devices.

Could you try this patch (in addition to the one below and to the one
I sent yesterday):

https://lore.kernel.org/all/20241003084342.27501-1-brgl@bgdev.pl/

It should prevent pci_bus_add_devices() from racing with pciehp stopping
and removing devices.

BTW, are you using a stock kernel or do you have any custom patches
(such as grsecurity) applied on top which might lead to a different
behavior than a stock kernel?

Thanks,

Lukas

-- >8 --

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 387db92..1b38d79 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -36,6 +36,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 	if (pci_dev_is_added(dev)) {
 		device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
 				      pci_pwrctl_unregister);
+		dev->match_driver = false;
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);

