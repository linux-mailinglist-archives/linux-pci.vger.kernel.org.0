Return-Path: <linux-pci+bounces-34753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F183B35F6B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 14:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC97204B4B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 12:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539802628D;
	Tue, 26 Aug 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i6zmgQ35"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FCD4A33
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212418; cv=none; b=RDMBPvjGPh5ft4M2alZPHh2GoiNMAJ/31dLIL45rpwQlM9eFtPsDXwkcRpAVsTkguZH9zNxDgV/fSy0EdSNTcJsqOe7LRqVBALD3PQAczCPSVKfFQpTtk2kxjYn+94vvdMdwBW9aYoellYGmIGFYyps2ri7aErnpZmJD26Gd3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212418; c=relaxed/simple;
	bh=iHUpwlWM9ME7yJb/N+FUqQzCla783algkjkQendMj5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfJKmuVuNDwJH4EJw8IfZGN3JH8GQS6G5FpzZTsZAuN//58SE7VUfdBEZgwg77cfejfm/0q8cFpcm3u8Qa6Vz8XbQYm6lUgb0PZV4yDeqoNy6yDyzTrFjxDE10lVnQk8vyHEy/mVn1j/vQ7hUCnzgtgTvg/Rn+oaoKWP87LEp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i6zmgQ35; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8kjEW000432
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 12:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VxNvM3zI9+e4Og7qp3khlmwrMRYEiOud00mzVOcnRdw=; b=i6zmgQ351vgxvz2G
	TGLt8+BvEaiAaD18tMzSLcvIk30HjW6tqmnZME8wMtJOGY9t7Nmt/LLJiLA4cLv2
	26yRYSksBeuwP3JN5pnpnAcTjGWshedeV/R/6xNELXt6IlqKqvBmqmSFOTH8OxDc
	11a8HFwoZO2TX4/IY0VT7yLoYxptyA2LqfjKX2/h+JFOskCsSi/i8aKTxyRWP1so
	dpfJm4YrmkjqqRcQlwQ3Q5QekJflSXeqBTIeIVca3a77QftxR+TYuU5FOYmmRrhC
	JlBK8NX9N2sHGXG3O6+BgUTU9VE0BPApaAPbkb7+yb+UekgztUv+nI7CI5BUUo1l
	G4e0Rg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfgrqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 12:46:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24636484391so45805655ad.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 05:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212413; x=1756817213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxNvM3zI9+e4Og7qp3khlmwrMRYEiOud00mzVOcnRdw=;
        b=bL/XYWx6m99JJ7TKZMbwpfol7PUoxX3zW1h4T1BhIllXo1vWOebkmqroIa47CeIUDp
         MOFcZ1+UVAzeIC6u4mAeRDZYgWjj0IA94MFQAyTFuy3f8z8VfiGGfXoeO0+Nyp9Jgeop
         Xf/Vn+TzD47IUWP/38O+0/dZIr+dI7eusLuVsiuDFz+NvVqecF15uYl65xWczxFjYy0r
         ZFao0YEKDXRd8rjYTFMZkb7LhMyFwRtFKL834sIURBCKre6FqE9BOsQz/6l+lE1NJ/G8
         XcHiQxDsSBCSoqQhtH1iBnF5rKOb+/iLwnrgE66VwcCnz/l99+j85TQPbW1Is0Oagalx
         zCaw==
X-Forwarded-Encrypted: i=1; AJvYcCXzy5PG+QdNKdO+wJWcYaKG3xrORSdUEYRtO9Lr6lx4Lb/OMvti+Otd0S5eP68QzLntmMJtCZvl63U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWyQbWuAvcCsv9wZigC7+QO/qCPo5HjQ4F7mKt+8gFfa3kJsTX
	4jSIU5DfSwq5TB5oki+EIRiqJOwaoHA9nrkCFeMK6EY5VrH7qRxW08nDHxMoKFLG4rPpAlvMfoh
	5XwjVuItLA769YTig8REvL6oSL3qrmRWSzBStunLOCZMILdErE7pmPUiAKLYfzJA=
X-Gm-Gg: ASbGncv3Sn/EROtrfUR3GKMGI6egynMSzUG24/7YbGvaNMgqFunDmxpvR7KWl8V6ubD
	pJRH4WBj1DKFToW7mp7nGYia15+sghGwJFFBMh5EUcafRVOLVfBonQcdzzlxS11SpM0qpgfDjMl
	bKEIKYQThARgpEjWtdFwQUiz9cZmhbW7pFnHDby0T9mQ5I1pxsxB3EdAUkz+HcRcg+9vWK/sJr5
	HW9qr3vgsXbFoUS/rwB5sMTPanLVDAF79FSWiX5IjHy3f4uImHlQdth4FF4/45nq9xbTQbBimPS
	CzDqdxDrkh6UU0Lxghs6I7mPpXAr4wyn8SJR9jRPo4ezVD0h2weKlFKIERMOb3O553mJ5s56B98
	=
