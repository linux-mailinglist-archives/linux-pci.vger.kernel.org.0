Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788223E4BF8
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhHISPq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 14:15:46 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:20080 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233837AbhHISPn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 14:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628532923; x=1660068923;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Fh8i8RuSmLYdZEiYN/BxpHDN3XDZCpVtlp5XsxdL3Vg=;
  b=AGaKBEqZgIJb73wDUTOJsujhyT5jMKX2JRT7UStpylp6MvXr2uoPkRXb
   00fmHiPI585gJzBguOOoWIKaR/ylli9BZjwEJUAqcHJY7IDuB9vYz/3/8
   fAcke3w1iVSE+zjF6t6KadyKDztIaIWGh4QNHtM716AIa0sMJ5k8PPam+
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Aug 2021 11:15:22 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Aug 2021 11:15:22 -0700
Received: from [10.111.162.189] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 9 Aug
 2021 11:15:21 -0700
Subject: Re: [PATCH v2 4/6] PCI/VPD: Reject resource tags with invalid size
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
CC:     Hannes Reinecke <hare@suse.de>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
References: <20210729184234.976924-1-helgaas@kernel.org>
 <20210729184234.976924-5-helgaas@kernel.org>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <a20b07f5-6849-e4b6-82fa-ddf67693e104@quicinc.com>
Date:   Mon, 9 Aug 2021 14:15:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729184234.976924-5-helgaas@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03g.na.qualcomm.com (10.85.0.49) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/29/2021 2:42 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> VPD is limited in size by the 15-bit VPD Address field in the VPD
> Capability.  Each resource tag includes a length that determines the
> overall size of the resource.  Reject any resources that would extend past
> the maximum VPD size.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

+ mlx5_core maintainers

Hi there, running the latest linux-next with this commit, our system started to
get noisy. Could those indicate some device firmware bugs?

[  164.937191] mlx5_core 0000:01:00.0: invalid VPD tag 0x78 at offset 113
[  165.933527] mlx5_core 0000:01:00.1: invalid VPD tag 0x78 at offset 113

0000:01:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]
	Subsystem: Mellanox Technologies MCX4421A-ACQN ConnectX-4 Lx EN OCP,2x25G
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 318
	Region 0: Memory at 10100000000 (64-bit, prefetchable) [size=32M]
	Expansion ROM at 10030000000 [disabled] [size=1M]
	Capabilities: [60] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 512 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L1 <4us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x8 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, NROPrPrP-, LTR-
			 10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-, TPHComp-, ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-, LTR-, OBFF Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [48] Vital Product Data
		Product Name: CX4421A- ConnectX-4 LX SFP28
		Read-only fields:
			[PN] Part number: MCX4421A-ACQN        
			[EC] Engineering changes: AE
			[SN] Serial number: MT2042X16761            
			[V0] Vendor specific: PCIeGen3 x8     
			[RV] Reserved: checksum good, 0 byte(s) reserved
		No end tag found
	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 04, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 2, stride: 1, Device ID: 1016
		Supported Page Size: 000007ff, System Page Size: 00000010
		Region 0: Memory at 0000010104000000 (64-bit, prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1c0 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
		LaneErrStat: 0
	Capabilities: [230 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: mlx5_core
	Kernel modules: mlx5_core


0000:01:00.1 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]
	Subsystem: Mellanox Technologies MCX4421A-ACQN ConnectX-4 Lx EN OCP,2x25G
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 392
	Region 0: Memory at 10102000000 (64-bit, prefetchable) [size=32M]
	Expansion ROM at 10030100000 [disabled] [size=1M]
	Capabilities: [60] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 512 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L1 <4us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x8 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, NROPrPrP-, LTR-
			 10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-, TPHComp-, ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-, LTR-, OBFF Disabled
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [48] Vital Product Data
		Product Name: CX4421A- ConnectX-4 LX SFP28
		Read-only fields:
			[PN] Part number: MCX4421A-ACQN        
			[EC] Engineering changes: AE
			[SN] Serial number: MT2042X16761            
			[V0] Vendor specific: PCIeGen3 x8     
			[RV] Reserved: checksum good, 0 byte(s) reserved
		No end tag found
	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 04, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 9, stride: 1, Device ID: 1016
		Supported Page Size: 000007ff, System Page Size: 00000010
		Region 0: Memory at 0000010104800000 (64-bit, prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [230 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: mlx5_core
	Kernel modules: mlx5_core


> ---
>  drivers/pci/vpd.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 66703de2cf2b..e52382050e3e 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -77,6 +77,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>  
>  	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
>  		unsigned char tag;
> +		size_t size;
>  
>  		if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
>  			goto error;
> @@ -94,8 +95,11 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>  						 off + 1);
>  					return 0;
>  				}
> -				off += PCI_VPD_LRDT_TAG_SIZE +
> -					pci_vpd_lrdt_size(header);
> +				size = pci_vpd_lrdt_size(header);
> +				if (off + size > PCI_VPD_MAX_SIZE)
> +					goto error;
> +
> +				off += PCI_VPD_LRDT_TAG_SIZE + size;
>  			} else {
>  				pci_warn(dev, "invalid large VPD tag %02x at offset %zu",
>  					 tag, off);
> @@ -103,9 +107,12 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>  			}
>  		} else {
>  			/* Short Resource Data Type Tag */
> -			off += PCI_VPD_SRDT_TAG_SIZE +
> -				pci_vpd_srdt_size(header);
>  			tag = pci_vpd_srdt_tag(header);
> +			size = pci_vpd_srdt_size(header);
> +			if (size == 0 || off + size > PCI_VPD_MAX_SIZE)
> +				goto error;
> +
> +			off += PCI_VPD_SRDT_TAG_SIZE + size;
>  			if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
>  				return off;
>  		}
> 
