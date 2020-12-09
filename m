Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D402D37F9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgLIAsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:48:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:22193 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbgLIAsp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:48:45 -0500
IronPort-SDR: qToCuF3DYEHnsbMmk9m0jNEwEVMHQ23dYDP9StxtWCoqobhsxZfotWm1KGrWybe/HVzjxBBaJ9
 SRup8uWwx3wQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="161760180"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="161760180"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:48:03 -0800
IronPort-SDR: 2PwPeX/CmEAAdjthHGpVdPoJ9u2El5jfwLVPCKKI5HbnzpB8G317oo8lHUJaCRbzOtmeXkQVxP
 dHvZ1ILV6hDw==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="542210242"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.137.9])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:48:02 -0800
Date:   Tue, 8 Dec 2020 16:48:00 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Chris Browy <cbrowy@avery-design.com>
Cc:     bhelgaas@google.com, dan.j.williams@intel.com, ira.weiny@intel.com,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        rafael.j.wysocki@intel.com, sean.v.kelley@intel.com,
        vishal.l.verma@intel.com
Subject: Re: [RFC PATCH 0/9] CXL 2.0 Support
Message-ID: <20201209004800.lvsmjrjmkg6kmr4d@intel.com>
References: <FB00A034-7C6D-40B1-8452-318A3B052216@avery-design.com>
 <F0ACA340-5BDE-4C17-80ED-DB7F5C5B8403@avery-design.com>
 <20201204181217.n3cm7gqujaqlcp2h@intel.com>
 <B4FDE6CB-DA00-4F58-AA9F-F04E678E076B@avery-design.com>
 <792C4B53-7548-4BDA-99EE-9E5A0233DD16@avery-design.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <792C4B53-7548-4BDA-99EE-9E5A0233DD16@avery-design.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-12-06 23:40:47, Chris Browy wrote:
> Hi Ben,
> 
> 
> >On Dec 4, 2020, at 1:12 PM, Ben Widawsky <mailto:ben.widawsky@intel.com> wrote:
> >
> >Hi Chris.
> >
> >On 20-12-04 12:40:03, Chris Browy wrote:
> >
> >Hi Ben,
> >
> >Trying to bring up the environment using the latest developments as follows:
> >
> >1. Linux kernel baseline version is cloned using
> >     git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> >   Using master branch.  Merged the 9 CXL linux kernel patches manually and built kernel
> >
> >2. QEMU baseline version is cloned using
> >     git clone https://gitlab.com/bwidawsk/qemu.git
> >
> >3. UEFI baseline is cloned using
> >     git clone https://github.com/tianocore/edk2.git
> >   Using master and built
> >
> >4. Now can run qemu as follows:
> >     The qcow2 we use is based on Ubuntu 20.10 with updated with kernel from 1) above
> >
> >     QEMU command:
> >
> >     sudo qemu-system-x86_64 -nic \
> >     user,hostfwd=tcp::2222-:22,hostfwd=tcp::1234-:1234 -machine \
> >     type=pc-q35-4.0,hmat=on,accel=kvm -enable-kvm -cpu host -smp \
> >     6,cores=6,threads=1,sockets=1 -m 8G -boot order=d -k 'en-us' -vga virtio \
> >     -drive file=/home/chris/Downloads/AQCXL/ubuntu_20.qcow,format=qcow2 -drive \
> >     if=pflash,format=raw,readonly,file=/home/chris/OVMF_CODE.fd \
> >     -drive if=pflash,format=raw,file=/home/chris/OVMF_VARS.fd \
> >     -object memory-backend-file,id=cxl-mem1,share,mem-path=/tmp/cxl-test/cxl,size=512M \
> >     -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52,uid=0,len-window-base=1,\
> >     window-base[0]=0x4c0000000,memdev[0]=cxl-mem1 \
> >     -device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0  \
> >     -device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M  2>&1 | tee -a \
> >     /home/chris/Downloads/AQCXL/log/qemu.log
> >
> >   The qemu options are derived from looking at the tests/qtests/cxl-test.c
> >   along with the -hmat=on which seemed to make sense.
> >
> >   The system boots and lspci -vvv shows the CXL device is enumerated.  But
> >   no DOE capability register for CDAT access though (see below).  Otherwise the
> >   DVSEC registers are present.
> >
> >DOE is not supported yet in either Linux or QEMU. For us, CDAT isn't a high
> >priority yet so it likely won't be done for a while. I'd really like to see DOE
> >support added by someone - not me - so that we can wire it up. Not sure what
> >that would look like in the QEMU side.
> >
> >
> >
> >   acpidump indicates the CXL0 and CXLM devices but no SRAT or HMAT tables are
> >   in the dump which is curious.
> >
> >I don't typically use HMAT, but I do have an SRAT in mine, so that's strange.
> >You should also have a CEDT.
> >
> Could you provide the QEMU command line?  I was not successful adding numa node for cxl-mem1
> and RAM.  Leaving out numa node for cxl-mem1 I can now see  SRAT table being created but that’s
> not exactly the point.
> 
> Are you using UEFI or legacy BIOS to boot?
> 
> Reproducing a known working environment is better for now and then deviate for trying new
> configurations.

