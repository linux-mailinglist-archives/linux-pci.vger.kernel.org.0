Return-Path: <linux-pci+bounces-22338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A79A43EE3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 13:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD179188E5E6
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82199267738;
	Tue, 25 Feb 2025 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UmbTRmkY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C81267B9C
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485351; cv=none; b=V4l31m4KT+04xgBq1B00/7YageZfbfcesJP3n3YxUfvi0dFMAL6XQKqj8kchI1cuzf95ywBNQHIVIyKb++S13mgF08wJN+kyPGRcraHU4XvhEfS98xc++nAtKsUkQujrWMs7Go6SmEfazYM/d5R548XQtbMT/8OkHbyo1TIQcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485351; c=relaxed/simple;
	bh=iCgS3i4jeT3RTXkayVl0IK8NtFDsUCkuiJsYeX22TDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qI59wPyNHcSUZRMI1SRNyAlS/mAQTFgtJrh5C9US9640k2mImy8Vwt6ZiKk1S2ywH/RxgBsj9Batrlub04QQ7scRiX75dwgxsLAZXvVME6TxP4IV5cL+RmoC7O8fbi8K/dMjjZyl4reZvSgMHHMqUuQB2CHb5Pj3FI8iuX6mlqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UmbTRmkY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8Sg39012737
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 12:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	liyKdemlEyYUI2F9xPgM63joz99qtCmXbXh4OS9ua+Y=; b=UmbTRmkYHXtlT9Zk
	8xuUn1hdDUvJ4/AQg1trwY5wG6DAyasQsbxW0P4K21hzEM3MpDB6546tmo7VDyaR
	0olCwdxgmn2nV8/Iu00fica/xmJ0LqKAGQ8u8tiNCbpZ3ub2ITgQYA2x3dHfvo5T
	/dGo4reJmOzi8xXpOy2GocJsuB/lSYjqmqCyLoNOfTAfCyfhUw81HuJGm303Dq88
	LIIZVLi4hZYUps1pzHjWQXTWLSKUkAzG5zPHdnmbJ2ehzTRELNWqqPsnQg4UMnr+
	4kO7dUkenU0kg0pefiU3zcWGGxuJ8myikoV3L/IQ64Ae/iaWZ3TpWPT0VqFGoxv3
	NOp5lQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y65y0s7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 12:09:08 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e249d117b7so5214496d6.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 04:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485348; x=1741090148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liyKdemlEyYUI2F9xPgM63joz99qtCmXbXh4OS9ua+Y=;
        b=MXhJfitvlvvZ422+inN49bMZhWZ/0+YYYy1N1sm7hTMJ5yxnP6bGjaqPxFtar5/iKv
         bZFlclPpIIsyw8rgjGGY7VvosRlN223XKSComtnVwZytx/RJ0Ya7izNAMxWU6xQnwyA5
         81HfQ3HnLuBD6UCPewapALhUJHqc5YDExzmbdd3gaXm6L0zWbbJjUTSSCojerfvCRILZ
         O/rEeJ4xUsEDE9Boj7AJsUg/QNh8VPwYFmnGHRI0JE1nXDef5R6UOaPrk8bnZBlY0yc0
         OtKVDrSnYghwxTjdFXG85X+ieVZTQcqv9Ug/BFSeXtWCxeF1qYtL4euYcKIzPvukZkdt
         XUPw==
X-Forwarded-Encrypted: i=1; AJvYcCX5JB53AWcTpxKuwtvksRjic/c6NuIjnJo5X6Jh2wwTgVQ0g4HP85/Ct2ajNETn+eXj6jpp7yWp1+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YznriuPxV3x9dcAuIONgGz/1hGUmytPvLHyLM1ZwFgaGk9148ws
	YZbXVpB6FKlSUxgteTHG5NM3wkEVdPeMFY7a/h0E8wOqAirbadU5Tj0MRXiay8hO5pK/R8QAj5z
	osezi9VU4vjVob7Y4Psha00/wUFr8Mt3LEoFXwl9EdUMe4wgKW33uS639KyU=
