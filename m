Return-Path: <linux-pci+bounces-38878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7D6BF65D5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03904352BB4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F7D355041;
	Tue, 21 Oct 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="faTPRRly"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432AD355036
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048768; cv=none; b=WEkRqJC0OBMsdnVEqKHbxQPnn/N1SJzzy6VjNoGQS53n2+YZXHzPbbdzhS705C9vEdxMo8HxJgFvY6MCVOvQ15StkPyFVJQShmuUOXMBi88pqP4gUUSkMvihMCFvDGaN0ynRhpMKjOlMORUthF597dyOzQY4fJ8VeGi4f+0Bad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048768; c=relaxed/simple;
	bh=HHLuhyjdrpYP+6RicMRAMeMaT9Q8fxefq0Y4Q+tK25c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnqlJli/MypT4y3tVg4HAoDybRmY8JNiUjDZZRC5HkTpZ1VtydN+CqikhOzhNrhOsYCCFJGjoU7gcHk79WDgzXhc/asZsd4rS1piP4E/w9D6W7yVAM5geCm+WOsvnKj9W0NlO0CAxsqpTt+hZdHXuWouL3wxZUKSxQ1pbjoXE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=faTPRRly; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8OfD9002360
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oWb0iuOCvOXjqmawB9cZBO7fb4qJEEBrLs9e6I4+SuQ=; b=faTPRRly9aEUDETA
	UdqguB2P24J6VOE828KBDpzjEnexwxydEUI3mLr5MxSZs4AoLB5I2doqw8LqLDsR
	Iyksvbcw38r3OY0JjDZFAPy/BBZBeR3BrNNYMO8Ceg6j/WtNtEO9bEkhXW2r+twV
	T1O22IFUqBePw9lvcVzzgGlPQrSwohey8GrUOS1MnnQfgXE9fg795pC3IJM+fhVU
	lXLBoeQ5g5eeo5hlAuyMQp42rv4g7mXNFSCsjKV0sVsgczUrwabw0JDEdTYR2Ppe
	T0LcP6xmDCrqI/a+0v3nrr1QmXqf0+GabEHyXhcr+PIiOEqo0XZVa22IzgmagRcz
	It3tkw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w66x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:12:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28a5b8b12bbso138705605ad.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 05:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761048765; x=1761653565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWb0iuOCvOXjqmawB9cZBO7fb4qJEEBrLs9e6I4+SuQ=;
        b=OLKci5GKpa5RSuaTbwmcTwecTZDwu1hwflsCrhQOUCjAdcA1mYX2h8NGd888rO8Op2
         EsauWuv+H4AbQ28K7P8ALK8Mm3KV2mIMn7xMCr3HIrG+5o3DfYdAmIoVK4HDqmeXFQpj
         YPiLnfwC0V/PjREXwauJjCeU7ddBLwWeE7BAiz++9BDc2trkYyG28ETldS8eKrXWEKl8
         2P/XRwIhZNqN9Zsuxm0yS3nGLDHrkKoZLmKsOunMqt1fL7GKFiw/Wh2FJ7CSDRYdZHFH
         gRBZjMhQQF3e3JBMkBA9eF/skx7EBfy92J0L36zF2qcKEzUY5NipCFjmxp8hdpzmaxnE
         KMtw==
X-Forwarded-Encrypted: i=1; AJvYcCV/+xjTzLr3DMr4Ri2ets2TJ93TjJLBP1ZVQabubDdBrrgu555D3zrBqEUc7+oAZpaqOf+MWNERFjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUmKyX2lN7D6Xsyib5cNYJSrWPskE4VGYdKmUWuBQ3jrTNdi7i
	4q2k9s6/XA/cLp40pZMBYSEZ5IS/ZCttt/H+fVuJ0JVHfnflZygKIDnaV6kEsd3z6wmEioEhftK
	2owwV//b2yON/W7ox+vPC85pFlIQ0KCclLsvEjQrbWHGBqkAUlNAyPW8xjMo08W4=
X-Gm-Gg: ASbGncs6fdT/O8+0ZJKcSYLR2X6s7wkGOFZZE6SKEHUKQaf3hqS/yvHIzTNP8ru2Lr6
	T9VgmxBqZ3jYkPF0PvwscOT+ecfl6nCv/yw6nszOd9KHzz1bKfg8lAUOD+TSHuZuxrlv+nr/SHZ
	qwkZzxGbGCDRnvCb+DT+58qPihLqtR9zlfMy9KPt90WB5pBqnEWyhJfFALxIk8ECT655pvFLn4g
	h/jBqKIJQO2z/ZZSX0G0i5kj3fMufSQa6rhdZRfw7HUtKkIanmmGAx1cU2ii6bQjlXSs+KQm9Bs
	9heflxJOaBvY6+tNYTj724a72pFvdt7k7fePuVSVQiBVnWojMec/7md1UY1W8aFXF1BRK88k+sq
	iLCMVmrXycrU2tUX/DpJXAGgBe2vcrCTc
X-Received: by 2002:a17:902:ef4f:b0:275:b1cf:6ddc with SMTP id d9443c01a7336-290c9cf8f20mr213534545ad.5.1761048764464;
        Tue, 21 Oct 2025 05:12:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv6jCOOD6llWl3c+F3lpCgLyEVyjBbNEywAKQpMvm+VMkm9TzNfqWByG3kTLSRh2pz87DfHQ==
X-Received: by 2002:a17:902:ef4f:b0:275:b1cf:6ddc with SMTP id d9443c01a7336-290c9cf8f20mr213534125ad.5.1761048763979;
        Tue, 21 Oct 2025 05:12:43 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b77bf6sm10254761a12.41.2025.10.21.05.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:12:43 -0700 (PDT)
