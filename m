Return-Path: <linux-pci+bounces-28456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471ECAC5006
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 15:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4D51887754
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E0327587D;
	Tue, 27 May 2025 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hzab7NX/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2222749C2
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353056; cv=none; b=KqddcX0E5S7mGMxbk3FLuRlf/Vpas/xM+WV3kzAE54TsOgpDjI5eB+kYLdFfnbBV/KhWZgRGlw9F9xdGjK5rw5hGClqa0ij864lvKQmtapEe96qrtZPpTC1KBPLmWPPZSmnmiXFu9eT6LI/HN3/CNhb79889MupOqsUbLHaGqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353056; c=relaxed/simple;
	bh=KhRlIO71gEXyEYjy1ByXE+VmuW6Go3ztEoZDkTXkyxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzEWc0XVKSNosmpWOoXBX3dHxy/0M0rcT39+2xhejT3ha5meeUft2NUyCsGg9w6xuE/zyljkUc07/hxArrbkYabhEfyG+YiSG8dUdwolMH8IUIjf+kdtxybD/+CZuoDAW0XGCuoZ1UkkdZObvdSRONsOfcc8rH/hR5Fmg+YEqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hzab7NX/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RBdmd8013744
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 13:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xLEufRgtL9qKIG4lX4CSfuKvPSGQ804jDCPgn0wAin4=; b=Hzab7NX/6BOzvYdV
	yhL7RHU3rpqw3lHO/14gTSrivQQeBRJ/vWOBd6sKeuAGCJ6p4j9fn0XNJDYz7F4j
	9SUbprGcye8/6Re9rpChZ0FdwPctvFAnbtGVcqekBAe85YyIVo0lUi3mzOqCXB4X
	pWf7SevqlglQoHZtYiH4reDWnqFg0gP67c5w6VZjRoaCWLlv1r05sSNVF93980vF
	tS8K25WlJQ6mL1Bmvic6BgJY9SatdEmPr4RY2k+RULKlpQN3dldq2Zz6l8fbQkq/
	0q5+gGUaSUgoGa/Zow+uDKH3LnRCL96MPgITd5PnsGHeWNLMFQpu3qlNcF/VatIp
	TDD0FA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w6919ff1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 13:37:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7ceec331273so111491985a.3
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 06:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353052; x=1748957852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLEufRgtL9qKIG4lX4CSfuKvPSGQ804jDCPgn0wAin4=;
        b=MMm54sIq6ciZkeNCgT38+t2QeYwOKL3o5JD34US9Q5ZH7s2/O8FMwd6I8UKPSsXJ5b
         yx3Ta5XRYDQNB7bzXj6n5s6yA/unIgARJtpe/GP9DsUOtkqv3btqdb6YhfcRb4kHLGZE
         w2ZMr1zf0YtuArgpZhgX4HSGySzRyf/1lG9e+fhEuMJRxS8RC31kQK6ZMsjrm1QldSFi
         7ityMH/Z2wehS/JaYPJDlZlGeSh7kGQ3JLBFIo70r+VOJJFDVMaow7U32DxNdmYk4yYS
         tNFJFYpXA+UndAEcwXh6E8vM1DDpULO/bLSPRJSHgvlfx/JGbdt+k8SFIr3bD7eYoTFY
         l9nA==
X-Forwarded-Encrypted: i=1; AJvYcCW7/XhwVPmBf9O0n+lQPA8fEDhcWw6N4E0rLBvsfjQq2edFl8h9e4Jeh2waRjJURBrZOsuiMWWD0Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQXDjZuM2azFiu3T6aozFdVzxA42pNfQd3pLKjw7mlWUkMAHn
	p8bS6LnkNtPRN0Hignp7Zt1+ez0b0445dpM6AqAuhtSGQSJN9C7k0IqJMQCpUoRq55fdVOpsZBF
	ZFvZW3Ici42qiGPGoL9nKqjfiYAd/fKpFN5z/DrHkmKS805C4JULS0oNAa2ff0A8=
