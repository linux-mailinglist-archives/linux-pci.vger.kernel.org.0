Return-Path: <linux-pci+bounces-29457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04166AD5A33
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F71D16067B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7B51A5BA4;
	Wed, 11 Jun 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHg0w8FU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07A1A23BA
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655037; cv=none; b=kAw2zJN56pp8OzRmd1N6WMP+OBPB6mTq6fCUdzK5CcyXMwS0qX18hiVkDiwwyAyaxOLN8xNZp9cs3RD3KsXDBzluDsml5JIs0x0Hgc6TjHxjRpGKdws3WouEu9/ItbP91D26a28keBUy114YzxaxvbI7ehyEo/ADohe/KVptHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655037; c=relaxed/simple;
	bh=pGgotr9k0uSAGJ/bX3htTWswsENYRPWHaegUlGQDCiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Af/ttMmWwHx/87IVnF8TlTfoieVAGvotBAT4CiIsMMHYC5Mn3IILYuAmPbLkcRqE+eDsUbEy3w2e0bmRV560jGtuekDT+/hd73QGZBuLwhaG1MtPogGWpllSGMUHMqDVmQl1tsS3TsTUGSmPnV8T3CgkEOYzBFF+m1OYXwYvc70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bHg0w8FU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DFVw011018
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 15:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EqTW/NVYvWCa/RrQ71wsb3xnRvish0J2TidcBsJz/7o=; b=bHg0w8FUw0YHtQ1/
	sj9ponopkcNURpPNqj5l1H+rnMWzzdZ7SZLG1ZXxNPz3yyk6zC3604OL+CJbpwo9
	5iQXv4yib1niyonEkfGcnjVMxlMGGjD/S35GG2rzoa3W6MnIPkKV0ukZR+uY6+sM
	qYm3lnfUXwLKcHHntAus0CvsV4c4I4I39ItEN16x2pqVAXInbdJZ+CuPcu4Mz0hw
	t0L9Fxaz7+syk/gz1ulRNnqjepbu2Ik+yqEs5XCsi9Om8svcCxehpJ9gfGXlyJC5
	jec5kGcgc/jq4btiB5AqXBLNVPISFo0NRW57EggMVh3IVCk62wAFK3ZfUVx3kKUI
	DX3s5w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ekpw3h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 15:17:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d094e04aa4so20451885a.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 08:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749655034; x=1750259834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqTW/NVYvWCa/RrQ71wsb3xnRvish0J2TidcBsJz/7o=;
        b=IpR5i39jK+3I4aA+PN+uruyCH8UytpghRgYQWlZwIAl2gbWy6BzVpiCzArSUJifkMv
         QbShbe3jKwHwY29yN+CKwFWD38ZgEkRUxMfiKJoVpw+iFf/iDQ57vRnr5gawQ9C0q9Jb
         WZqE+YvyTMzvN5ZZdiSHxOWJ1gO3BJ9ddzEHcR0d1xCkwc3a7/uzWBRGQZCFawdTDR6x
         GOmRihKsyZDGxRQAwRgsP6ooV/fyKsOGujpne3npA0PohOM7q+/mLDHVyW0a+FB0Zn57
         SyGKqy9HWwaoV0r10MBfxvmjpuflmtrzYYgirPSAEFmrLI1Ve/JNLrhld3xlMmkMXRAN
         5hPA==
X-Forwarded-Encrypted: i=1; AJvYcCVMr25HvU1A5CUU9Zr71QQXcJvnNtkQgqEQeBh2nU9ClHoouUMCKJjMsRNzlepIf0sH0q4ClP7LNP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKeR+Ys3GeIe+wXKFqvD6Yb0wjKdQG4NjK/gaINf05Z4SPFMf8
	I7qZ5VRB2T1jIZU4KzOmSqdaBipiFx75CqEhxKaZvrHcu+DNIZ9/NNyspiAE6bwGqjPvA5mtj8a
	jOOiuHuIsXSTuboC3GgARRui8csrjc9yDmVhaq0FGPUxHnE799xcXRuux5qGCghg=
X-Gm-Gg: ASbGncu/DRUe/sOd27vgx24/Zn+ppWhfDMK0jf2ei+XYp23O259BeHjubpOkPvwSnfa
	rSZ2NRR4iqEOQj9IIYe8YAiUcQu7IMpCn8c5ozWoB36n2C7SqPHMLaUqm/2kCZPn3lm2lfN9NSO
	na3mllvHnVRSpUqSQSqmZPOTOr6UtlAcCz63uSdOvgheyWPpznmAfyGdywJBf+wfha1ki9Dc3d8
	+GAX6/4BNiU9TdNs6cjeb4DpSxG5OO8dIuUO+VLZiguJz6TuwZRummOl9CidykbuCXx92n/5Ycc
	klIRfOQ//sWT4IWakgmEsPjskDSEMuPzz0mLhmqfPwmmeZ1Zk5Zh9E5XnVXoUZ4N6F8QdAEQIXD
	4veY=
