Return-Path: <linux-pci+bounces-38570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C87BECC72
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 11:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6436242EC
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F7C28467D;
	Sat, 18 Oct 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gRrEm74c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B11448E3
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779522; cv=none; b=qLPcKPrY8o2B5P71k/GG7M4/vN+YUd7pJkGIpkY3tAwlz2lcadUUZDiVloRd5oe5h9hh/aQDVq8UPEITzqEBDinCU0UPso0kteESk9PBURM1L8ileF60gRz8cP0Fkq3u5WXPlWjEl24TogvbwmnYNNle8Oc0rLnYQxcUx5FRgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779522; c=relaxed/simple;
	bh=KVvDpU8cWny/IsaxMprp6ClDCn/39UbEnGQXzrbslOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKTSu9KSR2DD77uztz3/OqZiAaXscXrelRhpEWtpF3iHMRUir+6iziI5Kr5IL1t34ngkwOkunTH3UkdkZ7CJW1yTAOOUuxvDivPby++cIHu6fkmIvRhHlnGyHf+IW0SUYjRqenG/Nc3Yje5zLNwdi+ISDLZdUBJgu5BQ+7aj+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gRrEm74c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I7xmej025952
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 09:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Ogq17zuJgrBwLUyHJBik8HaQnFhDvO3zs76wTR60B8=; b=gRrEm74cJNddd5J5
	L7OqH4b23apE0h3ZZVZvReRKwBnUQuC0u7DWT9hvZ0XvbrUEOMzYtzwXkhSpXre2
	nTvughkUEX8YFnnluPtF7XD0x5rADgyo71/cTg8BbVdSCZKK/Oi9o17y3tG9NhdW
	l8nbLKlT70fhYhbLbS2HAdCLBmr85vrQ3ssz2NHD/9n3E2Bx5THqYQ2jjApFNm8y
	2N8zGEZUrzBiXvDViPxNAHrQ5IadV3DXkjeYVmEaZV/sZa0iC8U4x1XucmnuOHya
	8qeqt822I8uV3u7ogzvM1B/I7NBUWtHKzTvkWZy8cMuC66l0uUdN0O4J3gjDwlaP
	21Gakg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42k0bpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 09:25:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b62da7602a0so1979535a12.2
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 02:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760779519; x=1761384319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ogq17zuJgrBwLUyHJBik8HaQnFhDvO3zs76wTR60B8=;
        b=OHd2P+k6ysRUOrY6iCU1w5cYjmhYlZkSQv8zbvH0gJbx0i9Hk/l/U4ttLLV5uAu8Un
         pAwG2LAa4zumcrfpSdoK1bc0V6wvZoAFWpwcSnDZPI0Bs605qDAPBqS/wPZB0iFkXv+t
         IgomBohhWv6URmI3bcuy09Zb+Gg5PBPCQO0kVfIT5+sW+qFIkdq8oGEMeftYIpwCelzc
         VfRV2HXi0DR1d0WFArJUiKlnpeHGiZcebHYoo4iZlnpL7nyfqQ2epUzceFpjhfLtFKK4
         HDvIUO5CfrI1hQazJs1I8qOuBy4oG/L3Ca8r3Bq2TEaiCoCinK1GZZGN6j+CWjE32XTP
         VR4g==
X-Forwarded-Encrypted: i=1; AJvYcCUX6yi7rp6aFCwb9zOo0ZjORNIHuxSM6bShjnNtJpjJFg1kk4ig2h7mqGGbOoWTdfJ42pwtmYcwM+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgujn1ilttCrx4QCbxWL/02FhA5DjQg6m9cf1zHsMDla9ZSkFS
	uuU0T4Dklf/5sp+q8+zdPluoHkRb6asfNeS1f2Wpjb4lIMe9wToELAyfnWD4dFexbpRcIMsDVV/
	oeDp7H1+aYfaJzkpsAGPdNdhL0F3i7x7O2QX09bRZbZLw21pr54odYc5HphaSGCLJh1YmuvI=