Message-ID: <f80e1d58-cae1-4f3b-8b66-fc920ad4c5ba@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 17:42:39 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Ron Economos <re@w6rz.net>
References: <20251017191005.GA1041995@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251017191005.GA1041995@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 93zc7tSmw4giDB9b-tQ5k9gBudXGnlb9
X-Proofpoint-GUID: 93zc7tSmw4giDB9b-tQ5k9gBudXGnlb9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX1ESdq7AbCwIz
 r/XTRVzV9B3YIzJPxpPpTdRxsq1UZ42IERUGcNlp+mAJn3/aVtqtF2DhH+pJnXMyOa9A6ioypHo
 09+H0q1Avclm/8N0SnmdULMYMWN3cPCy8OrgAzjXpS+PG32ESyReVMwcO6SoSpODk04kqb4ax4k
 I+IHkLgXPG9P9u4WJ2wCuPWDVT5qYBnYuxwXHE28QYuL1KsWHqSGUZRygrCxllXae/AzSiW9ze4
 hxcwEEd9M3fBUnU5I34NaY0bn8YF6Hq8knVXnR/2ksNv/bzlRnrlCM8hO+rYt431D2+3DWkfWNQ
 oc0OPIgunPrcQQ2lDHw3C+gRbkIg7hrXYB3hL6iVmhQLOULUya+IUTwey1bkaTzzjrxzae5JR7u
 ytnF3hKkVDLjSO/7PAVsIurMFBtvrQ==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f778bd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8 a=EUspDBNiAAAA:8 a=fRNJI3KV-S8XUuZoZUwA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=nmWuMzfKamIsx3l42hEX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090



On 10/18/2025 12:40 AM, Bjorn Helgaas wrote:
> On Fri, Oct 17, 2025 at 05:10:53PM +0530, Krishna Chaitanya Chundru wrote:
>> When the vendor configuration space is 256MB aligned, the DesignWare
>> PCIe host driver enables ECAM access and sets the DBI base to the start
>> of the config space. This causes vendor drivers to incorrectly program
>> iATU regions, as they rely on the DBI address for internal accesses.
>>
>> To fix this, avoid overwriting the DBI base when ECAM is enabled.
>> Instead, introduce a custom ECAM PCI ops implementation that accesses
>> the DBI region directly for bus 0 and uses ECAM for other buses.
>>
>> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
>> Reported-by: Ron Economos <re@w6rz.net>
>> Closes: https://lore.kernel.org/all/eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net/
>> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 28 +++++++++++++++++++----
>>   1 file changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 20c9333bcb1c4812e2fd96047a49944574df1e6f..e92513c5bda51bde3a7157033ddbd73afa370d78 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -23,6 +23,7 @@
>>   #include "pcie-designware.h"
>>   
>>   static struct pci_ops dw_pcie_ops;
>> +static struct pci_ops dw_pcie_ecam_ops;
>>   static struct pci_ops dw_child_pcie_ops;
>>   
>>   #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
>> @@ -471,9 +472,6 @@ static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *re
>>   	if (IS_ERR(pp->cfg))
>>   		return PTR_ERR(pp->cfg);
>>   
>> -	pci->dbi_base = pp->cfg->win;
>> -	pci->dbi_phys_addr = res->start;
>> -
>>   	return 0;
>>   }
>>   
>> @@ -529,7 +527,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>>   		if (ret)
>>   			return ret;
>>   
>> -		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
>> +		pp->bridge->ops = &dw_pcie_ecam_ops;
>>   		pp->bridge->sysdata = pp->cfg;
>>   		pp->cfg->priv = pp;
>>   	} else {
>> @@ -842,12 +840,34 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>>   }
>>   EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>>   
>> +static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
>> +{
>> +	struct pci_config_window *cfg = bus->sysdata;
>> +	struct dw_pcie_rp *pp = cfg->priv;
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	unsigned int busn = bus->number;
>> +
>> +	if (busn > 0)
>> +		return pci_ecam_map_bus(bus, devfn, where);
> 
> Is there a way to avoid the "root bus is bus 00" assumption here?  It
> looks like something like this might work (it inverts the condition
> to take care of the root bus special case first):
> 
>    if (bus == pp->bridge->bus) {
>      if (PCI_SLOT(devfn) > 0)
>        return NULL;
> 
>      return pci->dbi_base + where;
>    }
> 
>    return pci_ecam_map_bus(bus, devfn, where);
> This is working fine Bjorn, shall I send v2 with this change.

- Krishna Chaitanya.
>> +	if (PCI_SLOT(devfn) > 0)
>> +		return NULL;
> 
> This essentially says only one function (00.0) can be on the root bus.
> I assume that someday that will be relaxed and there may be multiple
> Root Ports and maybe RCiEPs on the root bus, so it would be nice if we
> didn't have to have this check.
> 
> What happens without it?  Does the IP return the ~0 data that the PCI
> core would interpret as "there's no device here"?
> 
> Regardless, I love this series because it removes quite a bit of code
> and seems so much cleaner.
> 
>> +	return pci->dbi_base + where;
>> +}
>> +
>>   static struct pci_ops dw_pcie_ops = {
>>   	.map_bus = dw_pcie_own_conf_map_bus,
>>   	.read = pci_generic_config_read,
>>   	.write = pci_generic_config_write,
>>   };
>>   
>> +static struct pci_ops dw_pcie_ecam_ops = {
>> +	.map_bus = dw_pcie_ecam_conf_map_bus,
>> +	.read = pci_generic_config_read,
>> +	.write = pci_generic_config_write,
>> +};
>> +
>>   static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>
>> -- 
>> 2.34.1
>>

