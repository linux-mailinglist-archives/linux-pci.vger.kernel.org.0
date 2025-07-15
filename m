Return-Path: <linux-pci+bounces-32150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB6B0591A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 13:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F5A4A1FEE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 11:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4DA252906;
	Tue, 15 Jul 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxeTaSLl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E42D0C75
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580065; cv=none; b=lwgBPbWGAjbtQ0oLMeJKYovTruU/fx9L4Tv0FfCnig3RLPeP700w8+C3k02iuHIiqBPj2nSUQD6WtVwvPCfU8kpXelPjqzEMm++DGMuQ9xiZb4XuAOubAPA4oaWdhPopepkBxdtDY6ygXlRtZEp5EC28gTOFn371m8HNAjKP09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580065; c=relaxed/simple;
	bh=OGNOsMqNwzC6G/i9UwKvbTqXMfdKqOw4as/Q58XcGVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtU9Udz92rbTAlGD9IUr2sxuOhBgVKX1DFerBZfdVir4nYwJjJEKVpSf/hbC1yk/wAalH7AUM6lOjHnMkci6GXnvCEcAaFTFBzjuD/7IZsGKMbmJ8nJtFkpnP7fxRjY4+vSNXxn/VEDAV7RwejXjp3Tk48RbYeB9TaE5u0TSuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxeTaSLl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F4oOBi012384
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 11:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+iXLFGA6J5aFgF0rOG2NVhZA5bpjJjvu96bzK64t0fc=; b=hxeTaSLlbwM3IkY9
	VOUWJ9zFL+zNuiklw2zu7Rk5K6+pYJeZylNTefM6ZedT7EIkJV61sPN6m3f21dJ2
	tcOt5qZVjhE8BJr/nTCSb3KeQY9p9l4mm9tt+qQ/ADsnqcMVf2ywTxK7PJqVNOR2
	Y3XJ1vCu7msHKb/uFl5cGVb2i0PiOFcxc8rT92emwI4LAqr99EuHYQmcRC501QT4
	3XN8JumPnAvzB8uNWTs5JOD3MIyYFkoYc6iDlEPRr5rQiD34CCQXBWPFFdr4G/Pk
	k2U83jvX+/07lR1dnL6YmJW7SwEPD747tE/YnMbo7o4Ei++gAvwDZ3eFDMYPtulI
	V86oRw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58yjx0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 11:47:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab7077ad49so4694821cf.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 04:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752580061; x=1753184861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+iXLFGA6J5aFgF0rOG2NVhZA5bpjJjvu96bzK64t0fc=;
        b=Z80MJWkufqR6+jN2TSUIMWtPMeUcz1729ChzjOKIiicaJE8MqV1iUa3hxmDWmavDkb
         kK9YTJSkQ4ijsaBH+2BtojK2xCA9qhONha4r0MeSpTZSvTVk/L1nBOrYTRxqjjh0F8HX
         QS0wZuTt0FuZ1hWVINIhseaOZ1z39OOVyNFTItYakUJc7Ut5uNBjr5YaK0yjabBKNuuY
         NL6hMgXsvJn7my5yjKntk2Zb7tgEEHOKd/CXfVYYQ6206rgOHmWxUvMSztnA333EhdUX
         dsP53YdQ9CZuHjuFcbjhcRy1su364dM8NnWDY6orQJJF5IcN0vwyJ6qlWmsQGuFfLxvt
         mxfA==
X-Forwarded-Encrypted: i=1; AJvYcCVzdGosBPKIh3VvnjrwgCia7LTo95A/1gQCxusf0GUd31I/KgUNh4MAnrzVdP50HAmSRp5qzBaJv3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRRkF16jC6loqmPV2uDuPS8obzmAS+gCzjRs3gk8OZxJbG5GL
	+WNZRUfL0uJODiHHx8D1NXY5r0nJt2BmvIaZUhKofYsdqQiAz4Pj0jZhJNVADrCV3d+MrUdos41
	iUohIURDUHR/6BiowsqC2cwRImyKM/NHDUbwyEZ/ldeUbm3y1NDjXCk++lvcETh0=
X-Gm-Gg: ASbGncv4y4vLhXxSg7UQI/RwEZX197CfQYaRLo4K+hk2egv+P3ubeKMkYySho1bVtx9
	12LRoaFjFVmjuS8ejk2Z3RjAjHOOp2J1LYN4CeTmWQKYNxaN1XV+HRrP5cR1rGv2l7Bn1lVjCmv
	xbuyoT+sMh4YGCvlBxBZFg16NXOPZbNKywkXFrTSU66SgMDZZ0zatrZ+a4OFs9l+GuVYDr6zc0F
	BlCx3KzOwSGUVF7Z+DpkjkYQeF10BLXo7YRPLR4s72yuMSzxYMNMmDvRaFV78e+WnwkKFEx+rxQ
	393j1abViuG870dpw2Qpba4TD+n07hs/ZC1SdNl3nbcEQ/7PVOvojtZgE0iwdx6tRNYOK9JA7GA
	mdPGSuE66XEFh19p04K1Z
