Return-Path: <linux-pci+bounces-24974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F6DA75585
	for <lists+linux-pci@lfdr.de>; Sat, 29 Mar 2025 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38FC7A5544
	for <lists+linux-pci@lfdr.de>; Sat, 29 Mar 2025 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732C1ADC97;
	Sat, 29 Mar 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKPCq82n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047D188A3B
	for <linux-pci@vger.kernel.org>; Sat, 29 Mar 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743241196; cv=none; b=dGTV4lBtNyvaMSZNBFZO7+yBjGrifT0c2PBGkdWzn9DSB8qqmLcR/PFuxbhyyHDT9rn4fCsgM4mSWHznEbydtghTIWxBc5Hd3qFiqqiF22xqLSL3T7kKCWtrDzdHKB994FsRDvXYBuj+N+jh1qYvciCo4LLeBLrkOOS1JDWRaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743241196; c=relaxed/simple;
	bh=h448OrPfM6UqZDCzp4murBMKPsAopVuytMHYVBEJNWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG5KrQ9SoocqQ209YsuL2pQPijqxXMneiTTp8ub66QpsmCPVlBJPUXcVj3B3TaUm5GUfw15ZPUW8s09+PVmgTDR0SjyTYLedDnYW9Dug22RHrb5Oqa9C1IpDmRdB4ca9DbtZuup762EzBp3GlPkyFfuoxhzN65jfrs4rV7IaB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JKPCq82n; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2239c066347so69265745ad.2
        for <linux-pci@vger.kernel.org>; Sat, 29 Mar 2025 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743241193; x=1743845993; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f1B6fKZgCWYC21ZRAVBlXkt0qD2ak5SViuiSZ8N3+e4=;
        b=JKPCq82nH8bDC+cU8tnhJWItY3Ilb6xEVyaKIkICBEReBze7/s0Z04Fq90xv/ZWTu9
         uDfw19DOa1c4zb4maRAj37trhYQX5sp05MmdejOk1AjH8ny7eabJJVHj2hMJSmGXHhKa
         ze0jRZ2cQI1whbhJexo69q3G4Z4iewcdQZ1a3OrvZwEFL/3U1Rn6ukQl9zdQO+I8ck2L
         rGPRKXU63wvjNzYVXzrhWgVz16KZgrpDKpik5CfFPCs15UhmANaqePm8NjcQHkOQYlnO
         b+f3ZM398IsFY8qIiY//Oj/hCheALT6w78KIqfbP8ROf6aHYRsn//+qbt/c5t4eq/bXG
         1E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743241193; x=1743845993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1B6fKZgCWYC21ZRAVBlXkt0qD2ak5SViuiSZ8N3+e4=;
        b=AI2T58WdB7ZtjCiP93lz9L1AYjXQcFboQrM95lhsv9jQzr5CDdVQSeXA4t3JdFjNZS
         iE9ri45HxyhwDjvfww67+CjwIVaqyI28J1PzWQHpw6LNzhqZiKSN2Z6UtOyJjxdyTDj9
         +kHUrpg9ZejTwso+YuTXdR2Q6RWnZZ2+VYYXObznXUI1Sns6q8w/7LMd4d7Bk60UXI7U
         yiObE/TO9k4YcyuHngdQTeptLlIr+ydZ+OxhiCb0k2ghlzJWAU0xnOoNbErKtu/LGD0H
         IVmkJBLnBrvbUCyjHr5ji3aPdnlhKD5QUxet31Bd0waVln4yHYApIgm8oqvNbMWd9z6G
         Aigw==
X-Forwarded-Encrypted: i=1; AJvYcCWOuhMjoD4z3Ks9aTQlDjqV8rCRj0jNhhkSA9A+sgGSC8ajCSsUoZiG1dtXOd/Pv6QbkycL9XqxikM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWFOfQ1/NUEQQ7bnORPtaYdXfqMvBncoqkZwI99mRDMxlfaZa
	8Ujb/IDe3PB0rM5KLvsbeKHHAxTmvOXhZBoGS0G0ZLUM3BYOVuf1uijV0c+aKg==
