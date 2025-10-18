Return-Path: <linux-pci+bounces-38572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FFBBECC94
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3151A3B1665
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE101F3B87;
	Sat, 18 Oct 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RiksWa37"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB524EA81
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779842; cv=none; b=EBMSekyvME6V/R6qPuyTmZGrk//z1stbXvjNIK320/Ag0KDgMRG/z5xkQ8JXVFKqkm7p5iBCW3zAml5tVgw+3rOIz8UL/967WL6qj6wX6RoudZpKHEy11Fp+cIrWrgJp623/bJhquijkNQSxTYKyYusGSTN/HlW3fwRxDLxp85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779842; c=relaxed/simple;
	bh=oD5lN/WAuYh/HK6Ah4Pkz2gG6gbaVIjcpoVNUvCww8Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bYc4hpBFNZHSgomh4jnOqtSMegovCGU7rhJZ8/wF6ogJQlGY26if1gcVJ+uZqDkLX6U2IaBrKp6/OgJcVAXlUACnj8dhpi28Qx+pFxRwkxFJjBBwVi02yC6a6gQ78zYhLSvBnyfEtB2duVGaqIJK/EmQeXmGIatxZ8fSNTx7yuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RiksWa37; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I7xFab025660
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 09:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9FCLY6m2CafM7SsUWCIuGAId+vM7SdE3NvTvT54I0Eg=; b=RiksWa37gPHm7xFX
	4VF3YjEEtVVgrWm2R11NkBfOxl/TocFZVj9jOEAT7U1YqUmxX2VZOKLHmT8XV4aJ
	RV69clwvNFR7jY07jAaoaVcjzzhhEOKgYuL4ePVt1KFTa7X+AiN7LGuEP8iDQ/wS
	1qx8LtkXVEMEHvMmzrYm/+heSMe+7LqVrp25KvvJ2H+49uzdABiy+fgymxJafsiT
	OByrbdbpEmlYHcB3JS5amiSjtHArNYg9biVVq5NOByPYUpVt5de48F07T5EGGpdm
	CZ19SkY3Hc2spFf4i0zLzAjlRQXyu71FkGVbXuHacwLA1gDEbhxfJAkYlp/svBvt
	dZz8cg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42k0bvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 09:30:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7810912fc31so2687218b3a.3
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 02:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760779839; x=1761384639;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FCLY6m2CafM7SsUWCIuGAId+vM7SdE3NvTvT54I0Eg=;
        b=lo9OF1zoM3PdxECi+MWVgz2Ms3yzRhCJKptT16c9rF5uwUnUv+6JefY/CEujf45nhe
         wYsnGvv0c+D3FbZyIfRfTDrEA9XQjQrb/0nd5JOq2frdaHJyGtlN6CWL+oCShMV+cz4i
         ZjuBSClZ4I41Ibs1sqZ6k8MOICF8pTpXYRZJSNSA2SyI9/eXiZZYoVOGE3JWvLEPmOPp
         Z12JOVnuRD/7VOLip+WKsM/6XFRu6d9AjdYjdhLKyymUoPkKU7/8dRSgo9CQqkrau2V8
         wsXHyDlKW4bRh1fhD8bLTOthNikOtBEs1DYNPpS20aaTP3kZOQMhwCYJxJMoL8NWs/p2
         B1og==
X-Forwarded-Encrypted: i=1; AJvYcCWQ7IMxK84rum4mgMxCs6e8nnKGkLLTHdEe67GqqGf6Q2i6xF9ruI2Yerux06xkMi2bKdqLzjg8wX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89RnxrFaGN64wY4IOqj54Xc4Vcofnf29Dzz5VYYlYzmCCI/nn
	PQQoKMATATSicCJ/lTO3xWa+b6Ib+IsAeeb6YLLNh/0pfu8tB1/wwOHtGhuoarcf6dW81JhA2r2
	0t8cIyauSEMKgWDqy06ABhaJCORLuDQiwCcEXmAo4Ejo0/tbjzXcgs2xRotRmI7tBQ1IIv7A=