X-Received: by 2002:ac8:5a93:0:b0:472:2122:5a37 with SMTP id d75a77b69052e-4ab86e22a8cmr7185521cf.4.1752580061438;
        Tue, 15 Jul 2025 04:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE16WXzqfrkizeZwS9xDN1JalpfUl7uZPacEPMkaJASCCYgdE2C9z7E6fN8uPL5G0sXubPD7A==
X-Received: by 2002:ac8:5a93:0:b0:472:2122:5a37 with SMTP id d75a77b69052e-4ab86e22a8cmr7185261cf.4.1752580060937;
        Tue, 15 Jul 2025 04:47:40 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90a07sm987503366b.6.2025.07.15.04.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 04:47:40 -0700 (PDT)
Message-ID: <98088092-1987-41cc-ab70-c9a5d3fdbb41@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 13:47:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, Johan Hovold <johan@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
 <20250625090048.624399-4-quic_ziyuzhan@quicinc.com>
 <25ddb70a-7442-4d63-9eff-d4c3ac509bbb@oss.qualcomm.com>
 <aG-LWxKE11Ah_GS0@hovoldconsulting.com>
 <4f963fcc-2b92-4a01-93a4-f0ae942c1b6f@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4f963fcc-2b92-4a01-93a4-f0ae942c1b6f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwNyBTYWx0ZWRfX9+JA7SVN6cFq
 BgofLK7PibWMdJMn0jkjEZ1tu6eX47erX8ZhVJ83cUcRDAvrpYMQlshd6elpNGIFDPGZV6+Gg8y
 IjEstaEobsbKNPgzE+BaeGkiw7Y81O3/LLcDJlBhkNffuTkW/O+6V9WYy3Ob5qmQutq+e8rHRmV
 JvQeTXK/PJWyE7aK/wFlQ3Fg+zMLCvYjFsGptdnz6SZIYSqJ/O5WKdZzfsrAHOskkqAL9HFa7bm
 T3cZ9Rj+ToM15AckMXNb+e9MDMXl16JVDGQZH1OqOR8doVMWicqmyKqZBa3ymVgEKPMq4j4O4jK
 vXD0x1EVQYplyosStD/a4PKll/eHPhGmUC3tszkBvqtudcD2HYgU5oDnJkuj6v/s9VXSgtSCaKg
 djQIhZUI7J9BUn1ivq+qGn30i8uwYPuVhvAWL5WrSfpmG6U6JHaip7mvLcUl8wOj/5He1An4
X-Proofpoint-GUID: 4XRr34njcRogu8c9u1BlFRK0UfDeMmPM
X-Proofpoint-ORIG-GUID: 4XRr34njcRogu8c9u1BlFRK0UfDeMmPM
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=68763fde cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=dJGf4bKP5mfmDP1ZOs4A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150107

On 7/10/25 12:24 PM, Ziyue Zhang wrote:
> 
> On 7/10/2025 5:43 PM, Johan Hovold wrote:
>> On Fri, Jun 27, 2025 at 04:50:57PM +0200, Konrad Dybcio wrote:
>>> On 6/25/25 11:00 AM, Ziyue Zhang wrote:
>>>> gcc_aux_clk is used in PCIe RC and it is not required in pcie phy, in
>>>> pcie phy it should be gcc_phy_aux_clk, so remove gcc_aux_clk and
>>>> replace it with gcc_phy_aux_clk.
>>> GCC_PCIE_n_PHY_AUX_CLK is a downstream of the PHY's output..
>>> are you sure the PHY should be **consuming** it too?
>> Could we get a reply here, please?
>>
>> A bunch of Qualcomm SoCs in mainline do exactly this currently even
>> though it may not be correct (and some downstream dts do not use these
>> clocks).
>>
>> Johan
> 
> Hi Johan
> 
> After reviewing the downstream platforms, it seems that GCC_PCIE_n_PHY_AUX_CLK
> is generally needed. Would you mind letting us know if there are any platforms
> where this clock is not required?

Do you base this on "downstream has it", or did you check with the
relevant folks internally? I'm still unconvinced by the clock looping back
to the PHY.

Konrad