X-Gm-Gg: ASbGncuXu5F97gBq8uLOTfLBnleM9XqdXNRjtU6Z1FCcVZ8EDwUKa1rdlJp0D4Tl5Gw
	eB8jbb3pvuuAfOVCYKeiw6er4riJTSazM3vLzvXE4bdVtmPOJUfaziWjdpeD8Fzw3Yh6iqJQAFw
	u2n3pUZPzG7CaZRGs3ybu58T9hfXGCHFJHmzdt+08Zf7APPt35eRWZ8Eo1GUpp8zp6P9rBxLBqx
	0jSNCvrKi3QMidQYROdf6QkMHOreWT+1uQUoLLVR0rli2HmqtoWTCOlb0OhqV3eoz6bCoP5Na9l
	PDpqiIUolQBb3GEZjgorCkag/WCDXQCMvD8amB46VofiNEsm0lZQH2uUie+WpARDyg==
X-Google-Smtp-Source: AGHT+IE1KaqJ+6Cbvp5IKf9CYxA89yFr/QCAcVpYriUorwTLgRU9GCydNQpKyuIpw63iCI+2E23ifQ==
X-Received: by 2002:a17:902:ea02:b0:21f:6546:9af0 with SMTP id d9443c01a7336-2292f9fcb73mr34169145ad.44.1743241193405;
        Sat, 29 Mar 2025 02:39:53 -0700 (PDT)