X-Gm-Gg: ASbGncswPOis7pvJEr0iPZ9Ik5xXsEP/kqKZD4mSxaNjSaOYZWhJV3WVNd77A3aph+1
	7Go0RVBitBaktVVvMYFade2AxGTQ+KoDwxvnkp8iR2GPK2r7rG7ML/GZ82K3eHAKZxDlRthlsXL
	UnOJR4n0DCPfRjtLHrO+jm5RJDVqKbeeif8M3CWZkyWrekthbiEFprEZ2XnrkXuq25+4FZIDx5B
	NuImW5v0KTwBmqKbhEsEQ27KbY+VMEPBUR63DHcgvWXRUjvMqDqEH/V1UGNDjvJl+IzD3qAZVa2
	SRCJIRrHT68LPKy5Mtft+lcxhqQVtCY9vKQyH525nlZIO2OWb0/LD40KnoMhl9GdY6/rhty3uNh
	7SKWGBJV08bo/aX0mrm3c3OHE4o8PqnWg9po=
X-Received: by 2002:a05:6a20:1585:b0:334:9cbd:72ad with SMTP id adf61e73a8af0-334a85397e6mr8837032637.16.1760779838721;
        Sat, 18 Oct 2025 02:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyCmXTNH5ovcv21xit30ZtszwP+05T3cmOy73/7o1arYyQdNGBTWbaWxuW3JMyTMSiOojJrw==
X-Received: by 2002:a05:6a20:1585:b0:334:9cbd:72ad with SMTP id adf61e73a8af0-334a85397e6mr8837015637.16.1760779838273;
        Sat, 18 Oct 2025 02:30:38 -0700 (PDT)
