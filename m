Return-Path: <linux-pci+bounces-43553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A8ACD80ED
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 05:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D2203019E08
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 04:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1123FC49;
	Tue, 23 Dec 2025 04:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E0zb6bLc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVeFfFIo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3E3A1E7F
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 04:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766464542; cv=none; b=H2AWMNo5hvZxgtQi588L6c3YbUuU7ZTZV072OnFytgY34/QmQIXXOoE3z2g4/Yx2tAkPQ23j5uZwhW2jiRvu/NKR0uB+SsmKhVjoSjooWPgW2Uvv5LgCfzgUy2QgR6zDjFq10WHIVm3XhaNmO8P+2LasOtVA30OhZ+vYTvRNBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766464542; c=relaxed/simple;
	bh=wdtDMUbC6NbGA/o/z+BNmLC4TtEzZBHOhzRAURe9zDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axFUrWwC/zTAnrMhgAyB3cJvFEHDbg8NOPOxgf95yDUOFgjnlfNR6AdBqkuPdOTHPFH5JK2hpDTn9SLopMkRPegqgGq7k6WSppEttGmVJSEbueNq8vJQWI1F0SFx22pqjMPxhsn4afc9y4ZiEYKnPwdpMy/Baeg17puhVL8qYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E0zb6bLc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iVeFfFIo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN37pIM1569209
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 04:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vW3ZLxVEsD3ZnS4hcgk7+GzcbDbg62AI3dazF0fUbcc=; b=E0zb6bLcQEhAUQi7
	qirNq9kZD9utivAhqBHeP7r0AlJbEyD+OgYu+WGDffhm+piGb/5ZOfJehy12ngrI
	14q61hSiJ3LbWrXgyFh/EW/WmJnloqGRsc9oxRnVldyIQMP7yv8w9pJizQwxUHs9
	F1wjpN/F+AimipFyvNRUukspfs9rxjMZ4jhSWDLR0yQNeze4ebdqTsF3wfVODYLY
	0IdavefERM3zN3l7DIGtlTe1GjeWq/JwNeT1o2EXREIL7XkMGmUUQb5XDnNew2Kf
	4rCvbVKD3kkK2KS6ijmp9P2nwXyuM36xny0YgS7yMBDdP6vsJEJ0w1VpBj1ptITY
	MkzgEQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b76yy29ek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 04:35:40 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b9090d9f2eso8831741b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 20:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766464539; x=1767069339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vW3ZLxVEsD3ZnS4hcgk7+GzcbDbg62AI3dazF0fUbcc=;
        b=iVeFfFIoTcn0R4PrrZdhpNPqeaZLln9+xC5mvH8ytIFgdEi4N1SzcY5eauQF75zK4V
         bswTvj8eU1e7B+fghC3pZcmBwgAJtv7ZQxf8yp7w+8bBYf6bi5B7KaLsBv2TmAuIWawu
         goSEM9TWNC+/hybl4YBp5evZ3lOOt5iN31Hmk0Rcogrd6A+L+/EXls3WA/aQ7xAHM2lp
         wU1GBt0f+oBZe9pZLXfbt/fYxk47x+Hg0eNeLkG6/kIk8YRw3YfDgvPMPwtL7f7852qq
         TKeb0mZ3U6CuWHS9ROGTaVSX47JdeE1IOZ4Z7sQidYMfmqwBReuXvJqAxrgxLmZv07pk
         cUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766464539; x=1767069339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vW3ZLxVEsD3ZnS4hcgk7+GzcbDbg62AI3dazF0fUbcc=;
        b=VwL4KNYjD7pPXsIB+IUR9lphxynBTfuuSw1jtDIsYZU/cub9FY9YgY74yQgUvqDYDB
         8jHguUyDzlDeQZ0aRTLOrNCBd2c0XYAXJ7xXHvazPikcjtounZSERp/3/yPBcFTcDufT
         6hj2wpmdXitPybARfYEoeiwGFCzUjr6oK08WCJiICXU6/t5JyZ/EGCxoTG7x7jtVXr5h
         nb4PEKxifEHG/Mf6WkDs9tkH7cVQkPy9xVzErj2qfU74Fs3aQSPCbVvVHIOSHvtAckSY
         ZmIY3cAnfzwL6+Q340PW3DahrzX+Wy4DKV8i1N3i1CZsAz1sA88KnQ8rMvz6Wkm3TOVI
         wgNg==
