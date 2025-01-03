Return-Path: <linux-pci+bounces-19223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F283FA009C8
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 14:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55A4163FE7
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79541F9421;
	Fri,  3 Jan 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ilRI2H2i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FAF8F58
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735910067; cv=none; b=GAGyFhbDZLgDBiGMEFyB4F4f2uyBufsfmWCYjgfh+P8zREF59N9n4Mu/lfCK6oK00IPsMSfQYbkE5Upzy4l9J50lnILmnOkleK99siGzxC8NJKPmOpzI1/ooQsuNGN76YkTXtGRNq29eL1FG5FEisNUeXYuycrmk1Y+ILH+N93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735910067; c=relaxed/simple;
	bh=2skwZes6S2F4o/TX9dsIHLJ7QRN9SNxYlDV4H1y3bXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYQA9wS9rOYt8oP8lk4WpGxI3tSoyVJQzGLwIU8nUo6LgAyI0IAdk9LDSo3YAitrHSpz32No3dYrLg95V37t2INHWmRaAJDd660dVpi9JsS/D7C3JR0v+9cmIrHLzxsfbPPVqk4An3xm69wk5AyAigI5OUR81jJiPhDMD+bq7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ilRI2H2i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5036Yo5P010682
	for <linux-pci@vger.kernel.org>; Fri, 3 Jan 2025 13:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zs4a2hB2iyjshiuXvUroL7xY8a8QZWPTWdCIATDXiu8=; b=ilRI2H2idECs2PmL
	PN7mxrqgB9zaEGXw6A5EdowL11CQOexJZdIRc74ryDWSPooNAycjSgO8VwSvtWQs
	VwliAx0UHvpejLOeW2Nld/J0xwWR1FLJvQulerfmGsf8u8wRz+W/NfnTFWuKwYRs
	u7l439GAHvM0PCaCivOYibmEyzBBSFLbNBEUSfzfLH7SdpxyrGaS01aLLyPH65El
	lWakqyLHICgRpJ0oV3+PiCLteuXV5ObWnbMu+2FB34hkpRzSqadASfPX3rutG+KZ
	3ur0RV788DNcKyLMn9LoD5oFxcFS6vSg3OXH6o7oV8/TSp1/chScOkDILFhziPsU
	XIQ4AA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43xardgtv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 03 Jan 2025 13:14:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8f8762a69so17098396d6.3
        for <linux-pci@vger.kernel.org>; Fri, 03 Jan 2025 05:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735910063; x=1736514863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs4a2hB2iyjshiuXvUroL7xY8a8QZWPTWdCIATDXiu8=;
        b=ohbcIGYm6LIUmeCohW6Auub3YWS+jx7pv1Ab+drFHNGj920YdVbYAhlizCKUqfTRYk
         r4LdwXVll8jSzcsYg4AmkffKos9MLlvPalZaMvMzZVae1UaF1+v9+IpwpNcfsQVWU4v8
         ziWNb9qkSGSxPKpvv0HaGf7jYv04mE+a0O5zarDPVlw/iL6QF94HbWXd3fthU5S6rANd
         AINBik/UZVDhyTtPr4etcqYdJ8VECRqkLR0xCzkabSCcqAGIa5+kegF1U6fQHrAUySfW
         LEYj+64Rd0kflKQ7m+jtyHae90sxAn2zBYjMMtP1G09ANUExiZZS0zJ3zqgP5ssVp/Aj
         N9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwA8nyicODULy/MiecVX6SficrNeBUMYxre6lx5Pfg74coIjsj3+X76SZXz3tfJgEwI+ZBONHeSHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLU/fCWT8Qgy/K5zE9Okc4LztX/8Pg+tIBPIpd0KOkIGhRhDz
	yu1g5OdFSbwMD8zDo6D8q1T1+RUQXM7boUKpXY26oZStTPCe5UWc2mfyrMIQ9rKClh4wu5hgcop
	S68yyTG9vRR7fkp6oMm0bbkvcSFU0OVhcdZzcagyPXdZpeJCIongQxYMda4g=
X-Gm-Gg: ASbGnct2ZAn8X8hJn13rbdMXe++bFkL8qhIA3jIasmMrUU/QEkQBEXy+2H17YNTPq5W
	bDwuZFGGn7dap2Q4PbYmpRDUI3PALtjO66N9psdAWwHN0J7i73LiQACutr7vRD6y9/nSKt9HAJv
	y8ZLhqW9kUTgFW48hyuDU3VMDixvf6R/1r0GOkp3FNW64YxtGvCbKCHY4dx8BW3ZzmGDp4qu+FO
	azPDKyPoiGOGC3LaIsfoIu6QLy0lFieslN1Uo/PG5a9AvWOWZ1NBmGzMwmFH2UE7n/E9V96N/k/
	Gg6NJ6ltoodT8pRYCmIQwS1WTC1+IJdERt4=
X-Received: by 2002:a05:622a:2891:b0:464:9463:7475 with SMTP id d75a77b69052e-46a80758455mr163481291cf.2.1735910063456;
        Fri, 03 Jan 2025 05:14:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtSCiX+k+KsO86q71/HLEx4LrYnqWiPisT04z7RdRIYvR9bGfBVgELyJkqShujMdRnUNYBOQ==
X-Received: by 2002:a05:622a:2891:b0:464:9463:7475 with SMTP id d75a77b69052e-46a80758455mr163481071cf.2.1735910063124;
        Fri, 03 Jan 2025 05:14:23 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe490asm1890162166b.98.2025.01.03.05.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 05:14:22 -0800 (PST)
Message-ID: <dca2e244-873f-4c3f-b7f5-86e6bec3d9fc@oss.qualcomm.com>
Date: Fri, 3 Jan 2025 14:14:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: qcs8300: enable pcie1 for
 qcs8300 soc
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20241220055239.2744024-1-quic_ziyuzhan@quicinc.com>
 <20241220055239.2744024-8-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241220055239.2744024-8-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9ZwFSSHtor-sNLx7rFMaTO42MwM31YGL
X-Proofpoint-ORIG-GUID: 9ZwFSSHtor-sNLx7rFMaTO42MwM31YGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=566 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501030116

On 20.12.2024 6:52 AM, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe1, including registers, clocks,
> interrupts and phy setting sequence.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

