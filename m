Return-Path: <linux-pci+bounces-31921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124F1B018EA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 11:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086E33B6742
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DFC27F16D;
	Fri, 11 Jul 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/9TXDuB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6827E7E1
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227831; cv=none; b=NJwJzj2kVfMzC0Lzqtdh1tuf6ba+9V8OQBltkvK7A12e3zkQgBFgXVlGclDl6chY/CMAfvi4vQijh0DtK/eOSHKxdgntWsD7Fw/i80SWxNUVW1qlPH2+g+TLenoTn9dfp9YaAMFz3MFg6dsPydkzSdZp5v4GtnFSUh4gcjLjPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227831; c=relaxed/simple;
	bh=enbfKkLsSZBEWGR0TQ1aBR/Caf7pFGAF+OXo++3GrIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lz6h9OkcZChys54dpDdLSLkDHOppEpaCRdwpZ1Mel1JUuay09TcPo0+n/IGX+zybsQGbSE6PKQbOT2Q0EftiWEX/98rFRe0LHZ/C3YiIWAzdx4JJ+eZXDsszkUgc3cTd4eB/vDAzRG/+xt6eiFCQRX2tyFHecpbeub/0KBROGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/9TXDuB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B3H21B017093
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 09:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V4oAm1F+mw0qWWBJIzHoogPbCCFnCCeogdv2Fm/i06c=; b=Z/9TXDuBX6DLWExy
	amIfnDq2nwAGxAmsKPGGMdV1zGp7rbIEd36Bcke7MdK/kpAls3A8j9AK+sroPED4
	w4Iy1/Pw2QG213/xbqAiXRDZ9WLaukhJc4mOGYo4DILOLcYOgBh0ktLoU61Pm4vr
	cDcI8ngeNVKeOqESAJ8aEWAOjCWNdyzzBpeaWTCsAb9HofRYBDYBjkDxBov5otr9
	boPqlh2/MuAeirb9RSiw2dqsNhc8OM7T7lO3jZPTGrNHHFl8YB0EuD8KLKLjWc7e
	waCZn6tFiQKk93dNh99sR0ScI93DWdOgFI+WEpHFfdPgQig7diPREBRYq+gNU7Rn
	D0tVxQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ttj9s072-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 09:57:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7deca3ef277so17183185a.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 02:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227828; x=1752832628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4oAm1F+mw0qWWBJIzHoogPbCCFnCCeogdv2Fm/i06c=;
        b=Pf97RoBaH4HC51fWA8l/L3Ordq5WxdHff/O5mV0mq3Qq1pOYdx0zCOyrYEFTVF2kj7
         Kagb063viSVEw/4RnpEFoc/djC0ADProElNrunS2zigjaduW/2kX4womzQ9I7s+t1mAU
         IVobDQXlAd0aMeESLTBT6czus3/FR6sN3Kyxsp3BUuyoQ9v6hSlsX+yfT9dWSjRlzfGN
         CoUF9tKY+6I3RZTBwuPGY/hl4KlMbvc1CTGHaZTR+3OfvabG7f7y1If79EkQ7DmAwWHm
         g9ZWt5Wbnf+jMmpH0tZml+doJLaBYZQPg5Z8CP7YdZdS1KeU/pLsnt+rspveLmvKAFmI
         owIw==
X-Forwarded-Encrypted: i=1; AJvYcCVhabEXqSysoGYn/EdkQejmUF+su5sFoApErB+AT4eodKl20TUXrlRChzSQ7xbs+sYOfsGD2hP7ISI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkioB+7sXFF7yFKWcO4FbLLTWle9Bvk2rl5bxvQeNbWiRDKzFC
	FH5gJaB23BP6Ctcr6on58tyyL5XoOvDmmUyTuKxJU+IbXOX0giYKdvglsP8q0W1KnTTGRtmdyAv
	llqoKpco6msujYSquyModvURuLcSBZFnNIdkSOHAzmkv+kOGsnMGRbscd/Wj4fZg=
X-Gm-Gg: ASbGncvASz/3PCvKzYlU6xGBOIEVOt72pbnkxzspft1w2XGZslsjsc3fd960a5SIDmI
	iX/hcDdiyL2okpm/pAJKaXnLrdg/DhcawCigzISOG+fWzzXveqhtWd+5/CwEqUwK1MezgQfbjfh
	1ytatllvUgJjqSs9OnLW6N9jv2RUV5fBuUZuUtAhQm95Fp4koEQFQpcH3Lh7ijo8ucstsflbu5F
	vkAvzGRJpG/ftprtaHOk37koAHaKUtY7B9u8zb+WUVCWj76JjOrD8ZuQsF2qajo6+69jEKiWPrz
	u0McfeHpZ3fW+aEErYo/O93Xg/j+1RXxrF8l0saSpukd9Hbdlafz2pK4vswihuYOlkerGJt2z6I
	JDHNR8eXGHKWHO9UjMzGV
