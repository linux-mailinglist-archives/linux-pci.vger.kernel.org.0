Return-Path: <linux-pci+bounces-29324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C00AD38DC
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 15:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C1616E156
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0D19B3CB;
	Tue, 10 Jun 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ijXudvW+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D317A305
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561350; cv=none; b=NPEpOwcSIRj0D1iXW5xvetIINZXmY54AZY9X5hKJuQFHztIolTK2wP35X7UIZU9N5Ff1N27r1oqPDZwo4d0HkzS4fHksDkwIq8EuLgpXFzgAkLGZt6X4SbuA6vvSK1zfq3L1KafKIFnNi5xtCXpxgjgmLMgzxAvNN5X9NQPOKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561350; c=relaxed/simple;
	bh=5KHtsypxTOEwH2hoppvEko6q+MsIdk4Z+d5NAh05LDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JESnGDAJTlU4yaj33+scuYjyGgSyxWklhoIagABubkmeq0liXhrWQut9KI2jxwey8bt7E+m0FZ7cH9jpdkn55341O1nEGPojbrXStKRgnd3bCXRjIQqvhMeDd+ane4EsiTuYyHo1zAUzR6o+Ci7kOgCLINAipqIi1L6BSPXXzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ijXudvW+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A8N3me016705
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 13:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EwAmNEgz2U5R+Js4hjnEnVcfF/36zo6RLHZeqTJsg0s=; b=ijXudvW+2QCLsfen
	AvCbBi9I3LSakxmN0oAsNGHvKAGVW4Mg/6zczjaVLxk64Xdc3TyE6+DaEkCzUqSy
	Qxh8xhAbg+Xxx+6WkKkR+7MdWTJKxpp80fp9J4eJp8K3O9sVulnnNQ0MdHyuZa7f
	b1ZuD7t7BriHB2U25cWUblM6kbMrT/Y31FxGkiBcRo9/PVm1kMeI9MbgAcAHikCs
	0JFekTXbYZKXxCwGrdYWoxq/fprh7c1KqtIAJoRMCWNnynHFuQuGa08mrS9inTtH
	14l1CKq+edM3PLL5IM07eS8Zf5WGtOZ0ghVvbU05ekFqR38s8jx39P8XE/SPeibo
	wbT85g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dn69ffh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 13:15:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c76062c513so99122285a.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 06:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561347; x=1750166147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwAmNEgz2U5R+Js4hjnEnVcfF/36zo6RLHZeqTJsg0s=;
        b=RaRsh1BaqEp0LZmcTgAhBeGijcZttHxuQK1/tSQ053Q5qiDR0QUM/ijJKu2YeSMcm+
         DvbyJBhCx4Nce9xzeTRvTEqsBC3KtX7pUhTRKsl1odCzHTzo7SPrsV5OWZVYcPj0TbH4
         JkgZr5Yo02zlH7qMJwtnULOWGrg2dMmmVbr6mmbrUHQKV/hWDJTup2ySc3kSzgujS3rv
         B1YDOwQNcat6lk0Rj5q2RswKHZuFouie0WDMK3zudkVyIvlrt/iqdlJQZcY7boR7vH4s
         Yjo/You3XDhVjEHKtkkz9MdY7ubukzVTIBGCLTxHJV+lt7vJuBATrwlA751ckeyUHi/F
         fU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrWun+eCgrOlLiRHZMO+hRZxu8FmysmxwYtN4LQAUYE3rx28nQkdspLDRlkja02yWtYBgkNRLaBag=@vger.kernel.org
X-Gm-Message-State: AOJu0YymjD8DWQHRt1f9Rse53HM1hJZl41I4Ojcdmys2XUp+9j5VCUrh
	oT/cbFjWv6cDaSPOy4/MptihuRJsVpKNA0l0VeG3BgKNTTsopgkeUO/i2wdIWaV3N/Rs5uhD2OY
	r0TnYMuxpeclGCyOVo7m0SsZ2KTnPagtWjE6rgNmZlcfn40lAU+8X9Jqd9rbhQMY=
X-Gm-Gg: ASbGnctHbnh/b1wOAjo8sBEIOP4aHcbcoNBii5rSlBuCCuoUAY65YKSUt0vvfcYsChi
	qTcFw+PZ9M6pjXfcpS9QILisa5J2O3t89+/Q+faZBXnD8FkXfv+MyIA49m8e8FtXT6AC3lTxkzr
	T00d5wIhBUd+Gx7K01mK9CpbQTl4Mksw3ZGPKwzlpdJefv9mvm4lPnxpF0TyMrCXIs43xZrfVRP
	l7UeDU4Mglw8Em90NwQeLVA4xWfX2XhwsuCYgmaMchD+6rKx7lXi3U8VuyTk5Zhtc/2rFjY/SnV
	almmf91yQ8OhSMoRoxBmtdeLcXH68yJAYh9gPF4FmidazO6vBX4UrOxsa54EQlxoVeyRoGv83Cp
	Y