Received: from thinkpad ([120.60.65.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf4f6sm31834655ad.152.2025.03.29.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 02:39:52 -0700 (PDT)
Date: Sat, 29 Mar 2025 15:09:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, quic_mrana@quicinc.com, 
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v8 4/4] PCI: dwc: Add support for configuring lane
 equalization presets
Message-ID: <4rep2gvymazkk7pgve36cw7moppozaju7h6aqc3gflxrvkskig@62ykri6v4trs>
References: <20250316-preset_v6-v8-0-0703a78cb355@oss.qualcomm.com>
 <20250316-preset_v6-v8-4-0703a78cb355@oss.qualcomm.com>
 <3sbflmznjfqpcja52v6bso74vhouv7ncuikrba5zlb74tqqb5u@ovndmib3kgqf>
 <92c4854d-033e-c7b5-ca92-cf44a1a8c0cc@oss.qualcomm.com>
 <mslh75np4tytzzk3dvwj5a3ulqmwn73zkj5cq4qmld5adkkldj@ad3bt3drffbn>
 <5fece4ac-2899-4e7d-8205-3b1ebba4b56b@oss.qualcomm.com>
 <abgqh3suczj2fckmt4m2bkqazfgwsfj43762ddzrpznr4xvftg@n5dkemffktyv>
 <622788fa-a067-49ac-b5b1-e4ec339e026f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <622788fa-a067-49ac-b5b1-e4ec339e026f@oss.qualcomm.com>

On Sat, Mar 29, 2025 at 09:59:46AM +0100, Konrad Dybcio wrote:
> On 3/29/25 7:30 AM, Manivannan Sadhasivam wrote:
> > On Fri, Mar 28, 2025 at 10:53:19PM +0100, Konrad Dybcio wrote:
> >> On 3/28/25 7:45 AM, Manivannan Sadhasivam wrote:
> >>> On Fri, Mar 28, 2025 at 11:04:11AM +0530, Krishna Chaitanya Chundru wrote:
> >>>>
> >>>>
> >>>> On 3/28/2025 10:23 AM, Manivannan Sadhasivam wrote:
> >>>>> On Sun, Mar 16, 2025 at 09:39:04AM +0530, Krishna Chaitanya Chundru wrote:
> >>>>>> PCIe equalization presets are predefined settings used to optimize
> >>>>>> signal integrity by compensating for signal loss and distortion in
> >>>>>> high-speed data transmission.
> >>>>>>
> >>>>>> Based upon the number of lanes and the data rate supported, write
> >>>>>> the preset data read from the device tree in to the lane equalization
> >>>>>> control registers.
> >>>>>>
> >>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >>>>>> ---
> >>>>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 60 +++++++++++++++++++++++
> >>>>>>   drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
> >>>>>>   include/uapi/linux/pci_regs.h                     |  3 ++
> >>>>>>   3 files changed, 66 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> >>>>>> index dd56cc02f4ef..7c6e6a74383b 100644
> >>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> >>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> >>>>>> @@ -507,6 +507,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >>>>>>   	if (pci->num_lanes < 1)
> >>>>>>   		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
> >>>>>> +	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
> >>>>>> +	if (ret)
> >>>>>> +		goto err_free_msi;
> >>>>>> +
> >>>>>>   	/*
> >>>>>>   	 * Allocate the resource for MSG TLP before programming the iATU
> >>>>>>   	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> >>>>>> @@ -808,6 +812,61 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >>>>>>   	return 0;
> >>>>>>   }
> >>>>>> +static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
> >>>>>> +{
> >>>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >>>>>> +	u8 lane_eq_offset, lane_reg_size, cap_id;
> >>>>>> +	u8 *presets;
> >>>>>> +	u32 cap;
> >>>>>> +	int i;
> >>>>>> +
> >>>>>> +	if (speed == PCIE_SPEED_8_0GT) {
> >>>>>> +		presets = (u8 *)pp->presets.eq_presets_8gts;
> >>>>>> +		lane_eq_offset =  PCI_SECPCI_LE_CTRL;
> >>>>>> +		cap_id = PCI_EXT_CAP_ID_SECPCI;
> >>>>>> +		/* For data rate of 8 GT/S each lane equalization control is 16bits wide*/
> >>>>>> +		lane_reg_size = 0x2;
> >>>>>> +	} else if (speed == PCIE_SPEED_16_0GT) {
> >>>>>> +		presets = pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS - 1];
> >>>>>> +		lane_eq_offset = PCI_PL_16GT_LE_CTRL;
> >>>>>> +		cap_id = PCI_EXT_CAP_ID_PL_16GT;
> >>>>>> +		lane_reg_size = 0x1;
> >>>>>> +	} else {
> >>>>>
> >>>>> Can you add conditions for other data rates also? Like 32, 64 GT/s. If
> >>>>> controller supports them and if the presets property is defined in DT, then you
> >>>>> should apply the preset values.
> >>>>>
> >>>>> If the presets property is not present in DT, then below 'PCI_EQ_RESV' will
> >>>>> safely return.
> >>>>>
> >>>> I am fine to add it, but there is no GEN5 or GEN6 controller support
> >>>> added in dwc, isn't it best to add when that support is added and
> >>>> tested.
> >>>>
> >>>
> >>> What is the guarantee that this part of the code will be updated once the
> >>> capable controllers start showing up? I don't think there will be any issue in
> >>> writing to these registers.
> >>
> >> Let's not make assumptions about the spec of a cross-vendor mass-deployed IP
> >>
> > 
> > I have seen the worse... The problem is, if those controllers start to show up
> > and define preset properties in DT, there will be no errors whatsoever to
> > indicate that the preset values were not applied, resulting in hard to debug
> > errors.
> 
> else {
> 	dev_warn(pci->dev, "Missing equalization presets programming sequence\n");
> }
> 

Then we'd warn for controllers supporting GEN5 or more if they do not pass the
presets property (which is optional).

> > 
> > I'm not forseeing any issue in this part of the code to support higher GEN
> > speeds though.
> 
> I would hope so as well, but both not programming and misprogramming are
> equally hard to detect
> 

I don't disagree. I wanted to have it since there is no sensible way of warning
users that this part of the code needs to be updated in the future.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

