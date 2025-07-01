Return-Path: <linux-pci+bounces-31142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A19AEEFE5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 09:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B7D441321
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 07:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD49672601;
	Tue,  1 Jul 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kqzinbpD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4D25E479
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355633; cv=none; b=B9mx9w2mPBJxe0DS//OISNj8iSL/LHX9hdzRQknzAWAauMJjJ+RptdNiSiY6DpaX4BfeSPNpdYYMkX9sv18phjDg4CtvJue4FY1UjTmU9Dz/XmYLNdBlBEVOJJ8tBaP6qBixH+UaqqGFL7Cck+ugCpNPMFCQsLJKYJs1yblcmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355633; c=relaxed/simple;
	bh=yD+gTzX65UHJgMgaHXUtRp/UqZB3K8WSvA4L6J7/iWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFLsizC23QCcXJkwq9uA2z0lmXasxfuoguGBSnDkazP8Y81sfE9YeIFDCH6KkKeT2q48dgs/VzgvL9ycQCVXc2ZADtzhsheSketogcfgppf+e5s1pyB4kWyQ/YzHHXaSJzxM7o60MEoNXcr2Vsjh+l+OSBmXJvey6ISDdOlyxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kqzinbpD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5616fUHe029895
	for <linux-pci@vger.kernel.org>; Tue, 1 Jul 2025 07:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9FJpgLVOiD37cYFqSGkdmMgvU4F7xSlbYlGdvhvvuUw=; b=kqzinbpDsgdG2QUS
	YY2Sstvk7QTvAoViLiWREvOunSo9e/Al7nwST0OPYVl4JWej7BeHIDKz/QBXQOTX
	ca/3bIsGLLUASNpzfkLQ4eGD77nAUhwxBq1h3nlc7M/+l6LE5s9+GIhj5maSSCxk
	H2dGNHGDh6pjJMO0OVX1PXYr3r+Ri4e67rfu++1/2xdxYg+IN0nGVZjqJ13JI7z3
	BjUNz3+QhYVjwzOsnQBIVE1M7ubOYaTs9h54dWJy2KVs6bBQ2+bF71XauaHKOx3X
	nlqo/HnUuhcYSKn+e3h9qju2W9J3Y3zZwxiqVXZYqfTwlubECMcWeQvk8FXIUbwK
	0KJIMw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47m02v1qq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 07:40:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-236725af87fso64411085ad.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 00:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751355620; x=1751960420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FJpgLVOiD37cYFqSGkdmMgvU4F7xSlbYlGdvhvvuUw=;
        b=rPmGi9HYnEL8m5hja112yx590S/zkpYQ9/XmJDwB1rpz7qDdiQE3WQfuLdc6ehMU53
         uzVZSvjezIk/v/aymbS73/eY/LWaX+EV3T80VsXrzLUEcQW+bUw/DKt5Cc2HesyNGbgY
         cO/3pUrB6qYDFQlEuNjbyJHdKWnT1211F+qRXW1dzkBIiTh8okOpfqwdBpXcXEQT+4RB
         g/QMozFHy09zwFr8fHIupvGJCp6bMcjaxRsHOYKRwJ8YNUrh9WhJJ7GFUGU3ig//fulw
         gC7tiRnviIXTGhmz/WhYN+IbJ1+e9/RNUs6y0LQNgTdEiBF9jOwuGSvRZBkfUjV7PoKa
         tAGw==
X-Forwarded-Encrypted: i=1; AJvYcCWADlqpzBA1e2/DDkhtS149VKkmE4ymeHm/42GKPqh3zSU0AqJkK1xx1d3Fj65Ozyrr0ZxjS4uYJrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiOAozKguVXhlLbQldgNEdUIviY3KQZbYlcyCaINg07y81u/AX
	zQu8/Ztq4oRImH9ia4j42rHKJddQIffxW4DcaF5hrdljFrGv2De/zPqm3+veKloYjg0KcGHx7NM
	Cj2wGT+aTkYGJRc9tu7EIAYMtUpZQVo6OaEMWkU2b8VVK1nzygI58HiDsllDWiso=
X-Gm-Gg: ASbGncsp5+RE/8A3dSjHpcGO1EQJR5QLR5kZNpF3HfQ18HDIEz94eXs+oLUMXoXq7ux
	XgJV0Y89zmFGVHDTK20fbnU4x3y5cfoLJb+JZGYlV3lyoAhwi+j3/LQ9/v4mCNE477SEfEddO2s
	aI2mDbKQIJgNf4huEms+8QiRtfLvLJ1aEVPN9XBooJU17bre6AoD44JIQd7Bb+M175H1WpLJYRl
	dAd8mv58gCpyLgpQHpy7OL4c/GYN4sJw+WjP3BCgAZuQGM0/+I68Qm0RmTYQ9ahTp59Ir7ye5HL
	c3N3GLDazcYTTEJV9MWb88lTnkXfUp8etPTF8HItGjuMnaYK9KNI
