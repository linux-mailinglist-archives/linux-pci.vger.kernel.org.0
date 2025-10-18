Return-Path: <linux-pci+bounces-38553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18118BEC7F5
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 07:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1185427EAB
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 05:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B98224AF1;
	Sat, 18 Oct 2025 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BaZG2Fg0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A01217722
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760764119; cv=none; b=bVxFEbXyrnU0g4AbZ3LWs7O8M01ypxNEMKu0bAPZlFiaAz8AkT/4dsTvJSpGnRytSadoRPHvOTjQaMRvwLs4q2TrtkAwzwkeNL4COxrQiB1/CVRcmL9Vk2+7x/trzZ4jDWs7+dvtXgp+QlQsEQlpuLI3FPFXh1DsLQBfWaRKkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760764119; c=relaxed/simple;
	bh=2vwmMK7vKk+2Uqpd3qlXNXx/Ocde/9oWTYy78ZUHsnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IatdawPceyejlfcP8M5bAKqe6tBRnnGGH5yIeejH95AVXvkh25Sk10DCbeYmQ4s61OLlgVacEoIQpmjjQhtsIYHibDxA0rx4HxPdipVgQMvye+W+WVWi7QQQuOeomTStD1fUdXgDv6HvuY7OYgjtfiaxGfLkfuT5E005dBPdYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BaZG2Fg0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I4D3At032646
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 05:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YFRfKHwNm/v/YfwSW1zeQumv
	JtVkPxZgZB7VyLM7YLU=; b=BaZG2Fg0D1KFGuIgHwuLjMlJt5q3iuphyXPi8t5J
	ltXZa/KFT81qf9IiLvx/g08r7OW3KDxvkUJlTRlz7EO2YIgFAVBld2GmyjZg8FKQ
	hzWRYYdPXDVQBw6FKx2FM8lObSZHcyjgVJKiE6hdWntzN5+WPonajEsvqPY01ozx
	i7auYX9+qZcAnLHrLsVFSC80MW8fXL+mhHTZdGQ/25OPGSMLKLMCeCLl9f8RvaNk
	huAwgNL0cMa7zUMfcVdfFCBrak1o4JgksDARLODRU3XVsGt4qcWqSuxCKvS3QyB/
	40+zufNdZML9mMqfAtDQUztzg9vx0vjT7JZOYMMmF86MAw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nf82et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 05:08:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33bb3b235ebso4458745a91.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 22:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760764116; x=1761368916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFRfKHwNm/v/YfwSW1zeQumvJtVkPxZgZB7VyLM7YLU=;
        b=hF1CMPygTRogBOsyqfeSkb/ezl34bUwQtlIkdlD1PdySvX7nPyGrcsXb1wSxVpt64K
         ibh9RYfP/pIkXmiuhJONrTBg+biYDQeYTyBTXNlkXySfwi6GdQSS9XA0sesohj/o7tmV
         WK5hLPXIxQFqVXVp65UoQo+2MEfbeGE8KEyhXKiKIRl2gISeLB2n/QaIDIWhUpA59f1O
         hhKUh2UZIFIIv30NM67AnfZ2w+9EUDo3qUW9aib+zY9wKuhSwKKtBDfrr2/IJoCy9y6z
         vYniZxv2Kj9mAoAJG1m/JPW4hhXbAlM2xVO5PvR8zO1dWy2e2/bf8qrYfgCFTI30qNsv
         1FQg==
X-Forwarded-Encrypted: i=1; AJvYcCVbHObMWiRXESjmJOlttbqhrjTP48nGx/8kepL1JYMQE65vor31qtakEee6LKof+vFR0WjeLFfFXGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUNrNqAmL3j9UAmfZDub3uzpslSdQwkHAWdGoSu15wnPGixsG
	CSzToPp8t4RxS9S1WMYzMBQ0duXKxgCdCBefl/50STzTaH94+FUxipbdhjEYZKLTM622j/5EMBM
	z6EUM67hcflJ1lB8do26k9GGQAM9KGkSkZh1DoHAQbUGrZGUhsb7Up/no2CtP954=
