Return-Path: <linux-pci+bounces-43509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4154FCD5244
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 09:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC050302D2A9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF422D8DCA;
	Mon, 22 Dec 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljpGLsd3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GRFD/tFW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43DE23EAA1
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766392980; cv=none; b=CaQVSAnY3dUwkbBTg4XhILRSb3Mzbj9C/CKD8dh+WwS1iuTNS3+49C/ka5gAyi+3TtTL49toZzgFz0clfM8pyHgxRhLLNEFRLaGjOIINOEhUN2eR06N88VL/kH79nq8sJdJLT+M5IZiB/2WxBsofeyL7VY73rht+0jkzincDXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766392980; c=relaxed/simple;
	bh=Rbyg2cO/+0nTP4okcqHGqpUcCAQAOZ7EpQ9lJDiwaEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7pynSyuVEOPEYtKJ7QcFsffO9Zf7q58sNTscv5u5XwjPedM3V0K0nm8L/4ksilDbOOAMNrS457/JCZwn5BXZuXbXUa1cs7Ar413xiSDr3wWe00hychMhNv/gS+/RuMloGuMUG6WqCiQknRx2+sULcyiUWeCQBQSG2U/SXjeU0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljpGLsd3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GRFD/tFW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM7wwNc4140102
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 08:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U/53NstVJmIxcTnewwVyMPIlunyaNnLAMwanoIrGVb8=; b=ljpGLsd3yTbQyWey
	LYuqQPfJI5fvoEO8/2xnmcAKkqFcyyzLv+BO0SO/Iod8gozpz/sQvupmzakMH1JQ
	gHY3X9DZOFCz4xp4AG1yo6hQg/IbHObwV9DF7fz9acfZKXp0MBI1OA9nlvphuGv6
	v7nCXvu3kVrjGiXC31C3NrzzJZMX09jTDPWT+x4ABInlUc/3hgla1EK7UN1KDHxh
	G4D1GVGvehYtyHxym6hIiT91ytF2Q6Tbw8WVSAT8wfaCuqutYaPUtEkmbiF3mwHh
	pErlaxj/QbJNAT2NO1C9oppITSokgS4bOLj27d3xJT3fSp1OPIXzwEdFqTgBsvfD
	43b3EA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mracb9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 08:42:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c43f8ef9bso4406604a91.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 00:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766392977; x=1766997777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/53NstVJmIxcTnewwVyMPIlunyaNnLAMwanoIrGVb8=;
        b=GRFD/tFWMjMTjbzxKIOv9wu4xUFUM3gu267FNFC1gpbgOVDujIlnIbE4zb/Y4+SFoO
         Re8CtboBQMHvX0D/4/6IQeRvq4fhUzyDUxmYMlqHpPTBtzlOm8RPCkkZE0JtOF+D97uA
         d3jfeJ+IB/B1GYSrxEIOFjE4uIYLgXL+yjkRfuWMZxtr1/WplKBZqDh99NsNdfodLrcq
         TIW9OXfD5ipEiByUl7bzfn8X8x4mynBET7p6Qt+GA+H2CBF7mQ7DOaOeG3sw7FKh03IQ
         QiIMRZ/FRQt7NVOYWku+iei8CaRo00qIKr2i9jCkqA5Dte0XQEzvg07d2c+fyszPmyZI
         H5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766392977; x=1766997777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/53NstVJmIxcTnewwVyMPIlunyaNnLAMwanoIrGVb8=;
        b=rbwEkOoEKlHIN8eGm98MasWFmVZhuVNeTNa6yhgafFYVVflsDmeVwVPQmkdKdnOqaa
         FahSluRfAspdyT6JrKF8inyA6u5+QdFeDVzSDZdiMFrUjVoAl6C7FUsBSpGK6fuVv+4s
         Av4b96CIf8ZnThjtYfLU/ZkGlQ0g73BoBWrKGaldjXQF6Qc/V/DCE+AqtGEpZvQlb0nO
         iGgEKPl6k/4byYVPYxON8ew43vLCc5f8sXb3gCGwGzSczzYOAbg9acG4OOV0GdjLEq2R
         Xmzg8KRlHe90XLGOwRkrszWAHjXJ5hRokUhGcLxFe5WgkFj8+cLpUYmeGximiSpaLmDS
         Ik2A==
X-Forwarded-Encrypted: i=1; AJvYcCWJoYe64QwpiTHhGls8VzlPeRmpbJ0nn6xIzo/6M5yJlSa8+ICuw/3nxTy7UOCRZyH0qAPR3+IznKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0Vw66lHtUy7FwW03kkazycoH7Ewy8KccYTgsVS6K1dCTBIPE
	I7RH0ddUeRW2zor1I3EYpSCPAS+x0TurK+1tn01T+/LVi5nAKeRS+Nm29aosabSey/3eCZAKqdo
	r6lRrftT33UZApzFp4stVtVT+a9RrkTeeCQBcYY1FIf/ztplxtqO0QmOH3WwwupU=
X-Gm-Gg: AY/fxX71uu5Wtvx/ZsiDsNTT6TTa3gk8hWg2GLaBmmJ5ermF4fm1EtF2jNDy8XSDWsw
	eUnNKDFW2QGNyzAxsQwmFcDtoA0+VwTuNq5WA91EecXh86GR8JOb6++4E+AIWil6mGurSfMdLkX
	D/YoTo/H5QHP1VM6dQTWoUcEuIpZq53et/XWq/6c5vJT7m0c0ujxgSJNVBEXFRumccWmiaT1E0I
	eVYFaFOiKGjZObwvXppzGKx4ElIZkMXIqShTAl/OVvZiJyvAKMQ+AOK3Uab9UXhvp2eCA6HZ0ba
	wpSYWcExzf1Q83OaXDSkA3obUtvWuZnrgVeysgucDeRMqLUhFwTrbmzjquCZYcgtGgUbMkiCeLP
	x9KVvpZLG0+eC1Rc95bXFcaH+cmAC4xfndqicDByZrg==
