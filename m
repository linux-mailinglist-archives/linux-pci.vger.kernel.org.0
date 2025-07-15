Return-Path: <linux-pci+bounces-32141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAE5B05733
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 11:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A453AAF3C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 09:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E77226D4D4;
	Tue, 15 Jul 2025 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m5YS2BWE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0628213E7A
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573295; cv=none; b=cunofXBi3g4nkFxN1Wy0kYa7FPgZxfI08hEyW2q0K2ZvttwnZ8635Iax8FLdRsuNa0/NqUnW323WRcwy5p7ebjAdkLoxXjlGcAZ8JubKMzsYhKqFDAn4XljrE+u6iSob6L4aOeLc6TYqS8Cq6uePve78My+Sej2N0W+/dyQX2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573295; c=relaxed/simple;
	bh=6OVUx+9AwmAwTG1I+KdQVdAktmQDgN5EP4C7NezIitY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyuRaSGmUPPll0t/EkEF3lmxxTT88uPJUmHoBCTHuce8PjLZhrdwkijTrfb0VSVjN6bxtCUSDQsqtNd5NHQvsJ7ujUrLgOCvAtRzGNDH1MEX3sRE46CoVYhCFrLLAkebGIkklGb/qwKDn9HYFmHiSo5Rde9B0mLLWNUB+TZEUwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m5YS2BWE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7kjbl028415
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 09:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ix9VuDZeEsjg3KAly3eDP764kZgW3cJT4+AkWYQ4FOg=; b=m5YS2BWEXwTUWNzM
	Ny0qjTcqmh7VMk3IvJ/ykNqT/s22qqoWpXtCfhf5miRg4FVlyl0mUDLeZ9TwhV1s
	xlZzwwbxrY7uIayCVQFvkiVbr2k6q4eUARnUz1iej7Qkt8CXRgwywGRUTf7Gdzsj
	m/Vn2gC0R+I6W54GG7HW2gACmSqqEQnKRzsAudngJqBDDl/muh7QtvQ+WVo/qV+r
	9zlGi4ijehAqP0jAv8h0qy49CZFmVd0y16Hmu+3S62TZx5sLnBmFxR3ewPaWtXGx
	ogXcRleHvisQLl/tlzaQKqi2n8dxZlL2p7qhJtCjcXPhgt3/1R/MS+SLe+gFz7No
	yi8Aqg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut7mh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 09:54:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e33e133f42so4854385a.3
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 02:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573292; x=1753178092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ix9VuDZeEsjg3KAly3eDP764kZgW3cJT4+AkWYQ4FOg=;
        b=ozEArgTTHqlz89KaHwkbYNjyC40bpqF9rn0vRjVLs7ug3HEQvoOTLRTvviDEATMD/J
         clGdU8qSDH/ZCzFTOQvpNybhSUAQFqVNtWAzSc1x8CnNY82qm222ArpCwRnAEOw7fj4h
         uQXViJ7mNQgHsDXUN7PKVoQVd3Iw43D0qlQQJ+GrXuC6oONMAk7CzGW4V6L1AVCk4pYN
         B0I5Az+93SLpu1ndpItCLuSzBdsQjklROtPb35sgFZHbmAAqiH7WC+/aRN7q+55A1TUO
         Vu0eFVSwUG8Mby5XfafKZgkaWGBrbOlbyjaZPdKytA/wGYyhNhB+aXkrGRrttVtfiMx8
         iTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb7JbSdYwDO37Cvmm8YR5vvkKXCxdXzcelS61K9v0hH3JPGxdnWSwkYLBPb7XBC1wi9M379qD6j/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiv3ozJOmcQzvM77ZpMTS1sqRbvteshj+fTcAiXIV2GuFLjdWJ
	BttJb3d5k+7T+eyaBR2xX4R1nukwJdtfa36Qi6AgNBas/Gdb9N3nuTMiQj3j6tsjMPQ0kw0hm1l
	6imPc+1/RRCYOiVOXOvy3Z5OesxmD3rIfm3EhDLfrjNPUqpRrsFd8AZxGYRixgxI=
