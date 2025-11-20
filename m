Return-Path: <linux-pci+bounces-41807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 680DCC75315
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5A1C4E9123
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDD7376BE5;
	Thu, 20 Nov 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MrWlbsmy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NkGV3fOZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956228851C
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653851; cv=none; b=RDDELlKgV7PEKFKp5DKEWY09GV+bm7oTwTeeBz/YeNlH3GvRowypzUhVbdOPkVdHjNW6QPRytQg1H5wWUcvJJrUrLh6GCIQ9EK702OCqGJejKZgXUfdhNI/bCB9YkCMpHG44hKUrsEV9zpBEFXT0YkG4Ff5jNAew/BK4wACWseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653851; c=relaxed/simple;
	bh=3LXjZvhAxhf5oSUUkSRQAsK/IDNbfA5F7E3Mq6aXfQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twYYuWWZmZsi2/ZAdnXVCHjjQhSbRA5qI9Ng48VO4wioEa3Mwi9LmFxv3/f6aAGp0RR8rqGMzWd2NTRvo9u1leJPv8zl4IaH807rbzA/RLSqdkNXGMM6KUM3BWFtQGt1XRAHVu2stIlB4M248cN1P9+VsC26hoqVaz1FmSEQigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MrWlbsmy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NkGV3fOZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKEraIn082212
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 15:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fjJkCHucrCZBX5LjnXaIOgVpyAHpaiZEXld9Y5GuCoc=; b=MrWlbsmyA5Myc170
	76O8bjw+rdnsu5I+jXBNKffSmeUz+9n+i7t2TnOLewNadcT6LY06NNc7C80IDnL2
	W8TkAL+8as0th5hoQEJoPsZjUjTIVVSHGa/Rcp8ULNX2y8ExqopMxV/6rBPARx1M
	Woz9OdtAXgkhWwpJwK0bYPEEdo/DSUcBQG5kspYPkz9z246nPtuW12e2m2ygkk45
	eE6zqt17vPTowi2DJfCXQ1jHd21AP3OdfjeDuyBpbxPv/HACC0AlJ2H2cGT0SDVB
	jdYTlGB4hKn7hwx9Wrezeh1uUMMyd0fNpbAKalX9KcMeUAr3vtUrktpmCOKVLt1l
	3B1C5Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahxrn9fya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 15:50:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2ea2b51cfso28425285a.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 07:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763653848; x=1764258648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjJkCHucrCZBX5LjnXaIOgVpyAHpaiZEXld9Y5GuCoc=;
        b=NkGV3fOZy/AuMwIVroEXDysn46e+x8z6AhqrpqXHPt1BbwSU6GU+A7nNVZ06IeMNgn
         1/2yUcGVuhEYCI0ml6XciFBPovnPJNevgaKG0jrz+8ezj0HY3tyuk91kbv53XUgRI7+j
         /hb8BQC0PtbzuVKxgM3hPxNzuHd0xr3DHIFPE8yUV+olxicZvmYK/pVDHY3ic4E1/TDp
         I6XXziMgN/y+lbxyxwZeVBgsG4A8CbPwN+Pb1nJGyNQ/LlkLCscIOHQVL0jj+TQUy8X9
         nfJM9DPkHB4wSS4GKGxNil5kOCbvnPCiprtoFBXSOWF0QA6zFE4gsbBGKQumoNu9Xeb3
         8Cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763653848; x=1764258648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjJkCHucrCZBX5LjnXaIOgVpyAHpaiZEXld9Y5GuCoc=;
        b=cQ99dYuZMbkExQ2T3KG838AGUngAcGq06wTfrGXgkU7LMR43ZfxpGpTsobnUf5xHSj
         9SAsXuEuPClAf4HlfzRqJ9488CC1ynIQCNOc3VUhyri4tOGpD/12tnU4Xdf6Hx5qeba6
         OK5wMx89qQFJL/PpL1wVe2rGBX90d1VmM0/RLPbudlxzr/1++5paTI+FXAHLXidoPwSI
         MzcECSZNC8Wnr1X+nG7tRj1p/WnYkqTFo+Rrp/1qPWhshE3VLbv0Cd1MXmhZ53b5GeMm
         LvwbwQht2RWUclvhjYys6bDt39hL3eja/1Yn86l3+C6Poh2sxpzhoP0WCjpyAZusfHPP
         mAHg==
X-Gm-Message-State: AOJu0YzsnrvXzXJY1md8HTGYfpN9a7oJjKg2s+P4dbXmI+ZmbyZvFt4R
	hheA3y3ulrOo6Se4QjIl0HENJu3EzQdLwofG1/ox7fleF+AKq3koB/E3t6EU0+wLrp++sz3cSKD
	TT0Kbr/3jZUg1mLTDoQ4SqrTGsXn0JjWOwUfuiZ1h9dNCde2nzNmNTRXlsWvB4fo=