X-Gm-Gg: ASbGnct8j5yrzhxq5iq71MMMF2xY1bjj1okg9e7pei1KXGt3G9IDUjOrgIdZf7A0E4G
	/Cy+lXiC8Y78N7+oHPTKDYhGRPc+S4CzvA3HvBUIvyncoPq6BUwLFakVn2iyK0TUdmfCDMEhNhp
	ycaLjPpjqc2Y1wAIxlq3quAM/b056oz68SURImfjMDp6knnzzX8JtQkZ8juCmOoF9NxXYGp0I5r
	WFNDlt2nrXeBD8AQc3p0e+GDIzqKMrjJBW4L72XbwUV794oRdzyTXh8WpykIfszyKCf8tdptnRO
	6Avf/tCHZyfVXJOiAJ/LLmV7+JYer6hrvmjKy5JX4tirUTsFBU0ozV4GlvDWI0StVFZ1NIA0ZTI
	6FKWTo2GJnPmRZfPnzgdX5Ssrt4fMR8y3FpI=
X-Received: by 2002:a05:6a20:4323:b0:2f4:a8f:7279 with SMTP id adf61e73a8af0-334a862e040mr9773298637.54.1760779519412;
        Sat, 18 Oct 2025 02:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVWG8EuY0mF3PY3ppTV5mDlwk0Eq3Yi16l3SLbLvJeJ2thfHVArqaxLIVoNfb4IQQemIbABg==
X-Received: by 2002:a05:6a20:4323:b0:2f4:a8f:7279 with SMTP id adf61e73a8af0-334a862e040mr9773276637.54.1760779518866;
        Sat, 18 Oct 2025 02:25:18 -0700 (PDT)
Received: from [192.168.29.113] ([49.43.226.255])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm2132488a12.10.2025.10.18.02.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 02:25:18 -0700 (PDT)
Message-ID: <0bc6eb69-029d-45f4-a723-c003ecbb11e5@oss.qualcomm.com>
Date: Sat, 18 Oct 2025 14:55:13 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
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
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <mtxez55p4hfvtmhcnwtxeetzqxydyq5e4g5zsdhytxpzgvgeqn@s7asinok5l22>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2oZXVC4D1ZdZPsO-AS5xwR72IqJ5TOPd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX2OZwSogKB29z
 2++Y30uYgjVBT8z9IkTSIv4Rb+bzppWrr3rTfsRoU1y9YSqbxORXuCkODkxYcLIE7L4TAIc2FfU
 LYlrGeHyxyC0vXDMAzZyMzxmnR5ulMGX4sYf+rPZJKkt2yu9Y6YJ48eeekbQWw62bN0jamx8QEZ
 Xc8mLr8ujxUATjGcAy3qG7A43rFpYketv8bTn+VZiCK5Hal+4DimJW8No4jWzyYeZCLlGVlLo1A
 T4vfhZ9DEgElFBPErdU3eNvA0gWL4IW2eReNNYdwZxkfsAXaBzY7OzzIXTMMbNrostmsqXyiYeB
 Uu29fbBekk/j5fe3UrTY8IO5mnbagqHrz39VxTMSb8JyHpIRgnTGLKpVY9a3jxT9dPmEdM1vKFF
 WaSVNmPM7SU/FVyMFgVbte2LpQWrBA==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f35d00 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=r8OtbAjNO6w9l/f+plF4pQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8 a=EUspDBNiAAAA:8 a=UQbOXMLpRsKdYNi8uUUA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=nmWuMzfKamIsx3l42hEX:22
X-Proofpoint-ORIG-GUID: 2oZXVC4D1ZdZPsO-AS5xwR72IqJ5TOPd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031



