Return-Path: <linux-pci+bounces-43522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF62CD5F92
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 13:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43587303461B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7458B280A52;
	Mon, 22 Dec 2025 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VYaNygxS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dSzqKfLr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF40280014
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766406216; cv=none; b=j0Ll+ApxNWpRLc+FMfMM1+FD2BDsbiJc4aMVpDJVL/uUKI+BvGpQPTzWFDJfMYnpEwK4CyeHsgMee2xYR6T8gRY6HnWE7ddbnu9OY/cj0U7CE7QMZQ75wGlOPHSiQS/GPL7DL1UhkQpFYjHbBnxtM0Puf8sjtl9l6phVj6arrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766406216; c=relaxed/simple;
	bh=hrhy+XUyU5fYPK/WudXyHFpG6+QmbrPqhq23UCkuFf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxluwPue69qkir3EzjaYDWjrxBTA1JPWkyLIxC/EJ9dX5xBiO0tKzTIt7HlyPZldCDiGdDEyGnbVU/NHoTLFC0lLm0VzlBMRy2JC/dxWYAnkTcbCUJZu42+QruO9otxSgDHeBO2koFBZT+KXIbogFYuV7EHYnftFE298+EJan48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VYaNygxS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dSzqKfLr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM8la5G3964461
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 12:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BTZ/2lUSjSajv9m9zkDv0MEhhN3IoVMCIEtXRs4qpZM=; b=VYaNygxSRU1pkEhy
	m4kw/FR6yVK/KAXQLP9uQalmJZttiPYd4brznpAGzdwy4hRFYXVPq+IgfE0caCjT
	QG+YxDvwUel+7TzcKEs8GUfgUbGkl/z9NalJH8fyAXv7rBAYUrs2HLSb3lPozSmz
	/e7ceqmtQWlO+cpVkwDh4FKp+lUOGlhk2AR2B/WIAmrAfEYgR8xIi7gJIl9wmd0o
	58obMfW83qs36P/s9+nxtfm4H+frR7E79mySMVrU3t5dC6dz4fylnir2/4WOW032
	BoHq3ITJbEqzVjQ5XhttUjV7tPH7R4QTHSmmX6ux+qjPgeymNjdLwMvnmw8fReop
	/9OD0g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b6vk6hq4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 12:23:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34abec8855aso8362023a91.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 04:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766406213; x=1767011013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BTZ/2lUSjSajv9m9zkDv0MEhhN3IoVMCIEtXRs4qpZM=;
        b=dSzqKfLrLZ8DDJU6e900787G4uqYxlWSP0dDz1KRNAIeeWIrAvy1eOPWbZg90KnyBy
         Al+zeklBsJI8CrSB5me+PNJEmGnGU/AoV9XHu5HtiQlbLxG/k/BezUChsikwE/4xfSsO
         zJfZ2kR3pymks9qKkD79NKvEUfOQSdsJbagHNTA5Rk7GNu2Wo9zOR13Hoa781EeT3wgI
         ydnvD/ZJyUUklVX3GlOfDl2QqHIDPph53vENvKA8M7ZM6Z7IEfMWfH0aGBZMBfPuBJ4z
         TLT9+ST54vHxZtlR2wOdJ1vMmLkYlUdDRTMq2HgW5M8kypSHJVegYpnEpMeC5WqW8nIb
         HUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766406213; x=1767011013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTZ/2lUSjSajv9m9zkDv0MEhhN3IoVMCIEtXRs4qpZM=;
        b=k0mfA5cWmUgSeFu8Bbf7ZWAV0NqIEIiMr4sH347lWyvHFmGYGcvzgU8Ghuy7vC4NM/
         1KjBMNdIu8LIB0bKHm6xqY3fq/pPOVeHtK52NlKtI37BPmdcVjShe+52BtHvOlCtSMRP
         okNu33RprugQau7wgvWTEt2uBSVBha72oxQgAPVDSmlov5eiHaTArN2sw43sgFQb4X5Z
         XXNBRq+9ILIfkW+Rka2ht7k4mcr4SUrHOrzjijBqkunEYSkXoQ/wevM0pJFj/lCIPDjN
         DYFj/VIjmOtBCW+FXn54bEGesMgUeCGnnVmEkiTV+E3bMACjamrHIN+1DVbcd2oJWrPy
         o1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0Yq5foYvmRU4hBJ4UMoEEgYY+soZ2Bk9VqoCZJHI0Xm3O9TMHO+6zcFpPJ6EQ96Q0H2JWIO6YceE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgsaHPqdZFovuiZdIeQ8LSJH+LFHzrUQ0Hy/OoSiKwvIhu/QE
	x9Ls6s7a+Y21VLzKuwfTjb7ZwsalFzGnzpg5t5eHGWLfXKDD5y6Xs0+KH9Tpz8Zbh7tECQxi/un
	FQeCFHm9WmZbHduNOyCI3m0JH142+kll8CKroOBEwxAGCrhg6u5kEibwFwGxLtu8=
