Return-Path: <linux-pci+bounces-22681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9EEA4A640
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 23:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9C21899EC2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771701DE8AB;
	Fri, 28 Feb 2025 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxeUqstM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7BE1A3140;
	Fri, 28 Feb 2025 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783449; cv=none; b=OjhHs71JsbXxfLXNtoMw8WWpsIqWFSkFS9hYYTwvxkFKlEwr04GwGlWQ8va5NyIpChVjmAs7zT0L0u8XWh5GadysmC0b2nHFG0OGWhlfmIGx4H5R878NDBdiU/cgKrTSLLcXInrF+N/1veMWeLzoAsxf/aIMokEmFceS01q0oCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783449; c=relaxed/simple;
	bh=WMLnSI9SQ0/XViJPHmv5+aeuy3kPdCNlElCF9NJj5Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDYTvz4t/cCfTkOdUBR8GlQAvwsBlU3hIxezGKUMxSGD7daPyCM0Ss6oY4xwnhfycZipsiytqKeV8wbDroTyS+Ch7nVnoS624cT8iwF+bim/iPZMIAFSKP+JXfNr2mGqi0p1OujnkVohKbsjN5PQlrBNRxJV1nNjKpLhVHTeaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxeUqstM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb892fe379so364270766b.0;
        Fri, 28 Feb 2025 14:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740783446; x=1741388246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ9vrPuZKHglRvDTCb+9WUSOgDE6HzKOx9it/BTeGAs=;
        b=lxeUqstMYwSHbljsyIdjyhUe6GyiXi+qPkMnUxn10wFGlFdD1jfVENrH86wkx1SK8o
         HVGMeUtkeY4qbH5Ux0ZpjXWol5Dm5NG8o3L4FibOERXiPJkFliYOWZOY4lMTSKYui1xP
         M3YjYE5Qj0L9pJKM5zs1Wu6DuJaJhut2DyUskT/fYpqN23B9CJw2pYB97m/+PmkMar/H
         Mwv7lSTLcpCsgtXHJjV3lSifLf8/S/B4sYtgLS0k6nXczbaWfXXQNa3fx/hDnoc3ADkF
         Ao1ylmFXSbY6muXNfZLno4GSJCRk4QIGtkNoDheKwuO1LqgVTFNnriotzCPAp1F5stQD
         LQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783446; x=1741388246;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ9vrPuZKHglRvDTCb+9WUSOgDE6HzKOx9it/BTeGAs=;
        b=Z9LvKfYLtm9DaWJC6wUdTWEtHoXYL6xR1Ewij2P+TCqc8cfI81CkvFX4Do44zkQ+MU
         MLJUlONZHlLEPNuJ2i/WRcAuO1ZZKgWh9Uzak/7dr1DhRIGgM50FqTgQQZcNkhCv5LOo
         6lcoFM+jhAL9sqcO3x1aHjFXQ9ntYDXXED+iQ6edALqRW46Q5rX9LizmMxEFJWvd4ZlL
         xCbzkAwwrvU6jZN7MU1e+6snj7mvokiYQntWWSA59uYhVcTvdvmAG3Mo502NH3Ziy9+p
         Vd52kQRyroEup0qqXIiNXtRUehZKwFhHhqOQ83hwiujZb49v8XEwm2XiihOBSkPBYj6C
         6sHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXiZZNQr6wSvPiHbgFABl81uYTnwnYUm5vZdKm+QSCiXZ5J4Glprs/lv1UVpNVBDOdl9DsD1Ti@vger.kernel.org, AJvYcCUe1P5vIsnoHcmb9gN5E9nqxxQYlK/9XYK+msNN4TzQQoL+4jhlGlrG9Ka5hnoFkGs9QOJa8bQWv8Fqhmk=@vger.kernel.org, AJvYcCVnZ+IjTAnxZIdKHQOb0ds46KeLoJVxLdr4X+HExueV/2seRX3J1/GcEGmIvPyEpPi+eSUccJ+kNiyB@vger.kernel.org
X-Gm-Message-State: AOJu0YwWl9Vi72GdLVX/MNWNjU8T97fiC25kfJrn2v36TjUkSpNwB0Qn
	EpjdfKtbLzHutlVaaNcff9l5UXFgKLi9/haqByWvdcrQGDbDXlrq
X-Gm-Gg: ASbGnctlS9r0jWPx7V+cFeBwINprCtL1d5ujNJsdKTuXErTmnWIJSsQD7XcLUA6oOGG
	h4Hcmrmxm4YDsHOppmduLbx8vkowoOudZSIQvND1iSn3V+NKHGeAfy/ajghWEY8fyfEDrR8U40h
	VwZ0f3rz8SULA3CQoZu71pwO9fGERqLf5MhewpWOhvloN8GGPoFqwnzT7Etfm+W2ZIWys6IK5p0
	EG4QgMEmfyEcbz7B3IZjH0pwkzydzaeglwsMjbdm4xukEfiYPRFxFyIKWvVl0nOnVgph+iyASUf
	aDRSz5eNRPfVlWR1gns8AW6X54IKr3mX9p7mgI3A6c91IGxu06cmAkA5zIanqmITjfuDF8m1pKh
	s2o6vP9up+y5Tdk8oTbsWvJ4q8Vn/1ZgcxrILKfeOiHPAIlvawvzHQCZ0fColl9xTMU7Sjt19W/
	4wBdVqSMcpTPpHXYJg41vUrnucImGzSofCEqWR