X-Received: by 2002:a05:620a:288d:b0:7ca:d396:1460 with SMTP id af79cd13be357-7d33df39118mr853770485a.14.1749561346916;
        Tue, 10 Jun 2025 06:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtqxF7J4fX5ZWQs38R17ip9jUcljtcIHttrdjrmoxx/VmubjbCQ1iXaj4T2zV2SHyjyVpQ1w==
X-Received: by 2002:a05:620a:288d:b0:7ca:d396:1460 with SMTP id af79cd13be357-7d33df39118mr853767185a.14.1749561346394;
        Tue, 10 Jun 2025 06:15:46 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783dd48esm6072351a12.56.2025.06.10.06.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 06:15:45 -0700 (PDT)
Message-ID: <56eccdb0-c877-431d-9833-16254afa1a0c@oss.qualcomm.com>
Date: Tue, 10 Jun 2025 15:15:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring
 <robh@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
 <20250419-perst-v3-3-1afec3c4ea62@oss.qualcomm.com>
 <20250423153747.GA563929-robh@kernel.org>
 <2ce28fb9-1184-4503-8f16-878d1fcb94cd@oss.qualcomm.com>
 <ba107a41-5520-47fa-9943-6e33946f50b1@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ba107a41-5520-47fa-9943-6e33946f50b1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEwNCBTYWx0ZWRfX0/Yvierr+uZL
 +UyShlPo+ZFPDdevKoMlMgkMRasDq22lTd4DculOVhCuF+q44DLOVL/izMtIQ2nJmhht8w9KUgC
 93JBwBpKOpW1wVwTYMKJC8r0cVj9tYe5kXhLsrfvO9kLd5jjWsRhGoM2IFxR9t3yQQWK4MH42sk
 uAlhareD2hwyRwLfDgvad0ZeEgSPCNo8641g5NLL8O94gyfsIKm1+YKK+oezXfSdVL5W/oXvogU
 Px49sZ9F3B4V7wB+rViZTldCGO+hxQBVrk7e8neyl8q5TZ6beEWRk/pbT3FH3cEG2MLjawad5a2
 tdmQeOBHRfvhal57dRe7Hdes7sjWfRqcjASeA5I4W5DTezxkXIIkXy6uL6XYVKV5DABYy79UURs
 Tn5oc/MGUoLrAOp5lNE3+PSJNOKlx64EK3dm9onrPd0KYxcuCYaQlLIiBmFR5Nve5SSwtHhk
X-Proofpoint-GUID: LcnszdniXjOJaYyWkHzzEAIhGk-ACLsH
X-Authority-Analysis: v=2.4 cv=FaQ3xI+6 c=1 sm=1 tr=0 ts=68483004 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=IJG2AnB_qZu2HhMjgm4A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: LcnszdniXjOJaYyWkHzzEAIhGk-ACLsH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100104

On 6/2/25 3:01 PM, Krzysztof Kozlowski wrote:
> On 08/05/2025 16:26, Konrad Dybcio wrote:
>> On 4/23/25 5:37 PM, Rob Herring wrote:
>>> On Sat, Apr 19, 2025 at 10:49:26AM +0530, Krishna Chaitanya Chundru wrote:
>>>> There are many places we agreed to move the wake and perst gpio's
>>>> and phy etc to the pcie root port node instead of bridge node[1].
>>>>
>>>> So move the phy, phy-names, wake-gpio's in the root port.
>>>> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
>>>> start using that property instead of perst-gpio.
>>>
>>> Moving the properties will break existing kernels. If that doesn't 
>>> matter for these platforms, say so in the commit msg.
>>
>> I don't think we generally guarantee *forward* dt compatibility though, no?
> We do not guarantee, comment was not about this, but we expect. This DTS
> is supposed and is used by other projects. There was entire complain
> last DT BoF about kernel breaking DTS users all the time.

Yeah I get it.. we're in a constant cycle of adding new components and
later coming to the conclusion that whoever came up with the initial
binding had no clue what they're doing..

That said, "absens carens".. if users or developers of other projects
don't speak up on LKML (which serves as the de facto public square for
DT development), we don't get any feedback to take into account when
making potentially breaking changes (that may have a good reason behind
them). We get a patch from OpenBSD people every now and then, but it's
a drop in the ocean.

Konrad

