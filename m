Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9721F440374
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 21:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhJ2TpZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 15:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhJ2TpY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Oct 2021 15:45:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4985160F58;
        Fri, 29 Oct 2021 19:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635536575;
        bh=MImQ+A6efjy2I8+a/pp6zKUXGNbj24+Vxt4Ky/zJaCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cPv3B/R8fJFR2usW/rNFTEdShDiVjtH6wxf82liiI1dlOELL2zjsJpCBHSh5vMY8D
         ZVRS5IKJ43hQzIOnQSMmUNFTf21HiYquO5xNJsg3SGQlV1Un8IWx571iNT16n3vaAV
         Sss+XWBqrLCq9HYAUgr06Hax4UaqCaCZBQsiJB+5BwMKELhfaJ/CzzhLa+tlFSuIhk
         VF7f5fevBYfbbORU2DgaAsjKSc2N3bcU9pDkw5D45oHPFk3N429KUomElW011RKPPv
         YNkdeLS1GMhsPTebBpvmB9+GIQCvqqyCZ5gq2/0kIxiCpsfEbt6ErVJE/ybXC6gDL4
         JJzG41zMYff+w==
Date:   Fri, 29 Oct 2021 14:42:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [EXT] Re: nvme may get timeout from dd when using different
 non-prefetch mmio outbound/ranges
Message-ID: <20211029194253.GA345237@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR19MB4024F88716768EC49BCA08CCA0879@CH2PR19MB4024.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 29, 2021 at 10:52:37AM +0000, Li Chen wrote:
> > -----Original Message-----
> > From: Keith Busch [mailto:kbusch@kernel.org]
> > Sent: Tuesday, October 26, 2021 12:16 PM
> > To: Li Chen
> > Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob Herring;
> > kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Joseph; Jens
> > Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead.org
> > Subject: Re: [EXT] Re: nvme may get timeout from dd when using different non-
> > prefetch mmio outbound/ranges
> > 
> > On Tue, Oct 26, 2021 at 03:40:54AM +0000, Li Chen wrote:
> > > My nvme is " 05:00.0 Non-Volatile memory controller: Samsung Electronics Co
> > Ltd NVMe SSD Controller 980". From its datasheet,
> > https://urldefense.com/v3/__https://s3.ap-northeast-
> > 2.amazonaws.com/global.semi.static/Samsung_NVMe_SSD_980_Data_Sheet_R
> > ev.1.1.pdf__;!!PeEy7nZLVv0!3MU3LdTWuzON9JMUkq29zwJM4d7g7wKtkiZszTu-
> > PVepWchI_uLHpQGgdR_LEZM$ , it says nothing about CMB/SQEs, so I'm not sure.
> > Is there other ways/tools(like nvme-cli) to query?
> > 
> > The driver will export a sysfs property for it if it is supported:
> > 
> >   # cat /sys/class/nvme/nvme0/cmb
> > 
> > If the file doesn't exist, then /dev/nvme0 doesn't have the capability.
> > 
> > > > > I don't know how to interpret "ranges".  Can you supply the dmesg and
> > > > > "lspci -vvs 0000:05:00.0" output both ways, e.g.,
> > > > >
> > > > >   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffffff window]
> > > > >   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> > > > >   pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
> > > > >   pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff ...]
> > > > >
> > > > > > Question:
> > > > > > 1.  Why dd can cause nvme timeout? Is there more debug ways?
> > > >
> > > > That means the nvme controller didn't provide a response to a posted
> > > > command within the driver's latency tolerance.
> > >
> > > FYI, with the help of pci bridger's vendor, they find something
> > > interesting:
> > "From catc log, I saw some memory read pkts sent from SSD card,
> > but its memory range is within the memory range of switch down
> > port. So, switch down port will replay UR pkt. It seems not
> > normal." and "Why SSD card send out some memory pkts which memory
> > address is within switch down port's memory range. If so, switch
> > will response UR pkts". I also don't understand how can this
> > happen?
> > 
> > I think we can safely assume you're not attempting peer-to-peer,
> > so that behavior as described shouldn't be happening. It sounds
> > like the memory windows may be incorrect. The dmesg may help to
> > show if something appears wrong.
> 
> Agree that here doesn't involve peer-to-peer DMA. After conforming
> from switch vendor today, the two ur(unsupported request) is because
> nvme is trying to dma read dram with bus address 80d5000 and
> 80d5100. But the two bus addresses are located in switch's down port
> range, so the switch down port report ur. 
> 
> In our soc, dma/bus/pci address and physical/AXI address are 1:1,
> and DRAM space in physical memory address space is 000000.0000 -
> 0fffff.ffff 64G, so bus address 80d5000 and 80d5100 to cpu address
> are also 80d5000 and 80d5100, which both located inside dram space. 
> 
> Both our bootloader and romcode don't enum and configure pcie
> devices and switches, so the switch cfg stage should be left to
> kernel. 
> 
> Come back to the subject of this thread: " nvme may get timeout from
> dd when using different non-prefetch mmio outbound/ranges". I found:
> 
> 1. For <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x04000000>;
> (which will timeout nvme)
> 
> Switch(bridge of nvme)'s resource window: 
> Memory behind bridge: Memory behind bridge: 08000000-080fffff [size=1M]
>
> 80d5000 and 80d5100 are both inside this range.