X-Received: by 2002:a17:90b:3c4d:b0:340:6b6f:4bbf with SMTP id 98e67ed59e1d1-34e71e6a525mr12869584a91.18.1766392976594;
        Mon, 22 Dec 2025 00:42:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSUV8oiLSZgumEQqP2L8RCmiVHRcXvAeOW/lJDmx1g94Z8zbq9O16bsT9s9Xm1euJDpEZkrg==
X-Received: by 2002:a17:90b:3c4d:b0:340:6b6f:4bbf with SMTP id 98e67ed59e1d1-34e71e6a525mr12869563a91.18.1766392975845;
        Mon, 22 Dec 2025 00:42:55 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm12393819a91.3.2025.12.22.00.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 00:42:55 -0800 (PST)
Message-ID: <712064a7-abb4-4cad-b6a6-b5c3a8faadea@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 14:12:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
        Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <aUkC-_pko_cItpKP@ryzen>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <aUkC-_pko_cItpKP@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2y4d4zqK5HZsq5tv7bNzI8RAzpcZSY4n
X-Proofpoint-GUID: 2y4d4zqK5HZsq5tv7bNzI8RAzpcZSY4n
X-Authority-Analysis: v=2.4 cv=e9wLiKp/ c=1 sm=1 tr=0 ts=69490491 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Qq8GJjFHIG0Kcp0Q-yEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA3OCBTYWx0ZWRfXwVs90XcHMRQp
 ojsGBe57m4KGgxi92ceFb0icjNoWXXADaUnI+2t4b78rMiSHPHGD7MIbwmVjsO7Flv37o7q35fJ
 E+A5kh3V3nQ/TJQftqJ6BuBZOgISFGs2GU+ukmXJ1UHOYxQUYQiNjoMNddYi3LA0ElsQlDKCC3i
 7p+85gTXNlbXv2+lKM4Wd2qMgAjOPdMfY9CX4z0Zaa/V4rE1FNeI86kwTvxynLorYAWNvp+s2XN
 a2Bdnsw+lBX1V3WtS4v5iHXBJ6pbbSQpu4qVcSd5ELCBEtMZI4ghycqZ/cgQGi7+a07V3LJMJEK
 WL+3ke3KXiB7u+rQeedApkbP7VaQvJod6fCnbiJx2zpome7ab8422bSEY3ffykOXSRuymNwEN/R
 h/FNd8S/9TMbSt+YmUqpCNVx27q0Niy7nLwEYtyI2gqRExIEwP0BhD23Md7io+mG4JVSn2Qn69M
 weeUVjwhdVi4/soSNUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220078



On 12/22/2025 2:06 PM, Niklas Cassel wrote:
> On Mon, Dec 22, 2025 at 01:49:21PM +0530, Krishna Chaitanya Chundru wrote:
>> On 12/10/2025 12:43 PM, Niklas Cassel wrote:
>>> @@ -786,14 +819,36 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>>>    	}
>>>    	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
>>> -	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>>> -				  map_size);
>>> -	if (ret)
>>> -		return ret;
>>> -	writel(msg_data, ep->msi_mem + offset);
>>> +	/*
>>> +	 * Program the outbound iATU once and keep it enabled.
>>> +	 *
>>> +	 * The spec warns that updating iATU registers while there are
>>> +	 * operations in flight on the AXI bridge interface is not
>>> +	 * supported, so we avoid reprogramming the region on every MSI-X,
>>> +	 * specifically unmapping immediately after writel().
>>> +	 */
>>> +	if (!ep->msi_iatu_mapped) {
>> This is wrong, in MSIX each vector can give you different address, you can't
>> expect same address for
>> all the vectors in MSIX table. In ARM based system you might see only single
>> address for X86 this will
>> change.
> Ok, thank you. I did not know.
>
>
>> And also we see in MSIX the address are getting updated at runtime with x86
>> windows host machines.
> My idea was to add a pci_epc_set_currently_enabled_irq_type() API, and then
> let the EPF driver call that if it wants to change the IRQ type.
>
> But... if the msg_addr can change at runtime, even when the IRQ type does
> not change, then a pci_epc_set_currently_enabled_irq_type() API will not
> help.
>
> I guess we will need to come up with something else for the MSI-X case.
>
>
>> Use the MSIX doorbell method which will not use iATU at all,
>> dw_pcie_ep_raise_msix_irq_doorbell().
> AFAICT, right now, the only driver ever calling this function is:
> drivers/pci/controller/dwc/pci-layerscape-ep.c
>
> Are you suggesting that we somehow change all the other DWC based EPC
> drivers' .raise_irq() callback to call dw_pcie_ep_raise_msix_irq_doorbell()
> instead of dw_pcie_ep_raise_msix_irq() for case PCI_IRQ_MSIX ?
Yes.
> That sounds like a big change that would need to be tested and verified
> for each DWC based EPC driver.
I agree, but this will be clean solution to avoid iATU for MSIX.

- Krishna Chaitanya.
> Kind regards,
> Niklas


