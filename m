Return-Path: <linux-pci+bounces-39753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924FC1E713
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 06:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C968B3B40C5
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 05:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8B32572A;
	Thu, 30 Oct 2025 05:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4GMrorz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ipG2aAH3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0163F2E8E10
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802652; cv=none; b=FPO25dvEjl55qaVc2w0Ke3Hn7er62DLbsPoWHI5owDD7xUcw4+VSVtheUKTZEDQb5iQxs7itD80RDwnW4Hqp9tJoxZWnWHzisnuv1odADWpUFvew7jQX+U2oHNNNj07ZXWWfFcx7aY6ao2Y+LgWqlFG2sMhDCwSO4utXVAPLC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802652; c=relaxed/simple;
	bh=eCGAlRA0QSOsRVcn1TquQsOHuKQDaQ+psONOlxvOkk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haaG6CY6LcxKkEIci9xcLN55AqERS7DT6cSiSFNi8+EiLaWQwno4CG0XJjlJBUWzxESBL1OfYevHUIb+HRPqucpBdhLoWLv92MFbDjnDQn3dCgqmgT4inMZVoHumjCUtPadzdhe/5tqk+GVIgVDeZN6PWVd7imn2bnQre6C2upo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4GMrorz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ipG2aAH3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TKnjnb1598987
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 05:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7M5/feYIXAcY/xiSvoX7AATD4bRj++JaUOMJzVqLb/U=; b=b4GMrorz0W4TMU75
	3T9CRxT9sb3JenThV91wxDEZCZTNp6TCFVK5xU7KPfvomzcJtxJeQ2h3PPll0ORt
	syi4uWn8kab/OI00aD1vnhRqjR52fN1zZwXiaYlkzdaYJAR6vebpJGpWh9xIok5G
	Q1SujHUUiGHwsb5UvedzVT9DQT+jvYfYdh66SN1wTDp1ker+MUOqoFbs6womOH7b
	/Ji7rvy7HaWaIb51jCZ5uZDLz0mKr/tX0sJrlwxDmWa/aONxR6qmKGGHMG25V+tf
	SehFzwkPAgCVIZRdQNdITf7ApxpZyxhrP+aM2AUbn6kH2ImQdPRXJiHHoE96JPXu
	dzLKNw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ta7s7un-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 05:37:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27c62320f16so5313565ad.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 22:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761802648; x=1762407448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7M5/feYIXAcY/xiSvoX7AATD4bRj++JaUOMJzVqLb/U=;
        b=ipG2aAH3GXjzDARjceZdspQUmwo957P2bngsKFE0YWI1riR/9dt33qNSRTmxmedNet
         /rFfeJ7J2FHrEsP3SGlwwtSH7QLAXSYF2eg+LtYhgyj7plf7nkX7khCsd7HJf1k+/Dj4
         SYPrTlcJ4wFDTtLAC0tkZA3VmVFaRIhLQkFO33odC3FJejQtiP3HbnBmUW91/jg1DPKS
         40rR0US/KywFcMj14MDsSVdZAxV7yWyL5UqiAUY2RHmlHFfCYZOn+StlK6zG2ED5LI0C
         RpGp43vnVagpv/EjODec4hucx2TBCXSuS7JieGPR2dPiavjODSqRA1vSwRd0NoY/AHn4
         3zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761802648; x=1762407448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7M5/feYIXAcY/xiSvoX7AATD4bRj++JaUOMJzVqLb/U=;
        b=BpdCwploOcw7NDCttEgxZQAqfqBv7W7QZzsk3yWB7Fb7QyMJ2F8ZAtNKAc0Bd6PKh+
         hfs5ZiM3+/W7PAjEEIn5FDCb1Z/ysYDU/DfSd68mQYZf0llcTJG6uWtLvSbq4Gf5SEpd
         PeWlyxld4+rWh8GWhtnp0O9ez5zhz8SgIh5ThmNqfRlaIjCzCdYm8NlS0lwRhjq9z0l5
         dZU5pXLuWkFb9X4LUq5r+WCSd2rj8jFkkJQECMSiPbxmJID/SmbQO1Bd2qdyW6lEePQJ
         WDYVza7XENdmwu5T98F1mTL6Ga4BFzGyRJQ23HJ/sefbfHFcOXkEZ/5uhqOdGbosVptb
         i38A==
X-Gm-Message-State: AOJu0Yzjv0/EfJO1bHD/3mBlgoghl/qhZLUHBnfACendEQUzlXv7UyLX
	+eUcMubh2dSDMPvjXXZyyk3Ki1XgYurF9ZMKF6O+Z+w8qVgIL/f3ZpwlAge430d0InZ87x7My0o
	POoLh7E1ZJKB+JO3k5/Sg3o1qoH9fTiN8M3X87gBENRt04W4ssLB31/EVhkcl/UQ=
