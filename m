Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1342CF34A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 18:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbgLDRmv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 4 Dec 2020 12:42:51 -0500
Received: from server.avery-design.com ([198.57.169.184]:58476 "EHLO
        server.avery-design.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbgLDRmv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 12:42:51 -0500
Received: from ool-944ab965.dyn.optonline.net ([148.74.185.101]:52265 helo=[192.168.1.180])
        by server.avery-design.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <cbrowy@avery-design.com>)
        id 1klF1E-0006B3-Jn; Fri, 04 Dec 2020 17:37:20 +0000
User-Agent: Microsoft-MacOutlook/16.43.20110804
Date:   Fri, 04 Dec 2020 12:40:03 -0500
Subject: Re: [RFC PATCH 0/9] CXL 2.0 Support
From:   Chris Browy <cbrowy@avery-design.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <bhelgaas@google.com>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
        <sean.v.kelley@intel.com>, <vishal.l.verma@intel.com>
Message-ID: <F0ACA340-5BDE-4C17-80ED-DB7F5C5B8403@avery-design.com>
Thread-Topic: [RFC PATCH 0/9] CXL 2.0 Support
References: <FB00A034-7C6D-40B1-8452-318A3B052216@avery-design.com>
In-Reply-To: <FB00A034-7C6D-40B1-8452-318A3B052216@avery-design.com>
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

Trying to bring up the environment using the latest developments as follows:

1. Linux kernel baseline version is cloned using
     git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
   Using master branch.  Merged the 9 CXL linux kernel patches manually and built kernel

2. QEMU baseline version is cloned using
     git clone https://gitlab.com/bwidawsk/qemu.git

3. UEFI baseline is cloned using
     git clone https://github.com/tianocore/edk2.git
   Using master and built

4. Now can run qemu as follows:
     The qcow2 we use is based on Ubuntu 20.10 with updated with kernel from 1) above

     QEMU command:

     sudo qemu-system-x86_64 -nic \
     user,hostfwd=tcp::2222-:22,hostfwd=tcp::1234-:1234 -machine \
     type=pc-q35-4.0,hmat=on,accel=kvm -enable-kvm -cpu host -smp \
     6,cores=6,threads=1,sockets=1 -m 8G -boot order=d -k 'en-us' -vga virtio \
     -drive file=/home/chris/Downloads/AQCXL/ubuntu_20.qcow,format=qcow2 -drive \
     if=pflash,format=raw,readonly,file=/home/chris/OVMF_CODE.fd \
     -drive if=pflash,format=raw,file=/home/chris/OVMF_VARS.fd \
     -object memory-backend-file,id=cxl-mem1,share,mem-path=/tmp/cxl-test/cxl,size=512M \
     -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52,uid=0,len-window-base=1,\
     window-base[0]=0x4c0000000,memdev[0]=cxl-mem1 \
     -device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0  \
     -device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M  2>&1 | tee -a \
     /home/chris/Downloads/AQCXL/log/qemu.log

   The qemu options are derived from looking at the tests/qtests/cxl-test.c
   along with the -hmat=on which seemed to make sense.

   The system boots and lspci -vvv shows the CXL device is enumerated.  But
   no DOE capability register for CDAT access though (see below).  Otherwise the
   DVSEC registers are present.

   acpidump indicates the CXL0 and CXLM devices but no SRAT or HMAT tables are
   in the dump which is curious.


35:00.0 Memory controller [0502]: Intel Corporation Device 0d93 (rev 01) (prog-if 10)
    Subsystem: Red Hat, Inc. Device 1100
    Physical Slot: 0
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Region 0: Memory at c0a00000 (64-bit, non-prefetchable) [size=64K]
    Region 2: Memory at c0a10000 (64-bit, non-prefetchable) [size=4K]
    Capabilities: [80] Express (v2) Endpoint, MSI 00
        DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
        DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
        LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <64ns
            ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
            TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, NROPrPrP-, LTR-
             10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt+, EETLPPrefix+, MaxEETLPPrefixes 4
               EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
             FRS-, TPHComp-, ExtTPHComp-
             AtomicOpsCap: 32bit- 64bit- 128bitCAS-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
             AtomicOpsCtl: ReqEn-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [100 v1] Designated Vendor-Specific <?>
    Capabilities: [138 v1] Designated Vendor-Specific <?>
    Kernel driver in use: cxl_mem

Questions/Comments:
-------------------
1. Linux
  a. Is there a gitlab for the linux kernel patches for CXL?  This would
     facilitate review and code modifications.

2. UEFI (edk2 from tianocore)
  a. seems to only support CXL 1.1 which means only method #1 (Device
     option ROM) of Coherent Device Attribute Table_1.02 spec
     for CDAT handling is possible now.

     Does device option ROM need to be added to QEMU CXL setup?

     Can we add a CXL 1.1 emulated device?

  b. lspci doesn’t show the existence of the DOE extended capability register
     in the CXL CT3D (needed to support method #2).  Are there more patches?

3. Do you have example user programs to share or better yet the CXL 2.0
   Sec 14.3.6.1 Application Layer/ Transaction layer test for CXL.mem?

4. What are the userspace system APIs for targeting CXL HDM address domain?
   Usually you can mmap a SPA if you know how to look it up.


Best Regards,
Chris Browy



