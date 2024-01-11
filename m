Return-Path: <linux-pci+bounces-2048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B72A82ACF0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 12:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F217A282D96
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 11:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AE514F8A;
	Thu, 11 Jan 2024 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hLpltpX6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F215488
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4b74a9a9d4cso1560327e0c.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 03:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704971351; x=1705576151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uS6LALFhoYnE7Jdai/ss+1NS4YSw97Bn9aZ8ZrLtLL4=;
        b=hLpltpX6vNK/S4jOXGihKnAeZnKwrswrJL+wq2QrKeOC+O2sYAwR60+eKHpJ0ze66k
         Voca0NgkrZ8ujZRtObCEgqtwlCbf90Ga9kAtkEhrBuRh7xLlkpaReHnvPWhknCpneTvB
         1M2rP1tWGMUJp0+yq/uNZfVQHVGKUTVo7GlD40gECRor6+SAndBQwQncFD6rOe6BBeAV
         GHT2RLZF8ia0RNCTyHdypSVhkxNWU31iwPNpTXrIGRMYzYiTsiF7HnDGLKC5v6X3B72Z
         abk5PF3kRXyR9ScAxOHVc7gBcmd/H/E8RqTPlqTHjeKXyCg8/OtFemQFuBgNdcsPViJi
         ph5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704971351; x=1705576151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uS6LALFhoYnE7Jdai/ss+1NS4YSw97Bn9aZ8ZrLtLL4=;
        b=mTwoLQ4Ez7Rg20wBc/TsXHVATF8thPdlFewo58YrKByNtOYUGQxdaACUCdCkbkE3Os
         iumqEKJW1xlw2YGIXWxGN+FaThLGS6WnZJkE+HXJuk4Ur6xdTW90NuPL31XorjpBPxlP
         NKZGzvp455B2/jIpp95yU1x/Yg3OHWSEYIr4x80Zcs689hMqOraaT8r7G6qWYWxYRZ4r
         1bVAZjyr4JilNYcPhdljuCjwSNRrbaW3DneWrWCK1nccfiLvvxG+jjs9tA3L2eii4sww
         eMNVuCL45Zj7p35LObt8zv4WPNtjtMmlv0wZkQ9Smy05Vib1JXIGMnvUAksciom7TaE3
         NlYQ==
X-Gm-Message-State: AOJu0YxLUTpcrLlb6Z9W9XIv5r7xNVtHcEp+7fzq+yearHBAzfcCZ0AI
	2a3cmnW19Rj6zsEq7azoFTUAX0iq95j75EgO6mqazM6KpafLOw==
X-Google-Smtp-Source: AGHT+IHE4Na926UlRgNq0ry0Vt4ei5SaY7xVXUFjbeeWVP+A1SyjHq3X68l06jQpFjtelzNy/HIDl8QrWPnWV5CI41Y=
X-Received: by 2002:a05:6122:3908:b0:4b6:d700:fecd with SMTP id
 ep8-20020a056122390800b004b6d700fecdmr257585vkb.12.1704971350838; Thu, 11 Jan
 2024 03:09:10 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jan 2024 05:09:10 -0600
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20240111104211.GA32504@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-4-brgl@bgdev.pl>
 <20240109144327.GA10780@wunner.de> <CAMRc=MdXO6c6asvRSn_Z8-oFS48hroT+dazGKB6WWY1_Zu7f1Q@mail.gmail.com>
 <20240110132853.GA6860@wunner.de> <CAMRc=MdBSAb_kEO2r7r-vwLuRAEv7pMODOMtZoCCRAd=zsQb_w@mail.gmail.com>
 <20240110164105.GA13451@wunner.de> <CAMRc=MdQKPN8UbagmswjFx7_JvmJuBeuq8+9=z-+GBNUmdpWEA@mail.gmail.com>
 <20240111104211.GA32504@wunner.de>
Date: Thu, 11 Jan 2024 05:09:09 -0600
Message-ID: <CAMRc=MfT_VLo7++K4M89iYrciqWSrX_JyS1LX5kaGTNDNVQiOg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jan 2024 11:42:11 +0100, Lukas Wunner <lukas@wunner.de> said:
> On Wed, Jan 10, 2024 at 02:18:30PM -0600, Bartosz Golaszewski wrote:
>> On Wed, 10 Jan 2024 17:41:05 +0100, Lukas Wunner <lukas@wunner.de> said:
>> > On Wed, Jan 10, 2024 at 05:26:52PM +0100, Bartosz Golaszewski wrote:
>> > > Seems like the following must be true but isn't in my case (from
>> > > pci_bus_add_device()):
>> > >
>> > >     if (pci_is_bridge(dev))
>> > >         of_pci_make_dev_node(dev);
>> > >
>> > > Shouldn't it evaluate to true for ports?
>> >
>> > It should.
>> >
>> > What does "lspci -vvvvxxxx -s BB:DD.F" say for the port in question?
>>
>> I cut out the hexdump part, let me know if you really need it.
>
> I really need it.
>