X-Gm-Gg: ASbGncu/Cl5kEn4IN0eueRURXD0GJydUYZTxagqyWFaCcO44DDNNZOnt/Eaf1YMqoGH
	Bh8zFaEATI12xssaV+D5c+Mtk84nyWA2UWmUQjha+p57GOkU1jzWsyYd+JKtHG3KY2MbQs+zg/F
	HjyunhAh32JaIyYXJzOOonk4F5M3W7zpYGJCoqh8E9xl4grsOZ9o80g+Qj6vYUdoO9olnhS2gIs
	8yoyPseLXX11aSmUFwMJ2yKJ89cub+dnHs4IVIVel6MB+1HawL4GshFdvkjxUPH6fYsu0wrtl6Q
	Qq7ejYcApynB5GN/YPM04WDM7H9VFQbz/stG1aVnjawhKRpwPQdOHklA23v9xu7t10TvXEP/ex5
	QZm+lD98LxvXl0N4mHXp0XmuFB6SGS7M=
X-Received: by 2002:a17:903:22cf:b0:278:704:d6d0 with SMTP id d9443c01a7336-294edbf56admr21509615ad.19.1761802647639;
        Wed, 29 Oct 2025 22:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOi3AtcF65oro4e3+BO0KlY5luy6t+0LWSKM1u0T44ogvuEu8VYVcI28WV6vxqGpo9V+1xOg==
X-Received: by 2002:a17:903:22cf:b0:278:704:d6d0 with SMTP id d9443c01a7336-294edbf56admr21509355ad.19.1761802647083;
        Wed, 29 Oct 2025 22:37:27 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d39048sm171628295ad.66.2025.10.29.22.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 22:37:26 -0700 (PDT)
Message-ID: <dc230a62-bd31-450a-9acd-fa654f694b3a@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 11:07:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] PCI: dwc: support missing PCIe device on resume
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
 <20251029-rockchip-pcie-system-suspend-v4-9-ce2e1b0692d2@collabora.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-9-ce2e1b0692d2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aaVsXBot c=1 sm=1 tr=0 ts=6902f998 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QX4gbG5DAAAA:8 a=G1FknBJvTCrQj4ipN-0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: T2uFE0FNmHMj6WonnzFny4EJiJhp-w8-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA0NCBTYWx0ZWRfX/vGEbQo09gwb
 l2W+AiG/TOcOBZGM7CQxCx27xKVawOc52BvzgBWMyJBRakbwOf3rGSsNOHWMb6cBBucG0i1aQ9B
 31R8CfMCcxq9C9xCzbxK+mFnft0GGKAQu+T+gorH6pHdhqmrXIRJmqUezaFNvO9UpcPSRsgYmlr
 PNtfsafxN0DDzauVRLtGU6/UYeKRntSYnvJRmr7DKvu5XqfbLPOODQIw4mhMQ9q1BD1yvELKMux
 RTDsLw69umFeRMjyF3UfdXPCDOx2hxf/rhAD6D40kqdZh7hoMw1WQ/CuJD8Q3yuCEA5FSu1jUnq
 W+UJT7MRfwjNYUuvIb+V2uxn10SniEO+jpc0f6RWO245ZYmpF18vR7I4Jdfxrg5LZqAmC4RLcpQ
 7CIiPyl+AQLHCmanEA0vmpFHD2TvIA==
X-Proofpoint-GUID: T2uFE0FNmHMj6WonnzFny4EJiJhp-w8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300044


On 10/29/2025 11:26 PM, Sebastian Reichel wrote:
> When dw_pcie_resume_noirq() is called for a PCIe root complex for a PCIe
> slot with no device plugged on Rockchip RK3576, dw_pcie_wait_for_link()
> will return -ETIMEDOUT. During probe time this does not happen, since
> the platform sets 'use_linkup_irq'.
>
> This adds the same logic from dw_pcie_host_init() to the PM resume
> function to avoid the problem.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e92513c5bda5..f25f1c136900 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1215,9 +1215,16 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>   	if (ret)
>   		return ret;
>   
> -	ret = dw_pcie_wait_for_link(pci);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * Note: Skip the link up delay only when a Link Up IRQ is present.
> +	 * If there is no Link Up IRQ, we should not bypass the delay
> +	 * because that would require users to manually rescan for devices.
> +	 */

In the resume scenario, we should explicitly wait for the link to be up, 
there is no IRQ support at this resume phase
and secondly after controller resume pm framework will start resuming 
the bridges & endpoints. what happens
if the link is not up by the time endpoint is resume is called. And 
entire save & restore states might also gets messed up.
There will be no way to recover from this.

- Krishna Chaitanya.

> +	if (!pci->pp.use_linkup_irq) {
> +		ret = dw_pcie_wait_for_link(pci);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return ret;
>   }
>

