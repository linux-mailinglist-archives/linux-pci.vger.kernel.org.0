Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD52D09C6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 05:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgLGEnD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 6 Dec 2020 23:43:03 -0500
Received: from server.avery-design.com ([198.57.169.184]:38770 "EHLO
        server.avery-design.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgLGEnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2020 23:43:02 -0500
Received: from ool-944ab965.dyn.optonline.net ([148.74.185.101]:58650 helo=[192.168.1.180])
        by server.avery-design.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <cbrowy@avery-design.com>)
        id 1km8Hw-0005gk-M1; Mon, 07 Dec 2020 04:38:16 +0000
User-Agent: Microsoft-MacOutlook/16.43.20110804
Date:   Sun, 06 Dec 2020 23:40:47 -0500
Subject: Re: [RFC PATCH 0/9] CXL 2.0 Support
From:   Chris Browy <cbrowy@avery-design.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <bhelgaas@google.com>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
        <sean.v.kelley@intel.com>, <vishal.l.verma@intel.com>
Message-ID: <792C4B53-7548-4BDA-99EE-9E5A0233DD16@avery-design.com>
Thread-Topic: [RFC PATCH 0/9] CXL 2.0 Support
References: <FB00A034-7C6D-40B1-8452-318A3B052216@avery-design.com>
 <F0ACA340-5BDE-4C17-80ED-DB7F5C5B8403@avery-design.com>
 <20201204181217.n3cm7gqujaqlcp2h@intel.com>
 <B4FDE6CB-DA00-4F58-AA9F-F04E678E076B@avery-design.com>
In-Reply-To: <B4FDE6CB-DA00-4F58-AA9F-F04E678E076B@avery-design.com>
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.avery-design.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avery-design.com
X-Get-Message-Sender-Via: server.avery-design.com: authenticated_id: cbrowy@avery-design.com
X-Authenticated-Sender: server.avery-design.com: cbrowy@avery-design.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ben,


>On Dec 4, 2020, at 1:12 PM, Ben Widawsky <mailto:ben.widawsky@intel.com> wrote:
>
>Hi Chris.
>
>On 20-12-04 12:40:03, Chris Browy wrote:
>
>Hi Ben,
>
>Trying to bring up the environment using the latest developments as follows:
>
>1. Linux kernel baseline version is cloned using
>     git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>   Using master branch.  Merged the 9 CXL linux kernel patches manually and built kernel
>
>2. QEMU baseline version is cloned using
>     git clone https://gitlab.com/bwidawsk/qemu.git
>
>3. UEFI baseline is cloned using
>     git clone https://github.com/tianocore/edk2.git
>   Using master and built
>
>4. Now can run qemu as follows:
>     The qcow2 we use is based on Ubuntu 20.10 with updated with kernel from 1) above
>
>     QEMU command:
>
>     sudo qemu-system-x86_64 -nic \
>     user,hostfwd=tcp::2222-:22,hostfwd=tcp::1234-:1234 -machine \
>     type=pc-q35-4.0,hmat=on,accel=kvm -enable-kvm -cpu host -smp \
>     6,cores=6,threads=1,sockets=1 -m 8G -boot order=d -k 'en-us' -vga virtio \
>     -drive file=/home/chris/Downloads/AQCXL/ubuntu_20.qcow,format=qcow2 -drive \
>     if=pflash,format=raw,readonly,file=/home/chris/OVMF_CODE.fd \
>     -drive if=pflash,format=raw,file=/home/chris/OVMF_VARS.fd \
>     -object memory-backend-file,id=cxl-mem1,share,mem-path=/tmp/cxl-test/cxl,size=512M \
>     -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52,uid=0,len-window-base=1,\
>     window-base[0]=0x4c0000000,memdev[0]=cxl-mem1 \
>     -device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0  \
>     -device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M  2>&1 | tee -a \
>     /home/chris/Downloads/AQCXL/log/qemu.log
>
>   The qemu options are derived from looking at the tests/qtests/cxl-test.c
>   along with the -hmat=on which seemed to make sense.
>
>   The system boots and lspci -vvv shows the CXL device is enumerated.  But
>   no DOE capability register for CDAT access though (see below).  Otherwise the
>   DVSEC registers are present.
>
>DOE is not supported yet in either Linux or QEMU. For us, CDAT isn't a high
>priority yet so it likely won't be done for a while. I'd really like to see DOE
>support added by someone - not me - so that we can wire it up. Not sure what
>that would look like in the QEMU side.
>
>
>
>   acpidump indicates the CXL0 and CXLM devices but no SRAT or HMAT tables are
>   in the dump which is curious.
>
>I don't typically use HMAT, but I do have an SRAT in mine, so that's strange.
>You should also have a CEDT.
>
Could you provide the QEMU command line?  I was not successful adding numa node for cxl-mem1
and RAM.  Leaving out numa node for cxl-mem1 I can now see  SRAT table being created but that’s
not exactly the point.

Are you using UEFI or legacy BIOS to boot?

Reproducing a known working environment is better for now and then deviate for trying new
configurations.

