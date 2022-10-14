Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEB75FEE9E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Oct 2022 15:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJNNaW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Oct 2022 09:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJNNaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Oct 2022 09:30:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8359CB489E;
        Fri, 14 Oct 2022 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665754218; x=1697290218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BHE+r5s4VlK4YT9hQhAZhahgKkF55vGFXR2qoXrG0ps=;
  b=SDmo6T/qopWSmR3R/NsT8t9d0hUcNZb5oT5B0hcmZ4nwq2IaBJQCowP7
   Jno6SdcHwGaS9u6Hn0D0r7sG8t9tvXDmeGGPVmCGuKy7jsE6LD2of4KKW
   b37bPPf81U9DQCfEY0dvsAs45bFxwztP1+xqGFCxR7VEfBMCXYR/kJoKl
   ySmZ8RdpDCGgYmuqWqpf0ikubpN0LKBa1cB1TRhQb7nQNpx39kM6SGLjn
   JowXISYq5ThykWxBUSTnCNA8/1v00B7AK1nI8rF9emmAbGVkN15bssNlD
   mHdrKMhaOhhxSWUL+grjM7t1fVpbwsGaYT4zdqb8K/LYI++zITQFKPi89
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="288661558"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="288661558"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 06:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="629935035"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="629935035"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Oct 2022 06:30:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1A890109; Fri, 14 Oct 2022 16:30:35 +0300 (EEST)
Date:   Fri, 14 Oct 2022 16:30:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: Regression: Re: [PATCH v2 4/6] PCI: Distribute available
 resources for root buses too
Message-ID: <Y0lkeieF3WNV3P3Q@black.fi.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
 <20220905080232.36087-5-mika.westerberg@linux.intel.com>
 <20221014124553.0000696f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014124553.0000696f@huawei.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Oct 14, 2022 at 12:45:53PM +0100, Jonathan Cameron wrote:
