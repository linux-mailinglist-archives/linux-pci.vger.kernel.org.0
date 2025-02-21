Return-Path: <linux-pci+bounces-22023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FF5A3FFAA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 20:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B0E19E07D6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 19:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882EF25290F;
	Fri, 21 Feb 2025 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CPaCY9zx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F92512C9
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165801; cv=none; b=c88mG6K/qFsphejWutGhn1kijLEqFC8anmKpuj85an28VIJoInRINlYdp0Y1Ai61YbHSh8as8Gx/BcgGCFbgzZIKBczc3pY/M3+DSDd8VgJTfSE1X5VXNyPuliEF90nkozIJy32dlOvUl6oaGhorg0eZITZlY+MG0pvz2grs3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165801; c=relaxed/simple;
	bh=WylaHPl7kQFGmSp8WXjj7W2gvI+NBOhDbeMQbmwatU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ypfk0ulPfucfRw0YbO00cPGWAI9jBq9PfR3Kc2DXlNJrMXThAwDgdjKB/Rpyf7GWegIdKksLhbma9y/kaPRR3Q6ggGQ163+rp5AVow+IfAuNxHmnSlR2IXieZuhWSfBQi2n/Nr3e1Pmcxx8W4577zNby22WRsvn+ZQT20R5fEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CPaCY9zx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCmjCW015223
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 19:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Km9ahlx1nwdQ8uA3tj/aNXPGPboPCEVKF4XebUprYcE=; b=CPaCY9zx7jOEU+h4
	KxzFB0N3q1cHyfn0Y81LZCvGWDuOGwfstj5bjhSW0Xfqk4Z7tklRUZ1snaJyPYHH
	JYc4d6Wf2yQ5rsok+WGulQn2Iw/yLc44CQWRO6zcQN0s9mg7q5Xz0yRqbVl1gajx
	YDimZf+ZtQaBxmDDOjSlZvxaOINafDvbhGF7ALQFyXYwKsRybv95G7B/4uMbW0F6
	Wvfxx/m/f3BsZ4kPVM5nZYEwth68Ew56GQ6KoIgIyh5RlKz0AwGCHdYEI3i7xbB8
	ADfbTPyTPyyW0IQu2fX8UzrkL33KWid8QvcRcwxCBrnh79l1KQSY2fdYQ8WsKSFG
	kt9zrg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy4k2j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 19:23:18 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e662a02f30so5630786d6.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 11:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165798; x=1740770598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Km9ahlx1nwdQ8uA3tj/aNXPGPboPCEVKF4XebUprYcE=;
        b=aMNjsdHnYlBQE1oL2sr1JoG3nS3zsoCFDuF0ZLdl7nOdX7ki6QAP/wPM7U6CxcIqTU
         45+ddDAnhtzOX+SqaKIbceYQWViUOtHRzHKlw3NI3T0eBuuz0oSlCE8BmCvD2/IEafqc
         0rm3rW7jXLPEHUTyY22aZHcZuW6w8WOrTfMoOW1DL9ObuCdypuVG9UIVtyg8T0B/yVxy
         PvB6uPVsb90RJOUbvNpaZqdN72KxES+B6YA0jxQAwwiHy3bnEiJDB2a4tmKbb15qGRQm
         MCSpxmc8Y5dnL1TE4EKkZyKgcAfGkf8SDksFwYE52fJP6zt8JFMe8jtcudNhkk0LjntL
         S8HA==
X-Forwarded-Encrypted: i=1; AJvYcCUEggTeyrJRtUlOjCl/b6JH9PCPGK7WFwssUoThU7QSrnqptoO5Mp7EyMgIJZWoPeiMVhIXX1yCulA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZjZfX2d1tKx61K7uhgD9ZWBMozkWFiRVb3g5F7aiv6KausDG
	cFPfbQYeGGDC6viKDjK5fNMZV502CXAaVSqdhr3vmtEfUGKdzJ5+iF7PFKu4JBoMwNo0Csm8MRz
	LcGkdJQsU8jY8x6BVhkhJfVaoYAhTyBWoI7S4JvRYvoT9NGcY0UhF54OEbvk=