X-Google-Smtp-Source: AGHT+IEenxmA41PtiSn649HIT8duMpsmivaQAC7fNzHqYti8c54i0LqPEuAvwpDVFS0ZX0ilQat+zA==
X-Received: by 2002:a05:6402:358f:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5e4d6af1677mr10406661a12.15.1740783445393;
        Fri, 28 Feb 2025 14:57:25 -0800 (PST)
Received: from ?IPV6:2a02:3100:af43:5200:e57d:90a4:e6b5:1175? (dynamic-2a02-3100-af43-5200-e57d-90a4-e6b5-1175.310.pool.telefonica.de. [2a02:3100:af43:5200:e57d:90a4:e6b5:1175])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abf0c0b99bcsm360391766b.24.2025.02.28.14.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 14:57:24 -0800 (PST)
Message-ID: <7b32aa88-d3bc-4414-a124-59befc3dc098@gmail.com>
Date: Fri, 28 Feb 2025 23:58:27 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] r8169: enable
 RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126 LTR support
To: Bjorn Helgaas <helgaas@kernel.org>, Hau <hau@realtek.com>
Cc: nic_swsd <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250224190013.GA469168@bhelgaas>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250224190013.GA469168@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.02.2025 20:00, Bjorn Helgaas wrote:
> On Mon, Feb 24, 2025 at 04:33:50PM +0000, Hau wrote:
>>> On 21.02.2025 08:18, ChunHao Lin wrote:
>>>> This patch will enable RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126
>>>> LTR support on the platforms that have tested with LTR enabled.
>>>
>>> Where in the code is the check whether platform has been tested with LTR?
>>>
>> LTR is for L1,2. But L1 will be disabled when rtl_aspm_is_safe()
>> return false. So LTR needs rtl_aspm_is_safe() to return true.
>>
>>>> Signed-off-by: ChunHao Lin <hau@realtek.com>
>>>> ---
>>>>  drivers/net/ethernet/realtek/r8169_main.c | 108
>>>> ++++++++++++++++++++++
>>>>  1 file changed, 108 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>>>> b/drivers/net/ethernet/realtek/r8169_main.c
>>>> index 731302361989..9953eaa01c9d 100644
>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>> @@ -2955,6 +2955,111 @@ static void rtl_disable_exit_l1(struct
>>> rtl8169_private *tp)
>>>>       }
>>>>  }
>>>>
>>>> +static void rtl_set_ltr_latency(struct rtl8169_private *tp) {
>>>> +     switch (tp->mac_version) {
>>>> +     case RTL_GIGA_MAC_VER_70:
>>>> +     case RTL_GIGA_MAC_VER_71:
>>>> +             r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdd2, 0x8c09);
>>>> +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdd4, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcde8, 0x887a);
>>>> +             r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdec, 0x8c09);
>>>> +             r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdf0, 0x8a62);
>>>> +             r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdf4, 0x883e);
>>>> +             r8168_mac_ocp_write(tp, 0xcdf6, 0x9003);
>>>> +             break;
>>>> +     case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
>>>> +             r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdd2, 0x889c);
>>>> +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdd4, 0x8c30);
>>>> +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcde8, 0x883e);
>>>> +             r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdec, 0x889c);
>>>> +             r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdf0, 0x8C09);
>>>> +             r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
>>>> +             break;
>>>> +     case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_53:
>>>> +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
>>>> +             r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
>>>> +             r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
>>>> +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
>>>> +             break;
>>>> +     default:
>>>> +             break;
>>>> +     }
>>>> +}
>>>> +
>>>> +static void rtl_reset_pci_ltr(struct rtl8169_private *tp) {
>>>> +     struct pci_dev *pdev = tp->pci_dev;
>>>> +     u16 cap;
>>>> +
>>>> +     pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &cap);
>>>> +     if (cap & PCI_EXP_DEVCTL2_LTR_EN) {
>>>> +             pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
>>>> +                                        PCI_EXP_DEVCTL2_LTR_EN);
>>>> +             pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
>>>> +                                      PCI_EXP_DEVCTL2_LTR_EN);
>>>
>>> I'd prefer that only PCI core deals with these registers
>>> (functions like pci_configure_ltr()). Any specific reason for this
>>> reset? Is it something which could be applicable for other devices
>>> too, so that the PCI core should be extended?
>>>
>> It is for specific platform. On that platform driver needs to do
>> this to let LTR works.
> 
I interpret this in a way that the chip triggers some internal LTR
configuration activity if it detects bit PCI_EXP_DEVCTL2_LTR_EN
changing from 0 to 1. And this needed activity isn't triggered
if PCI_EXP_DEVCTL2_LTR_EN is set already and doesn't change.
Hau, is this correct?

So the PCI_EXP_DEVCTL2_LTR_EN reset is some kind of needed quirk.
However PCI quirks are applied too early, before we even detected
the chip version in probe(). Therefore I also think a helper for
this reset in PCI core would be best.

And what hasn't been mentioned yet: We have to skip the chip-specific
LTR configuration if pci_dev->ltr_path isn't set.

> This definitely looks like code that should not be in a driver.
> Drivers shouldn't need to touch ASPM or LTR configuration unless
> there's a device defect to work around, and that should use a PCI core
> interface.  Depending on what the defect is, we may need to add a new
> interface.
> 
> This clear/set of PCI_EXP_DEVCTL2_LTR_EN when it was already set could
> work around some kind of device defect, or it could be a hint that
> something in the PCI core is broken.  Maybe the core is configuring
> ASPM/LTR incorrectly.
> 
> Bjorn