> On Mon,  5 Sep 2022 11:02:30 +0300
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > Currently we distribute the spare resources only upon hot-add so if
> > there are PCI devices connected already when the initial root bus scan
> > is done, and they have not been fully configured by the BIOS, we may end
> > up allocating resources just enough to cover only what is currently
> > there. If some of those devices are hotplug bridges themselves we do not
> > leave any additional resource space for future expansion.
> > 
> > For this reason distribute the available resources for root buses too to
> > make this work the same way we do in the normal hotplug case.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
> > Reported-by: Chris Chiu <chris.chiu@canonical.com>
> > Tested-by: Chris Chiu <chris.chiu@canonical.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> 
> Early days, but I have a regression that's bisecting to this patch
> after I did an optimistic checkout of mainline mid merge window.
> 
> Initial platform was QEMU emulation of CXL on arm64 with EDK2 / ACPI etc.
> That uses an extended version of the PCI eXpander Bus (PXB) with extended
> version of the emulated pci root ports.  Particular test was
> 
> 1 PXB, 2 RP, below first RP switch USP, with two functions (USP and
> a stand along switch CCI), below that 4 DSP each with a CXL type 3 device.
> 
> Clearly something wrong with the error handling in CXL code as it goes boom
> spectacularly.  I'll address that separately.  Anyhow, setup way to complex
> to debug easily. 
> 
> Anyhow to make this easier for others to poke I set up equivalent with pxb-pcie
> etc and it happens there.  Everything works with the exception of additional
> functions on USP.
> 
> Next up in minimal test case (could be more minimal but I'm lazy) is 
> 
> ../qemu/bin/native/aarch64-softmmu/qemu-system-aarch64 -M virt,nvdimm=on,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max -smp 4 \
>  -kernel Image \
>  -drive if=none,file=full.qcow2,format=qcow2,id=hd \
>  -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd \
>  -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 \
>  -device virtio-net-pci,netdev=mynet,id=bob \
>  -nographic -no-reboot -append 'earlycon root=/dev/vda2 fsck.mode=skip tp_printk maxcpus=4' \
>  -monitor telnet:127.0.0.1:1235,server,nowait -bios QEMU_EFI.fd \
>  -object memory-backend-ram,size=4G,id=mem0 \
>  -numa node,nodeid=0,cpus=0-3,memdev=mem0 \
> # Interesting part follows:
>  -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2 \
>  -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on \
>  -device e1000,bus=root_port13,addr=0.1 \
>  -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3\
>  -device e1000,bus=fun1
> 
> 
> Error message on failure to probe my switch integrated e1000 (who doesn't have one of
> those - lets pretend it's a more common switch PMU function or something like
> that) is :
>  e1000 0000:02:00.1: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
> 
> With this patch reverted it works as normal and the e1000 driver comes up.
> 
> Possibly useful stuff follows:
> 
> # lspci -tv
> -[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
>            +-01.0-[01]--
>            +-02.0  Red Hat, Inc. Virtio block device
>            +-03.0  Red Hat, Inc. Virtio network device
>            \-04.0-[02-04]--+-00.0-[03-04]----00.0-[04]----00.0  Intel Corporation 82540EM Gigabit Ethernet Controller
>                            \-00.1  Intel Corporation 82540EM Gigabit Ethernet Controller
> 
> with patch in place.
> //without patch
> Note I aligned by hand so may be errorr.
> 
> # dmesg | grep pci                                  
> pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff window]
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
> pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff window]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
> pci 0000:00:01.0: [1b36:000c] type 01 class 0x060400
> pci 0000:00:01.0: reg 0x10: [mem 0x10643000-0x10643fff]
> pci 0000:00:02.0: [1af4:1001] type 00 class 0x010000
> pci 0000:00:02.0: reg 0x10: [io  0x2200-0x227f]
> pci 0000:00:02.0: reg 0x14: [mem 0x10642000-0x10642fff]
> pci 0000:00:02.0: reg 0x20: [mem 0x8000000000-0x8000003fff 64bit pref]
> pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
> pci 0000:00:03.0: reg 0x10: [io  0x2280-0x229f]
> pci 0000:00:03.0: reg 0x14: [mem 0x10641000-0x10641fff]
> pci 0000:00:03.0: reg 0x20: [mem 0x8000004000-0x8000007fff 64bit pref]
> pci 0000:00:03.0: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
> pci 0000:00:04.0: [1b36:000c] type 01 class 0x060400
> pci 0000:00:04.0: reg 0x10: [mem 0x10640000-0x10640fff]
> pci 0000:02:00.0: [104c:8232] type 01 class 0x060400
> pci 0000:02:00.1: [8086:100e] type 00 class 0x020000
> pci 0000:02:00.1: reg 0x10: [mem 0x10200000-0x1021ffff]
> pci 0000:02:00.1: reg 0x14: [io  0x1000-0x103f]
> pci 0000:02:00.1: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
> pci 0000:03:00.0: [104c:8233] type 01 class 0x060400
> pci 0000:04:00.0: [8086:100e] type 00 class 0x020000
> pci 0000:04:00.0: reg 0x10: [mem 0x10000000-0x1001ffff]
> pci 0000:04:00.0: reg 0x14: [io  0x0000-0x003f]
> pci 0000:04:00.0: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
> pci 0000:00:01.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
> pci 0000:00:01.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
> pci 0000:00:01.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size 200000 add_align 100000
> pci 0000:03:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 100000
> pci 0000:03:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 04] add_size 100000 add_align 100000
> pci 0000:02:00.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 03-04] add_size 200000 add_align 100000
> pci 0000:02:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 03-04] add_size 100000 add_align 100000
> pci 0000:00:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 02-04] add_size 300000 add_align 100000
> pci 0000:00:04.0: bridge window [mem 0x00100000-0x002fffff] to [bus 02-04] add_size 100000 add_align 100000
> pci 0000:00:01.0: BAR 14: assigned [mem 0x10000000-0x101fffff]
> pci 0000:00:01.0: BAR 15: assigned [mem 0x8000000000-0x80001fffff 64bit pref]
> pci 0000:00:04.0: BAR 14: assigned [mem 0x10200000-0x103fffff]
> // pci 0000:00:04.0: BAR 14: assigned [mem 0x10200000-0x104fffff]
> pci 0000:00:04.0: BAR 15: assigned [mem 0x8000200000-0x80002fffff 64bit pref]
> // pci 0000:00:04.0: BAR 15: assigned [mem 0x8000200000-0x80005fffff 64bit pref]
> pci 0000:00:03.0: BAR 6: assigned [mem 0x10400000-0x1043ffff pref]
> // pci 0000:00:03.0: BAR 6: assigned [mem 0x10500000-0x1053ffff pref]
> pci 0000:00:02.0: BAR 4: assigned [mem 0x8000300000-0x8000303fff 64bit pref]
> //  pci 0000:00:02.0: BAR 4: assigned [mem 0x8000600000-0x8000603fff 64bit pref]
> pci 0000:00:03.0: BAR 4: assigned [mem 0x8000304000-0x8000307fff 64bit pref]
> //  pci 0000:00:03.0: BAR 4: assigned [mem 0x8000604000-0x8000607fff 64bit pref]
> pci 0000:00:01.0: BAR 0: assigned [mem 0x10440000-0x10440fff]
> //  pci 0000:00:01.0: BAR 0: assigned [mem 0x10540000-0x10540fff]
> pci 0000:00:01.0: BAR 13: assigned [io  0x1000-0x1fff]
> pci 0000:00:02.0: BAR 1: assigned [mem 0x10441000-0x10441fff]
> //  pci 0000:00:02.0: BAR 1: assigned [mem 0x10541000-0x10541fff]
> pci 0000:00:03.0: BAR 1: assigned [mem 0x10442000-0x10442fff]
> // pci 0000:00:03.0: BAR 1: assigned [mem 0x10542000-0x10542fff]
> pci 0000:00:04.0: BAR 0: assigned [mem 0x10443000-0x10443fff]
> // pci 0000:00:01.0: BAR 0: assigned [mem 0x10540000-0x10540fff]
> pci 0000:00:04.0: BAR 13: assigned [io  0x2000-0x3fff]
> pci 0000:00:02.0: BAR 0: assigned [io  0x4000-0x407f]
> pci 0000:00:03.0: BAR 0: assigned [io  0x4080-0x409f]
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
> pci 0000:00:01.0:   bridge window [mem 0x10000000-0x101fffff]
> pci 0000:00:01.0:   bridge window [mem 0x8000000000-0x80001fffff 64bit pref]
> pci 0000:02:00.0: BAR 14: assigned [mem 0x10200000-0x103fffff]
> pci 0000:02:00.0: BAR 15: assigned [mem 0x8000200000-0x80002fffff 64bit pref]
> // pci 0000:02:00.0: BAR 15: assigned [mem 0x8000200000-0x80004fffff 64bit pref]
> pci 0000:02:00.1: BAR 6: no space for [mem size 0x00040000 pref]
> pci 0000:02:00.1: BAR 6: failed to assign [mem size 0x00040000 pref]
> // pci 0000:02:00.1: BAR 6: assigned [mem 0x10400000-0x1043ffff pref]
> pci 0000:02:00.1: BAR 0: failed to assign [mem size 0x00020000]
> // pci 0000:02:00.1: BAR 0: assigned [mem 0x10440000-0x1045ffff]
> pci 0000:02:00.0: BAR 13: assigned [io  0x2000-0x3fff]
> pci 0000:02:00.1: BAR 1: no space for [io  size 0x0040]
> // pci 0000:02:00.1: BAR 1: assigned [io  0x3000-0x303f]
> pci 0000:02:00.1: BAR 1: failed to assign [io  size 0x0040]
> pci 0000:03:00.0: BAR 14: assigned [mem 0x10200000-0x103fffff]
> pci 0000:03:00.0: BAR 15: assigned [mem 0x8000200000-0x80002fffff 64bit pref]
> // pci 0000:03:00.0: BAR 15: assigned [mem 0x8000200000-0x80003fffff 64bit pref]
> pci 0000:03:00.0: BAR 13: assigned [io  0x2000-0x3fff]
> // pci 0000:03:00.0: BAR 13: assigned [io  0x2000-0x2fff]
> pci 0000:04:00.0: BAR 6: assigned [mem 0x10200000-0x1023ffff pref]
> pci 0000:04:00.0: BAR 0: assigned [mem 0x10240000-0x1025ffff]
> pci 0000:04:00.0: BAR 1: assigned [io  0x2000-0x203f]
> pci 0000:03:00.0: PCI bridge to [bus 04]
> pci 0000:03:00.0:   bridge window [io  0x2000-0x3fff]
> // pci 0000:03:00.0:   bridge window [io  0x2000-0x2fff]
> pci 0000:03:00.0:   bridge window [mem 0x10200000-0x103fffff]
> pci 0000:03:00.0:   bridge window [mem 0x8000200000-0x80002fffff 64bit pref]
> // pci 0000:03:00.0:   bridge window [mem 0x8000200000-0x80003fffff 64bit pref]
> pci 0000:02:00.0: PCI bridge to [bus 03-04]
> pci 0000:02:00.0:   bridge window [io  0x2000-0x3fff]
> // pci 0000:02:00.0:   bridge window [io  0x2000-0x2fff]
> pci 0000:02:00.0:   bridge window [mem 0x10200000-0x103fffff]
> pci 0000:02:00.0:   bridge window [mem 0x8000200000-0x80002fffff 64bit pref]
> // pci 0000:02:00.0:   bridge window [mem 0x8000200000-0x80004fffff 64bit pref]
> pci 0000:00:04.0: PCI bridge to [bus 02-04]
> pci 0000:00:04.0:   bridge window [io  0x2000-0x3fff]
> pci 0000:00:04.0:   bridge window [mem 0x10200000-0x103fffff]
> // pci 0000:00:04.0:   bridge window [mem 0x10200000-0x104fffff]
> pci 0000:00:04.0:   bridge window [mem 0x8000200000-0x80002fffff 64bit pref]
> // pci 0000:00:04.0:   bridge window [mem 0x8000200000-0x80005fffff 64bit pref]
> pci_bus 0000:00: Some PCI device resources are unassigned, try booting with pci=realloc
> // LINE NOT PRESENT
> pci_bus 0000:00: resource 4 [mem 0x10000000-0x3efeffff window]
> pci_bus 0000:00: resource 5 [io  0x0000-0xffff window]
> pci_bus 0000:00: resource 6 [mem 0x8000000000-0xffffffffff window]
> pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
> pci_bus 0000:01: resource 1 [mem 0x10000000-0x101fffff]
> pci_bus 0000:01: resource 2 [mem 0x8000000000-0x80001fffff 64bit pref]
> pci_bus 0000:02: resource 0 [io  0x2000-0x3fff]
> pci_bus 0000:02: resource 1 [mem 0x10200000-0x103fffff]
> // pci_bus 0000:02: resource 1 [mem 0x10200000-0x104fffff]
> pci_bus 0000:02: resource 2 [mem 0x8000200000-0x80002fffff 64bit pref]
> //  pci_bus 0000:02: resource 2 [mem 0x8000200000-0x80005fffff 64bit pref]
> pci_bus 0000:03: resource 0 [io  0x2000-0x3fff]
> // pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
> pci_bus 0000:03: resource 1 [mem 0x10200000-0x103fffff]
> pci_bus 0000:03: resource 2 [mem 0x8000200000-0x80002fffff 64bit pref]
> // pci_bus 0000:03: resource 2 [mem 0x8000200000-0x80004fffff 64bit pref]
> pci_bus 0000:04: resource 0 [io  0x2000-0x3fff]
> // pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
> pci_bus 0000:04: resource 1 [mem 0x10200000-0x103fffff]
> // pci_bus 0000:04: resource 1 [mem 0x10200000-0x103fffff]
> pci_bus 0000:04: resource 2 [mem 0x8000200000-0x80002fffff 64bit pref]
> // pci_bus 0000:04: resource 2 [mem 0x8000200000-0x80003fffff 64bit pref]
> pcieport 0000:00:01.0: PME: Signaling with IRQ 51
> pcieport 0000:00:01.0: AER: enabled with IRQ 51
> pcieport 0000:00:01.0: pciehp: Slot #0 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep+
> pcieport 0000:00:04.0: PME: Signaling with IRQ 52
> pcieport 0000:00:04.0: AER: enabled with IRQ 52
> pcieport 0000:00:04.0: pciehp: Slot #2 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep+
> pcieport 0000:03:00.0: pciehp: Slot #3 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep-
> virtio-pci 0000:00:02.0: enabling device (0000 -> 0003)
> virtio-pci 0000:00:03.0: enabling device (0000 -> 0003)
> 
> All suggestions of things to test and other useful info to provide welcome.

