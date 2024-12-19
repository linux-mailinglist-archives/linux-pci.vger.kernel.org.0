Return-Path: <linux-pci+bounces-18824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDDA9F8713
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 22:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239E316F301
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851F111A8;
	Thu, 19 Dec 2024 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="StYEXxLF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583219DF6A
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644095; cv=none; b=OlZqTVpmOQEi5boWBKD5fbkBvlEf+Z5hVb7KaXVUYeATNkvNXgN7S90jnRcZeJQhgR5DbNHXaA19fti1VsPBs+OA6gqL42f0iDG/6HqQbJ1Cm3jhjp05C9x5n07xEuCSmBDtNQqM3Vj5tXxrKfNbd16chZ9V2QpwjLBNXUhyFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644095; c=relaxed/simple;
	bh=EDwfbnFQhamTwYpt13p2WAt2bfbKSJIxLOy57KvYyn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8ksqBYO97uNL/0L+4B8+IUM9beqRaqQgZ3VY3stNhwyiZ1pSYSemsHLqQehObCRnnvSl3aIMfTD9NXgIqd6pUJBSnqiaQQO2pUU0G5ZrpZDtDHCHd1tevmuu+NXCcCfeiLOmtzSsG93/L0prELb4kpOHHhM7baJ1g4lMXlRZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=StYEXxLF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJLDc4g017296
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 21:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tnnxDdh3Ddg+joVXVofvYsyNFGq/oIrBrCCuqTFAbSA=; b=StYEXxLFeccHNWFy
	y5+0OMtPgPNPInYzVqSdUq62t7Cg1MQwNDlTsihdmh9OVmxukCtyrNyTQpl7uRcX
	ofu64Sbyh5Eka7Rixcsevc8RGjrVGQ5r7zhxz9ocf40WPNof+JoDwj14y5MLww/7
	xG3U4/uHnGcUrhWYzfaLxojEZht77NcvROjaETObLQTnH5jIMXvmuwZEdHkqSI0k
	w9ujDZzOQQ2c1XVHIq6lRscI4vtwwEe7uCgNekXf7l+EUqrovO/3OIv9UTceTJsY
	RxP+L7JNhE2KOqN86mq6sBGFAz7o+c9VSq3uf15OURiP9PXxDG3xbVGndo6O27H0
	znAnPA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mu7g01u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 21:34:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4679fb949e8so3006071cf.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 13:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734644092; x=1735248892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnnxDdh3Ddg+joVXVofvYsyNFGq/oIrBrCCuqTFAbSA=;
        b=epIfRomfkmMR/zkf2VWs16sJ9n2OFP8XkMKmdio5vOsKNEyqSsasVOTWMy1cfJTjLT
         ZQ2aGJf7enc+GV7Gt0SypiLzGxWeI/0qBILufBC7ihWTD/xcNFOcKyaIsyGwdSi2GCeH
         NHsCPSqvsIioZHQaLLaDvoD/3U5aKYnm1y+W7TKmWdDM+SFrBkPiRpg/uyqaKeKmc7hX
         cRyCF/+uWhVzIe9XID6iX9zTlMfAVrFbuj6XB6xOz5rWmy6ciyhMNBW2BtGlBDPQucY5
         R2XFhf9FwLq25WjZNVKfM8zTAMXr5sU1bXEXGD64Hs/Q9VP46ZOGuco6UKOwF1DyBw7q
         xzNA==
X-Forwarded-Encrypted: i=1; AJvYcCUVcLKie99ZGJ+uEg/9/WG14J7fI7Siv7PoSbHwrFuSrenlGvB1+a9mVQxYGbYvNojjI1Mv02esHPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPqT4/9DbhSOAN8SjGnNwCMyBQvs1xDPo7UYKSvde+owOFMLUe
	zQvLLodZv5yNp33gNyV3PAXcunr5HlQj2h2RWaPv9hywBPYWv/p6wKCTHBRnaIRpkhszHkebRAX
	XWIB+XjnJdGGnfZ5MrEgWgv+T+s8+JZWWoNuN5xqGMsnl6iktROty74KQMJY=
X-Gm-Gg: ASbGnct8PDYmwQ8h42e9BQz7ccQVtQok6VBar4p2Mc95vcMGi+XYpvdlY7L8y74y0yj
	QJK+Qt7xXUun6jhy+tqskyyM6NsIA660G37ibHpH1hzmU5RrjpCmBuILxeddhuq2WPrmiWHcUzL
	5K7MOp9dXXwKNf4LBkRKGaARMmEHwVEqkRd0U9oumjL5b+P8NJwsLEnMO1mw8V4DhbpOLTRO2co
	We7GjGL/B+SqZ3DlmIibXYkcTW0KlT9Au5uw7RtKrxou1LzHj8fbuHcUdTqhnQ/0QfSqxizTzPN
	hjWSsTa+qRQGQeWxJI08KDp9uenUywwDRvk=
X-Received: by 2002:a05:622a:391:b0:467:6bbf:c1ab with SMTP id d75a77b69052e-46a4a8b605amr3438081cf.3.1734644091815;
        Thu, 19 Dec 2024 13:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVjawbA10Ym60gE7irfkFrd/QhB0O9kTyh4GjAE2jzgSGUi1LyX7S4W/jTHrm9J8Pl6KGrUA==
X-Received: by 2002:a05:622a:391:b0:467:6bbf:c1ab with SMTP id d75a77b69052e-46a4a8b605amr3437771cf.3.1734644091398;
        Thu, 19 Dec 2024 13:34:51 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a6ddsm1006047a12.3.2024.12.19.13.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 13:34:50 -0800 (PST)
Message-ID: <a33c3da8-0f38-4194-9eb5-249cf6848928@oss.qualcomm.com>
Date: Thu, 19 Dec 2024 22:34:46 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: ipq5332-rdp441: Enable PCIe phys
 and controllers
To: Varadarajan Narayanan <quic_varada@quicinc.com>, bhelgaas@google.com,
        lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, p.zabel@pengutronix.de,
        quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_srichara@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: Praveenkumar I <quic_ipkumar@quicinc.com>
References: <20241217100359.4017214-1-quic_varada@quicinc.com>
 <20241217100359.4017214-6-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241217100359.4017214-6-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GUFfyyahn9DZKXncH6qq1cKuDXKFFUnh
X-Proofpoint-GUID: GUFfyyahn9DZKXncH6qq1cKuDXKFFUnh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=993
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190171

On 17.12.2024 11:03 AM, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Enable the PCIe controller and PHY nodes for RDP 441.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Reorder nodes alphabetically
>     Fix commit subject
> ---
>  arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts | 74 +++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> index 846413817e9a..2be23827b481 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> @@ -32,6 +32,32 @@ &sdhc {
>  	status = "okay";
>  };
>  
> +&pcie0_phy {
> +	status = "okay";
> +};
> +
> +&pcie0 {

Node names with suffixes sort below node names without suffixes

Python's PartialEq for strings works well for determining this

>>> 'pcie0_phy' < 'pcie0'
False

>>> 'a' < 'b'
True

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_default>;

Please follow this order:

property-n
property-names

> +
> +	perst-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
> +	status = "okay";

And keep a newline before status

Konrad