X-Gm-Gg: ASbGnctpPjJtDyp/iJqJsQmqmvZrsxVJw5swjxDtWzlzPwNgc1SnbLmDS7lOXnA4+Or
	0pOO5iov53n3qp2iVUkofSxYOepYPoJegb6JoW/u0zc5i0RhFK5+iz9Z2ud2UQY71i/6o1Zouyv
	SZxYCSe5scNdAuhz4JEwNegOEgLT8qPxD8GnkUkF4sAelClPyyNNr7XIR+2unykdvp0Qcg7WxZk
	iTU1I4oZqCpUbh3l6rcBPJHOuFdKyXsGiPHNxa5uoAIPgTzJUrPyRgvnUNyn3iSv/uHpqxkUUZ7
	0/Z9EHuoatZMkcnPF2lF7U44iewR4EylphbtqCenV5ozlPe2jtS8Zwxzw2M8kef41W7dZaFMX0t
	I05KUf4kU81724ridl2wTH3E7NmZuHz9WmJl1aRybMYzaUxVFYvlHqGZCU5/c57ZHfD4=
X-Received: by 2002:a05:620a:7107:b0:8b2:1f04:f8b with SMTP id af79cd13be357-8b32747edf9mr366253885a.6.1763653848090;
        Thu, 20 Nov 2025 07:50:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4MYAPZE3Av5PSX2AH04IPx8xcJqHIXsZFnzG0TUzdhgaJAWfh7xBLUjVQ4xGirjPSFLXPHw==
X-Received: by 2002:a05:620a:7107:b0:8b2:1f04:f8b with SMTP id af79cd13be357-8b32747edf9mr366250785a.6.1763653847529;
        Thu, 20 Nov 2025 07:50:47 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645364437b2sm2304423a12.25.2025.11.20.07.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 07:50:46 -0800 (PST)
Message-ID: <88778660-18de-40a7-83af-41f60334c4cc@oss.qualcomm.com>
Date: Thu, 20 Nov 2025 16:50:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add quirk to disable ASPM L1 for Sandisk SN740 NVMe
 SSDs
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20251120154601.116806-1-mani@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251120154601.116806-1-mani@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: p3AFUoV0JDdgZjb8o2m8QwlNVxK5hnMI
X-Proofpoint-GUID: p3AFUoV0JDdgZjb8o2m8QwlNVxK5hnMI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDEwNSBTYWx0ZWRfX3rhOrwrgAa4C
 FRyl+irlFM3KKOaWTwMjo1FEx6X8zm66L+izqES4tbhbyUDHJQ1d132yqBbvO0KzNir/AnfjPyi
 GTyRdpiyJATJN+8IiClFTy3/VOTdyRbjBdbpL3Kuc1UY0i6nGwbVwGIEXA7ZAKZ0ln0MPQK8omi
 h2mrPaxfxLSkJS5teEpSxwaPRRNH4jbFxAyyC9+Q9ycsvxQlOO7tBFuk2h5fXg7ipx6gO0ZDU2j
 NmpwkjVqt82AwIjQFkYBprD8MsVGua3Gm+xf6w5fqsYaXjWfv4WOGI1m6kQG1gjvLR8nf/AVvuS
 bfQB4ASJLENqKhvvCczBN/bAr6dcaPZFScoebxIvFQPUbyhHqO+yh3NU1DD6AM0liN3lpNxKbGS
 fU+Wk6Hfz/eIvg9asj8VU1wloB8ChA==
X-Authority-Analysis: v=2.4 cv=S6TUAYsP c=1 sm=1 tr=0 ts=691f38d8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=6wk0BdiTjokcx5KyKl0A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_06,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200105

On 11/20/25 4:46 PM, Manivannan Sadhasivam wrote:
> The Sandisk SN740 NVMe SSDs cause below AER errors on the upstream Root
> Port of PCIe controller in Lenovo Thinkpad T14s laptop when ASPM L1 is

                             ^ Microsoft Surface Laptop 7

Konrad

> enabled:
> 
>   pcieport 0006:00:00.0: AER: Correctable error message received from 0006:01:00.0
>   nvme 0006:01:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
>   nvme 0006:01:00.0:   device [15b7:5015] error status/mask=00000001/0000e000
>   nvme 0006:01:00.0:    [ 0] RxErr
> 
> Hence, add a quirk to disable L1 state for this SSD.
> 
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..a6f88c5ba2f4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,18 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>   */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>  
> +static void quirk_disable_aspm_l1(struct pci_dev *dev)
> +{
> +       pci_info(dev, "Disabling ASPM L1\n");
> +       pci_disable_link_state(dev, PCIE_LINK_STATE_L1);
> +}
> +
> +/*
> + * Sandisk SN740 NVMe SSDs cause AER timeout errors on the upstream PCIe Root
> + * Port when ASPM L1 is enabled.
> + */
> +DECLARE_PCI_FIXUP_FINAL(0x15b7, 0x5015, quirk_disable_aspm_l1);
> +
>  /*
>   * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>   * Link bit cleared after starting the link retrain process to allow this

