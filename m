Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5A72CD5D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 20:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjFLSAV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 14:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbjFLSAQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 14:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A2BE63
        for <linux-pci@vger.kernel.org>; Mon, 12 Jun 2023 11:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A20E61DAA
        for <linux-pci@vger.kernel.org>; Mon, 12 Jun 2023 18:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988F5C433D2;
        Mon, 12 Jun 2023 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686592811;
        bh=G05q08CcX0RraqhG8vjUiir0dQYVoF5+idd7/g8G8uY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JZ1G1JTsCyISQGB6sc65N7C4Hxdk7xmD9dfryGTrXCiODSTPVFhw9/g70jFyE/m3i
         nc+1/IlEpK2Aq39dUKoR0/piAD2S0TiHfL1QR5EsXnnjUQYT5UefFOAwMJInfXhr3L
         MN2jjz8Nji3YAc5qr7EfKRDSCRa7vMacviYyLOpG/n0dWlmhSoPeGXdDRBjYh9tyxt
         kEbdjcKarcqF86fl9OUwYYK/ZSzdQuztv52bN6wy8Meaenv79dc/ISd7Xdoq2Kf7xn
         Nz1UAhDCwm4vz9rr7QX++SZ+2z7A7cd6grt+usK3fkHCR+VBwHXNB3S9OdZXepAPKW
         DSg/QHj/DxLOg==