X-Gm-Gg: ASbGncuA0O7IiXSXSTR3so0FE4aqPWqfAW30CeNxGQQHELUZKVdV6H8paeCV6tKfq0Q
	HvXQW1dL/HBtE4RnPKkoZd6TnjMih1BLm4//z7gXxswt0mzDEYRD4lvnVjlc5anBLs5Uzal+d6i
	H40p9Tb5UuscI0R9GnxeEpTodEj9fS/Af5g/02Aj4x338GHqVVE+zf7ra/E75IcyXmGrb61H1mv
	AILXRtz9bMoiZS2DyZw04Yiz6PgO+zz7xZBlXenGrR7+ul6WcLai2i9G67Fcz4M5FFoPhOMn0sQ
	4P/upwa+zwCmc7UPIexjt+goq7pP/70a7qHIA7mm2/r99vBLKSbrGclMEfa7RXJH1X0iM/iY5pH
	a28lYl71ZR0vsOSUvx2fe9JImLMZshx2pbigT/K4JK19YhA==
X-Received: by 2002:a17:90b:4f:b0:330:6c5a:4af4 with SMTP id 98e67ed59e1d1-33bcf93fbd3mr8844243a91.35.1760764116147;
        Fri, 17 Oct 2025 22:08:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnsOvzqMJgakJpAFi012zqe+RaSnCnO9z16vlR2YEX88fpBKQknf9LBuyAwqHvhkV7oX6kWA==
X-Received: by 2002:a17:90b:4f:b0:330:6c5a:4af4 with SMTP id 98e67ed59e1d1-33bcf93fbd3mr8844211a91.35.1760764115714;
        Fri, 17 Oct 2025 22:08:35 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de2f933sm1263261a91.11.2025.10.17.22.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 22:08:35 -0700 (PDT)
Date: Fri, 17 Oct 2025 22:08:33 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 Kaanapali compatible
Message-ID: <aPMg0f+PaT4xscGE@hu-qianyu-lv.qualcomm.com>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
 <20251015-kaanapali-pcie-upstream-v2-2-84fa7ea638a1@oss.qualcomm.com>
 <32a14a2e-f61e-422a-ae77-f60ea44581eb@kernel.org>
 <61b7d2d6-6c53-4934-a2eb-8d92b50e0405@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b7d2d6-6c53-4934-a2eb-8d92b50e0405@kernel.org>
X-Proofpoint-ORIG-GUID: dNkTZ09Y4XjFL9XLLYstF_cAQm3k1U4B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX3yL2NL1PvCQN
 JAFNDNxSK469/W5uoaqo43vH8JNOwKEiUd/fb39TT21ogG80GFYLYY7Ns3Bu3GM7x/KG4ZSnY1t
 AV/2CpPO6VF76qvXGfhT2KlarPP9eToH4yTvlPwoIk47KkzCpir1hb/5gEKFe+ofuv6hkgO+fBs
 ABwFXW1fExdv23AfEZkuDV/o/xtotxY9EqIdeV4tjLnuT5M3zeMt3jbOSvrjwLj7HMyqYmfkTdv
 pTO7yB9lr4zKKJBCg/ODRsFGrcjxOuOHv2SgZ3NYLqjc5xolhQABfGunLwfj3lkatCREuh9Oam7
 7C3TdAOj8i3zajRGWGFAP8DKdxgW5mS3lbvBdz8XUMLTlZ7YjI9uqfeAk45brkBhNdwavirUpgs
 667YNJXi0wjiyMsuf+Jjl2VoWUgqDA==
X-Proofpoint-GUID: dNkTZ09Y4XjFL9XLLYstF_cAQm3k1U4B
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f320d5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=BVIdy884nh2c1f4nCNkA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On Fri, Oct 17, 2025 at 07:00:32AM +0200, Krzysztof Kozlowski wrote:
> On 17/10/2025 06:47, Krzysztof Kozlowski wrote:
> > On 15/10/2025 12:27, Qiang Yu wrote:
> >> Document compatible for the QMP PCIe PHY on Kaanapali platform.
> >>
> >> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > 
> > 
> > Don't mix independent patches from different subsystems into one
> > patchset. You only make it difficult for the maintainers.
> > 
> > Really, really pay attention how your work should present itself to the
> > maintainers.

Ohk, I also mixed phy and controller patches for glymur, will note this.

- Qiang Yu
> > 
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> And please adjust and rebase on top of patch below:
> 20251017045919.34599-2-krzysztof.kozlowski@linaro.org
> 
> Best regards,
> Krzysztof

