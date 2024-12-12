Return-Path: <linux-pci+bounces-18254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B479EE456
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE821682C5
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1716321146F;
	Thu, 12 Dec 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EzfbFH1e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0620B1F7
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000042; cv=none; b=olAXpKkdlsTbDL6kJwAlw09wOgL2Geww4OQAAdZ0/fAf/aXbOww+XAEz8sCAHXqlzumeITS5WuxPdvi4QDiGqA8I2wdAncTvfA0bOon3tFJHrzqRzugIFgOUCRClFYg1A7dUxywSjYOe+pn8JlZ6hWqMBLV3yaHahRfo7YNoq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000042; c=relaxed/simple;
	bh=82uRSP6JyhMVkQdfMkG1/sQrlBHkCy+1P540zP48nsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcLe0GIGvsaNrz9wIyqN/L+JnmXREUQh72MqDagJ4YazIaHth6QgQvGV0rL+SYcTuNDa9NeXOBQN/W+AWKgLRqvBkz4Gr9jzqYmj3x/UYD68OESrOYL8uNyadHaUGinCynGILftkPAAeiABwEbo02RjaB65q3O/t/0hD0Wa9gOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EzfbFH1e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7kO83000924
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 10:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uWrJazIZB+IUAXQpfsubELHX8kDFRYRr2kfkMUKYC14=; b=EzfbFH1elAL75DhY
	fygULKF3OlazaRGQ8xKoAI3FOzA6nXiE8KS+4L82qF8C8/QI0VA3Ovk2scd6HatJ
	hm1sEbVUGCygnnTTv91N5CuEmDwIHB18ha6L5hYNg3lXTVf4rdQsscGoXD4jPv/d
	Cb7VB9DJsLUMsH/WMaRDQiXtZjeDRO+3l0NRE/K9+Vw9A5YBLbL9MOX3lIwkCM1E
	Lcy1LAumWLc5dZJddRrZrXvGadO/Rk/AlT6aKfK+ie1it2vELJcp1p4uDELNOsYF
	P7mW+W5tIDza+cnl8lrDzcqdCVVOuhh5peHAFgXPYsHZiqWeghC/PCc0xpgAwlH3
	kX6MMQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f70w3vrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 10:40:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so514824a91.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 02:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734000038; x=1734604838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWrJazIZB+IUAXQpfsubELHX8kDFRYRr2kfkMUKYC14=;
        b=uZo4w2CZfOMd7gDA41KmLGZFNrAQV1PpRmhN89yI1JNVO5V0NAWBLk9R3ZOK3X5YTD
         8cJ9SFsYjbwQQP1dpNTLK34sdhzB4sHBhT0HWD74ZYkUYN76C/QvmxQPeVKfMf1qGIza
         slo1esdizUtdDVGCRl7Er33LsAONpry4ZwDYwattyrLaUUQ+zIzjR5H4BZNDDWVT0zQ9
         uigG99Nvngko9ElDQ3krOR2scjfbZQgvr7G3L2E/0vapO3XgJpGbXB8CSI10FPQtExFl
         Q8Cq8ouSdv4os11uqbsuAkNrA5QbBHlh9tkLKXhEpOjD5ZzUmRRcbkW2f4qaXGNuyZZA
         I/gg==
X-Forwarded-Encrypted: i=1; AJvYcCWll6GjNXkb5eEPZzilUqViGt6w+Z+DdFmB6exYwhzVV8nBs0glUQfsGBpUxjkzH1u9YHNgUAxKv48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlOCO+TO58Q7v/4rLJFJBPEFBI5g4ZeJ0KgyKs2LiWv8z2b3+U
	Ah1MvKfC+4hbB4DhFB3Ov07TBIvyaEL0TMudWvEhoSr2TCFLRMdGpTbKd12AimBb7N+E+H8b/iY
	WmEtD5NRh/0pVZfdgU5TfRIatfigIruUGvo7U91ReIh/g/dKN2yLDEaDekEI=