Date:   Mon, 12 Jun 2023 13:00:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kallol Biswas [C]" <kallol.biswas@nutanix.com>
Cc:     "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: uefi secureboot vm and IO window overlap
Message-ID: <20230612180010.GA1342820@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL3PR02MB798617A47B1507D12B3E59D0FE54A@BL3PR02MB7986.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 12, 2023 at 05:46:44PM +0000, Kallol Biswas [C] wrote:
> -----Original Message-----
> From: Bjorn Helgaas <bjorn.helgaas@gmail.com> 
> Sent: Wednesday, June 7, 2023 3:15 PM
> To: Kallol Biswas [C] <kallol.biswas@nutanix.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>; linux-pci@vger.kernel.org
> Subject: Re: uefi secureboot vm and IO window overlap
> 
> > [FYI, I'm not sure why, but your email didn't seem to make it to the list; maybe there's a clue at https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=HSy9eEcg9NrbI7YGUiURvZ2SD5_lmb_abr4v5sda9bk&m=VHASNjeAs866UrvKqCdEbB1HjTvZTYFLidSIbWc0malEoRTcGFfCjQi729H0C69-&s=irSta89Vw2NwFRSAc4FiIRvh0Dant62MNDdEvOteqP0&e= ]
> 
> On Wed, Jun 7, 2023 at 4:42 PM Kallol Biswas [C] <kallol.biswas@nutanix.com> wrote:
> >
> > Hello Bjorn,
> >                             I have reproduced the problem in the 6.3.6 kernel and debugged the source of the conflict.
> >
> > Here is the OVMF log:
> > PciBus: Resource Map for Root Bridge PciRoot(0x0)^M
> > Type =   Io16; Base = 0x6000;   Length = 0x3000;        Alignment = 0xFFF^M
> >    Base = 0x6000;       Length = 0x200; Alignment = 0xFFF;      Owner = PPB [00|02|02:**]^M
> >    Base = 0x7000;       Length = 0x200; Alignment = 0xFFF;      Owner = PPB [00|02|01:**]^M
> >    Base = 0x8000;       Length = 0x200; Alignment = 0xFFF;      Owner = PPB [00|02|00:**]^M
> >    Base = 0x8200;       Length = 0x40;  Alignment = 0x3F;       Owner = PCI [00|1F|03:20]^M
> >    Base = 0x8240;       Length = 0x20;  Alignment = 0x1F;       Owner = PCI [00|1F|02:20]^M
> >    Base = 0x8260;       Length = 0x20;  Alignment = 0x1F;       Owner = PCI [00|1D|02:20]^M
> >    Base = 0x8280;       Length = 0x20;  Alignment = 0x1F;       Owner = PCI [00|1D|01:20]^M
> >    Base = 0x82A0;       Length = 0x20;  Alignment = 0x1F;       Owner = PCI [00|1D|00:20]^M
> >    Base = 0x82C0;       Length = 0x20;  Alignment = 0x1F;       Owner = PCI [00|03|00:10]^M
> >
> > [nutanix@localhost ~]$ lspci -s 0:2.0 -vvv
> > 00:02.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port (prog-if 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0
> >         Interrupt: pin A routed to IRQ 22
> >         Region 0: Memory at c1645000 (32-bit, non-prefetchable) [size=4K]
> >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> >         I/O behind bridge: 00008000-00008fff [size=4K]
> >         Memory behind bridge: c1400000-c15fffff [size=2M]
> >         Prefetchable memory behind bridge: 0000084000000000-00000840000fffff [size=1M]
> >         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> >         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >         Capabilities: <access denied>
> >         Kernel driver in use: pcieport Dmesg log:
> > [    2.232081] pci 0000:00:02.0: PCI bridge to [bus 01]
> > [    2.232098] pci_read_bridge_io:base 0x8000 limit 0x8000 io_granulatiry 0x1000
> > [    2.232099] pci 0000:00:02.0:   bridge window [io  0x8000-0x8fff]
> > [    2.233005] pci 0000:00:02.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > [    2.233034] pci 0000:00:02.0:   bridge window [mem 0x84000000000-0x840000fffff 64bit
> >
> > Kernel code:
> > static void pci_read_bridge_io(struct pci_bus *child) {
> >         struct pci_dev *dev = child->self;
> >         u8 io_base_lo, io_limit_lo;
> >         unsigned long io_mask, io_granularity, base, limit;
> >         struct pci_bus_region region;
> >         struct resource *res;
> >
> >         io_mask = PCI_IO_RANGE_MASK;
> >         io_granularity = 0x1000;
> >         if (dev->io_window_1k) {
> >                 /* Support 1K I/O space granularity */
> >                 io_mask = PCI_IO_1K_RANGE_MASK;
> >                 io_granularity = 0x400;
> >         }
> >
> >
> >         printk("pci_read_bridge_io:base 0x%x limit 0x%x io_granulatiry 0x%x\n", base, limit, io_granularity);  <= my print
> >         if (base <= limit) {
> >                 res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
> >                 region.start = base;
> >                 region.end = limit + io_granularity - 1;
> >                 pcibios_bus_to_resource(dev->bus, res, &region);
> >                 pci_info(dev, "  bridge window %pR\n", res);
> >         }
> >
> >
> > OVMF sets the base for 0:2.0 as 0x8000 and length as 0x200 but kernel 
> > io_granularity is 0x1000 So, the bridge window becomes 0x8000 to 
> > 0x8fff, which overlaps the OVMF programmed IO base registers for other endpoints.
> >
> > [    2.996029] pci 0000:00:03.0: can't claim BAR 0 [io  0x82c0-0x82df]: address conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
> > [    2.996049] pci 0000:00:1d.0: can't claim BAR 4 [io  0x82a0-0x82bf]: address conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
> > [    2.996058] pci 0000:00:1d.1: can't claim BAR 4 [io  0x8280-0x829f]: address conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
> > [    2.996068] pci 0000:00:1d.2: can't claim BAR 4 [io  0x8260-0x827f]: address conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
> > [    2.996093] pci 0000:00:1f.2: can't claim BAR 4 [io  0x8240-0x825f]: address conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
> > [    2.996997] pci 0000:00:1f.3: can't claim BAR 4 [io  0x8200-0x823f]: address conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
> >
> > Sorry, did not get time to debug this before.
> >
> > Question, why does the kernel set IO granularity to 4k?
> 
> > The "io_granularity = 0x1000" in pci_read_bridge_io() comes from the fact that PCIe r6.0, sec 7.5.1.3.6, says bridges assume the lower 12 address bits of I/O Base registers (the bridge I/O window) are zero.
> 
> I think you have answered my question.   The lower 12 bits of the
> limit register are assumed to be 0xfff. Granularity is derived from
> this, right?
>
> Spec:
> "Thus, the bottom of the defined I/O address range will be aligned
> to a 4 KB boundary and the top of the defined I/O address range will
> be one less than a 4 KB boundary".

Right.  There are few bridges that support 1K granularity instead of
4K; see dev->io_window_1k.

> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Tuesday, December 13, 2022 1:31 PM
> > To: Kallol Biswas [C] <kallol.biswas@nutanix.com>
> > Cc: linux-pci@vger.kernel.org
> > Subject: Re: uefi secureboot vm and IO window overlap
> >
> > On Sat, Dec 10, 2022 at 05:45:50PM +0000, Kallol Biswas [C] wrote:
> > > The part1 of the dmesg:
> > >
> > > [    0.000000] Initializing cgroup subsys cpuset
> > > [    0.000000] Initializing cgroup subsys cpu
> > > [    0.000000] Initializing cgroup subsys cpuacct
> > > [    0.000000] Linux version 3.10.0-957.el7.x86_64 (mockbuild@kbuilder.bsys.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-36) (GCC) ) #1 SMP Thu Nov 8 23:39:32 UTC 2018
> >
> > Is there any chance you can reproduce the problem on a current kernel?
> > If it's been fixed by now, maybe we could identify the fix and you could backport it?
> >
> > Bjorn