X-Gm-Gg: ASbGncuHzcoGbV0HemZh0kZqCcYjlqyokhSOrRj5XZvgRzX4uZupvHwB4rGmx02Tub+
	B/15og4Canm0502ZcBO11U5J/ru4ahYTGFkuEDqpZ/vscdwAsBSlAGk2CT+Ty6sA9g2fl6qMedy
	4I98/rzrzm9UbyEj22ysHFAw8ZovZ6Cvkljp+3WZFcG+HkkBhQYJOLy3QYS77OkwSsigfDqUXlu
	S4B1/P0tsU5Kh+Hz+xPLzmtJG1VoKdJZYgMWJgdo3hXkrwdBRjH5uUJiu1VBEdtSCcqV9Bkoj25
	Z+CrLUmXrnJlUhXeIFZCDHkkqfWOW4nuOOCkBci53tjtmRodBqkuHZcrjp6C7R4aM4d/EQ==
X-Received: by 2002:ad4:5be2:0:b0:6d4:2db5:e585 with SMTP id 6a1803df08f44-6e6ae7d85e7mr22638866d6.1.1740165797733;
        Fri, 21 Feb 2025 11:23:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhe3D2pb35rVzYTf0irYbfcNunEhouF+kKjaEaBYD9eenWOnmtYKYr2TVvZBWUT1AJ8DrVIQ==
X-Received: by 2002:ad4:5be2:0:b0:6d4:2db5:e585 with SMTP id 6a1803df08f44-6e6ae7d85e7mr22638616d6.1.1740165797364;
        Fri, 21 Feb 2025 11:23:17 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7f766313sm1255261366b.142.2025.02.21.11.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:23:16 -0800 (PST)
Message-ID: <916d3d13-acf1-4ae9-81f3-7539172ee8aa@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 20:23:14 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] PCI: dwc: pcie-qcom-ep: enable EP support for
 SAR2130P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
 <20250217-sar2130p-pci-v1-4-94b20ec70a14@linaro.org>
 <20250220072310.kahf4w4u43slbwke@thinkpad>
 <wa4vr63eiaiqq54aauxviwph2wbosrmfypxpxtw7w32la6qz7q@flhdoc4k3d6e>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <wa4vr63eiaiqq54aauxviwph2wbosrmfypxpxtw7w32la6qz7q@flhdoc4k3d6e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FAmL-SKdh3z-7_68Rt0VgS8ySwaUtcRU
X-Proofpoint-ORIG-GUID: FAmL-SKdh3z-7_68Rt0VgS8ySwaUtcRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210133

On 20.02.2025 11:50 AM, Dmitry Baryshkov wrote:
> On Thu, Feb 20, 2025 at 12:53:10PM +0530, Manivannan Sadhasivam wrote:
>> On Mon, Feb 17, 2025 at 08:56:16PM +0200, Dmitry Baryshkov wrote:
>>> Enable PCIe endpoint support for the Qualcomm SAR2130P platform.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>> index c08f64d7a825fa5da22976c8020f96ee5faa5462..dec5675c7c9d52b77f084ae139845b488fa02d2c 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>> @@ -933,6 +933,7 @@ static const struct of_device_id qcom_pcie_ep_match[] = {
>>>  	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
>>>  	{ .compatible = "qcom,sdx55-pcie-ep", },
>>>  	{ .compatible = "qcom,sm8450-pcie-ep", },
>>> +	{ .compatible = "qcom,sar2130p-pcie-ep", },
>>
>> Could you please use a fallback? I'd prefer to not add compatible to the driver
>> unless it requires special config.
> 
> This is a tough question, I have been thinking about it too. But granted
> the differences in clocks used by the controller I opted to use
> different compat strings without a fallback. I think it would be hard to
> describe the schema otherwise.

You could use if-else ordering or is: instead of contains: but I don't mind

Konrad

