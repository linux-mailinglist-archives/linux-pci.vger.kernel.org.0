Return-Path: <linux-pci+bounces-17789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E49E5C57
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 17:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF65D2831B8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A0321C173;
	Thu,  5 Dec 2024 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UsPhLu6r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697320C468
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417907; cv=none; b=DZVUFZA+FVdMpy9ef25X5qHR79bcTG+/730MQfukS/q6xMQmTfAkV8D582K8uB+7Qp1iVPtDuGCY7WD0eMBhnFRtatFuQSnu4VAPqt/x7bn6rYu9dnO/hGEcE3fJxY3IO17X+C7Q4SiWXfHHpxpsu3/MB5cSpqK4A+3E1ehMn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417907; c=relaxed/simple;
	bh=inCbXkwUzPcSLvpsaPPDZfCM12NcD0fYXXxPtBqpNnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ap14r/et7rcy5Nj5Ha5yl5N6yNjuO3UEtFJQc7MhOXHWkrOoHQKdA3xyf2zgvi/8laUvpbXodp1NVOJV2nxQXcRnkcaqrJp+26WOAqKYLjHzW1lODlslo4gWC8E7/6lr1C7xR8ROsH4w23g8MAgniLakqH2n37C7+a5n5AlLdTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UsPhLu6r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5BouVl029468
	for <linux-pci@vger.kernel.org>; Thu, 5 Dec 2024 16:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lvYEHuLrFacd4tRRJuuJxO6xcj+0DaH3kv4nnEJbJa4=; b=UsPhLu6riXg0XWs7
	hEZnl5ShhTpuyrx7sviAjFccQ2TLQQlMnIgY2nx8H9KwXM1s41o3cev2nUNmRO7/
	9jc5qctUPLAchs+IiQcl//6kYTmJmAi41PYUfd7YQyamoO1R1q4GiZ7nr/QwhHbH
	1+sWHdc2qllGXlg5aWRzTJ4u7tV0EmBivdlPxvfItWXWFWbMfohOCo8Vl5H0IUuA
	GAPcVEaaxFlwiQ3IOt4w2xSMXQ5rJHmdMFn5xkJz+cXCsEfMfkw+zcOGr02RqENu
	qOYfQMkAbN36dZLwdTbVeyvSlAxvJqQ/OmMY/O9vCK8TFigjj51VVfp1AlqKXa4l
	TK6Vtg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bbnj0uyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2024 16:58:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d88fe63f21so3044226d6.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2024 08:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417903; x=1734022703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvYEHuLrFacd4tRRJuuJxO6xcj+0DaH3kv4nnEJbJa4=;
        b=wWxj4Gm2ivRKpdLS16/elKWj4oZcq8pVQNC4y25ZHcd+GIihd/W/MaA8P26jR8UWsM
         7J7mVu2g/77ykePfaCRmLICxOxu4BqgCE91cGm3/nsmNA1JLsQDxjeXMVqgaSV9DPKBK
         VO1f2zXHevjOpuPjNEeEtKIGv7ZiX4mPeTIZEQFF4L4iaC05j8dB4L6vknkL2ERYT7aK
         ofZ2objKtupoDcBFs8DXJEvYRnWGRMz8L7Gd7rJIOD+eoEXmPHVh0Yl+BUpDS0fkAQI+
         AJE07aFPc80OAJzme5ZD1OtQQQIXVpzsLThkrZsYnsWsGE00uczHsFA0R+v1zWanMm2l
         b3UQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0y+yfnN1ueKRk/W7rnyIuPdbBXVPXoWu6eQZTREuagDwPNkOdtVBLbyOLlwijmyiZApi0HUg7DOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6dsBo1NfajRqw416/LgFB9CiYxqo7aOTJNxSoGMg31kbGVck
	pqV/g4FKfcbx3XtXHrWOtt4r6Zvdq99Qqj0yoD9KAQ7rT+MRzlPh3V9HME3nvCokGlaJYivs0i7
	HcJpHsUhpXpjtpQrBHqr7FFIh+5OqPnwMc96fZW3HJf4nXqoId+XGzVB9pQM=
X-Gm-Gg: ASbGncvV6S4Tfanjearpc8UPUk+EoTyEUqybFaQ/zF5L1NWS19h/cco44pelnCCqsyG
	NVP33Wa+4kBgc8kXlUIXL/6UmZ0YgIouBq1R/vhPlsgk8ml1xb1nhItr+oKqVH4cMGLw+pxDW6S
	/2bitnA+wntfnDQZZGQgdTcnkHarKjpgGkv0Qp+ExCz+eB4mUORAS7FBQ3T4FLGV6jwBOKzvlsf
	FL/iNBUENB6LU0v0y/r//vA99yIbfxe8BPQ/xTPgdynaGm4pY9v+uTv6d75sT/r+0GGfX2ZnMd+
	WsdoQR3uvEqyRZU1kWXm/AmS55LYT30=
X-Received: by 2002:a05:6214:529c:b0:6d8:aa37:fe17 with SMTP id 6a1803df08f44-6d8b72b8ce1mr64771006d6.5.1733417903454;
        Thu, 05 Dec 2024 08:58:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3gkUNAmqO6vru/PCoJ4kSNmbvskxFZvs6Kgllqc/8lYi31ikybio9azXiwqqimK8yIfYovw==
X-Received: by 2002:a05:6214:529c:b0:6d8:aa37:fe17 with SMTP id 6a1803df08f44-6d8b72b8ce1mr64770836d6.5.1733417903026;
        Thu, 05 Dec 2024 08:58:23 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260ea41bsm114574166b.192.2024.12.05.08.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:58:21 -0800 (PST)
Message-ID: <8a8cdb54-93b9-4093-8e85-f3d698d66e22@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 17:58:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: ipq5332: Enable PCIe phys and
 controllers
To: Varadarajan Narayanan <quic_varada@quicinc.com>, lpieralisi@kernel.org,
        kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
        bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, p.zabel@pengutronix.de,
        quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc: Praveenkumar I <quic_ipkumar@quicinc.com>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-7-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241204113329.3195627-7-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EvDaePxc5jjCL6U1yA3UX7hwRnTWEERa
X-Proofpoint-ORIG-GUID: EvDaePxc5jjCL6U1yA3UX7hwRnTWEERa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412050124

On 4.12.2024 12:33 PM, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Enable the PCIe controller and PHY nodes for RDP 441.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts | 74 +++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> index 846413817e9a..83eca8435cff 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> @@ -62,4 +62,78 @@ data-pins {
>  			bias-pull-up;
>  		};
>  	};
> +
> +	pcie0_default: pcie0-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio37";
> +			function = "pcie0_clk";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio38";
> +			function = "gpio";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +			output-low;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio39";
> +			function = "pcie0_wake";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie1_default: pcie1-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio46";
> +			function = "pcie1_clk";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio47";
> +			function = "gpio";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +			output-low;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio48";
> +			function = "pcie1_wake";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +	};
> +};
> +
> +&pcie0_phy {
> +	status = "okay";
> +};

'p' < 't', please put this before &tlmm

Also, would this be something to put into rdp-common?

Do we still use all of these variants?

$ ls arch/arm64/boot/dts/qcom/ipq5332-rdp*.dts
  arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
  arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
  arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
  arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts

Konrad

