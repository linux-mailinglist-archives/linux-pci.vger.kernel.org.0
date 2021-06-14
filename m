Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC53A6D58
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jun 2021 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhFNRpU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Jun 2021 13:45:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48506 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhFNRpT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jun 2021 13:45:19 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2395E20B83C2;
        Mon, 14 Jun 2021 10:43:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2395E20B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623692596;
        bh=XLwzXvw1RAJgBw5gzYZsnOoVRak/mGbyImQenQwQgTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KDiTxvhV21kHIkj9uRaQCnKT/bQk9BjdKvPVWn/he4Wur7x+Fs+2A8si/Lj5wMKQp
         +h67xcKi22RxUYdz9MECaH953kDQ2T+j/jBolGtN7LYAMAs/rhUqk/VsBOyonJDMlx
         Dr1KurFPY0Fzcqqy6zXjVYVcZdWyvBTl++8WpxjQ=
Date:   Mon, 14 Jun 2021 12:43:14 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Xingxing Su <suxingxing@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH] PCI: Don't use Printk in raw_spinlocks
Message-ID: <20210614174314.GU4910@sequoia>
References: <CAL_JsqKVn+e-eX+=kkSXxdwAmJUahrTdhuBKfVCXVZ8bQJ5MUw@mail.gmail.com>
 <20200910184627.GA804924@bjorn-Precision-5520>
 <20210330205332.GE4749@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330205332.GE4749@sequoia>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-03-30 15:53:35, Tyler Hicks wrote:
> On 2020-09-10 13:46:27, Bjorn Helgaas wrote:
> > On Thu, Sep 10, 2020 at 08:21:06AM -0600, Rob Herring wrote:
> > > On Wed, Sep 9, 2020 at 8:07 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > [+cc Mark, Florian, Rob, Scott]
> > > >
> > > > On Sat, Aug 01, 2020 at 09:25:49AM +0800, Xingxing Su wrote:
> > > > > Do not use printk in raw_spinlocks,
> > > > > it will cause BUG: Invalid wait context.
> > > > >
> > > > > The trace reported by lockdep follows.
> > > > >
> > > > > [    2.986113] =============================
> > > > > [    2.986115] [ BUG: Invalid wait context ]
> > > > > [    2.986116] 5.8.0-rc1+ #11 Not tainted
> > > > > [    2.986118] -----------------------------
> > > > > [    2.986120] swapper/0/1 is trying to lock:
> > > > > [    2.986122] ffffffff80f5ddd8 (console_owner){....}-{3:3}, at: console_unlock+0x284/0x820
> > > > > [    2.986130] other info that might help us debug this:
> > > > > [    2.986132] context-{5:5}
> > > > > [    2.986134] 3 locks held by swapper/0/1:
> > > > > [    2.986135]  #0: 98000007fa03c990 (&dev->mutex){....}-{0:0}, at: device_driver_attach+0x28/0x90
> > > > > [    2.986144]  #1: ffffffff80fb83a8 (pci_lock){....}-{2:2}, at: pci_bus_write_config_word+0x60/0xb8
> > > > > [    2.986152]  #2: ffffffff80f5ded0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x1b0/0x3b8
> > > > > [    2.986161] stack backtrace:
> > > > > [    2.986163] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc1+ #11
> > > > > [    2.986164] Stack : 0000000000001d67 98000000030be9b0 0000000000000001 7b2aba74f6c4785b
> > > > > [    2.986172]         7b2aba74f6c4785b 0000000000000000 98000007f89cb438 ffffffff80e7dc80
> > > > > [    2.986181]         0000000000000001 000000000000000a 0000000000000001 0000000000000001
> > > > > [    2.986189]         ffffffff80f4e156 fffffffffffffffd ffffffff80cc2d98 fffffffff8000000
> > > > > [    2.986197]         0000000024000000 ffffffff80f40000 0000000000000000 0000000000000000
> > > > > [    2.986205]         ffffffff9500cce0 0000000000000000 ffffffff80f50000 ffffffff81546318
> > > > > [    2.986213]         ffffffff81c4c3c0 0000000000000018 ffffffffbc000000 0000000000000000
> > > > > [    2.986221]         ffffffff81340000 98000007f89c8000 98000007f89cb430 98000007f8a00000
> > > > > [    2.986229]         ffffffff806be568 0000000000000000 0000000000000000 0000000000000000
> > > > > [    2.986237]         0000000000000000 0000000000000000 ffffffff80211c1c 7b2aba74f6c4785b
> > > > > [    2.986245]         ...
> > > > > [    2.986250] Call Trace:
> > > > > [    2.986251] [<ffffffff80211c1c>] show_stack+0x9c/0x130
> > > > > [    2.986253] [<ffffffff806be568>] dump_stack+0xe8/0x150
> > > > > [    2.986255] [<ffffffff802ad408>] __lock_acquire+0x570/0x3250
> > > > > [    2.986257] [<ffffffff802abed0>] lock_acquire+0x118/0x558
> > > > > [    2.986259] [<ffffffff802be764>] console_unlock+0x2e4/0x820
> > > > > [    2.986261] [<ffffffff802c0a68>] vprintk_emit+0x1c0/0x3b8
> > > > > [    2.986263] [<ffffffff807f45a8>] dev_vprintk_emit+0x1c8/0x210
> > > > > [    2.986265] [<ffffffff807f462c>] dev_printk_emit+0x3c/0x60
> > > > > [    2.986267] [<ffffffff807f499c>] _dev_warn+0x5c/0x80
> > > > > [    2.986269] [<ffffffff806eea9c>] pci_generic_config_write32+0x154/0x160
> > > > > [    2.986271] [<ffffffff806edca4>] pci_bus_write_config_word+0x84/0xb8
> > > > > [    2.986273] [<ffffffff806f1664>] pci_setup_device+0x22c/0x768
> > > > > [    2.986275] [<ffffffff806f26a0>] pci_scan_single_device+0xc8/0x100
> > > > > [    2.986277] [<ffffffff806f2788>] pci_scan_slot+0xb0/0x178
> > > > > [    2.986279] [<ffffffff806f3ae4>] pci_scan_child_bus_extend+0x5c/0x370
> > > > > [    2.986281] [<ffffffff806f407c>] pci_scan_root_bus_bridge+0x6c/0xf0
> > > > > [    2.986283] [<ffffffff806f411c>] pci_host_probe+0x1c/0xd8
> > > > > [    2.986285] [<ffffffff807fa03c>] platform_drv_probe+0x54/0xb8
> > > > > [    2.986287] [<ffffffff807f71f8>] really_probe+0x130/0x388
> > > > > [    2.986289] [<ffffffff807f7594>] driver_probe_device+0x64/0xd8
> > > > > [    2.986291] [<ffffffff807f7844>] device_driver_attach+0x84/0x90
> > > > > [    2.986293] [<ffffffff807f7918>] __driver_attach+0xc8/0x128
> > > > > [    2.986295] [<ffffffff807f4cac>] bus_for_each_dev+0x74/0xd8
> > > > > [    2.986297] [<ffffffff807f6408>] bus_add_driver+0x170/0x250
> > > > > [    2.986299] [<ffffffff807f899c>] driver_register+0x84/0x150
> > > > > [    2.986301] [<ffffffff80200b08>] do_one_initcall+0x98/0x458
> > > > > [    2.986303] [<ffffffff810212dc>] kernel_init_freeable+0x2c0/0x36c
> > > > > [    2.986305] [<ffffffff80be7540>] kernel_init+0x10/0x128
> > > > > [    2.986307] [<ffffffff80209d44>] ret_from_kernel_thread+0x14/0x1c
> > > > >
> > > > > Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
> > > > > ---
> > > > >  drivers/pci/access.c | 3 ---
> > > > >  1 file changed, 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > > > > index 79c4a2e..b3fc164 100644
> > > > > --- a/drivers/pci/access.c
> > > > > +++ b/drivers/pci/access.c
> > > > > @@ -160,9 +160,6 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
> > > > >        * write happen to have any RW1C (write-one-to-clear) bits set, we
> > > > >        * just inadvertently cleared something we shouldn't have.
> > > > >        */
> > > > > -     dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> > > > > -                          size, pci_domain_nr(bus), bus->number,
> > > > > -                          PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> > > >
> > > > We just changed this printk (see [1]), but I think we still have this
> > > > lockdep problem even after Mark's change.  So I guess we need another
> > > > think about this.
> > > >
> > > > Maybe we can print something when registering pci_ops that use
> > > > pci_generic_config_write32()?
> > > 
> > > That was my suggestion, but as Mark pointed out that doesn't work if
> > > pci_generic_config_write32 is wrapped (which is 4 out of 8 cases).
> > > 
> > > Also, 3 of the cases are only for the root bus (bridge). Are 32-bit
> > > writes to a bridge going to cause problems? For xgene, interestingly,
> > > with DT _write32 is needed, but for ACPI it is not (only _read32). I
> > > think xgene is practically dead though a few people still have
> > > systems, but likely xgene with DT is really dead. The ECAM case was
> > > for QCom server which is also pretty much dead. SA1100 nano-engine is
> > > really old and something only a few people have at most (Russell
> > > King). So ignoring all those, we're left with just loongson and iproc.
> > > Maybe just remove the warning?
> > 
> > Sigh, removing it sounds like the best option.
> 
> Hi Bjorn - Was this lockdep issue fixed in a different way than removing
> the use of printk? I'm mostly interested in reducing the RW1C warnings
> as Mark suggested here:
> 
>  https://lore.kernel.org/lkml/20200806041455.11070-1-mark.tomlinson@alliedtelesis.co.nz/
> 
> While thinking how best to rejuvenate that patch, I came across this
> thread in the archives and it seems like the plan shifted to completely
> removing this printk callsite to address the lockdep issue. However,
> neither patch ended up in Linus' tree nor in the current PCI tree (I
> only peeked in the next branch).
> 
> What's everyone's preference at this point?

Hi Bjorn - friendly ping on this topic. Thanks!

Tyler

> 
> Thanks!
> 
> Tyler