On 10/18/2025 8:39 AM, Manivannan Sadhasivam wrote:
> On Fri, Oct 17, 2025 at 02:10:05PM -0500, Bjorn Helgaas wrote:
>> On Fri, Oct 17, 2025 at 05:10:53PM +0530, Krishna Chaitanya Chundru wrote:
>>> When the vendor configuration space is 256MB aligned, the DesignWare
>>> PCIe host driver enables ECAM access and sets the DBI base to the dw_pcie_ecam_conf_map_busstart
>>> of the config space. This causes vendor drivers to incorrectly program
>>> iATU regions, as they rely on the DBI address for internal accesses.
>>>
>>> To fix this, avoid overwriting the DBI base when ECAM is enabled.
>>> Instead, introduce a custom ECAM PCI ops implementation that accesses
>>> the DBI region directly for bus 0 and uses ECAM for other buses.
>>>
>>> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
>>> Reported-by: Ron Economos <re@w6rz.net>
>>> Closes: https://lore.kernel.org/all/eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net/
>>> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 28 +++++++++++++++++++----
>>>   1 file changed, 24 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 20c9333bcb1c4812e2fd96047a49944574df1e6f..e92513c5bda51bde3a7157033ddbd73afa370d78 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -23,6 +23,7 @@
>>>   #include "pcie-designware.h"
>>>   
>>>   static struct pci_ops dw_pcie_ops;
>>> +static struct pci_ops dw_pcie_ecam_ops;
>>>   static struct pci_ops dw_child_pcie_ops;
>>>   
>>>   #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
>>> @@ -471,9 +472,6 @@ static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *re
>>>   	if (IS_ERR(pp->cfg))
>>>   		return PTR_ERR(pp->cfg);
>>>   
>>> -	pci->dbi_base = pp->cfg->win;
>>> -	pci->dbi_phys_addr = res->start;
>>> -
>>>   	return 0;
>>>   }
>>>   
>>> @@ -529,7 +527,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>>>   		if (ret)
>>>   			return ret;
>>>   
>>> -		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
>>> +		pp->bridge->ops = &dw_pcie_ecam_ops;
>>>   		pp->bridge->sysdata = pp->cfg;
>>>   		pp->cfg->priv = pp;
>>>   	} else {
>>> @@ -842,12 +840,34 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>>>   }
>>>   EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>>>   
>>> +static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
>>> +{
>>> +	struct pci_config_window *cfg = bus->sysdata;
>>> +	struct dw_pcie_rp *pp = cfg->priv;
>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>> +	unsigned int busn = bus->number;
>>> +
>>> +	if (busn > 0)
>>> +		return pci_ecam_map_bus(bus, devfn, where);
>>
>> Is there a way to avoid the "root bus is bus 00" assumption here?  It
>> looks like something like this might work (it inverts the condition
>> to take care of the root bus special case first):
>>
>>    if (bus == pp->bridge->bus) {
>>      if (PCI_SLOT(devfn) > 0)
>>        return NULL;
>>
>>      return pci->dbi_base + where;
>>    }
>>
>>    return pci_ecam_map_bus(bus, devfn, where);
>>
> 
> I guess it will work.
> 
>>> +	if (PCI_SLOT(devfn) > 0)
>>> +		return NULL;
>>
>> This essentially says only one function (00.0) can be on the root bus.
>> I assume that someday that will be relaxed and there may be multiple
>> Root Ports and maybe RCiEPs on the root bus, so it would be nice if we
>> didn't have to have this check.
>>
>> What happens without it?  Does the IP return the ~0 data that the PCI
>> core would interpret as "there's no device here"?
>>
> 
> I hope the read returns ~0, but the idea is to catch the invalid access before
> trying to read/write. In case of multi Root Port design, I don't think we have a
> way to identify it. So maybe it is safe to remove this check.
>
For multi root port we may need to revisit this, currently along with
dbi there are some other registers iATU, elbi etc. So there might be
chances to read these registers like iATU as part of enumeration and
these can return non ~0 values which will have adverse effects.
So we should have this check for now.

- Krishna Chaitanya.

> - Mani
> 

