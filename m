Return-Path: <linux-pci+bounces-13485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B06D9852A0
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 07:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0C8B2264F
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4E14E2DA;
	Wed, 25 Sep 2024 05:50:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC31B85D5;
	Wed, 25 Sep 2024 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727243406; cv=none; b=EsYl1zvTMvWrlGWzuZSebKLIRvLquKebePLrKPVMBjgpX+F4SNshJ0lnAZMpvk3h8czk9/alCgS/ZYcMgHN+mozYx5/ELULReYT2G6/QPiIFxQnjt61rSXVgwuJH0HWcpZkVTbOnMzZ7XtLSH6IgycAa4ZK7XNB+DFDTsg2J7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727243406; c=relaxed/simple;
	bh=FNgvbMaqLXYmsJXcAxu4byiQRFJLsmkKtoRFCHKHUHU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eCWwM0nHbcMZyjOZV9Y25G8pHHoiMPLfr8lnP4nDTYDlx+w2jw/iqZ5sJC9FarKzQ/h0W+Q4owNZppEXgI+1qVlsXcnpPGMMNmGz40JkUAm3E0F03AN1UdzXhn6sd7MoDJcbERZhlWGlTddtjK5xWLYohbXExN0CvAiiZi8EgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c2561e8041so8713343a12.2;
        Tue, 24 Sep 2024 22:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727243402; x=1727848202;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuTSBdjniJEXFQhV59T1KqJYppW51Xb82xXlMdke/k8=;
        b=TJugWLKBRkrD1FrbLa3n1SnPII4wtr+O12W1uPd/bEp08TTX/Wld7CQM9cZKsIm+xh
         T/G2tmuqqQChnVdOdaao5A86HWKa9fP+4TQ1W4Z9x3R27v2IWw0btxAx7UsnmhUAKq/t
         Pb/seNRxwSj/8784tkRDp/mcvbRlKLi/rIg6sb5nuN4DLZILhIavY/x5lPO0m+zvNU0P
         D/7LESi+gZIS+vXCtN4NXXVPiobvZZ3F+jc73xFUaQXSqTiG0kXHDJQ1PNMexR/m5gLG
         5yFBdjsjYzjHaMpZWW8iYQNNkcm52th9Ga5/gi13O6zLrGLABR50uMa+k44ae8yC8z2Y
         XagQ==
X-Forwarded-Encrypted: i=1; AJvYcCULH8gF0Xbw1dDszWXpHg0HGsDAC8ZJydbxy8tcmFSkW/QHWjySt/tr5bE6+BBcszxTk7KfhM+jclQ=@vger.kernel.org, AJvYcCUXWbtm2Qs2k9WgKH9M8m2evVpegDarjYZujgnFPrbQJAtaZU/RWMbmQizbge7lUSMuKlZqptQA4OoRX4WF@vger.kernel.org, AJvYcCX8Qq/PCZ3XnfWrUrtCu213jJiXLLd9ZXAC0fH7LSNzYpZgnkurZb7DcvGYeDHoHAQvgIdetFlcIHR/@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmKBS+3FH2Bwcuzxk1hu2r2sGYuzFeKxSE1FD0Aidq+asqD9D
	JlC33IdXmdnf8jIHkKAwHHSN7OsiWwPXj+rOn376xgZwaWNI0pib
X-Google-Smtp-Source: AGHT+IFKnS6bHPikk0SvCO1Qa44Jg147G6c4Evzzr6+jMtsfb5Zos86up6hF72KUyeYSODSfUgYBBA==
X-Received: by 2002:a05:6402:13c7:b0:5c5:cb7f:e563 with SMTP id 4fb4d7f45d1cf-5c72060a905mr1270095a12.4.1727243402313;
        Tue, 24 Sep 2024 22:50:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf49de00sm1491517a12.55.2024.09.24.22.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 22:50:01 -0700 (PDT)
Message-ID: <b8fa3062-48ec-4de7-b314-2ff959775ecc@kernel.org>
Date: Wed, 25 Sep 2024 07:49:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
From: Jiri Slaby <jirislaby@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>, corbet@lwn.net, bhelgaas@google.com,
 galshalom@nvidia.com, leonro@nvidia.com, jgg@nvidia.com, treding@nvidia.com,
 jonathanh@nvidia.com
Cc: mmoshrefjava@nvidia.com, shahafs@nvidia.com, vsethi@nvidia.com,
 sdonthineni@nvidia.com, jan@nvidia.com, tdave@nvidia.com,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kthota@nvidia.com, mmaddireddy@nvidia.com,
 sagar.tv@gmail.com, vliaskovitis@suse.com
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240625153150.159310-1-vidyas@nvidia.com>
 <e89107da-ac99-4d3a-9527-a4df9986e120@kernel.org>
 <3cbd6ddb-1984-4055-9d29-297b4633fc41@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <3cbd6ddb-1984-4055-9d29-297b4633fc41@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25. 09. 24, 7:29, Jiri Slaby wrote:
> On 25. 09. 24, 7:06, Jiri Slaby wrote:
>>> @@ -1047,23 +1066,33 @@ static void pci_std_enable_acs(struct pci_dev 
>>> *dev)
>>>    */
>>>   static void pci_enable_acs(struct pci_dev *dev)
>>>   {
>>> -    if (!pci_acs_enable)
>>> -        goto disable_acs_redir;
>>> +    struct pci_acs caps;
>>> +    int pos;
>>> +
>>> +    pos = dev->acs_cap;
>>> +    if (!pos)
>>> +        return;

Ignore the previous post.

The bridge has no ACS (see lspci below). So it used to be enabled by 
pci_quirk_enable_intel_pch_acs() by another registers. But the "if 
(!pos)" does not let it run now.

I am not sure how to fix this as we cannot have "caps" from these 
quirks, so that whole idea of __pci_config_acs() is nonworking for these 
quirks.


00:1c.0 PCI bridge: Intel Corporation C610/X99 series chipset PCI 
Express Root Port #1 (rev d5) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 36
	NUMA node: 0
	Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
	I/O behind bridge: 00001000-00001fff [size=4K]
	Memory behind bridge: f3600000-f37fffff [size=2M]
	Prefetchable memory behind bridge: 00000000f3800000-00000000f39fffff 
[size=2M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s 
<1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via 
WAKE# ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00358  Data: 0000
	Capabilities: [90] Subsystem: Dell Device 0618
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

>>> -    if (!pci_dev_specific_enable_acs(dev))
>>> -        goto disable_acs_redir;
>>> +    pci_read_config_word(dev, pos + PCI_ACS_CAP, &caps.cap);
>>> +    pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
>>> +    caps.fw_ctrl = caps.ctrl;
>>> -    pci_std_enable_acs(dev);
>>> +    /* If an iommu is present we start with kernel default caps */
>>> +    if (pci_acs_enable) {
> 
> AFAIU pci_acs_enable is set from iommus' code via pci_request_acs(). 
> Which is much later than when bridges are initialized here, right?



-- 
js
suse labs


