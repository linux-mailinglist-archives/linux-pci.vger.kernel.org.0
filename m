Return-Path: <linux-pci+bounces-43786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08567CE6045
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 07:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C33B73005BA8
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 06:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5D028E59E;
	Mon, 29 Dec 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GOXQpy2z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Afd68Fft"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD2227BB5
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766989235; cv=none; b=QpAk8WxEQuCWnJR47GGZ3mZjlAS0bcEQyoIMLrSoLR4TT74YNYNpwUAIJGoMqTtEu0+im/8PXd2lEcKjDHfGRtGfTGrwjPM4sxAzMKJj4/X/OphU7yyZvpGrNTHx2Rb97dSlGToEs0UiILVL63gqgCkPc3BAe2SPyGaCow540zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766989235; c=relaxed/simple;
	bh=Zt+/vs/wknzQoPpW3cmLhZT20fdc96YY21T9PDEHX8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAsfx3K4gVBl/5OK910sds04su4RzUBRN7dt9weZZv9m7IPK43OwEjOC3KWZ6Jt1gzgaZKQ677OHVJ97MbJBn97bl6JsljitXGOrBQHvaHpk/6DrX4uRbWrF4LlhIe54BLpDnh5euA5EP4tMlvQOXI90lvYV+qnq4UAuNkc5lYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GOXQpy2z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Afd68Fft; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSLn9tB3156595
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 06:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	05YqvqnHZLPGWVCxziWJ9iVEtfJmID8mJOTDgMIm0oc=; b=GOXQpy2zwsC4vHnE
	ZDVuI3nHppMWgVCDVMQpTDeU/YC950xPVmOGRAb34P8L0sM+4RocnfYGKDA/Rev5
	S8ma+yE+uFMcYBdOHUFn/YdsOid6syQFfdbBtQyBaYEi2o2HqLTEYlpSxYbA9VZn
	cA0H78mlPILYq+gL0RbQdkIcOpGiVrVd3jrjFbD+CgrHl16cQ3G/1v/F6i1gjl36
	bjh0+h7WDqnpQboWRhvvHMcBgV5SzxDWM9OOIE9dsWMOSl+e0OzgXoc+NrHT57mr
	iPusB9VVX/of7MeHMTOrQWF9mI3keSK0VKel8PeZvjJttnT+dp1f43lKpTAEfCiv
	7XBpBw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba4tnuqy2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 06:20:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7f046e16d50so14830702b3a.3
        for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 22:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766989230; x=1767594030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05YqvqnHZLPGWVCxziWJ9iVEtfJmID8mJOTDgMIm0oc=;
        b=Afd68FftLyez6Y6RU2z2g+KKDWgpnDdPI0vsDCLPupCLBFEziMjFYtPRwxhE6Dxud0
         uyn76twWyb8wzUAeUjtW3aRJeq1NvLDsWORusLLLOm7WYJkfK/08gchXOk4dVy2+CMT2
         qwBPs8n8mw2YLZOB+3mltJiWHXbjuUfd57TIq7iepDAYzYL/HBLJtt0/64tO6zSeL+MG
         bVQKfNYqkjbKGrfmFJ/7BK2z9EA9RZysDrmRmH6uu5nQrVl4XEX26MkKm45qgUOvisvo
         5aLcw6QoS9rWCjJs1aKoWGDm700PtAVTZL0LmMTvvpbuDueDTvUAgyxxwVdfZBSgAU36
         Gklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766989230; x=1767594030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05YqvqnHZLPGWVCxziWJ9iVEtfJmID8mJOTDgMIm0oc=;
        b=k1J6eXPwUU2L5f8AoMjN3fN8fJhCpE4EfajDYAFrWgkx46rTfP/akrL5ej4OfpRErd
         c2Co0Zw8OnuPXpgSp74/s0aHA11my1L/QQAcUJ9MZ38fywmF5ykf9QyKAEH/dGiQdErI
         Joess76EY+fuKh/ZLwq9Q6Wmtk7QHNk+peaShd2AMFwjpvICaNkBb5nsYv3Lm/zeXUNa
         4E69DfLcKJ5e2t1CRhHcOAFSKB14+skj5fw/Jwt5gTBqTYxJAAiU5XUq7iMvrRKeJ/gm
         Ce51fyRTty4/iODTHeZlFbD3KrUVn64RakmUxirL6RYkw7ltMHxzNqxqiDx0O+RbFaDq
         bnJA==
