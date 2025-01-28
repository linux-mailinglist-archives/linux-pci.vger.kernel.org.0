Return-Path: <linux-pci+bounces-20452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAC0A209D4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 12:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F1D163CAE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D15019FA8D;
	Tue, 28 Jan 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xwnbn4e2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E51A00F2
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738064380; cv=none; b=RP9O0w0W6tYuodxXnT3LCip8QyV1B771L4LK776W3uMe1QGhQM4bupj6aC9Ztgu64XdSSu2pnsLLLywptJ2UyDi2cQhx7KYTfE/FBPN1YgXkputxn44xw5U+Kg7LSQpS8UFH65t/fJme3+UmPp5+mg7p4owEIssD7z3DYInMNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738064380; c=relaxed/simple;
	bh=cYLJ80PwLEuMleEF7sdQCbPqBtjyrB1AENlTlmkEFCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBfxYJOMI+S1gfj19k+oV0JLfN6dNvZMFUWFuLnFKrtKZOre/UjtFs4Iy3pjGWPt9gq+UrtPWOyTMevUOXPNlMWln9U0YkAVjMruYnNf4G0bw0dVvNCBZlV0nYq9eP8EWYRMbCjhUrmoyN220fTxN8sq/+qmYudaeZ/FNFdQjWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xwnbn4e2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S63Zt3011404
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 11:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c8G+n3ZngrU2GKCknxdXhyFizTUlkoDsJmcONKoxIhY=; b=Xwnbn4e2luTk7x/a
	xLMSwjOhT2k9FqYAWvyT0HjbWfJ/WzowulFkLpE94iVJD4q8JWC4x2Nvd2b3Iyfv
	iKCWgNOXh9+UBEF5KWLNlSsfmmkooTtRNBOKIr+mMRFqXeBaFmrsNA9hrR1+cnQd
	0TL7PQG3Jc9jhiscXzyhXRPNC6rQ0KzZ8AhZ7h/dXzZGMczoUqfuz+enZJ3yDMnn
	owfAIfirs6yNCzVyVrycIqnTKEgB0z/6+e+qbUM+i9xjVsqYcorWts/l6dXlOUzQ
	lxBEBajoWHjcCvMxjwxZOet9lZnOkfps9vyC0cH2zEfVNj7gqKm3zUb3XENLVhZ7
	vwqHCA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44esmw8rsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 11:39:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b704c982eeso133205585a.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 03:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738064376; x=1738669176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8G+n3ZngrU2GKCknxdXhyFizTUlkoDsJmcONKoxIhY=;
        b=lg8a8ingV0cC1/qGNr4kIQhec4wCbGPjCe77EJJaib+7F2aLoSNwCd+807VriPPfQE
         FQDMmc5zY61Qf+ZmJukIqH6+9rKTqG8nKGc8KYJT1Sauu/2rLyKnJMHbdzIqLhAs4QBp
         HuG7I6nXD1o6CBeA/nbEEbpUb8kZblQMxSfytE/B6tQxPA/kamDdrNBZSxsPj7kEyp35
         YweHcoelyzTiLjfh+UWOvzkuUt3VrFO/BAwb7wdoD8x5lVDujH8L8QhiVJiEhg8PCGsd
         kXB1TavjF9iya6iVpPqGYu/C6/zveObRwlVateT0oWOC/CLQfkgk4BD1mFDQ0vYkqVtS
         wWug==
X-Forwarded-Encrypted: i=1; AJvYcCX2Uhls3sRHBZ4CKUmcgptUx0zRZeXCeXHLT40gFtc69R5FaFUENHy/EfP6WlLQashfX6LtyEggr8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMi7cQDMkxxffFi2mi6Kk90DiyPN9wduGVlxQktW3gkdavM93
	AfvPv/A7KxwLGyc9cKEDdS4pwW+yqsAwNKMXcslbLOMVSonbtjZc+82Mz6deG20UrtYZpq+ewnd
	bThEnBASn4osSiJMSATTPGKYy0l2afJA/vltm80Q0/eQGy0/9J9/uO69y1NYksvESu7s=
X-Gm-Gg: ASbGncuECKYQ9jBsDGSMoK80HHYhySvhaawZjNvluJmLVycYIh6qzvX5vNPhwHfSpJz
	XrPxiQ7DWQtKZR3jlAfnAb5MtA+CUaVnfDsCRHxfI1BcXjepHYBpeFyc6RQyO5IUedqA0S5+24Z
	BA0JBbrwbT5NVUNbAkBPr6y8muQYRWm+SvuVcUTloUMz9NKYDWuP79KloNqnIGYvsW53H8LAJhV
	HG8mbrwjg5puEB7dH0iFe79lOR+MIlhfBMDGBC+IqbdYXEu0tTMxaRE50bkVf9Cc/Zmrg7PnUkS
	VmlF61e3qo7QrCxY91gxKkJjFBVoOdybnKtaeGImJ5x2hXcRb/c4ukKEFmE=
X-Received: by 2002:a05:620a:25c9:b0:7a9:bf88:7d9a with SMTP id af79cd13be357-7be8b35df7fmr1577081585a.10.1738064375906;
        Tue, 28 Jan 2025 03:39:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEl/9vihPrePN5++74ggHEkvKcwadtpWp9DHg/uRR9be1hDo37w4XNpR0496AEEaGNUPkeNA==
X-Received: by 2002:a05:620a:25c9:b0:7a9:bf88:7d9a with SMTP id af79cd13be357-7be8b35df7fmr1577079785a.10.1738064375562;
        Tue, 28 Jan 2025 03:39:35 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18619265sm7020915a12.7.2025.01.28.03.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 03:39:35 -0800 (PST)
Message-ID: <3e92c8e2-7745-4205-8a48-5ef783b098a2@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 12:39:31 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: ipq5424: Enable PCIe PHYs and
 controllers
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
 <20250125035920.2651972-5-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250125035920.2651972-5-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DDizcP1YorVsZFnTEH_PImI-Fgrgh3O1
X-Proofpoint-GUID: DDizcP1YorVsZFnTEH_PImI-Fgrgh3O1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501280090

On 25.01.2025 4:59 AM, Manikanta Mylavarapu wrote:
> Enable the PCIe controller and PHY nodes corresponding to RDP466.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V3:
> 	- No change.
> 
>  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 41 ++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> index b6e4bb3328b3..73e6b38ecc26 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> @@ -53,6 +53,30 @@ &dwc_1 {
>  	dr_mode = "host";
>  };
>  
> +&pcie2 {
> +	pinctrl-0 = <&pcie2_default_state>;
> +	pinctrl-names = "default";
> +
> +	perst-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
> +	status = "okay";

Please add a new line before 'status'

> +};
> +
> +&pcie2_phy {
> +	status = "okay";
> +};
> +
> +&pcie3 {
> +	pinctrl-0 = <&pcie3_default_state>;
> +	pinctrl-names = "default";
> +
> +	perst-gpios = <&tlmm 34 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&pcie3_phy {
> +	status = "okay";
> +};
> +
>  &qusb_phy_0 {
>  	vdd-supply = <&vreg_misc_0p925>;
>  	vdda-pll-supply = <&vreg_misc_1p8>;
> @@ -147,6 +171,22 @@ data-pins {
>  			bias-pull-up;
>  		};
>  	};
> +
> +	pcie2_default_state: pcie2-default-state {
> +		pins = "gpio31";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +		output-low;
> +	};
> +
> +	pcie3_default_state: pcie3-default-state {
> +		pins = "gpio34";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +		output-low;

The GPIO APIs are in control of in/out state instead, please remove the
last property from both entries

Konrad