Thanks for the detailed report! I wonder if you could try the below
patch and see if it changes anything? I will be on vacation starting
tomorrow for the whole next week so if nothing else helps then I suppose
we should revert that commit for now.

I can look at this further after I come back.

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index dc6a30ee6edf..637f1a1df409 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1939,7 +1939,7 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 					       available_mmio_pref);
 }
 
-static bool pci_bridge_resources_not_assigned(struct pci_dev *dev)
+static bool pci_bridge_resources_assigned(struct pci_dev *dev)
 {
 	const struct resource *r;
 
@@ -1951,16 +1951,19 @@ static bool pci_bridge_resources_not_assigned(struct pci_dev *dev)
 	 * in the same way we do with the normal hotplug case.
 	 */
 	r = &dev->resource[PCI_BRIDGE_IO_WINDOW];
-	if (!r->flags || !(r->flags & IORESOURCE_STARTALIGN))
-		return false;
+	dev_info(dev->dev, "check %pR\n", r);
+	if (r->flags && !(r->flags & IORESOURCE_STARTALIGN))
+		return true;
 	r = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
-	if (!r->flags || !(r->flags & IORESOURCE_STARTALIGN))
-		return false;
+	dev_info(dev->dev, "check %pR\n", r);
+	if (r->flags && !(r->flags & IORESOURCE_STARTALIGN))
+		return true;
 	r = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
-	if (!r->flags || !(r->flags & IORESOURCE_STARTALIGN))
-		return false;
+	dev_info(dev->dev, "check %pR\n", r);
+	if (r->flags && !(r->flags & IORESOURCE_STARTALIGN))
+		return true;
 
-	return true;
+	return false;
 }
 
 static void pci_root_bus_distribute_available_resources(struct pci_bus *bus,
@@ -1979,7 +1982,7 @@ static void pci_root_bus_distribute_available_resources(struct pci_bus *bus,
 		 * Need to check "bridge" here too because it is NULL
 		 * in case of root bus.
 		 */
-		if (bridge && pci_bridge_resources_not_assigned(dev)) {
+		if (bridge && !pci_bridge_resources_assigned(dev)) {
 			pci_bridge_distribute_available_resources(bridge, add_list);
 			/*
 			 * There is only PCIe upstream port on the bus