X-Forwarded-Encrypted: i=1; AJvYcCWAcxKSffXvmVf4TLG6EI4lYkUP9sBeGLYVPxRre6WzihGgRGcj5KXG9oy7mczrSN8ZnTLKisqp3sg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hUogFlKPkbQroH0YOP4T+cXzO96ahJ4KZtvChBy1jmXjcBuX
	rdTPgC1HZO235XPbVuu3mda6w/ERCIfUM4y1DAJgNIby3jg3CCyYQ0JHPI17nxzmrVh01WKh0/t
	qms/vQ3HiAm86rsuW8E/LNN0/FpZx4DRU9rUPnQ8h0uVhRB16y0sb1wsNLv1iuzey7BYkGBY=
X-Gm-Gg: AY/fxX7VmmACVXq4vZh7zuP1YO/9QIHYx2pzKPQvtx+/w5bPf1J/qUEl8GZjSSA+4Gj
	ZOLLOT88m3PmFH/R/J9wv5QmLyw04znDBnoi/2aU08niYFBPwmBasmBtZbNzpLudW7eTREBuRQO
	KIbCFJsAr+HMFuVBfm6mc//ja2ifrwkJ5x6WOrmEETht2sAYmK0FhbrUAakgr2UFvfCkIAjvsGS
	NycRUt3n8fB191IjaW/fjO8we2TMVLY7ne0myO1GcCrb752jGZnd42LeSdluXJdORtaEhLBPGaA
	BxsO7Ki10qB8sKqdiQlioXsEit3Bm21mVzjE2gh5j748X1M+xIrlAFCvuaQZimZ7y3UUuBckttq
	6tsarlB4qu9/9MO1F0BuhNxWjEeygENXw3omZCBB1WA==
X-Received: by 2002:a05:6a00:2998:b0:792:5db2:73ac with SMTP id d2e1a72fcca58-7ff64403c13mr27779743b3a.7.1766989230318;
        Sun, 28 Dec 2025 22:20:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/8PPFmUNAMdVmgSmx/862LH6AcDkr44kAE+N9QqjwiCDDj6Ydn7TWfSHyJUMycKsXaTOkHQ==
X-Received: by 2002:a05:6a00:2998:b0:792:5db2:73ac with SMTP id d2e1a72fcca58-7ff64403c13mr27779720b3a.7.1766989229776;
        Sun, 28 Dec 2025 22:20:29 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab841sm28202057b3a.35.2025.12.28.22.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 22:20:29 -0800 (PST)
Message-ID: <5b4418bd-6e04-477b-a8be-e4c469633371@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 11:50:24 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: dwc: Fix missing iATU setup when ECAM is enabled
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, macro@orcam.me.uk
References: <20251226205239.GA4138276@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251226205239.GA4138276@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G+YR0tk5 c=1 sm=1 tr=0 ts=69521daf cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8
 a=JKhCNoXipOyaKg5nHiIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-GUID: 5s1xY1Ig56bv5OEXiCMtgWAE-oTupcUh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA1NiBTYWx0ZWRfX/98OjsJjasWP
 L4STNrJKypwOp48aKlVTprstAfwqvP9eM6664NDxiOVd3KO6ru5DRWoQSq5b40DftOF93TGJmOr
 /V7g/9X20LzOF8CQa60qaQMBz/lT7sX36tiU8v6trpUL+ziLEoRmmtICcLt+HkFkeCgJQO+jgjs
 aLA75evHHobNgIhWB/7gp8eZOSpZe5Qsk2x1469tvPKNaBY7RkAUQkIHeigUzLpFKoR9qAdhpgY
 1V3IRnd2yV/qEdJj8RCdnta0eJxxn+fb8KSL6Rz5eh4O3wcs5v9MBGD3m8POURQ7Oaek93Y0VTc
 1TokYpWztjHSyFjJyak0GxcMuG6kOg5W+bCtyjfOEQ0ggN10BVKTqo8ZLaNOCiIMtRi5LrM6ZDo
 NEhsey6V0lB8BvYeBAjIuEPvMZ+rt40t398uH+4Dpqt53nf17YKSNVjlQ1eWnBnG9utp/2NulUm
 Km6AIX3BIo9/uxbM7KQ==