X-Received: by 2002:a17:903:3850:b0:234:a734:4ab1 with SMTP id d9443c01a7336-2462edecb80mr195025225ad.3.1756212412617;
        Tue, 26 Aug 2025 05:46:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQlHGmsnbqKJkO73iEvjRTmnymqxy942TWEDKdB2+bStn2lPbBN9lYEr1MAUW9X+vuBS67RA==
X-Received: by 2002:a17:903:3850:b0:234:a734:4ab1 with SMTP id d9443c01a7336-2462edecb80mr195024555ad.3.1756212412007;
        Tue, 26 Aug 2025 05:46:52 -0700 (PDT)
Received: from [192.168.29.113] ([49.37.131.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668779fcbsm95807195ad.8.2025.08.26.05.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 05:46:51 -0700 (PDT)
Message-ID: <c89fc295-0dfa-4910-838d-3520272cb26b@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 18:16:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] PCI: dwc: Add ECAM support with iATU configuration
To: Mayank Rana <mayank.rana@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com>
 <20250822-ecam_v4-v7-4-098fb4ca77c1@oss.qualcomm.com>
 <a158c4f5-e9c3-48c2-b440-fa9dc281b276@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <a158c4f5-e9c3-48c2-b440-fa9dc281b276@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXwRKcP7lH8WmN
 22/kI4AhUTzQKfO0zlxxFZn1aUseu2e+6bnyUcuRKU8VDi9kF42L8E1SNy2irY2reXAkyA8TQO+
 6aAidHIJx3f+cKJlCZ6E0Er1DiOAM9DbgAOAP5dooLpB+LVpe8qvwwTGZJNj2/prxqTiLAcRuf8
 SfFP5czDqFgd8zxkwlHCNH8kZNAhyXxRn3OpsEZqwiFmNxDQgTysODUEe/7rlSkVogddoHFVn+N
 i20V4gqDeiCoKev++p6PehQDbukEl8g1+HqAve1pTwbzx02uWokwkGKcnCLAccsFUYIo0URdPfm
 kvlTQ4OFUKpvP97DRXtU8RgVbbXlA7UWov24xg/FIKDK7fzG6MvduvbcA5dK4PDvLy0L3HK7WMP
 LM7FgZek
X-Proofpoint-GUID: wW4s5HHLnegiOfraH71jDvlQ1nAbjWKq
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68adacbe cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=SUMK02a9tYFXUWyLekUkwg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=wZ8ZQ-0c9djv7cOckn8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: wW4s5HHLnegiOfraH71jDvlQ1nAbjWKq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 8/25/2025 11:35 PM, Mayank Rana wrote:
> Hi Krishna
> 
> On 8/22/2025 2:27 AM, Krishna Chaitanya Chundru wrote:
>> The current implementation requires iATU for every configuration
>> space access which increases latency & cpu utilization.
>>
>> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift 
>> Feature,
>> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
>> would be matched against the Base and Limit addresses) of the incoming
>> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
>>
>> Configuring iATU in config shift feature enables ECAM feature to 
>> access the
>> config space, which avoids iATU configuration for every config access.
>>
>> Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift 
>> feature.
>>
>> As DBI comes under config space, this avoids remapping of DBI space
>> separately. Instead, it uses the mapped config space address returned 
>> from
>> ECAM initialization. Change the order of dw_pcie_get_resources() 
>> execution
>> to achieve this.
>>
>> Enable the ECAM feature if the config space size is equal to size 
>> required
>> to represent number of buses in the bus range property.
> 
> Also add 256 MB alignment requirement for using iATU config shift mode 
> here.
> 
>> Signed-off-by: Krishna Chaitanya Chundru 
>> <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig                |   1 +
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 131 
>> +++++++++++++++++++---
>>   drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
>>   drivers/pci/controller/dwc/pcie-designware.h      |   5 +
>>   4 files changed, 124 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig 
>> b/drivers/pci/controller/dwc/Kconfig
>> index 
>> ff6b6d9e18ecfa44273e87931551f9e63fbe3cba..a0e7ad3fb5afec63b0f919732a50147229623186 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -20,6 +20,7 @@ config PCIE_DW_HOST
>>       bool
>>       select PCIE_DW
>>       select IRQ_MSI_LIB
>> +    select PCI_HOST_COMMON
>>   config PCIE_DW_EP
>>       bool
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c 
>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 
>> 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..abb93265a19fd62d3fecc64f29f37baf67291b40 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -413,6 +413,81 @@ static void 
>> dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>>       }
>>   }
>> +static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>> +{
>> +    struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +    struct dw_pcie_ob_atu_cfg atu = {0};
>> +    resource_size_t bus_range_max;
>> +    struct resource_entry *bus;
>> +    int ret;
>> +
>> +    bus = resource_list_first_type(&pp->bridge->windows, 
>> IORESOURCE_BUS);
>> +
>> +    /*
>> +     * Root bus under the host bridge doesn't require any iATU 
>> configuration
>> +     * as DBI region will be used to access root bus config space.
>> +     * Immediate bus under Root Bus, needs type 0 iATU configuration and
>> +     * remaining buses need type 1 iATU configuration.
>> +     */
>> +    atu.index = 0;
>> +    atu.type = PCIE_ATU_TYPE_CFG0;
>> +    atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
>> +    /* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
>> +    atu.size = SZ_1M;
>> +    atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
>> +    ret = dw_pcie_prog_outbound_atu(pci, &atu);
>> +    if (ret)
>> +        return ret;
>> +
>> +    bus_range_max = resource_size(bus->res);
>> +
>> +    if (bus_range_max < 2)
>> +        return 0;
>> +
>> +    /* Configure remaining buses in type 1 iATU configuration */
>> +    atu.index = 1;
>> +    atu.type = PCIE_ATU_TYPE_CFG1;
>> +    atu.parent_bus_addr = pp->cfg0_base + SZ_2M;
>> +    atu.size = (SZ_1M * bus_range_max) - SZ_2M;
>> +    atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
>> +
>> +    return dw_pcie_prog_outbound_atu(pci, &atu);
>> +}
>> +
>> +static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct 
>> resource *res)
>> +{
>> +    struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +    struct device *dev = pci->dev;
>> +    struct resource_entry *bus;
>> +
>> +    bus = resource_list_first_type(&pp->bridge->windows, 
>> IORESOURCE_BUS);
>> +    if (!bus)
>> +        return -ENODEV;
>> +    pp->cfg = pci_ecam_create(dev, res, bus->res, 
>> &pci_generic_ecam_ops);
>> +    if (IS_ERR(pp->cfg))
>> +        return PTR_ERR(pp->cfg);
>> +
>> +    pci->dbi_base = pp->cfg->win;
>> +    pci->dbi_phys_addr = res->start;
>> +
>> +    return 0;
>> +}
>> +
>> +static bool dw_pcie_ecam_enabled(struct dw_pcie_rp *pp, struct 
>> resource *config_res)
>> +{
>> +    struct resource *bus_range;
>> +    u64 nr_buses;
> 
> As change is using Synopsis IP based iATU config shift mode 
> functionality, it is must that ECAM/DBI base address has to be 256 MB 
> aligned. Hence add change to check against alignment.
> 
Just to clarify this is not Synopsis IP requirement it is PCie
requirement. PCIe spec 6, sec 7.2.2 says "base address of the range is
aligned to a 2(n+20)-byte memory address boundary". n is 8 here.

I will add this info as a comment.
> #define IS_256MB_ALIGNED(x) IS_ALIGNED(x, SZ_256M)
> 
> if (!IS_256MB_ALIGNED(config_res->start))
>            return false;
> 
Ack.

- Krishna Chaitanya.
>> +
>> +    bus_range = resource_list_first_type(&pp->bridge->windows, 
>> IORESOURCE_BUS)->res;
>> +    if (!bus_range)
>> +        return false;
>> +
>> +    nr_buses = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
>> +
>> +    return !!(nr_buses >= resource_size(bus_range));
>> +}
>> +
>>   static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>>   {
>>       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> @@ -422,10 +497,6 @@ static int dw_pcie_host_get_resources(struct 
>> dw_pcie_rp *pp)
>>       struct resource *res;
>>       int ret;
>> -    ret = dw_pcie_get_resources(pci);
>> -    if (ret)
>> -        return ret;
>> -
>>       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>>       if (!res) {
>>           dev_err(dev, "Missing \"config\" reg space\n");
>> @@ -435,9 +506,32 @@ static int dw_pcie_host_get_resources(struct 
>> dw_pcie_rp *pp)
>>       pp->cfg0_size = resource_size(res);
>>       pp->cfg0_base = res->start;
>> -    pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>> -    if (IS_ERR(pp->va_cfg0_base))
>> -        return PTR_ERR(pp->va_cfg0_base);
>> +    pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res);
>> +    if (pp->ecam_enabled) {
>> +        ret = dw_pcie_create_ecam_window(pp, res);
>> +        if (ret)
>> +            return ret;
>> +
>> +        pp->bridge->ops = (struct pci_ops 
>> *)&pci_generic_ecam_ops.pci_ops;
>> +        pp->bridge->sysdata = pp->cfg;
>> +        pp->cfg->priv = pp;
>> +    } else {
>> +        pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>> +        if (IS_ERR(pp->va_cfg0_base))
>> +            return PTR_ERR(pp->va_cfg0_base);
>> +
>> +        /* Set default bus ops */
>> +        pp->bridge->ops = &dw_pcie_ops;
>> +        pp->bridge->child_ops = &dw_child_pcie_ops;
>> +        pp->bridge->sysdata = pp;
>> +    }
>> +
>> +    ret = dw_pcie_get_resources(pci);
>> +    if (ret) {
>> +        if (pp->cfg)
>> +            pci_ecam_free(pp->cfg);
>> +        return ret;
>> +    }
>>       /* Get the I/O range from DT */
>>       win = resource_list_first_type(&pp->bridge->windows, 
>> IORESOURCE_IO);
>> @@ -476,14 +570,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>       if (ret)
>>           return ret;
>> -    /* Set default bus ops */
>> -    bridge->ops = &dw_pcie_ops;
>> -    bridge->child_ops = &dw_child_pcie_ops;
>> -
>>       if (pp->ops->init) {
>>           ret = pp->ops->init(pp);
>>           if (ret)
>> -            return ret;
>> +            goto err_free_ecam;
>>       }
>>       if (pci_msi_enabled()) {
>> @@ -525,6 +615,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>       if (ret)
>>           goto err_free_msi;
>> +    if (pp->ecam_enabled) {
>> +        ret = dw_pcie_config_ecam_iatu(pp);
>> +        if (ret) {
>> +            dev_err(dev, "Failed to configure iATU in ECAM mode\n");
>> +            goto err_free_msi;
>> +        }
>> +    }
>> +
>>       /*
>>        * Allocate the resource for MSG TLP before programming the iATU
>>        * outbound window in dw_pcie_setup_rc(). Since the allocation 
>> depends
>> @@ -560,8 +658,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>           /* Ignore errors, the link may come up later */
>>           dw_pcie_wait_for_link(pci);
>> -    bridge->sysdata = pp;
>> -
>>       ret = pci_host_probe(bridge);
>>       if (ret)
>>           goto err_stop_link;
>> @@ -587,6 +683,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>       if (pp->ops->deinit)
>>           pp->ops->deinit(pp);
>> +err_free_ecam:
>> +    if (pp->cfg)
>> +        pci_ecam_free(pp->cfg);
>> +
>>       return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(dw_pcie_host_init);
>> @@ -609,6 +709,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>>       if (pp->ops->deinit)
>>           pp->ops->deinit(pp);
>> +
>> +    if (pp->cfg)
>> +        pci_ecam_free(pp->cfg);
>>   }
>>   EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c 
>> b/drivers/pci/controller/dwc/pcie-designware.c
>> index 
>> 4684c671a81bee468f686a83cc992433b38af59d..6826ddb9478d41227fa011018cffa8d2242336a9 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -576,7 +576,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>>           val = dw_pcie_enable_ecrc(val);
>>       dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>> -    val = PCIE_ATU_ENABLE;
>> +    val = PCIE_ATU_ENABLE | atu->ctrl2;
>>       if (atu->type == PCIE_ATU_TYPE_MSG) {
>>           /* The data-less messages only for now */
>>           val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h 
>> b/drivers/pci/controller/dwc/pcie-designware.h
>> index 
>> ceb022506c3191cd8fe580411526e20cc3758fed..f770e160ce7c538e0835e7cf80bae9ed099f906c 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -20,6 +20,7 @@
>>   #include <linux/irq.h>
>>   #include <linux/msi.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-ecam.h>
>>   #include <linux/reset.h>
>>   #include <linux/pci-epc.h>
>> @@ -169,6 +170,7 @@
>>   #define PCIE_ATU_REGION_CTRL2        0x004
>>   #define PCIE_ATU_ENABLE            BIT(31)
>>   #define PCIE_ATU_BAR_MODE_ENABLE    BIT(30)
>> +#define PCIE_ATU_CFG_SHIFT_MODE_ENABLE    BIT(28)
>>   #define PCIE_ATU_INHIBIT_PAYLOAD    BIT(22)
>>   #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
>>   #define PCIE_ATU_LOWER_BASE        0x008
>> @@ -387,6 +389,7 @@ struct dw_pcie_ob_atu_cfg {
>>       u8 func_no;
>>       u8 code;
>>       u8 routing;
>> +    u32 ctrl2;
>>       u64 parent_bus_addr;
>>       u64 pci_addr;
>>       u64 size;
>> @@ -425,6 +428,8 @@ struct dw_pcie_rp {
>>       struct resource        *msg_res;
>>       bool            use_linkup_irq;
>>       struct pci_eq_presets    presets;
>> +    bool            ecam_enabled;
>> +    struct pci_config_window *cfg;
>>   };
>>   struct dw_pcie_ep_ops {
>>
> Regards,
> Mayank