X-Gm-Gg: ASbGnct0yTW5k0wRkkrARttJhYIszycgZtAh7j7NAwYDeqIq8T2e3vlyxcDZ4qfeOuJ
	17OEMcQC2aHBcfm7+hNwogXtNRqIw2BqG5M3M5xQdloht/0PDSvGasDRrFtaLGpEkiI+eMRprL5
	VEVE7v8LDxuttFSgZg6Rm5H29ohBPaljuP8nLnMdjy9zDvMXJU/dy+Ud4BayiaCzeE4R84FNpnC
	UhIiGwHqp8xxol0MOcYurGvRgeU5ewuclyHX3dQJ8DB0GyPzOr+TTpWF0zcpT7r7iTLpT7XqcAE
	hOf3/DpIGeHbPCF+Eo/ntnr4wcvqG2Ud9MsqvGZpkSiz64c/LMwus4LgPPRX1D9a2w==
X-Received: by 2002:a05:620a:1a85:b0:7c5:ac06:af8 with SMTP id af79cd13be357-7ceecb968afmr708581885a.9.1748353052453;
        Tue, 27 May 2025 06:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6syR9I/XBh/MSLFb7D6Zw6VTBNOOLOjBK/d+fsxGEpEZQnhC1Aw9iZuvqUpC6mxmNYxr87w==
X-Received: by 2002:a05:620a:1a85:b0:7c5:ac06:af8 with SMTP id af79cd13be357-7ceecb968afmr708578585a.9.1748353051873;
        Tue, 27 May 2025 06:37:31 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad88bcd476csm126238066b.162.2025.05.27.06.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 06:37:31 -0700 (PDT)
Message-ID: <e1222269-6660-47f4-85e1-3782adb685ef@oss.qualcomm.com>
Date: Tue, 27 May 2025 15:37:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: qcs615: enable pcie
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, lpieralisi@kernel.org,
        kwilczynski@kernel.org, manivannan.sadhasivam@linaro.org,
        robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
 <20250527072036.3599076-4-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250527072036.3599076-4-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=6835c01d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=u-Wjf5nI4b4gXCDVDnUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: xQ1U9GQK3jyCrYb5D63-KTdkF5TdIn2j
X-Proofpoint-ORIG-GUID: xQ1U9GQK3jyCrYb5D63-KTdkF5TdIn2j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDExMCBTYWx0ZWRfX08MkKv/tQs04
 aM/dSydyVYwZ17PZ0FxypbMitlRdAiB5EOnInIT1r6WBg6jljtSG/1zEzfVugOUkoygSDmfxNlc
 b1mIvgD4K2ywhQ2Eul/IoWkFK21kex0nH7L5DClFSkaMS/rjSPOSlLmgrepX6wIw/Lq7/ruzhr2
 acbMK7ubSJQ33eyaBsuLbNwkpxHp0VdJBvkgEIvbHH3MBV+fSRy8+5CmR+r/vzM4300leNDtGzG
 3VBUcruKz+j0QMAhOdxWwwvhPApdw4vbdSVwIAStSpCSlAgK9CxyRgs4YhZht77lOF8hZ2kvnOf
 NQjFWyugUpmtNxIutWH+aQiGmwyC2fUFKx2H1pSorBpT7V2uSvfUF09pK/E/ag9MttLrIeIALSW
 zbLIrrWj/RujhP0jI4X9XS/kYE5XKoOAAo8dJnn15zGslXzTdO9NDBNe3WPkMryEATpuX1ZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=602 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270110

On 5/27/25 9:20 AM, Ziyue Zhang wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add configurations in devicetree for PCIe0, including registers, clocks,
> interrupts and phy setting sequence.
> 
> Add PCIe lane equalization preset properties for 8 GT/s.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