I'm using UEFI. I haven't built my own in a while. The script we use to run QEMU
pulls whatever is here: https://www.archlinux.org/packages/extra/any/edk2-ovmf/download/

-machine q35,accel=kvm,nvdimm,cxl
-m 8192M,slots=4,maxmem=40964M
-smp 8,sockets=2,cores=2,threads=2
-enable-kvm
-display none
-nographic
-drive if=pflash,format=raw,unit=0,file=OVMF_CODE.fd,readonly=on
-drive if=pflash,format=raw,unit=1,file=OVMF_VARS.fd
-debugcon file:uefi_debug.log
-global isa-debugcon.iobase=0x402
-drive file=root.img,format=raw,media=disk
-kernel ./mkosi.extra/boot/vmlinuz
-initrd mkosi.extra/boot/initramfs-5.10.0-rc2-BEN-00016-geb5b35e092af-dirty.img
-append selinux=0 audit=0 console=tty0 console=ttyS0 root=/dev/sda2 ignore_loglevel rw dyndbg="file drivers/cxl/mem.c +p"
-device e1000,netdev=net0,mac=52:54:00:12:34:56
-netdev user,id=net0,hostfwd=tcp::10022-:22
-object memory-backend-file,id=cxl-mem1,share,mem-path=cxl-type3,size=512M
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52,uid=0,len-window-base=1,window-base[0]=0x4c0000000,memdev[0]=cxl-mem1
-device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0
-device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M
-snapshot
-object memory-backend-ram,id=mem0,size=2048M
-numa node,nodeid=0,memdev=mem0,
-numa cpu,node-id=0,socket-id=0
-object memory-backend-ram,id=mem1,size=2048M
-numa node,nodeid=1,memdev=mem1,
-numa cpu,node-id=1,socket-id=1
-object memory-backend-ram,id=mem2,size=2048M
-numa node,nodeid=2,memdev=mem2,
-object memory-backend-ram,id=mem3,size=2048M
-numa node,nodeid=3,memdev=mem3,
-numa node,nodeid=4,
-object memory-backend-file,id=nvmem0,share,mem-path=nvdimm-0,size=16384M,align=1G
-device nvdimm,memdev=nvmem0,id=nv0,label-size=2M,node=4
-numa node,nodeid=5,
-object memory-backend-file,id=nvmem1,share,mem-path=nvdimm-1,size=16384M,align=1G
-device nvdimm,memdev=nvmem1,id=nv1,label-size=2M,node=5
-numa dist,src=0,dst=0,val=10
-numa dist,src=0,dst=1,val=21
-numa dist,src=0,dst=2,val=12
-numa dist,src=0,dst=3,val=21
-numa dist,src=0,dst=4,val=17
-numa dist,src=0,dst=5,val=28
-numa dist,src=1,dst=1,val=10
-numa dist,src=1,dst=2,val=21
-numa dist,src=1,dst=3,val=12
-numa dist,src=1,dst=4,val=28
-numa dist,src=1,dst=5,val=17
-numa dist,src=2,dst=2,val=10
-numa dist,src=2,dst=3,val=21
-numa dist,src=2,dst=4,val=28
-numa dist,src=2,dst=5,val=28
-numa dist,src=3,dst=3,val=10
-numa dist,src=3,dst=4,val=28
-numa dist,src=3,dst=5,val=28
-numa dist,src=4,dst=4,val=10
-numa dist,src=4,dst=5,val=28
-numa dist,src=5,dst=5,val=10