>
>
>35:00.0 Memory controller [0502]: Intel Corporation Device 0d93 (rev 01) (prog-if 10)
>    Subsystem: Red Hat, Inc. Device 1100
>    Physical Slot: 0
>    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>    Latency: 0
>    Region 0: Memory at c0a00000 (64-bit, non-prefetchable) [size=64K]
>    Region 2: Memory at c0a10000 (64-bit, non-prefetchable) [size=4K]
>    Capabilities: [80] Express (v2) Endpoint, MSI 00
>        DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
>        DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>            MaxPayload 128 bytes, MaxReadReq 128 bytes
>        DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
>        LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <64ns
>            ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>        LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>        LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
>            TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
>        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, NROPrPrP-, LTR-
>             10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt+, EETLPPrefix+, MaxEETLPPrefixes 4
>               EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>             FRS-, TPHComp-, ExtTPHComp-
>             AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>             AtomicOpsCtl: ReqEn-
>        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>             Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>             Compliance De-emphasis: -6dB
>        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>    Capabilities: [100 v1] Designated Vendor-Specific <?>
>    Capabilities: [138 v1] Designated Vendor-Specific <?>
>    Kernel driver in use: cxl_mem
Can you check this in the QEMU cxl_component_register_init_common() in cxl-component-utils.c


I used devmem2 to dump out CLX Component CLX.mem regsisters located at BAR + 0x1000. Header
List:
     04110000 CXL CAP
     08010002 CXL RAS
     0D820004 CXL Link
     11010005 CXL HDM Decoder
     00000000

I think the 1st entry is the CXL Cap Header List should be
0x03110001


Capability_ID looks like it is set using ARRAY_FIELD_DP32

    /* CXL Capability Header Register */
    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ID, 1);
    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, VERSION, 1);
    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 1);
    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);


But value reported for ID is ‘0’.

Since there are only RAS, LINK, and HDM headers found the Array_Size should be ‘3’
according to the spec:

Array_Size: This defines the number of elements present in
the CXL_Capability array, not including the
CXL_Capability_Header element. Each element is 1 DWORD in
size and is located contiguous with previous elements.


‘caps’ should one less that calculated in switch statement

 96 void cxl_component_register_init_common(uint32_t *reg_state, enum reg_type type)
 97 {
 98     int caps = 0;
 99     switch (type) {
100     case CXL2_DOWNSTREAM_PORT:
101     case CXL2_DEVICE:
102         /* CAP, RAS, Link */
103         caps = 3;
104         break;
105     case CXL2_UPSTREAM_PORT:
106     case CXL2_TYPE3_DEVICE:
107     case CXL2_LOGICAL_DEVICE:
108         /* + HDM */
109         caps = 4;
110         break;
111     case CXL2_ROOT_PORT:
112         /* + Extended Security, + Snoop */
113         caps = 6;
114         break;
115     default:
116         abort();
117     }


>
>Questions/Comments:
>-------------------
>1. Linux
>  a. Is there a gitlab for the linux kernel patches for CXL?  This would
>     facilitate review and code modifications.
>
>We're hopefully going to send out v2 in the next couple of days. I'll push the
>repo somewhere as well.
>
That’s great!

>
>
>
>2. UEFI (edk2 from tianocore)
>  a. seems to only support CXL 1.1 which means only method #1 (Device
>     option ROM) of Coherent Device Attribute Table_1.02 spec
>     for CDAT handling is possible now.
>
>     Does device option ROM need to be added to QEMU CXL setup?
>
>     Can we add a CXL 1.1 emulated device?
>
>Patches welcome :-). I know of other people who want this, but I only care about
>2.0+, so I have no intention to implement it.
Can you summarize how the System Physical Address (SPA) gets assigned to the
CXL pmem if not by the UEFI or CXL driver methods?

Is it some alternate method using host bridge window-base and then
cxl_realize() in cxl_type3.c.

-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52,uid=0,len-window-base=1, \
 window-base[0]=0x4c0000000,memdev[0]=cxl-mem1 \

The QEMU command would inform a lot especially whether you
create 2 backend memories with numa nodes to models
RAM and PMEM?

Eventually the CXL driver would need to handle hot plug of
CT3D and access CDAT from the CT3D via DOE Mailbox.

As Dan mentions about Coherent Device Attribute Table (CDAT) Specification r1.02
requires CDAT to build the SRAT/HMAT statically and dynamically
 - Figure 1 Pre-boot CDAT Extraction Method (for CXL devices)  (uses CDAT in option ROM)
 - Figure 2 OS Runtime CDAT Extraction Method (for CXL devices  (uses DOE mailbox)

>
>
>
>
>  b. lspci doesn’t show the existence of the DOE extended capability register
>     in the CXL CT3D (needed to support method #2).  Are there more patches?
>
>As above, it's not supported. I'm hoping someone else will do that work since I
>don't care about it just yet.

We can get a start on some QEMU updates to support DOE mailbox access.

>
>
>
>
>3. Do you have example user programs to share or better yet the CXL 2.0
>   Sec 14.3.6.1 Application Layer/ Transaction layer test for CXL.mem?
>
>I don't have, mostly because I haven't actually implemented a lot of the real
>CXL support. My primary concern was having the Linux driver be able to enumerate
>devices and communicate with the device via the mailbox interface. v2 will
>contain support for userspace to do this, which I think is a step toward what
>you're asking for.
>
Understood. Looking forward to v2 and linux branch!  Working from a known good
reference environment will allow for more in depth code review.


>
>
>4. What are the userspace system APIs for targeting CXL HDM address domain?
>   Usually you can mmap a SPA if you know how to look it up.
>
>I think Dan answered this in the other thread…

Correct 


Best Regards,
Chris Browy



