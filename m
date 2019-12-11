Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C3F11A2FD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 04:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLKD2K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 22:28:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbfLKD2K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 22:28:10 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 45E17D1165EF3A976E35;
        Wed, 11 Dec 2019 11:28:06 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Dec 2019
 11:27:56 +0800
Subject: Re: [PATCH v2] PCI: Add quirk for HiSilicon NP 5896 devices
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <andrew.murray@arm.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <huawei.libin@huawei.com>, <guohanjun@huawei.com>
References: <20191206181051.GA121021@google.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <6ebfcfc7-f9f0-bee0-172c-89c93530d94b@huawei.com>
Date:   Wed, 11 Dec 2019 11:27:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20191206181051.GA121021@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019/12/7 2:10, Bjorn Helgaas wrote:
> On Fri, Dec 06, 2019 at 03:01:45PM +0800, Xiongfeng Wang wrote:
>> HiSilicon PCI Network Processor 5896 devices misreport the class type as
>> 'NOT_DEFINED', but it is actually a network device. Also the size of
>> BAR3 is reported as 265T, but this BAR is actually unused.
>> This patch modify the class type to 'CLASS_NETWORK' and disable the
>> unused BAR3.
> 
> "NOT_DEFINED" is not the value in the Class Code register.  The commit
> message should include the actual value.

The actual value is 0, I will update the commit message.

> 
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  drivers/pci/quirks.c    | 29 +++++++++++++++++++++++++++++
>>  include/linux/pci_ids.h |  1 +
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 4937a08..b9adebb 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5431,3 +5431,32 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>>  			      PCI_CLASS_DISPLAY_VGA, 8,
>>  			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
>> +
>> +static void quirk_hisi_fixup_np_class(struct pci_dev *pdev)
>> +{
>> +	u32 class = pdev->class;
>> +
>> +	pdev->class = PCI_BASE_CLASS_NETWORK << 8;
>> +	pci_info(pdev, "PCI class overriden (%#08x -> %#08x)\n",
>> +		 class, pdev->class);
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
>> +			quirk_hisi_fixup_np_class);
>> +
>> +/*
>> + * HiSilicon NP 5896 devices BAR3 size is reported as 256T and causes problem
>> + * when assigning the resources. But this BAR is actually unused by the driver,
>> + * so let's disable it.
> 
> The question is not whether the BAR is used by the driver; the
> question is whether the device responds to accesses to the region
> described by the BAR when PCI_COMMAND_MEMORY is turned on.

I asked the hardware engineer. He said I can not write an address into that BAR.

> 
>> + */
>> +static void quirk_hisi_fixup_np_bar(struct pci_dev *pdev)
>> +{
>> +	struct resource *r = &pdev->resource[3];
>> +
>> +	r->start = 0;
>> +	r->end = 0;
>> +	r->flags = 0;
>> +
>> +	pci_info(pdev, "Disabling invalid BAR 3\n");
> 
> This quirk clears the Linux *resource* related to the BAR, but it
> does nothing with the hardware register itself.  There is no way to
> disable an individual BAR; all we have is PCI_COMMAND_MEMORY, which
> enables/disables all memory BARs as a group.
> 
> If this is a device defect, where the config register at 0x1c *looks*
> like a BAR, but it actually isn't a BAR and doesn't cause the device
> to decode any address space, a quirk like this might be OK.  But if
> the device does decode address space described by that BAR, we need
> more than this.

I think it actually isn't a BAR, just looks like a BAR.

> 
> Can you provide "sudo lspci -vvxxx" output for this device?

[root@localhost ~]# lspci -vvxxx -s 85:00.0
85:00.0 Unclassified device [0002]: Huawei Technologies Co., Ltd. Device 5896 (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 81
        NUMA node: 2
        Region 0: Memory at b0000000 (32-bit, non-prefetchable) [size=128M]
        Region 1: Memory at b8000000 (32-bit, non-prefetchable) [size=64M]
        Region 2: Memory at bc000000 (32-bit, non-prefetchable) [size=64M]
        Region 4: Memory at <unassigned> (64-bit, non-prefetchable) [size=256T]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s, Exit Latency L0s unlimited
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (ok), Width x2 (downgraded)
                        TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Kernel driver in use: np_card
00: e5 19 96 58 46 01 10 00 01 00 00 00 08 00 00 00
10: 00 00 00 b0 00 00 00 b8 00 00 00 bc 00 00 00 00
20: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
40: 01 50 c3 49 08 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 84 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 00 12 00 c2 8f 64 00 37 20 09 00 42 f4 43 00
80: 08 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 1f 00 00 00 00 00 00 00 06 00 00 00
a0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Thanks,
Xiongfeng

> 
>> +}
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
>> +			 quirk_hisi_fixup_np_bar);
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 2302d133..f21cd8b 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2558,6 +2558,7 @@
>>  #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
>>  
>>  #define PCI_VENDOR_ID_HUAWEI		0x19e5
>> +#define PCI_DEVICE_ID_HISI_5896        0x5896 /* HiSilicon NP 5896 devices */
>>  
>>  #define PCI_VENDOR_ID_NETRONOME		0x19ee
>>  #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
>> -- 
>> 1.7.12.4
>>
> 
> .
> 