X-Gm-Gg: AY/fxX6zaBLyzk7QVPUir7b552i6JgJOAbNDOGLCSFiQnKx5qB9Wa3P74tgf/KQfyPJ
	Njn8ZpAW3G8x3EWivkN5gE+itaXw50bCccs76G6cWskTOVaGU6SAOiNedGgVaOUiT4lPRlhCMap
	6bDOlR1jgXRlDj/uf5EAMwvGomAfpQbjziK7iXw6ywCl8w+2B6+2TjNgxgh5jFOPsmv5vWqUSQU
	TXTLcRJBGZPmzJgn1RPZGSJOj117iU03WW0WdMAJw/mym2DIvV7w3dybkGHeYbRZq+vF7LVfhBE
	63MIY9+vpUH5+fdl4dweShu+UzeehyfhD7EJF7OhB5SAQMSsa5A/nOQSP+kNRcNYe7/2MzIXZrm
	JsRGLythmcIjcBNKVcMIupp7Q5YWNXqBi2LUgNeyoaw==
X-Received: by 2002:a17:90b:548c:b0:34e:63c1:4a08 with SMTP id 98e67ed59e1d1-34e921c3e29mr9020530a91.20.1766406213323;
        Mon, 22 Dec 2025 04:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGThsA0pDvxulNzUx4mptftWNN/K4+16jF94FduYQupHFP+P/Ho8PnMl+8MKTAYN7xXwlE7Zw==
X-Received: by 2002:a17:90b:548c:b0:34e:63c1:4a08 with SMTP id 98e67ed59e1d1-34e921c3e29mr9020499a91.20.1766406212736;
        Mon, 22 Dec 2025 04:23:32 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12867266a91.0.2025.12.22.04.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 04:23:32 -0800 (PST)
Message-ID: <3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 17:53:27 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
        Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
 <aUknSzSpNxLeEN5o@ryzen>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <aUknSzSpNxLeEN5o@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IUuZ5s6mDajZ1f-iJ1M261nvRzS9fzMp
X-Authority-Analysis: v=2.4 cv=cuuWUl4i c=1 sm=1 tr=0 ts=69493846 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=S-UHFOOsjGpW8x-PihcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDExMiBTYWx0ZWRfX+yi0AyNPXFlt
 dFlaEj6QbzucjRaZUYXxP1/8nwy1io2pXqVRHo07rEcZTQludclyyYTb+aapRSmO2Lz3ck8xJRU
 2aG6zUA8suWKCLGkx4bPk4iKFdrc4PVYQBq7iIe//0IzKgF7VnZIXhWT6KFCcGoHqWZpDI857HH
 W00/aeRwAaayvun8OuG4chmFI/9E0gt4VtCrf9iGzQsty+3bE/j8VkKeDu+ByXddihYvE8t5sr8
 Ae3n8CT2KsGWeXu0II0MpX6nSfnb13cDcbQzfQt3o5JWkmg53IGCcyxYEaqWwQdyYHWMl9V4mM1
 DZo/o6AeOscTin25yGCBe6y3KRB3lV9PwN0VCVnV1KRwhdxyV/Y02go4LSRCr63jJsp8AzehaxJ
 AJDIVsneBskNK74XXR29oWuDF5hH0njA+eoCocEbctUub7J/ZZv2X+T9/wdKfXjG/jyrqkezRCA
 hKAzqHj3K+jhUI283sg==