X-Forwarded-Encrypted: i=1; AJvYcCU/UzA875JR3U1rit5i9iA5WX7JlLkep9JEN8L41VWNyNp0LVdITSHngS2fytTcxy/FmcQK5TFBxrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8rU+VPSxPXcWULFjh6d76YDjZG6x1HGCyZRr7Hbjj0z2F5si
	JyPldMkZV4/40b5QJAEPyOkbIy3h7jQUwXOw5mM7S6PIw1abIKb5CmbsdC1rCPLKnN2kQzDd1wa
	evEfArSkm5sGMM1pEbqkuzSur50J2yPxAULtbAa9Muv+zqacltQ/RCgBqvdpJk9c=
X-Gm-Gg: AY/fxX50vK98GYhHjy4a5Ae4yYXdCiFL8uxV3L6SOVqVjcEqOLKI3f8AyCbvi5BQhAj
	t3nBpMjwi1ynTasQ6cdYW0u+J+BVXiuFrlIWLTX3eykqlEjiatjku8ALdMM55u0nLrBhFJ1qFac
	fTopxL9Zfa/+b/ZbaIQ4Xvz+E8ByJrss5DqQeD803flUB420tslMY/EfhGEJ/gs+eatFyqDBp/6
	zCXPC7R4KGBjkucEGGBYs2biWX7fx9I23OmKN8SHpH2L1FoIl3zXowgBV1Fy4nvDfcBVSq+fPy6
	er8wp/nJS0O0BgLoaFCG+RpPO70atBXtLwDFTn+Q6aQwIWlfieSEfeE8ozXk/PGknFX39AxW4pO
	rax70xJW35kZpv/Fla0nua/AFkqz0v24kYvMTj+B6Dw==
X-Received: by 2002:a05:6a00:278a:b0:79a:fd01:dfa9 with SMTP id d2e1a72fcca58-7ff64215308mr13201720b3a.6.1766464539386;
        Mon, 22 Dec 2025 20:35:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkRpDAVO328ItJj7fT7qtlRC67hmAxEdch9oNkhrGUH1YoHfKdi+X2vAQNg/JUJLFGl/a7+Q==
X-Received: by 2002:a05:6a00:278a:b0:79a:fd01:dfa9 with SMTP id d2e1a72fcca58-7ff64215308mr13201695b3a.6.1766464538886;
        Mon, 22 Dec 2025 20:35:38 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a843ee4sm12220907b3a.10.2025.12.22.20.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 20:35:38 -0800 (PST)
Message-ID: <63321b7d-74a7-448f-ab20-08cc771beb5d@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 10:05:33 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
To: Shawn Lin <shawn.lin@rock-chips.com>, Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Jingoo Han
 <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
        Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
 <aUknSzSpNxLeEN5o@ryzen>
 <3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com>
 <aUlA7y95SUC-QA4T@ryzen>
 <a24a5d8b-5818-4e11-bc09-47090de164c7@rock-chips.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <a24a5d8b-5818-4e11-bc09-47090de164c7@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDAzNiBTYWx0ZWRfX7139lz8f8jwa
 2yjK3xgEd1tHlLl1//lUhC+RAY+UuosPYbzSQvJsR79/FZSc8U5B5bXExryHxPVQrbLMEj1cO2M
 /LHqcTt7itllPMTP+dDfR1NfA1xEmAIArSmhXMWMo2wuTgTtPZfX1ByGS1UccPTIglWjWJxwyh4
 HekIvQ7O78iFBk5kyyP1ArrCC5YYW9mHeA45vXFbTXnFl5SwdLbeGRT6uWV4lKbh7RUI9ZPFuOu
 R/sgnNbzFVpw5nKXQWyFJcyCkNv1x93XzpBcKknB65Z5P4wRETUHdexGbeQl+mRqV7Wryxnvuac
 C5r8QG/Fze4WC5DbFeURd6f8nSFSWAEJf7m9vwDOtETsetzZWkl+Wju+d5sUEsMynUlaCbkWyjs
 RJOvv5CsXfMOcZKGo1WUotzjcMoEmwS7/rv6yzA0iJ0l8EJ7xjHYlzBtZE4Edm7pcVU/li96Mi6
 QCVS2Ah1rTaCHK4damw==
X-Authority-Analysis: v=2.4 cv=Zb0Q98VA c=1 sm=1 tr=0 ts=694a1c1c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=0o6G4FUzGTm6UKix0egA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: IGOJ3SxxcF9t-y0vFcuBzOLFUcjq2Nc1
X-Proofpoint-GUID: IGOJ3SxxcF9t-y0vFcuBzOLFUcjq2Nc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_01,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230036



