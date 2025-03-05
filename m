Return-Path: <linux-pci+bounces-22943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBD5A4F6D2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1F816B72F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3886192B65;
	Wed,  5 Mar 2025 06:06:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00862E338F;
	Wed,  5 Mar 2025 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154799; cv=none; b=NI7vxksbG6A3iW4hB6bANrb6Ud6eAvK5elD/rdS11TPWNkCaAvFevUOFFCG2y1JvBVr6pDxYR1xcNPZjCkrEqeJnR08UEuGIApCy4mOLL9vY5d3Gs6NvaOdUbNJb2ce2uUFzn+jP/W5H2+zgaWZQcq4e0kEetq1exbxbOjxLp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154799; c=relaxed/simple;
	bh=mzD79kVQJ6SYllaNgoJTgwzJhnElyjKU14NftKqBcSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ5FInrSv+FxcdeulVlsMr+Mx1/0QsUEAR0BviANS/1n9qx3n0CEndRvf3yxRmIEK8brI+Dk0v67MB/F70+BPczcNWhYqnurDoO8Adue5U36KByAbbEwKLQSjJ94rQpp00JxZGbBo1sf8m3Ay2XE6HRaMoCxak2/91Ct8rvEEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15277C4CEE2;
	Wed,  5 Mar 2025 06:06:30 +0000 (UTC)
Date: Wed, 5 Mar 2025 11:36:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bo Sun <Bo.Sun.CN@windriver.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Kexin.Hao@windriver.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when
 PCI_PROBE_ONLY is enabled
Message-ID: <20250305060607.ygsafql53h2ujwjp@thinkpad>
References: <20250117082428.129353-1-Bo.Sun.CN@windriver.com>
 <20250210103707.c5ubeaowk7xwt6p5@thinkpad>
 <df5d3c54-d436-43bb-8b40-665c020d6bb5@windriver.com>
 <20250214170057.o3ffoiuxn4hxqqqe@thinkpad>
 <55a33534-bff0-488c-a2a2-2898d54bd62f@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55a33534-bff0-488c-a2a2-2898d54bd62f@windriver.com>