X-Proofpoint-GUID: IUuZ5s6mDajZ1f-iJ1M261nvRzS9fzMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220112



On 12/22/2025 4:41 PM, Niklas Cassel wrote:
> On Mon, Dec 22, 2025 at 03:28:30PM +0530, Manivannan Sadhasivam wrote:
>>> Use the MSIX doorbell method which will not use iATU at all,
>>> dw_pcie_ep_raise_msix_irq_doorbell().
>>>
>> I think this is the safe bet since this feature doesn't seem like an optional
>> one.
>>
>> Niklas, if you can just fix MSI in this patch and leave out MSI-X for the vendor
>> drivers to transition to doorbell, I'm OK to merge it. Otherwise, I don't know
>> how you can reliably fix MSI-X generation with AXI slave interface.
> FWIW, I did try to simply change:
>
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 8f2cc1ef25e3..00770f9786e3 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -319,7 +319,8 @@ static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>          case PCI_IRQ_MSI:
>                  return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>          case PCI_IRQ_MSIX:
> -               return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> +               return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
> +                                                         interrupt_num);
>          default:
>                  dev_err(pci->dev, "UNKNOWN IRQ type\n");
>          }
>
>
> For the pcie-dw-rockchip driver, but it is not working:
> [  130.042849] nvme nvme0: I/O tag 0 (1000) QID 0 timeout, completion polled
>
> Without this change, things work.
>
> Perhaps this feature is not an optional one, but at least we will require
> more changes than a simple one liner.
Hi Niklas,

It should be automatic only, no extra configurations should be required, 
I believe your
HW doesn't support this feature, from spec 6..0a, sec 3.9.1.3 iMSIX-TX: 
Integrated MSI-X Transmit (USP)
I believe your HW is not generated with MSIX_TABLE_EN =1. In that case 
you can't use this feature.

or
Are using VF for NVMe, in that MSIX doorbell logic needs to be updated 
for VF's also.

There is one more option to use MSIX with out using iATU i.e MSIX 
address match mode
taken from same section above this also, but it is not clear to me if 
this feature also depends
on MSIX_TABLE_EN=1. May be give it try once.

"Automatic triggering of MSI-X generation when your application issues a 
MWr at the
AXI subordi nate interface with an address equal to 
MSIX_ADDRESS_MATCH_LOW_OFF
and MSIX_ADDRESS_ MATCH_HIGH_OFF.
     ❑ MWr must be DWORD-aligned and must contain MSI-X vector, TC, and 
function number.

■ When your local application issues an MWr on the AXI subordinate 
interface to a specific address
(MSIX_ADDRESS_MATCH_LOW_OFF), the controller extracts the vector and TC 
information from the
MWr payload and creates the MSI-X request.

■ AXI bridge guarantees ordering coherency by forwarding the MSI-X 
request after the preceding MWr has been transmitted.

■ Processes one MSI-X request at a time and halts subordinate access if 
a second MSI-X request is submitted before first one is complete"

we can allocated a address and write in this MSIX Address match register 
at probe and update that address with the vector
number and function number etc(Same as how we write in MSIX doorbell 
register) when we want to send the msix.

- Krishna Chaitanya.
>
>
> Kind regards,
> Niklas