X-Gm-Gg: ASbGncsZY8cQ10T7xcNyZh8hOPsMfX4ZvMP40xCCcuQFt90YDyHhsCLwZT70UmTbYZu
	g8Cwk+Pony3aK7qHKKb88g/CMuF+GYTiISTiMI+HMc4N9wdhQkG+bKBgGsbJxvvE/T05Vb5Y14w
	DyvoeYHGxjDW8LEa+B/LWF43UkmZ3Lwu8714eCW7BFQsTZ1c37zGMeRp8Q/vZva0YBp8aF6yKee
	qGGJDXePnMAypsn/8ZfR7I9x5nFibaq1k5hWleUqIY/htacVh3SSetfydHh9+Ddq0M14nFjCp+Z
	2qwLBG5vXYw=
X-Received: by 2002:a17:90b:53c6:b0:2ef:19d0:2261 with SMTP id 98e67ed59e1d1-2f127fbf2b1mr10723682a91.16.1734000037928;
        Thu, 12 Dec 2024 02:40:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnyVwDRBDMftoBMWsplpwELfuZa5WcAYks6wRIYQboTRQ2Ou+bmDhyPWtpyTxpRnJH5n6szw==
X-Received: by 2002:a17:90b:53c6:b0:2ef:19d0:2261 with SMTP id 98e67ed59e1d1-2f127fbf2b1mr10723646a91.16.1734000037551;
        Thu, 12 Dec 2024 02:40:37 -0800 (PST)
Received: from [10.92.207.127] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeee3sm936232a91.20.2024.12.12.02.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 02:40:37 -0800 (PST)
Message-ID: <39012a4a-7d02-b954-bc06-53708b772a7c@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 16:10:30 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/4] PCI: dwc: Add support for configuring lane
 equalization presets
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, quic_mrana@quicinc.com,
        quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
References: <20241212-preset_v2-v2-0-210430fbcd8a@oss.qualcomm.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20241212-preset_v2-v2-0-210430fbcd8a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8IB6EfLeR5qrGJDp6kCbifzQgYtz_BKj
X-Proofpoint-ORIG-GUID: 8IB6EfLeR5qrGJDp6kCbifzQgYtz_BKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 clxscore=1011 phishscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120075

Please ignore this series it has wrong patches I will send new series to 
fix this.

- Krishna Chaitanya.

On 12/12/2024 4:02 PM, Krishna Chaitanya Chundru wrote:
> PCIe equalization presets are predefined settings used to optimize
> signal integrity by compensating for signal loss and distortion in
> high-speed data transmission.
>
> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
> configure lane equalization presets for each lane to enhance the PCIe
> link reliability. Each preset value represents a different combination
> of pre-shoot and de-emphasis values. For each data rate, different
> registers are defined: for 8.0 GT/s, registers are defined in section
> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
> an extra receiver preset hint, requiring 16 bits per lane, while the
> remaining data rates use 8 bits per lane.
>
> Based on the number of lanes and the supported data rate, read the
> device tree property and stores in the presets structure.
>
> Based upon the lane width and supported data rate update lane
> equalization registers.
>
> This patch depends on the this dt binding pull request: https://github.com/devicetree-org/dt-schema/pull/146
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v2:
>      - Fix the kernel test robot error
>      - As suggested by konrad use for loop and read "eq-presets-%ugts", (8 << i)
>      - Link to v1: https://lore.kernel.org/r/20241116-presets-v1-0-878a837a4fee@quicinc.com
>
> ---
> Krishna chaitanya chundru (4):
>        arm64: dts: qcom: x1e80100: Add PCIe lane equalization preset properties
>        PCI: of: Add API to retrieve equalization presets from device tree
>        PCI: dwc: Improve handling of PCIe lane configuration
>        PCI: dwc: Add support for new pci function op
>
>   arch/arm64/boot/dts/qcom/x1e80100.dtsi            |  8 ++++
>   drivers/pci/controller/dwc/pcie-designware-host.c | 21 +++++++++++
>   drivers/pci/controller/dwc/pcie-designware.c      | 14 ++++++-
>   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>   drivers/pci/of.c                                  | 45 +++++++++++++++++++++++
>   drivers/pci/pci.h                                 | 17 ++++++++-
>   6 files changed, 103 insertions(+), 3 deletions(-)
> ---
> base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
> change-id: 20241212-preset_v2-549b7acda9b7
>
> Best regards,