The PCI host bridge MMIO window is here:

  pci_bus 0000:00: root bus resource [mem 0x2008000000-0x200bffffff] (bus address [0x08000000-0x0bffffff])
  pci 0000:01:00.0: PCI bridge to [bus 02-05]
  pci 0000:01:00.0:   bridge window [mem 0x2008000000-0x20080fffff]
  pci 0000:02:06.0: PCI bridge to [bus 05]
  pci 0000:02:06.0:   bridge window [mem 0x2008000000-0x20080fffff]
  pci 0000:05:00.0: BAR 0: assigned [mem 0x2008000000-0x2008003fff 64bit]

So bus address [0x08000000-0x0bffffff] is the area used for PCI BARs.
If the NVMe device is generating DMA transactions to 0x080d5000, which
is inside that range, those will be interpreted as peer-to-peer
transactions.  But obviously that's not intended and there's no device
at 0x080d5000 anyway.

My guess is the nvme driver got 0x080d5000 from the DMA API, e.g.,
dma_map_bvec() or dma_map_sg_attrs(), so maybe there's something wrong
in how that's set up.  Is there an IOMMU?  There should be arch code
that knows what RAM is available for DMA buffers, maybe based on the
DT.  I'm not really familiar with how all that would be arranged, but
the complete dmesg log and complete DT might have a clue.  Can you
post those somewhere?

> 2. For <0x02000000 0x00 0x00400000 0x20 0x00400000 0x00 0x08000000>; 
> (which make nvme not timeout) 
> 
> Switch(bridge of nvme)'s resource window: 
> Memory behind bridge: Memory behind bridge: 00400000-004fffff [size=1M]
> 
> 80d5000 and 80d5100 are not inside this range, so if nvme tries to
> read 80d5000 and 80d5100 , ur won't happen.
>
> From /proc/iomen:
> # cat /proc/iomem
> 01200000-ffffffff : System RAM
>   01280000-022affff : Kernel code
>   022b0000-0295ffff : reserved
>   02960000-040cffff : Kernel data
>   05280000-0528ffff : reserved
>   41cc0000-422c0fff : reserved
>   422c1000-4232afff : reserved
>   4232d000-667bbfff : reserved
>   667bc000-667bcfff : reserved
>   667bd000-667c0fff : reserved
>   667c1000-ffffffff : reserved
> 2000000000-2000000fff : cfg
> 
> No one uses 0000000-1200000, so " Memory behind bridge: Memory
> behind bridge: 00400000-004fffff [size=1M]" will never have any
> problem(because 0x1200000 > 0x004fffff). 
> 
> Above answers the question in Subject, one question left: what's the
> right way to resolve this problem? Use ranges property to configure
> switch memory window indirectly(just what I did)? Or something else?
> 
> I don't think changing range property is the right way: If my PCIe
> topology becomes more complex and have more endpoints or switches,
> maybe I have to reserve more MMIO through range property(please
> correct me if I'm wrong), the end of switch's memory window may be
> larger than 0x01200000. In case getting ur again,  I must reserve
> more physical memory address for them(like change kernel start
> address 0x01200000 to 0x02000000), which will make my visible dram
> smaller(I have verified it with "free -m"), it is not acceptable.

Right, I don't think changing the PCI ranges property is the right
answer.  I think it's just a coincidence that moving the host bridge
MMIO aperture happens to move it out of the way of the DMA to
0x080d5000.

As far as I can tell, the PCI core and the nvme driver are doing the
right things here, and the problem is something behind the DMA API.

I think there should be something that removes the MMIO aperture bus
addresses, i.e., 0x08000000-0x0bffffff in the timeout case, from the
pool of memory available for DMA buffers.

The MMIO aperture bus addresses in the non-timeout case,
0x00400000-0x083fffff, are not included in the 0x01200000-0xffffffff
System RAM area, which would explain why a DMA buffer would never
overlap with it.

Bjorn