Ok, one more:

# lspci -vvvvxxxx -s 0000:00:00
0000:00:00.0 PCI bridge: Qualcomm Technologies, Inc Device 010b
(prog-if 00 [Normal decode])
	Device tree node: /sys/firmware/devicetree/base/soc@0/pcie@1c00000/pcie@0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 188
	IOMMU group: 7
	Region 0: Memory at 60300000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D01, subordinate=3Dff, sec-latency=3D0
	I/O behind bridge: f000-0fff [disabled] [16-bit]
	Memory behind bridge: 60400000-604fffff [size=3D1M] [32-bit]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
[disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
		Address: 00000000a1c00000  Data: 0000
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
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers-=
 DRS-
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
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
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
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
			  PortCommonModeRestoreTime=3D70us PortTPowerOnTime=3D0us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=3D70us LTR1.2_Threshold=3D76800ns
		L1SubCtl2: T_PwrOn=3D0us
	Kernel driver in use: pcieport
00: cb 17 0b 01 07 05 10 00 00 00 04 06 00 00 01 00
10: 00 00 30 60 00 00 00 00 00 01 ff 00 f0 00 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 bb 01 02 00
40: 01 50 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 8b 01 00 00 c0 a1 00 00 00 00 00 00 00 00
60: fe ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 00 42 01 00 80 00 00 1f 28 10 00 13 4c 7b 00
80: 48 00 12 f0 3f 00 02 00 c0 03 00 00 18 00 01 00
90: 00 00 00 00 1f 1c 00 00 00 04 00 00 0e 00 00 00
a0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
100: 01 00 82 14 00 00 00 00 00 00 40 00 30 20 46 00
110: 00 00 00 00 00 e0 00 00 a0 00 00 00 00 00 00 00
120: 00 00 00 00 00 00 00 00 00 00 00 00 07 00 00 00
130: 00 00 00 000 00 00 00 00 00 00 00 00 00 00 00
140: 00 00 00 00 00 00 00 00 19 00 81 16 00 00 00 00
150: 00 00 00 00 7f 6f 00 00 00 00 00 00 00 00 00 00
160: 00 00 00 00 00 00 00 00 17 00 c1 1f 01 00 00 00
170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1f0: 00 00 00 00 18 00 c1 1f 00 00 00 00 1e 00 01 00
200: 1f 46 00 00 00 46 4b 40 00 00 00 00 00 00 00 00
210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5f0: 00 =EF=BF=BD=EF=BF=BD0 00 00 00 00 00 00 00 00 00 00 00 00 00
600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
700: 3b 00 b1 00 ff ff ff ff 04 00 80 00 00 90 90 1b
710: 20 01 01 00 00 00 00 00 00 40 01 00 40 01 00 00
720: 00 00 00 00 01 00 00 00 11 74 40 03 10 00 00 08
730: 60 00 01 00 07 a0 01 00 ff ff 0f 00 00 00 00 00
740: 0f 00 00 00 00 00 00 00 60 00 21 45 07 a0 21 05
750: 00 00 20 05 00 00 00 00 00 00 00 00 00 00 00 00
760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
800: 00 00 00 00 00 00 00 00 00 00 00 00 90 01 00 00
810: 00 00 00 00 00 00 00 00 00 00 00 00 7f 00 00 00
820: 00 00 c0 a1 00 00 00 00 ff ff ff ff fe ff ff ff
830: 00 00 00 00 ff ff ff ff 00 3c 02 fe 00 00 00 00
840: ff ff ff ff ff ff ff ff 00 00 00 00 ff ff ff ff
850: ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff
860: 00 00 00 00 ff ff ff ff ff ff ff ff 00 00 00 00
870: ff ff ff ff ff ff ff ff 00 00 00 00 ff ff ff ff
880: ff ff ff ff 00 00 00 00 00 00 00 00 01 00 00 00
890: 01 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8a0: 00 00 00 00 00 00 00 00 60 00 00 04 a0 55 01 00
8b0: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
8c0: 00 00 00 00 44 00 00 00 00 00 00 00 01 00 00 ff
8d0: 00 9c 00 00 32 00 00 00 00 00 00 00 00 00 00 00
8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8f0: 00 00 00 00 00 00 00 00 2a 30 30 35 39 32 61 65
900: ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00
910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
930: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
940: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
950: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
960: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
970: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
990: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
9a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
9b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
9c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
9d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
9e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
9f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
aa0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ab0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ac0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ad0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ae0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
af0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b40: 14 00 00 00 d2 00 00 00 00 00 00 00 00 00 00 00
b50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ba0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
be0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bf0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ca0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
cb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
cc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
cd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ce0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
cf0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
da0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
db0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
dc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
dd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
de0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
df0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ea0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
eb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ec0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ed0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ee0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ef0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f20: 90 01 00 00 00 00 00 00 01 14 01 00 00 00 00 00
f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=EF=BF=BD 00
f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Bartosz