> 
> >
> >
> >35:00.0 Memory controller [0502]: Intel Corporation Device 0d93 (rev 01) (prog-if 10)
> >    Subsystem: Red Hat, Inc. Device 1100
> >    Physical Slot: 0
> >    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> >    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >    Latency: 0
> >    Region 0: Memory at c0a00000 (64-bit, non-prefetchable) [size=64K]
> >    Region 2: Memory at c0a10000 (64-bit, non-prefetchable) [size=4K]
> >    Capabilities: [80] Express (v2) Endpoint, MSI 00
> >        DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> >            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
> >        DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> >            MaxPayload 128 bytes, MaxReadReq 128 bytes
> >        DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> >        LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <64ns
> >            ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
> >        LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> >            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >        LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
> >            TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
> >        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, NROPrPrP-, LTR-
> >             10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt+, EETLPPrefix+, MaxEETLPPrefixes 4
> >               EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> >             FRS-, TPHComp-, ExtTPHComp-
> >             AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> >        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> >             AtomicOpsCtl: ReqEn-
> >        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> >             Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> >             Compliance De-emphasis: -6dB
> >        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
> >             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> >    Capabilities: [100 v1] Designated Vendor-Specific <?>
> >    Capabilities: [138 v1] Designated Vendor-Specific <?>
> >    Kernel driver in use: cxl_mem
> Can you check this in the QEMU cxl_component_register_init_common() in cxl-component-utils.c
> 
> 
> I used devmem2 to dump out CLX Component CLX.mem regsisters located at BAR + 0x1000. Header
> List:
>      04110000 CXL CAP
>      08010002 CXL RAS
>      0D820004 CXL Link
>      11010005 CXL HDM Decoder
>      00000000
> 
> I think the 1st entry is the CXL Cap Header List should be
> 0x03110001
> 
> 
> Capability_ID looks like it is set using ARRAY_FIELD_DP32
> 
>     /* CXL Capability Header Register */
>     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ID, 1);
>     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, VERSION, 1);
>     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 1);
>     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
> 
> 
> But value reported for ID is ‘0’.
> 
> Since there are only RAS, LINK, and HDM headers found the Array_Size should be ‘3’
> according to the spec:
> 
> Array_Size: This defines the number of elements present in
> the CXL_Capability array, not including the
> CXL_Capability_Header element. Each element is 1 DWORD in
> size and is located contiguous with previous elements.
> 
> 
> ‘caps’ should one less that calculated in switch statement
> 
>  96 void cxl_component_register_init_common(uint32_t *reg_state, enum reg_type type)
>  97 {
>  98     int caps = 0;
>  99     switch (type) {
> 100     case CXL2_DOWNSTREAM_PORT:
> 101     case CXL2_DEVICE:
> 102         /* CAP, RAS, Link */
> 103         caps = 3;
> 104         break;
> 105     case CXL2_UPSTREAM_PORT:
> 106     case CXL2_TYPE3_DEVICE:
> 107     case CXL2_LOGICAL_DEVICE:
> 108         /* + HDM */
> 109         caps = 4;
> 110         break;
> 111     case CXL2_ROOT_PORT:
> 112         /* + Extended Security, + Snoop */
> 113         caps = 6;
> 114         break;
> 115     default:
> 116         abort();
> 117     }
> 
> 

You're correct. I've fixed it and pushed it to the v2 branch.

> >
> >Questions/Comments:
> >-------------------
> >1. Linux
> >  a. Is there a gitlab for the linux kernel patches for CXL?  This would
> >     facilitate review and code modifications.
> >
> >We're hopefully going to send out v2 in the next couple of days. I'll push the
> >repo somewhere as well.
> >
> That’s great!
> 
> >
> >
> >
> >2. UEFI (edk2 from tianocore)
> >  a. seems to only support CXL 1.1 which means only method #1 (Device
> >     option ROM) of Coherent Device Attribute Table_1.02 spec
> >     for CDAT handling is possible now.
> >
> >     Does device option ROM need to be added to QEMU CXL setup?
> >
> >     Can we add a CXL 1.1 emulated device?
> >
> >Patches welcome :-). I know of other people who want this, but I only care about
> >2.0+, so I have no intention to implement it.
> Can you summarize how the System Physical Address (SPA) gets assigned to the
> CXL pmem if not by the UEFI or CXL driver methods?

The PMEM address isn't currently assigned. It expects the driver to program the
HDMs. However, for testing I faked this a bit, grep for SET_PMEM_PADDR. I did
have a tool I used to verify the HDM programming, but it appears that's been
lost to the sands of time.


> 
> Is it some alternate method using host bridge window-base and then
> cxl_realize() in cxl_type3.c.
> 
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52,uid=0,len-window-base=1, \
>  window-base[0]=0x4c0000000,memdev[0]=cxl-mem1 \
> 
> The QEMU command would inform a lot especially whether you
> create 2 backend memories with numa nodes to models
> RAM and PMEM?
> 
> Eventually the CXL driver would need to handle hot plug of
> CT3D and access CDAT from the CT3D via DOE Mailbox.
> 
> As Dan mentions about Coherent Device Attribute Table (CDAT) Specification r1.02
> requires CDAT to build the SRAT/HMAT statically and dynamically
>  - Figure 1 Pre-boot CDAT Extraction Method (for CXL devices)  (uses CDAT in option ROM)
>  - Figure 2 OS Runtime CDAT Extraction Method (for CXL devices  (uses DOE mailbox)
> 
> >
> >
> >
> >
> >  b. lspci doesn’t show the existence of the DOE extended capability register
> >     in the CXL CT3D (needed to support method #2).  Are there more patches?
> >
> >As above, it's not supported. I'm hoping someone else will do that work since I
> >don't care about it just yet.
> 
> We can get a start on some QEMU updates to support DOE mailbox access.
> 
> >
> >
> >
> >
> >3. Do you have example user programs to share or better yet the CXL 2.0
> >   Sec 14.3.6.1 Application Layer/ Transaction layer test for CXL.mem?
> >
> >I don't have, mostly because I haven't actually implemented a lot of the real
> >CXL support. My primary concern was having the Linux driver be able to enumerate
> >devices and communicate with the device via the mailbox interface. v2 will
> >contain support for userspace to do this, which I think is a step toward what
> >you're asking for.
> >
> Understood. Looking forward to v2 and linux branch!  Working from a known good
> reference environment will allow for more in depth code review.
> 
> 
> >
> >
> >4. What are the userspace system APIs for targeting CXL HDM address domain?
> >   Usually you can mmap a SPA if you know how to look it up.
> >
> >I think Dan answered this in the other thread…
> 
> Correct 
> 
> 
> Best Regards,
> Chris Browy
> 
> 
> 
