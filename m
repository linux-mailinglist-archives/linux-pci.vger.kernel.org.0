Return-Path: <linux-pci+bounces-24358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E9A6BCA7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 15:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5D73AAFE4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B500192584;
	Fri, 21 Mar 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="onTNuDhC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E218A6A7
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566272; cv=none; b=fc0SZfX07uyHIqqblgQTBagJoX42X38DyAQY9FSl36CjNRPGvRRG2N2GHmv9sBH2YqlDdhu1r9R9ccispuR9Ox4mjyMNLN9j1xB/rkLUnf539jGxyl435hygmB121+ykJdCF7GH2hhtUcQOMaubD/xKy+3qQyFNSZYljks5PC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566272; c=relaxed/simple;
	bh=yJomqzVYF7rE9qNwzqjDuJ7IjnKiei1NhFJrdHeLxHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4JJatWYAPNwTSU3VQYcm7xK8emfuLH62hlpJknOrp2WtgrqYh5A6MkycvfglYhvrKL89pJ0/MSZos38bl6HUxTmuJYajOLD9L2Jgz/iIuGLdb7B1LIosN27U0nLTkEcizqnobbeXBDhsPSqplI0TPs31bxmYWmbXYiFvvphHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=onTNuDhC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LCSHM6025701
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 14:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=enO7l0H3hE0QmwcHT71cY/s3
	vWok3ap99CzatKJPkdU=; b=onTNuDhCNCTfXSrPOBUcLvp3f5OeALfpEsuhqHW9
	RCv52LkJ7SN2KAleenq0acOkU/xJgABrrAcTcYmL1A/0ZTF2KUurtJCKAZW5eVdM
	0YMevWr3UTANvyorpyF+QXyOX0iim7CzFO1M73VaDIQ7rL7jz3YMovWVpuK4H0nC
	ZV1yZU5fizpEfF5OgZUo8wtW7i5GOOWqAEt1LRqApZnduWNL/70Zs+5Yqt9OwAE6
	KdR8TJ/whDUmPRDaqt7Zz4qG6NO0h0cH5dVmBUMto9EDn7kMAuHbm1Y4xca2Bexz
	wxfWeKUra2VuxsoY4LnJWphMnIpWAoEDJc4xxwK4Ijn6YA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h854g9hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 14:11:10 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8a04e1f91so50898306d6.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 07:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566269; x=1743171069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enO7l0H3hE0QmwcHT71cY/s3vWok3ap99CzatKJPkdU=;
        b=jzDxpwE2x4bmzOPwttwnsu2I6Ol5SNgVMBgKZPViEulnuRh020v48qSR222D9hquaU
         n4oXINPEwyBPFzNQT7tuYIPX9O/baKUTYEHs/ayh1KFRVWQIvR+TUsBYuHc97Dujoq6y
         xQuFcplETahub5gnWt0uKuqXvBWvWseYLIxt+WSeJ+2D4xLY2LvNxF8tE/AzFAA23uMC
         vTcaP8YwMFvh2RZuWLUduu/DvDwcdXYHv+YR1bIuTir79G437yCyZ8GvZm0kFOk+FTSr
         SBS7g05XKAWFzAtE2C3jtpmb+T9nMuzliYuExDvd10q7Opl/Xsqw/Nj/0b8Omxpt3yHU
         4uIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh/b5k+jqD5PRvWId53fj7Di2f5f/Eht7Jn3IszWDRMhYxIANd+FI3bGG7kOINqobeUYRZVP22ONk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa94nQXQtcaqJpqm9MeLCk6E2opRkEZ+drkHQdBoJPNTsRNCmf
	0IveYX6MJsU8Vgz+EmXJSIBYJWXK8EiOfUyJkw3vwOKIbmzT3gS3NpJo8sA91QUAWOewQCyTyn+
	CBbDlzAvsOBgMEMGofmd1HDi66USmYBWTUIX7n1qGwqZpglTcWHqL6PoNFis=
X-Gm-Gg: ASbGncv5TZ7PwicPgJbvu5WzNRS5u7j+boNLSq65aIkP1TvJeoGNmBkum/XeH6Q6kGK
	+UjNML+etbD6/IilWykizo9sHilzJVqd0rHCze7UTaovJbKo8JfGKcShSWppzePK9B6lF+abvt2
	wGU1wAhLH9NoGQFNQ0HpwZAPm2mv8ivNLflM+DnMpSjsm8//giht309CyFSplRTAGjMkdh2sbY2
	3qEeZkpkefx62ImxRujdMoL9RvxCQct8dpdPPTOy5RVK07EuqBzo92LHR8yS5Klh35FA6Vdlupv
	g2oYXi/ZD9PbKPUojZMdxexIEJARTDn9m9yIQ2/jX3HMigykVpyBNCSHvTcuuRJOVRdwyQmTerg
	/Sks=
X-Received: by 2002:a05:6214:248e:b0:6e6:6c18:3ab7 with SMTP id 6a1803df08f44-6eb3f323055mr49267946d6.27.1742566268761;
        Fri, 21 Mar 2025 07:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeivZrTcegaXr9Av/yzGkp+WEb5kB2nx0cZWW158gssFezgkz/WGmpsLNHyxLHrjlqxKgOeg==
X-Received: by 2002:a05:6214:248e:b0:6e6:6c18:3ab7 with SMTP id 6a1803df08f44-6eb3f323055mr49260706d6.27.1742566260223;
        Fri, 21 Mar 2025 07:11:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad65037bfsm191161e87.183.2025.03.21.07.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:10:58 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:10:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        20250317100029.881286-2-quic_varada@quicinc.com,
        Sricharan R <quic_srichara@quicinc.com>
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Message-ID: <6szijrbeubobgkiccxvs2povplcedacnofpqtlsnz2se24yjcs@3g2nry5nk7dc>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-5-b7d659a76205@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-ipq5018-pcie-v6-5-b7d659a76205@outlook.com>
X-Proofpoint-ORIG-GUID: pbV5E6cpr5ubK_E5he4jzXCb40LlKMjd
X-Authority-Analysis: v=2.4 cv=ZtHtK87G c=1 sm=1 tr=0 ts=67dd737e cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=IwAU_dWaxX3plY3JidMA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pbV5E6cpr5ubK_E5he4jzXCb40LlKMjd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=344 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210103

On Fri, Mar 21, 2025 at 04:14:43PM +0400, George Moussalem via B4 Relay wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add phy and controller nodes for a 2-lane Gen2 and
> a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
> one global interrupt.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 234 +++++++++++++++++++++++++++++++++-
>  1 file changed, 232 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

