Return-Path: <linux-pci+bounces-26788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4849A9D385
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 22:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33342179265
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 20:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBDA223DD0;
	Fri, 25 Apr 2025 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TNgYJy8Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F0221F2A
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614326; cv=none; b=QWRsV4FYuLTgD5BH3vqLL0NtLRhDT8eh+UcOVf6MSY9EjlA/IHT2Sh0SyUA9DRTZigjipi3AedUCx933lEgoc9Ci7aQZHBBxmZy5JOxhFf7s/mwe8HKADCWLRXDy63e58BNTXVQL7s4goXN62PdS0s4D37ydiHwJPkTeV5lgmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614326; c=relaxed/simple;
	bh=kAToM2XUXvvC5laIERANy/QDIAazwPQuoIadpAVkohQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LptaqAO8ylKanqSC9DhNgWWZOnk26TeE0MDayIoh/d70aPSV8JEPqaFAc46LsCjqDFCBecDKuXuoJLSTOPC6HXvdViLp00DxkImNB5I0IuUcNfoCwsV2Ix2cRSLFDLOpVJJPjZV9j7D3XXyjo+clWZnGAK0fSz8/I0Xq4yaL4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TNgYJy8Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGJwWs032080
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 20:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	khW+OjIu3QFmUYnH4/qhhaS7xRKHn2LSxx6Dexoku1Q=; b=TNgYJy8YLl6+dENP
	8ww9i+7XwieZ6kWucsJqjvRHXJPliQhHagU1H74m1RGdoSQLbLJEYkt50EA0s7aq
	lgubZPZe5PrKt0qvh7h/G8wwL/zJUa0WIJmcdug5dD6Bg+saz/f1Og2LngVJV0Nu
	iFTCvk/YFMcMSobQcsyYapjWNXkf2Xw547VIyCxTFicSeLbjIKF2pZQWfyBCZkO7
	32poQt/HJQIhLJnkMer/vUfno0zw4cUno0vCP904TTBHVErCSwr2AbwRaOxQLXs5
	+fw4MRlxchyg1ZGPbrmoEDsiVDU6uT4iLWqnSQDEigF8OYiW9oRRg+BPAOaouPb1
	ZDU6DA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1a4m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 20:52:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8fb83e15fso6515436d6.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 13:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745614322; x=1746219122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khW+OjIu3QFmUYnH4/qhhaS7xRKHn2LSxx6Dexoku1Q=;
        b=Gcpy6Nwnw52X7tjOo1608qgx/XuMjbQ0lFgFqVB4qFWt4iqi+iZ3BkUC9rQygMBXLR
         X8+HXG9iWfilP4RlsZgyghiQdMI2s7BGhv7G7bAeVNBcopHeTsnRLzl+1VDmwEEcgZfB
         yxfi4dBVMGt9DHXl/oCEe6yBiFA5t1DYZ4SkX2KshvFTEjDiEcm4SNr1CmKY24bAmBC8
         FQvaFVHmNWUcqojH5yvaUWF5ZotAAOPCEsftdauISyUzXxP1Bg9nztDX1SJBojQVsv39
         2xopBYTPUTnvP6OQB3a0dU0ZZMNfuKW4Z0vjxoHGk6RtB1eFQ6K4Zlvak6EntzhCkhVZ
         ljHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEaD8kxSAzn3+f6e1OfxwpE4XTMH4apt+s+q3/bRh3o8447MWHx9AMCOD7XT6b6om7IDi2Rc++w3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOIJd0o4gQ09ni5MStu3HhygjhfnW70tecO8v5MArgMZStCMC
	l3dn0nIPek7/Ghx9PG454gANU+faLZEG4shMl3ebbZEdxfnZh5Wj4Yog5xmyrmzjLN1t8K0LNqz
	EiCYjxwXlxnIBgBs/19UoeHIdXqBj1swg3visJcmbqfPmM/gb93LJdIUkkuE=
X-Gm-Gg: ASbGncsTNg1TSgPywsL6YtcBnVsMkybcxI50wTNR2Mly548In2vr74wjapW2M340Ubw
	NILZZwAdUJ2Z5IkyV9vMkm+8bs+SxrMILAwUMoECtY9lJntnjeKC+LopkThsqCkXouEloJulteH
	NcqvzlQc/T5Sc2lPZi7XJ8TChO7ysJJdEvdFiUFxqV9YBU3YkmDWfUTMEDQv8Ilbwqijjtht7vU
	FMv7NpYTy+RsQBlLzeJrrzKD1U773UpkleZnVZtwg2JJZiWrpf5Qla8knCC3m0nZ2HOZig9ymlM
	VSAyBfLFP/m0nbXusqnJT6tDTDH7mgayW9lYpYd6zNrz8LTXSgAnYYGITUsKq9ZJvkU=