X-Received: by 2002:a05:620a:800c:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7d3a8865591mr218866885a.14.1749655033548;
        Wed, 11 Jun 2025 08:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOlrj+WvRgsqxAguisTMF18suedyxOAw5Xm9Xpltd4DgN1JJ+kNX5luk8nv8h7J7EhzglSGA==
X-Received: by 2002:a05:620a:800c:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7d3a8865591mr218864285a.14.1749655033020;
        Wed, 11 Jun 2025 08:17:13 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c771sm906550266b.103.2025.06.11.08.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 08:17:12 -0700 (PDT)
Message-ID: <7eca5cd3-9ab8-4c42-93e8-d8043dd26408@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 17:17:09 +0200
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
 <56eccdb0-c877-431d-9833-16254afa1a0c@oss.qualcomm.com>
 <77eeca94-0703-44c9-b30b-17fc989dedb7@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <77eeca94-0703-44c9-b30b-17fc989dedb7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JcO8rVKV c=1 sm=1 tr=0 ts=68499dfb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=lYUf8r55RHZWWh1rIM8A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEyOCBTYWx0ZWRfX9ziibfLfV3p1
 60qIw7V4eRKnsnRswCJS2a2aG6jdU1UI2rYrchZaBG9UoK5pYmiX8ZT9ka5o4oRsB3sWcrxHF3Z
 gyUaOI68wKmnYWO+qdgDL04qXBnTfsdaUVX4LtTCPRQ/dzARTmQhcRQBDCkvK1f1qFPzpLuNH7r
 u8Q8KH1VZhyuWvdSF3IwCip4uxaSmpzoJMmZncY1P14LbFxsH7D7HXpf+bAvxPLCQhMJUf6ODI2
 Jd7TfAYadjAlbT8n4wFibnS41CHuC/sIULOybjKzKrf7BCruP38grmHrYbUZR0BKH5cy58SamvO
 eiiQcsECezfKcsTEGSWpj9CBaAGLH4kaslxN+/fiAfjMLscaSAZAFSSV2UAGbI5xXsupMBZDdWX
 Mgw7WDy/WsG6sYFUqIMSpPu+LP9CYeSzJ2rBVTk3+JAZJvb451Wc4YP5QMQZRv873bugZjfi
X-Proofpoint-GUID: zBHndDa3g8325qtKX-ovUf4LbV_kn41B
X-Proofpoint-ORIG-GUID: zBHndDa3g8325qtKX-ovUf4LbV_kn41B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110128

On 6/11/25 8:36 AM, Krzysztof Kozlowski wrote:
> On 10/06/2025 15:15, Konrad Dybcio wrote:
>> On 6/2/25 3:01 PM, Krzysztof Kozlowski wrote:
>>> On 08/05/2025 16:26, Konrad Dybcio wrote:
>>>> On 4/23/25 5:37 PM, Rob Herring wrote:
>>>>> On Sat, Apr 19, 2025 at 10:49:26AM +0530, Krishna Chaitanya Chundru wrote:
>>>>>> There are many places we agreed to move the wake and perst gpio's
>>>>>> and phy etc to the pcie root port node instead of bridge node[1].
>>>>>>
>>>>>> So move the phy, phy-names, wake-gpio's in the root port.
>>>>>> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
>>>>>> start using that property instead of perst-gpio.
>>>>>
>>>>> Moving the properties will break existing kernels. If that doesn't 
>>>>> matter for these platforms, say so in the commit msg.
>>>>
>>>> I don't think we generally guarantee *forward* dt compatibility though, no?
>>> We do not guarantee, comment was not about this, but we expect. This DTS
>>> is supposed and is used by other projects. There was entire complain
>>> last DT BoF about kernel breaking DTS users all the time.
>>
>> Yeah I get it.. we're in a constant cycle of adding new components and
>> later coming to the conclusion that whoever came up with the initial
>> binding had no clue what they're doing..
>>
>> That said, "absens carens".. if users or developers of other projects
>> don't speak up on LKML (which serves as the de facto public square for
>> DT development), we don't get any feedback to take into account when
>> making potentially breaking changes (that may have a good reason behind
>> them). We get a patch from OpenBSD people every now and then, but it's
>> a drop in the ocean.
>>
> I don't understand what you are commenting on. Do you reject what I
> asked for?

If the general consensus among kernel PCIe folks will come down to what
this patch does, I think it's fair to shift to a "correct" hw
description, especially if this is a requirement to resolve a blocker
on functionality (which the author didn't clarify whether is the case)

Konrad