X-Proofpoint-ORIG-GUID: 5s1xY1Ig56bv5OEXiCMtgWAE-oTupcUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_01,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512290056



On 12/27/2025 2:22 AM, Bjorn Helgaas wrote:
> On Wed, Dec 03, 2025 at 11:50:15AM +0530, Krishna Chaitanya Chundru wrote:
>> When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
>> before configuring ECAM iATU entries. This left IO and MEM outbound
>> windows unprogrammed, resulting in broken IO transactions. Additionally,
>> dw_pcie_config_ecam_iatu() was only called during host initialization,
>> so ECAM-related iATU entries were not restored after suspend/resume,
>> leading to failures in configuration space access
> Thanks for fixing this bug.
>
>> To resolve these issues, the ECAM iATU configuration is moved into
>> dw_pcie_setup_rc(). At the same time, dw_pcie_iatu_setup() is invoked
>> when ECAM is enabled.
>>
>> Rename msg_atu_index to ob_atu_index to track the next available outbound
>> iATU index for ECAM and MSG TLP windows. Furthermore, an error check is
>> added in dw_pcie_prog_outbound_atu() to avoid programming beyond
>> num_ob_windows.
>>
>> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
>> Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
>> Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 37 ++++++++++++++---------
>>   drivers/pci/controller/dwc/pcie-designware.c      |  3 ++
>>   drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>>   3 files changed, 26 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 4fb6331fbc2b322c1a1b6a8e4fe08f92e170da19..22c6ec7bff8840d935803f0b96749413b1c3f905 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -433,7 +433,7 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>>   	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
>>   	 * remaining buses need type 1 iATU configuration.
> Tangent: I think this comment should say "Immediate bus under Root
> Port needs type 0" or "Root bus needs type 0".
>
>>   	 */
>> -	atu.index = 0;
>> +	atu.index = pp->ob_atu_index;
> Previously we used entries 0 and 1 for config space accesses; now we
> program the entries for bridge->windows first and use later entries for
> config space.  But the implicit reservation of entry 0 persists below.
>
>>   	atu.type = PCIE_ATU_TYPE_CFG0;
>>   	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
>>   	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
>> @@ -443,6 +443,8 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>>   	if (ret)
>>   		return ret;
>>   
>> +	pp->ob_atu_index++;
>> +
>>   	bus_range_max = resource_size(bus->res);
>>   
>>   	if (bus_range_max < 2)
>> @@ -455,7 +457,11 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>>   	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
>>   	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
>>   
>> -	return dw_pcie_prog_outbound_atu(pci, &atu);
>> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
>> +	if (!ret)
>> +		pp->ob_atu_index++;
>> +
>> +	return ret;
> This would be better like this to match the type 0 case:
>
>      ret = dw_pcie_prog_outbound_atu(pci, &atu);
>      if (ret)
>          return ret;
>
>      pp->ob_atu_index++;
>      return 0;
>
>>   }
>>   
>>   static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
>> @@ -630,14 +636,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   	if (ret)
>>   		goto err_free_msi;
>>   
>> -	if (pp->ecam_enabled) {
>> -		ret = dw_pcie_config_ecam_iatu(pp);
>> -		if (ret) {
>> -			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
>> -			goto err_free_msi;
>> -		}
>> -	}
>> -
>>   	/*
>>   	 * Allocate the resource for MSG TLP before programming the iATU
>>   	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
>> @@ -942,7 +940,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> Earlier in dw_pcie_iatu_setup(), we have this:
>
>      i = 0;
>      resource_list_for_each_entry(entry, &pp->bridge->windows) {
>          if (pci->num_ob_windows <= ++i)
>              break;
>
>          atu.index = i;
>          dw_pcie_prog_outbound_atu(pci, &atu);
>
> I think this starts at 1 because of the implicit reservation of entry
> 0 for config access, so now I think entry 0 is never used.
>
> Since dw_pcie_prog_outbound_atu() now checks against
> pci->num_ob_windows, I don't think we should also do it here.
>
> The use of preincrement also makes this harder to read than it should
> be.  You could do something like this:
>
>      i = 0;
>      resource_list_for_each_entry(entry, &pp->bridge->windows) {
>          atu.index = i++;   # i++ better matches inbound ATU setup
>          ret = dw_pcie_prog_outbound_atu(pci, &atu);
>          if (ret)
>              return ret;
>          pci->ob_atu_index = i;
>      }
Yeah, this problem still present, this patches actually aimed for 6.19, 
so I skipped fixing
this index 0 reservation issue explicitly, since this needs separate  
patch as this needs to
be back ported separately.  I will raise separate patch for this.
>>   		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>>   			 pci->num_ob_windows);
>>   
>> -	pp->msg_atu_index = ++i;
>> +	pp->ob_atu_index = ++i;
>>   
>>   	i = 0;
>>   	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
>> @@ -1084,14 +1082,23 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>>   	/*
>>   	 * If the platform provides its own child bus config accesses, it means
>>   	 * the platform uses its own address translation component rather than
>> -	 * ATU, so we should not program the ATU here.
>> +	 * ATU, so we should not program the ATU here. If ECAM is enabled, config
>> +	 * space access goes through ATU, so setup ATU here.
> Wrap comment to fit in 80 columns.
>
> s/setup ATU/set up ATU/
>
>>   	 */
>> -	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
>> +	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
>>   		ret = dw_pcie_iatu_setup(pp);
>>   		if (ret)
>>   			return ret;
>>   	}
>>   
>> +	if (pp->ecam_enabled) {
>> +		ret = dw_pcie_config_ecam_iatu(pp);
>> +		if (ret) {
>> +			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>>   	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
>>   
>>   	/* Program correct class for RC */
>> @@ -1113,7 +1120,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>>   	void __iomem *mem;
>>   	int ret;
>>   
>> -	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
>> +	if (pci->num_ob_windows <= pci->pp.ob_atu_index)
>>   		return -ENOSPC;
> You added basically the same check in dw_pcie_prog_outbound_atu(), so
> I don't think this check is needed, is it?

dw_pcie_create_ecam_window, is not checking if the index is in the num_ob_windows
limit or not. Instead of having two checks in each iATU created, I added single
check here.

>>   	if (!pci->pp.msg_res)
>> @@ -1123,7 +1130,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>>   	atu.routing = PCIE_MSG_TYPE_R_BC;
>>   	atu.type = PCIE_ATU_TYPE_MSG;
>>   	atu.size = resource_size(pci->pp.msg_res);
>> -	atu.index = pci->pp.msg_atu_index;
>> +	atu.index = pci->pp.ob_atu_index;
>>   
>>   	atu.parent_bus_addr = pci->pp.msg_res->start - pci->parent_bus_offset;
> It worries me a bit that we don't log any messages when this function
> fails.  If it ever does fail, whether we failed to allocate pp.msg_res
> or there are no available ATU entries, it looks like suspend might
> silently fail with no clue in the logs, which sounds like a hassle to
> debug.
Ack.
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index c644216995f69cbf065e61a0392bf1e5e32cf56e..f9f3c2f3532e0d0e9f8e4f42d8c5c9db68d55272 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -476,6 +476,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>>   	u32 retries, val;
>>   	u64 limit_addr;
>>   
>> +	if (atu->index > pci->num_ob_windows)
>> +		return -ENOSPC;
>> +
>>   	limit_addr = parent_bus_addr + atu->size - 1;
>>   
>>   	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index e995f692a1ecd10130d3be3358827f801811387f..69d0bd8b3c57353763f98999e5d39527861fe1a7 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -423,8 +423,8 @@ struct dw_pcie_rp {
>>   	struct pci_host_bridge  *bridge;
>>   	raw_spinlock_t		lock;
>>   	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>> +	int			ob_atu_index;
> The number of outbound ATU entries (num_ob_windows) is apparently a
> Root Complex property, not a Root Port property, so it's in struct
> dw_pcie.  If ob_atu_index tracks how many of those entries are in use,
> I think it should be in struct dw_pci too instead of being in struct
> dw_pcie_rp.
ack.

- Krishna Chaitanya.
>>   	bool			use_atu_msg;
>> -	int			msg_atu_index;
>>   	struct resource		*msg_res;
>>   	bool			use_linkup_irq;
>>   	struct pci_eq_presets	presets;
>>
>> -- 
>> 2.34.1
>>