X-Received: by 2002:a17:903:1a70:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23ac46270f7mr205402965ad.30.1751355620384;
        Tue, 01 Jul 2025 00:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6PfU55PeZ0THoeIsQvpLSXshyFj5bq+0QDrT7N2DDDg3D3DoMl91iR6zJ6C30Jos6dGx8tA==
X-Received: by 2002:a17:903:1a70:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23ac46270f7mr205402505ad.30.1751355619911;
        Tue, 01 Jul 2025 00:40:19 -0700 (PDT)
Received: from [10.92.200.128] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c2352sm97622025ad.208.2025.07.01.00.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 00:40:19 -0700 (PDT)
Message-ID: <d055d163-a0a7-41c4-90e6-0606f9b6eb89@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 13:10:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] PCI: Enable Power and configure the TC9563 PCIe
 switch
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
 <ps5ck23ubpo2vdxzko6yixujlf7mqppdssqrc5bz3vbupmn6cu@yc2ld2tb3r2b>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ps5ck23ubpo2vdxzko6yixujlf7mqppdssqrc5bz3vbupmn6cu@yc2ld2tb3r2b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA0MyBTYWx0ZWRfX3R0l0ChBv+Z5
 04QxHaDs9vMpe4OdP3FKycMmqiMGuG6Ea3Ja+b4Swx2Bz8qXGscsazv1h+OzjqLazPbsz4ztD5j
 lsieokW5wfcOW0FdEADgPppRlAa9j4zBJ42Dxf+eQr6aQfxUnPtHFeHRV//s9d3SvdabWNQL70u
 09D891l1csOVsqzg26WNGRiteOY/iw+EjAzNWv833IB7Z7l1vp7m1/Nx5a3Jm5ZRstc+XRu22jf
 GJNehI820wvEgJksCxEmYCH32girQLMMBp8Z7Pq+Du9wluncL5bQSEhEJvl/apmaVfZOSnywUU/
 F583ajou/QAcmrn3pfb8oVwjRF1UfX05vyhj3EWM32Ezrxk/xWiUtvjgCHyGJieaIkPovvUbV/H
 VUcH83FhJ/yp8T0FZjHwTIB5q1I4OyBEu5WwnBBzuPaDgaBDjr6RfwR9vPtPaXctkE/sg1Hm
X-Authority-Analysis: v=2.4 cv=Y8L4sgeN c=1 sm=1 tr=0 ts=686390ef cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=MuaoRvlZ_d6aMCo3pHsA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: pqFitFJtXYT9HQot0rZNCzdFxQldJwVt
X-Proofpoint-ORIG-GUID: pqFitFJtXYT9HQot0rZNCzdFxQldJwVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=933
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010043



On 7/1/2025 12:41 PM, Dmitry Baryshkov wrote:
> On Sat, Apr 12, 2025 at 07:19:49AM +0530, Krishna Chaitanya Chundru wrote:
>> TC9563 is the PCIe switch which has one upstream and three downstream
>> ports. To one of the downstream ports ethernet MAC is connected as endpoint
>> device. Other two downstream ports are supposed to connect to external
>> device. One Host can connect to TC956x by upstream port.
>>
>> TC9563 switch power is controlled by the GPIO's. After powering on
>> the switch will immediately participate in the link training. if the
>> host is also ready by that time PCIe link will established.
>>
>> The TC9563 needs to configured certain parameters like de-emphasis,
>> disable unused port etc before link is established.
>>
>> As the controller starts link training before the probe of pwrctl driver,
>> the PCIe link may come up as soon as we power on the switch. Due to this
>> configuring the switch itself through i2c will not have any effect as
>> this configuration needs to done before link training. To avoid this
>> introduce two functions in pci_ops to start_link() & stop_link() which
>> will disable the link training if the PCIe link is not up yet.
>>
>> This series depends on the https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/
>>
>> Note: The QPS615 PCIe switch is rebranded version of Toshiba switch TC9563 series.
>> There is no difference between both the switches, both has two open downstream ports
>> and one embedded downstream port to which Ethernet MAC is connected. As QPS615 is the
>> rebranded version of Toshiba switch rename qps615 with tc956x so that this driver
>> can be leveraged by all who are using Toshiba switch.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> Krishna, the series no longer applies to linux-next. There were comments
> which required another respin. When can we expect a next revision?
Hi Dmitry,

Mani asked me hold on this series as he was working on some design
changes on pwrctrl framework which can impact our design too.
Once Mani posts his new design I will respin this series.

- Krishna Chaitanya.
> 

