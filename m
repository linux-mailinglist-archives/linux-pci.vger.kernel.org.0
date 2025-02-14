Return-Path: <linux-pci+bounces-21486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF867A363CA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9720A1704E4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A7E267707;
	Fri, 14 Feb 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLIZq1cE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C88264A9D;
	Fri, 14 Feb 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552466; cv=none; b=iO2bwHafBG3qr8vgAkXFcgE/navRTvsAKm6CvLSWI9gEOyNN27VoTdGzvVwFiqwGB5Z1fG6ZxEzzOpZuqOOdSbK9p8n0L5D9/s6mSNIKsbeqMxylfCIX1fkMrws6dYXX3UCb4Ow8koY3Wzrt7kImFZGs/foPFwv0BaLPj6GB5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552466; c=relaxed/simple;
	bh=KieRTUcnMSc5WPsYxL5r2U6ULuh+BG887FXcKaW9vRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEcelGBHkMObpcj7ztJvA9DeHXfyoAepbH4FA1j6H5Q6LD9pWpZhr29iLy6ctYDlBMOmGgFJu2eTgIbNP4JLJmDlAXI+8vPg+9dIfjumpF+VqE0Xei4vTfOWYlSmP2bGiesdaDvmr/aRqJFKLt3lNvSMo03R57RirINjjEkX2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLIZq1cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D099C4CED1;
	Fri, 14 Feb 2025 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739552465;
	bh=KieRTUcnMSc5WPsYxL5r2U6ULuh+BG887FXcKaW9vRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLIZq1cEt6U8tRefMY+0psNcrbzgIJnk5h7tNh0e0/upu/T97sRhKjRjePL/YNXyd
	 9xmzwfFw2qnaA2USdGfA8IxfYvIa4sti7cjp2ffHtTgqy6MBl2JT05efegJbscwd8Y
	 dMhRu5hbhlJnQGBZvfTfTNgflyTgT0B6xEVjqFT+Ds3esMjbSSXfu0w5y4jM+/VIm0
	 AoS4MJK/zANf9LXjfHlhiTFeNmgFJD1ImM/Dbm4bq8EHmzs4k9stmg4ymjF40YBoH/
	 n74ls55wL9q2U6sYam+u83SDTWeSUfu0jJHwR2LXsIGU5T6JP42ZBtdHzM38E/iL1F
	 ZwZw1gYSNpPAw==
Date: Fri, 14 Feb 2025 22:30:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bo Sun <Bo.Sun.CN@windriver.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kexin.Hao@windriver.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when
 PCI_PROBE_ONLY is enabled
Message-ID: <20250214170057.o3ffoiuxn4hxqqqe@thinkpad>
References: <20250117082428.129353-1-Bo.Sun.CN@windriver.com>
 <20250210103707.c5ubeaowk7xwt6p5@thinkpad>
 <df5d3c54-d436-43bb-8b40-665c020d6bb5@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df5d3c54-d436-43bb-8b40-665c020d6bb5@windriver.com>