X-Received: by 2002:a05:620a:1a04:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7c9607ce29bmr234168485a.14.1745614322383;
        Fri, 25 Apr 2025 13:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELNiJdwRrt+X3+ZmBmj8ToCx5SguQhymg571V2ufzv8cclkQ1COqWoTRaO72k8xjo3W2vT0Q==
X-Received: by 2002:a05:620a:1a04:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7c9607ce29bmr234165185a.14.1745614321971;
        Fri, 25 Apr 2025 13:52:01 -0700 (PDT)
Received: from [192.168.65.156] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecfa354sm185152266b.120.2025.04.25.13.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 13:52:01 -0700 (PDT)
Message-ID: <04201672-3d7c-4994-bdbd-959ec7a697a2@oss.qualcomm.com>
Date: Fri, 25 Apr 2025 22:51:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] arm64: dts: qcom: ipq5018: Add PCIe related nodes
To: george.moussalem@outlook.com, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        20250317100029.881286-1-quic_varada@quicinc.com,
        20250317100029.881286-2-quic_varada@quicinc.com,
        Sricharan R <quic_srichara@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250425-ipq5018-pcie-v8-0-03ee75c776dc@outlook.com>
 <20250425-ipq5018-pcie-v8-1-03ee75c776dc@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250425-ipq5018-pcie-v8-1-03ee75c776dc@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HNqtRYZvsohr84kJTWbBXHhXz4ZQ1X-i
X-Authority-Analysis: v=2.4 cv=OY6YDgTY c=1 sm=1 tr=0 ts=680bf5f3 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=UqCG9HQmAAAA:8
 a=g69xjaZfg-qW7mxf-08A:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HNqtRYZvsohr84kJTWbBXHhXz4ZQ1X-i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDE1MCBTYWx0ZWRfX5SYjio2Fzpmj 1yBwvLZEAZDS82FmPxEjFYMn6a73f8cseKZjoVUq9Hz0NWxMQJ0Y+wiMwPIS7ADVi0XcQIkRd3N kEViSGnWRcPlx6n5nD3k0YEUMihqlK3pWmY+AQyql2/x3z+lKRdfybI5cOH+ADRDsPHRQm2Emjy
 r5GWuUI2dKRES9H4J3R3Uav3u9AKIrJR1PZroe5J2ekO7Au6dTgM5XXI7exoW/FNDf1W2tYIyKk IvZHO61EOYy7uxBCp1Yq4YDfdJVPoDp9b6om8zmkWzaIXh1YuLrDz6DgOAY+JRFUkPSzC94hDjj g3JIS5myfw8ICEVh+2IQ4fhfE5sz05Pazn8mSJ4bxd4D79TIULd3r/SnP4vFnLkdhzNNfhJsHzE
 jCcvOvcIaA8Psanjd8+efjKhe6F14xp2nWdJGQsWU3mGHlGHEmhkljb3K8d+gEH+bm1CSgUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=746 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250150

On 4/25/25 2:00 PM, George Moussalem via B4 Relay wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add phy and controller nodes for a 2-lane Gen2 and
> a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
> one global interrupt.
> 
> NOTE: the PCIe controller supports gen3, yet the phy is limited to gen2.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 246 +++++++++++++++++++++++++++++++++-
>  1 file changed, 244 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 8914f2ef0bc47fda243b19174f77ce73fc10757d..917c6eb7c227e405e9216125cff15551f57839a5 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -147,6 +147,40 @@ usbphy0: phy@5b000 {
>  			status = "disabled";
>  		};
>  
> +		pcie1_phy: phy@7e000{

"@7e000 {"

[...]

> +		pcie0_phy: phy@86000{

ditto

[...]

> +
> +			/*
> +			 * While the PCIe controller supports gen3,
> +			 * the phy is limited to gen2. Hence, limit
> +			 * the link speed to gen2.
> +			 */

/* The controller supports Gen3, but the connected PHY is only Gen2-capable */

and it nicely fits into 1 line!

With that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

