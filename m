Return-Path: <linux-pci+bounces-20451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A84A209CE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 12:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B412F7A3674
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF51A1A08BC;
	Tue, 28 Jan 2025 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JcjtIjhB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEBD1A00F2
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738064292; cv=none; b=n8zxkNAPc6Uyd+0UAUhTUMKdnXj9e05AlRZuEdLzEk0YLqx/4KeEaolXSV2t5kQU0SCDrI1PE9oRDNwTHJahOlWtXGEF+bwnvhaEqUY45Q5tCozdbrd+sWV2NBJ5sJ6oNZHuVqj/jOKOM4fF2Fec2zREnR2WCZ/CZKtL9o5MYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738064292; c=relaxed/simple;
	bh=0BgJYAFmIfhKmUiJdaRGDiHPwseznBuyo9kvKgzoZC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z44ZUdXYz1VUAAFRGrEtgLuNboEGWiYvUU9CxKnC4v7yLXzci3pdbrHadEE4gUeucWDrlX8wfSgdT3HaJiAw/L3sDPlI/Kr2YnLdUFCWZuYy+MWX46Ohil862gFwcA/beE6PDfPBidaewBYLfGr5jyCYwzKNmYQprCzAcVNeXQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JcjtIjhB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S1g0EK024402
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 11:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6g2echZ7j23XTXqq2EVMBCfIeLtHvBBfpj4T6nbNFPw=; b=JcjtIjhB+rwU6PJZ
	on49s2BRQJb1L6kyZYUCWxsPP1DR4Lwniz2tu6Ypqnrkkr+pHt+fkr/IwmBL7iFE
	2AnT2IT2E4jU2N09jA2iCIURWMullinXOL4x1uSTTqttG/W9CMf4y+Q1b7q5h2/Y
	8Zcli1tBEZw+6OK/CZzpZi6g2Y3HY/TM+w0UssSDWMibNrTrx1MtFZvE2QCBWPjN
	fQMMrOhXBGcLYv7Q0W27AlFc/dH4aPYK+qx2TN6NZ4Q3i0sWCx5QLtbIJlevORq8
	6ifAG+V7gzK0Cibr6ajfn7cPgZlp3I7XM0Tfr52t/9KAN3UnAAnj7LDDWc7i+qz4
	MruBCw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44enrq94s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 11:38:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46e4842dbd0so17202341cf.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 03:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738064289; x=1738669089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6g2echZ7j23XTXqq2EVMBCfIeLtHvBBfpj4T6nbNFPw=;
        b=ighMZPKBo8kg0z6MobVxz9CZENZvZ1HOYzJf33PDdpIKKmWNs7VVjo3XohNuycoeki
         hrlwbsFRguSJnwoErmDDUKndJx0QlDZFak/jYyvrEUosCIsN7DCXGwE5qFl0tZQqmPHQ
         akK3om4+4UTpNBs3OZOYAoBkxONbY0jXURT2M+UyMWAEDnrWSxw6G/qtsoOY/mQLMSqr
         mi2Kco4egMlzo2spf3XFtI6xQ3EIs5T0c4k8jFqmtlzW1HoZ7ZfInbK2KpLTl1Cems8H
         nG4O6BcwnaRKAHxxpLsbnllEyqW2cGCekcUWicPIjNMvm0uaQGAXrsNcuUfnfoDnSDqv
         J6TA==
X-Forwarded-Encrypted: i=1; AJvYcCVwaBZk+S9IC7gBNd/xEZDDOOJztR5s2269DlcU8dPqepI8mCXDzZMaYY5pwS8a0KQlk/zVqr8xemc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBsR6XOeVOW9tGpB9HkO+1JI0Qsd1SF3en+kMO1QZf3UjzPBpN
	Sxhppg0JbUFWseMi9yVMFdH58hTpI/RQTlfitrv7HPRl8HeAw7sx8iN/CPLDY8Hydinx472V9eD
	DG/J1AK+RWa9iY9HZ+HaQjAZjqSvTukCqEWtxQmFsw5CWRTcA4YaLFzXiAb0=
X-Gm-Gg: ASbGncsr5upTVSxrB6usLx9Mt4EBRC3eZwaZ11ekkfLNbxGayWOA5hptXgNMXLK00GK
	xnPgCtfhWcd5fx8Gv1VPK96Ry1u9omxr4h6ApC6Qi++tVzK55ZLfY8eD0xYm5Re1gZInYxp47hT
	kIxt+GVHq+QaTRikDj4PSienxsGswYAmNjipLjJ+OvYsARZGFxekBUFRcGkrVzsxlp1uTWn5Mm7
	NuEeXLaWIlQs2yfYQ1VMeJPHG9SsyEzynJ8ZPrSC5hiTzhmrh/wyWe4usIKOSYsK2JR/RY64Nwd
	dqh4JnXPpHu2K98xODl1EvnjcJy7WLMCE90IPnn8KpujvBgZuO1hry5kpOQ=
X-Received: by 2002:a05:622a:608a:b0:46e:12fc:500f with SMTP id d75a77b69052e-46e12fc506cmr246727371cf.0.1738064289114;
        Tue, 28 Jan 2025 03:38:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCf2Y9aDvZCCSYPHZnq/Vme37o1Wy6pWQCZOXgJJV7jmJIX4dtvvrEwoqFnFZJe5GemRYcBA==
X-Received: by 2002:a05:622a:608a:b0:46e:12fc:500f with SMTP id d75a77b69052e-46e12fc506cmr246727201cf.0.1738064288803;
        Tue, 28 Jan 2025 03:38:08 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fc485sm764439766b.160.2025.01.28.03.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 03:38:08 -0800 (PST)
Message-ID: <772b211d-ca23-4810-8d92-a67892da4fbf@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 12:38:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: ipq5424: Add PCIe PHYs and
 controller nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
 <20250125035920.2651972-4-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250125035920.2651972-4-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rjvUYYavhN2bOgZhuMtjhPpGwudpmd2X
X-Proofpoint-ORIG-GUID: rjvUYYavhN2bOgZhuMtjhPpGwudpmd2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0
 adultscore=0 mlxlogscore=663 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280090

On 25.01.2025 4:59 AM, Manikanta Mylavarapu wrote:
> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
> found on IPQ5424 platform. The PCIe0 & PCIe1 are 1-lane Gen3
> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V3:
> 	- Replace all instances of ‘0’ with ‘0x0’ wherever applicable in
> 	  PCIe nodes.
> 	- Place both compatible entries in a single line for each PCIe
> 	  controller node.
> 	- Global interrupt is defined for each PCIe controller node.
> 	- Remove all clocks except the RCHNG clock from the assigned-clocks.
> 	- ICC tag is defined for the interconnect path of each pcie controller
> 	  node.

This one is wrong, please undo..

Konrad