X-Received: by 2002:ac8:58d4:0:b0:4a7:4eed:2582 with SMTP id d75a77b69052e-4aa35db7dcamr13443551cf.4.1752227827442;
        Fri, 11 Jul 2025 02:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYKec4bEyWI8YGiR6x1O+xUwfyU3XWv0u55EjX9PHiUbFeje3VltrjTPWAUpQi1AAK/4AayA==
X-Received: by 2002:ac8:58d4:0:b0:4a7:4eed:2582 with SMTP id d75a77b69052e-4aa35db7dcamr13443241cf.4.1752227826920;
        Fri, 11 Jul 2025 02:57:06 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e910f3sm273314866b.31.2025.07.11.02.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 02:57:05 -0700 (PDT)
Message-ID: <465f4136-418e-48b8-93f4-e384244cb913@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 11:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
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
 <20250625090048.624399-3-quic_ziyuzhan@quicinc.com>
 <20250627-flashy-flounder-of-hurricane-d4c8d8@krzk-bin>
 <ff2fb737-a833-474d-b402-120d4ed68d39@quicinc.com>
 <1606591b-5707-48bf-8f60-44063ecf8f1a@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1606591b-5707-48bf-8f60-44063ecf8f1a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfXzq/OnAJiGNDq
 egNybqlZ6g23fXmYI0zuf9NuMo2Ss0XIXVltLtW9wtyBiu+7h2f+ntdbg7Oz3TW1qW1JMUhy+r+
 MiFWpzauJE5kxtWfhjuY6Q5Hls5SOSNU7CWpcQOlE9FFjhR2An0xrubUU9D1Y4KIyBHsNuuPL/B
 zv/tGHz7ruuzxweLAcD9qqp4XRTYGRFZcGUk1/CLcLgnNoJuPrG0qQOKJceVozX23EfT2p1RuAX
 VBv8MdKJ0GWDi+AOnd8nJJ19phROAUdOFVDpujB7A9jvv6AQZJI0UFPa3FQQj99+LLvgooZbmVi
 evm8fqPHt03yf/5IEwcrqfBMgtKVG0cTwVD3k0jH74WTo/b1U+GgGvZ3O+NI7dUDyYWTXhgdi9v
 m54Al2P97PH7owYHsgTPKulJkdySygtTrC8FgPNGr0APyWV5o/eDdeX/249Yb+kRqYklFAXk
X-Proofpoint-ORIG-GUID: u8M0bZ20OMd1Jm4HiApCorIV6HQrg6MQ
X-Authority-Analysis: v=2.4 cv=Gu1C+l1C c=1 sm=1 tr=0 ts=6870dff4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=00NdyYYEmPKBbhCvcP8A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: u8M0bZ20OMd1Jm4HiApCorIV6HQrg6MQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=514 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110070

On 7/11/25 10:44 AM, Krzysztof Kozlowski wrote:
> On 11/07/2025 10:26, Ziyue Zhang wrote:
>>
>> On 6/27/2025 3:08 PM, Krzysztof Kozlowski wrote:
>>> On Wed, Jun 25, 2025 at 05:00:46PM +0800, Ziyue Zhang wrote:
>>>> Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
>>>> document it.
>>> This is an ABI break, so you need to clearly express it and explain the
>>> impact. Following previous Qualcomm feedback we cannot give review to
>>> imperfect commits, because this would be precedent to accept such
>>> imperfectness in the future.
>>>
>>> Therefore follow all standard rules about ABI.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Hi Krzysztof
>>
>>
>> This does not break the ABI. In the Qualcomm PCIe driver, we use the APIs
>> devm_reset_control_array_get_exclusive, reset_control_assert, and
> 
> I see in the binding requirement of 1 reset before and after your patch:
> requirement of two reset lines.
> 
> This is an ABI change. My entire comment stays valid, so don't just
> deflect it but resolve it.

Ziyue, the change is good, but it needs a better explanation.

Try something like:

SA8775P PCIe RCs include two reset lines: a core one ("pci") used
to reset most of the block, and a "link_down" one, used to ABCDXYZ.

As the latter was omitted with the initial submisison, describe it.
Because ABCDXYZ is not required for most of the block's functionality,
devicetrees lacking it will not see much of a difference - it is
however required to ensure maximum robustness when shutting down the
core.

----

Note that there are physically more reset lines going to/near the RC,
but many of them are either inaccessible to the OS, or very much
should never ever be. This is the case with most hw blocks, so don't
be surprised if you see a list with more than these two. I believe
"pci" and "link_down" are the only ones intended for OS consumption.

You can see some of that bleeding out to Linux on e.g. some IPQ
platforms that don't have a separate MCU (some flavor of RPM) that
would do the bus management.

Konrad