On Fri, Feb 28, 2025 at 07:58:10PM +0800, Bo Sun wrote:
> On 2/15/25 1:00 AM, Manivannan Sadhasivam wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Wed, Feb 12, 2025 at 03:07:56PM +0800, Bo Sun wrote:
> > > On 2/10/25 18:37, Manivannan Sadhasivam wrote:
> > > > CAUTION: This email comes from a non Wind River email account!
> > > > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > > > 
> > > > On Fri, Jan 17, 2025 at 04:24:14PM +0800, Bo Sun wrote:
> > > > > On our Marvell OCTEON CN96XX board, we observed the following panic on
> > > > > the latest kernel:
> > > > > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> > > > > Mem abort info:
> > > > >     ESR = 0x0000000096000005
> > > > >     EC = 0x25: DABT (current EL), IL = 32 bits
> > > > >     SET = 0, FnV = 0
> > > > >     EA = 0, S1PTW = 0
> > > > >     FSC = 0x05: level 1 translation fault
> > > > > Data abort info:
> > > > >     ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> > > > >     CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > > > >     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > > > [0000000000000080] user address but active_mm is swapper
> > > > > Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> > > > > Modules linked in:
> > > > > CPU: 9 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc7-00149-g9bffa1ad25b8 #1
> > > > > Hardware name: Marvell OcteonTX CN96XX board (DT)
> > > > > pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > pc : of_pci_add_properties+0x278/0x4c8
> > > > > lr : of_pci_add_properties+0x258/0x4c8
> > > > > sp : ffff8000822ef9b0
> > > > > x29: ffff8000822ef9b0 x28: ffff000106dd8000 x27: ffff800081bc3b30
> > > > > x26: ffff800081540118 x25: ffff8000813d2be0 x24: 0000000000000000
> > > > > x23: ffff00010528a800 x22: ffff000107c50000 x21: ffff0001039c2630
> > > > > x20: ffff0001039c2630 x19: 0000000000000000 x18: ffffffffffffffff
> > > > > x17: 00000000a49c1b85 x16: 0000000084c07b58 x15: ffff000103a10f98
> > > > > x14: ffffffffffffffff x13: ffff000103a10f96 x12: 0000000000000003
> > > > > x11: 0101010101010101 x10: 000000000000002c x9 : ffff800080ca7acc
> > > > > x8 : ffff0001038fd900 x7 : 0000000000000000 x6 : 0000000000696370
> > > > > x5 : 0000000000000000 x4 : 0000000000000002 x3 : ffff8000822efa40
> > > > > x2 : ffff800081341000 x1 : ffff000107c50000 x0 : 0000000000000000
> > > > > Call trace:
> > > > >    of_pci_add_properties+0x278/0x4c8 (P)
> > > > >    of_pci_make_dev_node+0xe0/0x158
> > > > >    pci_bus_add_device+0x158/0x210
> > > > >    pci_bus_add_devices+0x40/0x98
> > > > >    pci_host_probe+0x94/0x118
> > > > >    pci_host_common_probe+0x120/0x1a0
> > > > >    platform_probe+0x70/0xf0
> > > > >    really_probe+0xb4/0x2a8
> > > > >    __driver_probe_device+0x80/0x140
> > > > >    driver_probe_device+0x48/0x170
> > > > >    __driver_attach+0x9c/0x1b0
> > > > >    bus_for_each_dev+0x7c/0xe8
> > > > >    driver_attach+0x2c/0x40
> > > > >    bus_add_driver+0xec/0x218
> > > > >    driver_register+0x68/0x138
> > > > >    __platform_driver_register+0x2c/0x40
> > > > >    gen_pci_driver_init+0x24/0x38
> > > > >    do_one_initcall+0x4c/0x278
> > > > >    kernel_init_freeable+0x1f4/0x3d0
> > > > >    kernel_init+0x28/0x1f0
> > > > >    ret_from_fork+0x10/0x20
> > > > > Code: aa1603e1 f0005522 d2800044 91000042 (f94040a0)
> > > > > 
> > > > > This regression was introduced by commit 7246a4520b4b ("PCI: Use
> > > > > preserve_config in place of pci_flags"). On our board, the 002:00:07.0
> > > > > bridge is misconfigured by the bootloader. Both its secondary and
> > > > > subordinate bus numbers are initialized to 0, while its fixed secondary
> > > > > bus number is set to 8.
> > > > 
> > > > What do you mean by 'fixed secondary bus number'?
> > > > 
> > > 
> > > The 'fixed secondary bus number' refers to the value returned by the
> > > function pci_ea_fixed_busnrs(), which reads the fixed Secondary and
> > > Subordinate bus numbers from the EA (Extended Attributes) capability, if
> > > present.
> > 
> > Thanks! It'd be good to mention the EA capability.
> > 
> > > In the code at drivers/pci/probe.c, line 1439, we have the
> > > following:
> > > 
> > >                /* Read bus numbers from EA Capability (if present) */
> > >                fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> > >                if (fixed_buses)
> > >                        next_busnr = fixed_sec;
> > >                else
> > >                        next_busnr = max + 1;
> > > 
> > > > > However, bus number 8 is also assigned to another
> > > > > bridge (0002:00:0f.0). Although this is a bootloader issue, before the
> > > > > change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was
> > > > > set by default when PCI_PROBE_ONLY was enabled, ensuing that all the
> > > > > bus number for these bridges were reassigned, avoiding any conflicts.
> > > > > 
> > > > 
> > > > Isn't the opposite? PCI_REASSIGN_ALL_BUS was only added if the PCI_PROBE_ONLY
> > > > flag was not set:
> > > > 
> > > >           /* Do not reassign resources if probe only */
> > > >           if (!pci_has_flag(PCI_PROBE_ONLY))
> > > >                   pci_add_flags(PCI_REASSIGN_ALL_BUS);
> > > > 
> > > 
> > > Yes, you are correct. It’s a typo; it should be "when PCI_PROBE_ONLY was not
> > > enabled." I will fix this in v2.
> > > 
> > > > 
> > > > > After the change introduced in commit 7246a4520b4b, the bus numbers
> > > > > assigned by the bootloader are reused by all other bridges, except
> > > > > the misconfigured 002:00:07.0 bridge. The kernel attempt to reconfigure
> > > > > 002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
> > > > > bootloader. However, since a pci_bus has already been allocated for
> > > > > bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
> > > > > 002:00:07.0.
> > > > 
> > > > How come 0002:00:0f.0 is enumerated before 0002:00:07.0 in a depth first manner?
> > > > 
> > > 
> > > The device 0002:00:07.0 is actually enumerated before 0002:00:0f.0, but it
> > > appears misconfigured. The kernel attempts to reconfigure it during
> > > initialization, which is where the issue arises.
> > > 
> > 
> > Ok, thanks for the clarification. I think the bug is in this part of the code:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c#n1451
> > 
> > It just reuses the fixed bus number even if the bus already exists, which is
> > wrong. I think this should be fixed by evaluating the bus number read from EA
> > capability as below:
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index b6536ed599c3..097e2a01faae 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1438,10 +1438,21 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> > 
> >                  /* Read bus numbers from EA Capability (if present) */
> >                  fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> > -               if (fixed_buses)
> > -                       next_busnr = fixed_sec;
> > -               else
> > +               if (fixed_buses) {
> > +                       /*
> > +                        * If the fixed bus number is already taken, use the
> > +                        * next available bus number. This can happen if the
> > +                        * bootloader has assigned a wrong bus number in EA
> > +                        * capability of the bridge.
> > +                        */
> > +                       child = pci_find_bus(pci_domain_nr(bus), fixed_sec);
> > +                       if (child)
> > +                               next_busnr = max + 1;
> > +                       else
> > +                               next_busnr = fixed_sec;
> > +               } else {
> >                          next_busnr = max + 1;
> > +               }
> > 
> >                  /*
> >                   * Prevent assigning a bus number that already exists.
> 
> You proposed solution doesn't work on our Marvell OCTEON CN96XX board.
> 
> When probing the bus 0002:00, the bus number preset by the bootloader for
> the bridges under this bus start with 0xf9. Before configure of
> 0002:00:07.0, the 'max' bus number has already reached 0xff. With your
> proposed fix, the next_busnr is set to (0xff + 1), which evaluate to 0x100.
> This results in a 0 being assigned to the secondary bus number of
> 0002:00:07.0 bridge, causing a recursive bus probe.
> 

Oops. This is turning out to be too much of a problem.

> For reference, you can take a look at the code in probe.c and the
> corresponding log.
> 
>     pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
> 
>     primary = buses & 0xFF;
> 
>     secondary = (buses >> 8) & 0xFF;
> 
>     subordinate = (buses >> 16) & 0xFF;
> 
> 
>     pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
> 
>         secondary, subordinate, pass);
> 
> pci_bus 0002:00: fixups for bus
> pci 0002:00:00.0: scanning [bus f9-f9] behind bridge, pass 0
> pci_bus 0002:f9: scanning bus
> pci_bus 0002:f9: fixups for bus
> pci_bus 0002:f9: bus scan returning with max=f9
> ...
> pci 0002:00:06.0: scanning [bus ff-ff] behind bridge, pass 0
> pci_bus 0002:ff: scanning bus
> pci_bus 0002:ff: fixups for bus
> pci_bus 0002:ff: bus scan returning with max=ff
> pci 0002:00:07.0: scanning [bus 00-00] behind bridge, pass 0
> pci 0002:00:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> ...
> Kernel panic - not syncing: kernel stack overflow
> CPU: 12 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.14.0-rc4-00091-ga58485af8826 #16
> Hardware name: Marvell OcteonTX CN96XX board (DT)
> Call trace:
>  show_stack+0x20/0x38 (C)
>  dump_stack_lvl+0x38/0x90
>  dump_stack+0x18/0x28
>  panic+0x3ac/0x3c8
>  nmi_panic+0x48/0xa0
>  panic_bad_stack+0x118/0x140
>  handle_bad_stack+0x34/0x38
>  __bad_stack+0x80/0x88
>  format_decode+0x4/0x2e8 (P)
>  va_format.constprop.0+0x74/0x130
>  pointer+0x204/0x4f8
>  vsnprintf+0x2c4/0x5a0
>  vscnprintf+0x34/0x58
>  printk_sprint+0x48/0x170
>  vprintk_store+0x2d0/0x478
>  vprintk_emit+0xb0/0x2b0
>  dev_vprintk_emit+0xe0/0x1b0
>  dev_printk_emit+0x60/0x90
>  __dev_printk+0x44/0x98
>  _dev_printk+0x5c/0x90
>  pci_scan_child_bus_extend+0x5c/0x2c0
>  pci_scan_bridge_extend+0x16c/0x630
>  pci_scan_child_bus_extend+0xfc/0x2c0
>  pci_scan_bridge_extend+0x320/0x630
>  pci_scan_child_bus_extend+0x1b0/0x2c0
>  pci_scan_bridge_extend+0x320/0x630
> 
> So, I propose the following solution as a workaround to handle these edge
> cases.
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 82b21e34c545..af8efebc7e7d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6181,6 +6181,13 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536,
> rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537,
> rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538,
> rom_bar_overlap_defect);
> 
> +static void quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr(struct pci_dev
> *dev)
> +{
> +       if (!pci_has_flag(PCI_PROBE_ONLY))
> +               pci_add_flags(PCI_REASSIGN_ALL_BUS);
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_CAVIUM, 0xa002,
> quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr);
> +

LGTM. Please add a comment about this quirk too.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