X-Gm-Gg: ASbGncvgMZPRiI1mwAusG9cbaHJ75QzAnH67uWBEbMtBRgexhCDJQhEfIP7nZh5xT5a
	+/cpD7zJl/Grdad+ktBX+NN3h3xsoGC01abSK8C1ldNtRx7wMW8TyV62uv28Ic8+sjz/dEgvW9J
	SAsnhxHjYWVgCGvncs9Z+rF2jJB3ExQ6NJQvLmQGxAoJNiNX6kMa8Ytpw+6fUNHSVsBHJQL/PLu
	TxgA0u8Y8SCavjlTWd85rf8/WkZLq0ppP6bqJ09ysGYziqqRm2lG8jKJcPP79Yy1rv5wVgojd5y
	q7vgcVEnx2rUFwf13SCpBrxQRpyAnvnn2e81ySlU1SaiVlwx1uyCzyb6g2i9Lsu55vyhjxB33BS
	pTArvvLKaUHFuy8Qp8PSz
X-Received: by 2002:a05:620a:2903:b0:7e3:2c0d:dbf8 with SMTP id af79cd13be357-7e33c6fd95dmr51798885a.2.1752573291756;
        Tue, 15 Jul 2025 02:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDVkaPY/EUoM13O4zdHRmjA+XKRxdgOCmfN0kxQpZ1M/8LP2Xug82sWyuGii3UGqvnwGDvuA==
X-Received: by 2002:a05:620a:2903:b0:7e3:2c0d:dbf8 with SMTP id af79cd13be357-7e33c6fd95dmr51797185a.2.1752573291128;
        Tue, 15 Jul 2025 02:54:51 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df4dasm977493966b.157.2025.07.15.02.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:54:50 -0700 (PDT)
Message-ID: <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 11:54:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=6876256c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=u1rEIhXAyoO4lQmzz6IA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: _nSwaWhELwX1bK4z0hDMKK9cNvQfyMS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4OSBTYWx0ZWRfX4BbiIQAi4qme
 dwcSSElgK7JJBO+b4o0NdQGPt2fyIq6b3feCZWhFkotAvxgVS/YUOsyusnqmIxw9J6Qf2hQhhN/
 5F5087j188Wr0O4I85aTh2HhfrubAeSpUlfqTPc4ypyWHZwRKR30HzREm6BsWcHg4/oRM0el/6g
 rOllkKZe6Y5EqxU6rbNrWWnwRFuV3BxyfOgFrKUNnhZsmbJI/onhtfQjVX3fl1PvRt7dZugoqE4
 Uwikh1K4A/EKk9N36DrAGEVnoLFBM3+hjm9zzSVRZbDDSJ+pn++EK2R+EkvnXetegRoCV6NF13B
 G40iZhc7rY7nq++NfJ1rBw74xh3RPykgpAn4LTEEsEAGsXSl/zrSkKrdBjrI/IlM8Ozg0m6X7tq
 Pua7t8W0hAfpNS+/H63Y4LChCCH8Zknw6ziulYnf5s+vgGhD+Af7u5bfbw8wAgekeaYfgz17
X-Proofpoint-ORIG-GUID: _nSwaWhELwX1bK4z0hDMKK9cNvQfyMS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=996 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150089

On 7/14/25 8:01 PM, Manivannan Sadhasivam wrote:
> It allows us to group all the settings that need to be done when a PCI
> device is attached to the bus in a single place.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b4993642ed90915299e825e47d282b8175a78346..b364977d78a2c659f65f0f12ce4274601d20eaa6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1616,8 +1616,6 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>  		pci_lock_rescan_remove();
>  		pci_rescan_bus(pp->bridge->bus);
>  		pci_unlock_rescan_remove();
> -
> -		qcom_pcie_icc_opp_update(pcie);
>  	} else {
>  		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
>  			      status);
> @@ -1765,6 +1763,7 @@ static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
>  	switch (action) {
>  	case BUS_NOTIFY_BIND_DRIVER:
>  		qcom_pcie_enable_aspm(pdev);
> +		qcom_pcie_icc_opp_update(pcie);

So I assume that we're not exactly going to do much with the device if
there isn't a driver for it, but I have concerns that since the link
would already be established(?), the icc vote may be too low, especially
if the user uses something funky like UIO

Konrad

