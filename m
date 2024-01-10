Return-Path: <linux-pci+bounces-2011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297E82A20D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 21:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC27528DCAB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 20:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F24F1E1;
	Wed, 10 Jan 2024 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LQhgAxeN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587054EB4B
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4670adbd76aso1061762137.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 12:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704917911; x=1705522711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCx5QwVa70fzd8rquMw4I6kP8SoNutWIPIfWbbVPnLc=;
        b=LQhgAxeNKXARlYaz9p+WirSIlWc1OggKmi2zS4oGjM32ATv5aRdAV3V22iqAdbVIVw
         Ynjx4nY3CdMQwe40l+d/r/39PuGOniZT8ZYYOX/gw1g/eqIaa6GajUBQGwpm6ux07C7T
         vNqpGbMZpuP4NB6wq422gmdNErWaEPd9zFSQEipLqoHBHDn6KBOdtqJ+n/2FQKHGT0oc
         tveRy38ZS3qGMxZtaPJ9fCnn1jqnTspJ/rR3k07pIl13N1F8SfuUXnYF2ghm58gi3s+j
         qAjYjk9m5fPYJE5SCF2JmemjU1DHxha3QiFeDzN3OswGjvgGVbusdOj1JSMbPaVpvXZD
         5jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704917911; x=1705522711;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCx5QwVa70fzd8rquMw4I6kP8SoNutWIPIfWbbVPnLc=;
        b=TzgrcfzUTcLDFShmLObQR00jbydZM33OZNiz3S5Az2pdv1YMWAvGvdyw48ATQTKSDB
         NFN3FZ+AU/NjG5SQiVTTqYJtRncig6KCFQu6lXWnDajkPnSPHeFQXbffsgOwi6X+beQT
         H1noc0ca/IQsroY+pc+0JboFYzFemSo3Zd2mVWAEf881Iy3Ks1Jy4vKSb9fN8Y7UAvHp
         tOK3Z69M5oVHXBYO/1lbD3tXH99wIpnXdcvDfrdCjIIueb5ZC7LgvMQoYkRJxGpijJ7A
         3lWb7yih9HwvuYAs9WIG1HfDUubrnIaXyZNR/5XNhJFoYOhHp7Fhm/yGEQGoSSGtI9Ho
         El/g==
X-Gm-Message-State: AOJu0Yw6bTM0aOtu46OeVJwib6E7+F6oEZ3EPTQNUJZaNm3F8lrvC/HJ
	BPIP7XeQl/xzR/shV1xGI8NVez1GOIi9NFfJse6GD7Y/fCGmBw==
X-Google-Smtp-Source: AGHT+IE6zVAzl+4qyb1eQ51qm1s0EUGP2M/u9h85sqLJbME/ZYvgt4XDXmjce7aWTNg2Jl0ci+FP580NRa/9d4ocW0c=
X-Received: by 2002:a05:6102:570b:b0:467:1ffb:d6a1 with SMTP id
 dg11-20020a056102570b00b004671ffbd6a1mr68609vsb.26.1704917911195; Wed, 10 Jan
 2024 12:18:31 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jan 2024 14:18:30 -0600
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20240110164105.GA13451@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-4-brgl@bgdev.pl>
 <20240109144327.GA10780@wunner.de> <CAMRc=MdXO6c6asvRSn_Z8-oFS48hroT+dazGKB6WWY1_Zu7f1Q@mail.gmail.com>
 <20240110132853.GA6860@wunner.de> <CAMRc=MdBSAb_kEO2r7r-vwLuRAEv7pMODOMtZoCCRAd=zsQb_w@mail.gmail.com>
 <20240110164105.GA13451@wunner.de>
Date: Wed, 10 Jan 2024 14:18:30 -0600
Message-ID: <CAMRc=MdQKPN8UbagmswjFx7_JvmJuBeuq8+9=z-+GBNUmdpWEA@mail.gmail.com>
Subject: Re: [RFC 3/9] PCI/portdrv: create platform devices for child OF nodes
To: Lukas Wunner <lukas@wunner.de>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 17:41:05 +0100, Lukas Wunner <lukas@wunner.de> said:
> On Wed, Jan 10, 2024 at 05:26:52PM +0100, Bartosz Golaszewski wrote:
>> Seems like the following must be true but isn't in my case (from
>> pci_bus_add_device()):
>>
>>     if (pci_is_bridge(dev))
>>         of_pci_make_dev_node(dev);
>>
>> Shouldn't it evaluate to true for ports?
>
> It should.
>
> What does "lspci -vvvvxxxx -s BB:DD.F" say for the port in question?
>

I cut out the hexdump part, let me know if you really need it. Output follows.

Bart

--

# lspci -vvvvxxxx -s  0000:00:00.0
0000:00:00.0 PCI bridge: Qualcomm Technologies, Inc Device 010b
(prog-if 00 [Normal decode])
	Device tree node: /sys/firmware/devicetree/base/soc@0/pcie@1c00000/pcie@0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 176
	IOMMU group: 8
	Region 0: Memory at 60300000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
	I/O behind bridge: f000-0fff [disabled] [16-bit]
	Memory behind bridge: 60400000-604fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
[disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit+
		Address: 00000000a1c3f000  Data: 0000
		Masking: fffffffe  Pending: 00000000
	Capabilities: [70] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency
L0s <1us, L1 <64us
			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 128 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
		SltCap:	AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug- Surprise+
			Slot #0, PowerLimit 0W; Interlock+ NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP+ LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+
10BitTagReq- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [148 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [168 v1] Transaction Processing Hints
		No steering table available
	Capabilities: [1fc v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=70us PortTPowerOnTime=0us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=70us LTR1.2_Threshold=76800ns
		L1SubCtl2: T_PwrOn=0us
	Kernel driver in use: pcieport