Received: from [192.168.29.113] ([49.43.226.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230123116sm2168550b3a.69.2025.10.18.02.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 02:30:37 -0700 (PDT)
Message-ID: <db799304-1551-410b-af07-fb8d9b50be5c@oss.qualcomm.com>
Date: Sat, 18 Oct 2025 15:00:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Ron Economos <re@w6rz.net>
References: <20251017-ecam_fix-v1-1-f6faa3d0edf3@oss.qualcomm.com>
 <20251017191005.GA1041995@bhelgaas>
 <mtxez55p4hfvtmhcnwtxeetzqxydyq5e4g5zsdhytxpzgvgeqn@s7asinok5l22>
 <0bc6eb69-029d-45f4-a723-c003ecbb11e5@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0bc6eb69-029d-45f4-a723-c003ecbb11e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uu3iAwl3w6NZOs5r3oH4KcyErKu5S4Su
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX8IX2cD1YsFp1
 LlgGow8Dv/CHR1IO0satVjfqGaAIxk8FrTPFmUasKTtc1xxBF/My3jygk7zgAelrssELqw9F4az
 INsXuvqIQvrvihA46uvK5hEp+hZomwcrC9hIZoyqHobx47EBpIWIR8lOSbwzWPqwgQ4bsBGaDhi
 XhLMksJ70PgVHMV8lmt7lhV6IhU7zx7Wc+x1fOEBrDnIaiGwaKv606s0HIUbGxvZj9m4ZB5GX3o
 1O+zcYpyT0VeaaHLFMtT0WSAFZAWzXtIGy9VMVJVtX21ZvmPY6g0zYogkrft2qyMmePSQdNUXV0
 pR5GtP6Y5NJutAv5RqUhKaeUHSDnupRkHRMrs796VX6YR1C+uXLpjcwNrrHBFwpOrA86j2bULO3
 WBFGneBe4ve/iqCm2wLgCjCAlB3R4w==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f35e3f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=r8OtbAjNO6w9l/f+plF4pQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8 a=EUspDBNiAAAA:8 a=BshiAbRQLV5i_FA8PSwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=nmWuMzfKamIsx3l42hEX:22
X-Proofpoint-ORIG-GUID: uu3iAwl3w6NZOs5r3oH4KcyErKu5S4Su
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031



On 10/18/2025 2:55 PM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 10/18/2025 8:39 AM, Manivannan Sadhasivam wrote:
>> On Fri, Oct 17, 2025 at 02:10:05PM -0500, Bjorn Helgaas wrote:
>>> On Fri, Oct 17, 2025 at 05:10:53PM +0530, Krishna Chaitanya Chundru 
>>> wrote:
>>>> When the vendor configuration space is 256MB aligned, the DesignWare
>>>> PCIe host driver enables ECAM access and sets the DBI base to the 
>>>> dw_pcie_ecam_conf_map_busstart
>>>> of the config space. This causes vendor drivers to incorrectly program
>>>> iATU regions, as they rely on the DBI address for internal accesses.
>>>>
>>>> To fix this, avoid overwriting the DBI base when ECAM is enabled.
>>>> Instead, introduce a custom ECAM PCI ops implementation that accesses
>>>> the DBI region directly for bus 0 and uses ECAM for other buses.
>>>>
>>>> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM 
>>>> mechanism using iATU 'CFG Shift Feature'")
>>>> Reported-by: Ron Economos <re@w6rz.net>
>>>> Closes: 
>>>> https://lore.kernel.org/all/eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net/
>>>> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
>>>> Signed-off-by: Krishna Chaitanya Chundru 
>>>> <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 28 
>>>> +++++++++++++++++++----
>>>>   1 file changed, 24 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c 
>>>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> index 
>>>> 20c9333bcb1c4812e2fd96047a49944574df1e6f..e92513c5bda51bde3a7157033ddbd73afa370d78 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> @@ -23,6 +23,7 @@
>>>>   #include "pcie-designware.h"
>>>>   static struct pci_ops dw_pcie_ops;
>>>> +static struct pci_ops dw_pcie_ecam_ops;
>>>>   static struct pci_ops dw_child_pcie_ops;
>>>>   #define DW_PCIE_MSI_FLAGS_REQUIRED 
>>>> (MSI_FLAG_USE_DEF_DOM_OPS        | \
>>>> @@ -471,9 +472,6 @@ static int dw_pcie_create_ecam_window(struct 
>>>> dw_pcie_rp *pp, struct resource *re
>>>>       if (IS_ERR(pp->cfg))
>>>>           return PTR_ERR(pp->cfg);
>>>> -    pci->dbi_base = pp->cfg->win;
>>>> -    pci->dbi_phys_addr = res->start;
>>>> -
>>>>       return 0;
>>>>   }
>>>> @@ -529,7 +527,7 @@ static int dw_pcie_host_get_resources(struct 
>>>> dw_pcie_rp *pp)
>>>>           if (ret)
>>>>               return ret;
>>>> -        pp->bridge->ops = (struct pci_ops 
>>>> *)&pci_generic_ecam_ops.pci_ops;
>>>> +        pp->bridge->ops = &dw_pcie_ecam_ops;
>>>>           pp->bridge->sysdata = pp->cfg;
>>>>           pp->cfg->priv = pp;
>>>>       } else {
>>>> @@ -842,12 +840,34 @@ void __iomem *dw_pcie_own_conf_map_bus(struct 
>>>> pci_bus *bus, unsigned int devfn,
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>>>> +static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, 
>>>> unsigned int devfn, int where)
>>>> +{
>>>> +    struct pci_config_window *cfg = bus->sysdata;
>>>> +    struct dw_pcie_rp *pp = cfg->priv;
>>>> +    struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>> +    unsigned int busn = bus->number;
>>>> +
>>>> +    if (busn > 0)
>>>> +        return pci_ecam_map_bus(bus, devfn, where);
>>>
>>> Is there a way to avoid the "root bus is bus 00" assumption here?  It
>>> looks like something like this might work (it inverts the condition
>>> to take care of the root bus special case first):
>>>
>>>    if (bus == pp->bridge->bus) {
>>>      if (PCI_SLOT(devfn) > 0)
>>>        return NULL;
>>>
>>>      return pci->dbi_base + where;
>>>    }
>>>
>>>    return pci_ecam_map_bus(bus, devfn, where);
>>>
>>
>> I guess it will work.
>>
>>>> +    if (PCI_SLOT(devfn) > 0)
>>>> +        return NULL;
>>>
>>> This essentially says only one function (00.0) can be on the root bus.
>>> I assume that someday that will be relaxed and there may be multiple
>>> Root Ports and maybe RCiEPs on the root bus, so it would be nice if we
>>> didn't have to have this check.
>>>
>>> What happens without it?  Does the IP return the ~0 data that the PCI
>>> core would interpret as "there's no device here"?
>>>
>>
>> I hope the read returns ~0, but the idea is to catch the invalid 
>> access before
>> trying to read/write. In case of multi Root Port design, I don't think 
>> we have a
>> way to identify it. So maybe it is safe to remove this check.
>>
> For multi root port we may need to revisit this, currently along with
> dbi there are some other registers iATU, elbi etc. So there might be
> chances to read these registers like iATU as part of enumeration and
> these can return non ~0 values which will have adverse effects.
> So we should have this check for now.
> 
One more issue is some controllers may pass only 4k memory as dbi memory
so we might get unmapped address access issues also.
- Krishna Chaitanya.
> - Krishna Chaitanya.
> 
>> - Mani
>>