On 12/23/2025 6:42 AM, Shawn Lin wrote:
> 在 2025/12/22 星期一 21:00, Niklas Cassel 写道:
>> + Shawn
>>
>> On Mon, Dec 22, 2025 at 05:53:27PM +0530, Krishna Chaitanya Chundru 
>> wrote:
>>>
>>>
>>> On 12/22/2025 4:41 PM, Niklas Cassel wrote:
>>>> On Mon, Dec 22, 2025 at 03:28:30PM +0530, Manivannan Sadhasivam wrote:
>>>>>> Use the MSIX doorbell method which will not use iATU at all,
>>>>>> dw_pcie_ep_raise_msix_irq_doorbell().
>>>>>>
>>>>> I think this is the safe bet since this feature doesn't seem like 
>>>>> an optional
>>>>> one.
>>>>>
>>>>> Niklas, if you can just fix MSI in this patch and leave out MSI-X 
>>>>> for the vendor
>>>>> drivers to transition to doorbell, I'm OK to merge it. Otherwise, 
>>>>> I don't know
>>>>> how you can reliably fix MSI-X generation with AXI slave interface.
>>>> FWIW, I did try to simply change:
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c 
>>>> b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> index 8f2cc1ef25e3..00770f9786e3 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> @@ -319,7 +319,8 @@ static int rockchip_pcie_raise_irq(struct 
>>>> dw_pcie_ep *ep, u8 func_no,
>>>>           case PCI_IRQ_MSI:
>>>>                   return dw_pcie_ep_raise_msi_irq(ep, func_no, 
>>>> interrupt_num);
>>>>           case PCI_IRQ_MSIX:
>>>> -               return dw_pcie_ep_raise_msix_irq(ep, func_no, 
>>>> interrupt_num);
>>>> +               return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
>>>> + interrupt_num);
>>>>           default:
>>>>                   dev_err(pci->dev, "UNKNOWN IRQ type\n");
>>>>           }
>>>>
>>>>
>>>> For the pcie-dw-rockchip driver, but it is not working:
>>>> [  130.042849] nvme nvme0: I/O tag 0 (1000) QID 0 timeout, 
>>>> completion polled
>>>>
>>>> Without this change, things work.
>>>>
>>>> Perhaps this feature is not an optional one, but at least we will 
>>>> require
>>>> more changes than a simple one liner.
>>> Hi Niklas,
>>>
>>> It should be automatic only, no extra configurations should be
>>> required, I believe your
>>> HW doesn't support this feature, from spec 6..0a, sec 3.9.1.3
>>> iMSIX-TX: Integrated MSI-X Transmit (USP)
>>> I believe your HW is not generated with MSIX_TABLE_EN =1. In that
>>> case you can't use this feature.
>>
>> Looking at the RK3588 TRM, it does have register:
>> USP_PCIE_PL_MSIX_DOORBELL_OFF
>> Address: Operational Base + offset (0x0248)
>>
>> Port Logic registers start at offset 0x700 on this SoC,
>> so 0x700 + 0x248 == 0x948, which matches:
>> drivers/pci/controller/dwc/pcie-designware.h:#define 
>> PCIE_MSIX_DOORBELL         0x948
>>
>> I don't think the TRM would include this register if the
>> DWC coere was not generated with MSIX_TABLE_EN=1.
>>
>
> I checked the IP configurtion parameters for RK3588 DM controller for
> sure, it sets MSIX_TABLE_EN=1.
>
> Looking into dw_pcie_ep_raise_msix_irq_doorbell(), it doesn't seem to
> match the dwc databook. No matter for non-AXI mode or AXI access mode,
> shouldn't we need to generate a MSI-X table RAM with 
> data/address/vector/TC in advanced? Am I missing anything because I 
> didn't look
The MSI-X table will updated automatically when host updates the MSI-X 
table, when MSI-X is enabled
by host.

- Krishna Chaitanya.
> too much regarding to the EPC side?
>
>> Shawn, any suggestions?
>> For full thread, see:
>> https://lore.kernel.org/linux-pci/3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com/T/#t 
>>
>>
>>
>> FWIW, Krishna Chaitanya, I did try the 
>> dw_pcie_ep_raise_msix_irq_doorbell()
>> change above also with the pci-epf-test EPF driver, and it also 
>> caused the
>> pci-epf-test driver to stop working.
>>
>>
>> Kind regards,
>> Niklas
>>
>