X-Gm-Gg: ASbGnctkoEoe3rwcYa81GqlqofKde8CLPDJLjiH5OtlSofUk3XecLm3hhmlyqpzR2k7
	BxQQVxg7xcr2uC1FVNMUSGKLi7drorcgFw5ct/z8hcrG+oFvQ1As3VnD7wOsZWoxnBIobMDEsOy
	7tI8oG7OouCWkwPAbLPCL+/PeZOWNyTYZHuD+SOgu9WUwM1hqQLaXjMI76L4NGYKD8pxcofuxBv
	stFXGvRiJ+bUKfnvecreB7ZBKerdGnu2rTVZREOdbD60bog+J6UiCDqlocW4pGdNuIdFrYWSv4O
	QNkdxJnCyiB/qvcXfYYRkkp8Y5sj6Jf/fDVyx0pI9e+UUmdcJXQXFAOhSMsbbKHopsQELA==
X-Received: by 2002:ad4:576a:0:b0:6d8:98a4:cc5c with SMTP id 6a1803df08f44-6e6ae5f3142mr86218766d6.0.1740485347824;
        Tue, 25 Feb 2025 04:09:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBcYh3OaD6A8QQEHJCnWXKawL33DJwmF++4szvw0YSegATx81D674T3VIyiwI6/jeN5Mgo4w==
X-Received: by 2002:ad4:576a:0:b0:6d8:98a4:cc5c with SMTP id 6a1803df08f44-6e6ae5f3142mr86218666d6.0.1740485347469;
        Tue, 25 Feb 2025 04:09:07 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2012175sm129900566b.118.2025.02.25.04.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 04:09:06 -0800 (PST)
Message-ID: <d8ef7b67-a31f-4a49-8810-90dfebd2d8e1@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 13:09:03 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] PCI: pwrctrl: Add power control driver for
 tc956x
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-8-e08633a7bdf8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250225-qps615_v4_1-v4-8-e08633a7bdf8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7qdrYgLV7aXNj-xN_3P8YDyIQ-c_R2YS
X-Proofpoint-ORIG-GUID: 7qdrYgLV7aXNj-xN_3P8YDyIQ-c_R2YS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250085

On 25.02.2025 10:34 AM, Krishna Chaitanya Chundru wrote:
> TC956x is a PCIe switch which has one upstream and three downstream
> ports. To one of the downstream ports ethernet MAC is connected as endpoint
> device. Other two downstream ports are supposed to connect to external
> device. One Host can connect to TC956x by upstream port. TC956x switch
> needs to be configured after powering on and before PCIe link was up.
> 
> The PCIe controller driver already enables link training at the host side
> even before this driver probe happens, due to this when driver enables
> power to the switch it participates in the link training and PCIe link
> may come up before configuring the switch through i2c. Once the link is
> up the configuration done through i2c will not have any affect.To prevent
> the host from participating in link training, disable link training on the
> host side to ensure the link does not come up before the switch is
> configured via I2C.
> 
> Based up on dt property and type of the port, tc956x is configured
> through i2c.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---


> +struct tc956x_pwrctrl_cfg {
> +	u32 l0s_delay;
> +	u32 l1_delay;
> +	u32 tx_amp;
> +	u8 nfts[2]; /* GEN1 & GEN2*/

GEN2 */

[...]

> +static int tc956x_pwrctrl_set_l0s_l1_entry_delay(struct tc956x_pwrctrl_ctx *ctx,
> +						 enum tc956x_pwrctrl_ports port, bool is_l1, u32 ns)
> +{
> +	u32 rd_val, units;
> +	int ret;
> +
> +	if (!ns)
> +		return 0;
> +
> +	/* convert to units of 256ns */
> +	units = ns / 256;

Should we round up here, so that values in 1 <= x < 256 give a delay
value of 1 unit? Or maybe such values are never expected?

[...]

> +static int tc956x_pwrctrl_set_tx_amplitude(struct tc956x_pwrctrl_ctx *ctx,
> +					   enum tc956x_pwrctrl_ports port, u32 amp)
> +{
> +	int port_access;
> +
> +	if (amp < TC956X_TX_MARGIN_MIN_VAL)
> +		return 0;
> +
> +	/*  txmargin = (Amp(uV) - 400000) / 3125 */

double space

> +	amp = (amp - TC956X_TX_MARGIN_MIN_VAL) / 3125;

similarly here, is 0 an expected value for 1 <= x < 3125?

Konrad