On Wed, Feb 12, 2025 at 03:07:56PM +0800, Bo Sun wrote:
> On 2/10/25 18:37, Manivannan Sadhasivam wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Fri, Jan 17, 2025 at 04:24:14PM +0800, Bo Sun wrote:
> > > On our Marvell OCTEON CN96XX board, we observed the following panic on
> > > the latest kernel:
> > > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> > > Mem abort info:
> > >    ESR = 0x0000000096000005
> > >    EC = 0x25: DABT (current EL), IL = 32 bits
> > >    SET = 0, FnV = 0
> > >    EA = 0, S1PTW = 0
> > >    FSC = 0x05: level 1 translation fault
> > > Data abort info:
> > >    ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> > >    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > >    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > [0000000000000080] user address but active_mm is swapper
> > > Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> > > Modules linked in:
> > > CPU: 9 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc7-00149-g9bffa1ad25b8 #1
> > > Hardware name: Marvell OcteonTX CN96XX board (DT)
> > > pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > pc : of_pci_add_properties+0x278/0x4c8
> > > lr : of_pci_add_properties+0x258/0x4c8
> > > sp : ffff8000822ef9b0
> > > x29: ffff8000822ef9b0 x28: ffff000106dd8000 x27: ffff800081bc3b30
> > > x26: ffff800081540118 x25: ffff8000813d2be0 x24: 0000000000000000
> > > x23: ffff00010528a800 x22: ffff000107c50000 x21: ffff0001039c2630
> > > x20: ffff0001039c2630 x19: 0000000000000000 x18: ffffffffffffffff
> > > x17: 00000000a49c1b85 x16: 0000000084c07b58 x15: ffff000103a10f98
> > > x14: ffffffffffffffff x13: ffff000103a10f96 x12: 0000000000000003
> > > x11: 0101010101010101 x10: 000000000000002c x9 : ffff800080ca7acc
> > > x8 : ffff0001038fd900 x7 : 0000000000000000 x6 : 0000000000696370
> > > x5 : 0000000000000000 x4 : 0000000000000002 x3 : ffff8000822efa40
> > > x2 : ffff800081341000 x1 : ffff000107c50000 x0 : 0000000000000000
> > > Call trace:
> > >   of_pci_add_properties+0x278/0x4c8 (P)
> > >   of_pci_make_dev_node+0xe0/0x158
> > >   pci_bus_add_device+0x158/0x210
> > >   pci_bus_add_devices+0x40/0x98
> > >   pci_host_probe+0x94/0x118
> > >   pci_host_common_probe+0x120/0x1a0
> > >   platform_probe+0x70/0xf0
> > >   really_probe+0xb4/0x2a8
> > >   __driver_probe_device+0x80/0x140
> > >   driver_probe_device+0x48/0x170
> > >   __driver_attach+0x9c/0x1b0
> > >   bus_for_each_dev+0x7c/0xe8
> > >   driver_attach+0x2c/0x40
> > >   bus_add_driver+0xec/0x218
> > >   driver_register+0x68/0x138
> > >   __platform_driver_register+0x2c/0x40
> > >   gen_pci_driver_init+0x24/0x38
> > >   do_one_initcall+0x4c/0x278
> > >   kernel_init_freeable+0x1f4/0x3d0
> > >   kernel_init+0x28/0x1f0
> > >   ret_from_fork+0x10/0x20
> > > Code: aa1603e1 f0005522 d2800044 91000042 (f94040a0)
> > > 
> > > This regression was introduced by commit 7246a4520b4b ("PCI: Use
> > > preserve_config in place of pci_flags"). On our board, the 002:00:07.0
> > > bridge is misconfigured by the bootloader. Both its secondary and
> > > subordinate bus numbers are initialized to 0, while its fixed secondary
> > > bus number is set to 8.
> > 
> > What do you mean by 'fixed secondary bus number'?
> > 
> 
> The 'fixed secondary bus number' refers to the value returned by the
> function pci_ea_fixed_busnrs(), which reads the fixed Secondary and
> Subordinate bus numbers from the EA (Extended Attributes) capability, if
> present.

Thanks! It'd be good to mention the EA capability.

> In the code at drivers/pci/probe.c, line 1439, we have the
> following:
> 
> 		/* Read bus numbers from EA Capability (if present) */
> 		fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> 		if (fixed_buses)
> 			next_busnr = fixed_sec;
> 		else
> 			next_busnr = max + 1;
> 
> > > However, bus number 8 is also assigned to another
> > > bridge (0002:00:0f.0). Although this is a bootloader issue, before the
> > > change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was
> > > set by default when PCI_PROBE_ONLY was enabled, ensuing that all the
> > > bus number for these bridges were reassigned, avoiding any conflicts.
> > > 
> > 
> > Isn't the opposite? PCI_REASSIGN_ALL_BUS was only added if the PCI_PROBE_ONLY
> > flag was not set:
> > 
> >          /* Do not reassign resources if probe only */
> >          if (!pci_has_flag(PCI_PROBE_ONLY))
> >                  pci_add_flags(PCI_REASSIGN_ALL_BUS);
> > 
> 
> Yes, you are correct. It’s a typo; it should be "when PCI_PROBE_ONLY was not
> enabled." I will fix this in v2.
> 
> > 
> > > After the change introduced in commit 7246a4520b4b, the bus numbers
> > > assigned by the bootloader are reused by all other bridges, except
> > > the misconfigured 002:00:07.0 bridge. The kernel attempt to reconfigure
> > > 002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
> > > bootloader. However, since a pci_bus has already been allocated for
> > > bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
> > > 002:00:07.0.
> > 
> > How come 0002:00:0f.0 is enumerated before 0002:00:07.0 in a depth first manner?
> > 
> 
> The device 0002:00:07.0 is actually enumerated before 0002:00:0f.0, but it
> appears misconfigured. The kernel attempts to reconfigure it during
> initialization, which is where the issue arises.
> 

Ok, thanks for the clarification. I think the bug is in this part of the code:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c#n1451

It just reuses the fixed bus number even if the bus already exists, which is
wrong. I think this should be fixed by evaluating the bus number read from EA
capability as below:

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..097e2a01faae 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1438,10 +1438,21 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 
                /* Read bus numbers from EA Capability (if present) */
                fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
-               if (fixed_buses)
-                       next_busnr = fixed_sec;
-               else
+               if (fixed_buses) {
+                       /*
+                        * If the fixed bus number is already taken, use the
+                        * next available bus number. This can happen if the
+                        * bootloader has assigned a wrong bus number in EA
+                        * capability of the bridge.
+                        */
+                       child = pci_find_bus(pci_domain_nr(bus), fixed_sec);
+                       if (child)
+                               next_busnr = max + 1;
+                       else
+                               next_busnr = fixed_sec;
+               } else {
                        next_busnr = max + 1;
+               }
 
                /*
                 * Prevent assigning a bus number that already exists.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

