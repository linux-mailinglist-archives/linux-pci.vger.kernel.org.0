Return-Path: <linux-pci+bounces-16618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACE99C67A3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 04:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2B91F24E77
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 03:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAA81632F8;
	Wed, 13 Nov 2024 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JX1qTyrT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BF7083B;
	Wed, 13 Nov 2024 03:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731467756; cv=none; b=iNnQtiPKQpYGxqlCc0M2QX+9nU5034PfDwZQmakIKj11ZsCb8limn5dNdvP5zI0d4wN1CcwKrkkN71fXbaOWKjN1VL/ISmHjYzcki1nm+7vxQId5z2Iwy+ySdBcxGmnZmWivNajEGPxxWwLvoet/Upqlv1mptPcm7ht40CoJ4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731467756; c=relaxed/simple;
	bh=Kvtqt9CB3FwQ88prvtB4P/v91yBTj+PcYS64KOGOY3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vm6LoZkIpMLoCNqOFtkzSwDOIlULDIBAKzhLiDdVki5tu89d4FMk+ujKK3h2e/xUOKkj6tuN4idOSjlhi9hi5b/VBT6+nhJvGoPX+jilximrYEweQkuEpOfBoz70VTX2lUHoIAAycZQjfW32XuoeqcncgF5ojYznL7EHK6cRP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JX1qTyrT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRgqn020160;
	Wed, 13 Nov 2024 03:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+0nLDjWPpDSaIUWRpCkibPRwNwq3e9MLwoKzDakWg+w=; b=JX1qTyrT7zAKVhlY
	RlEkMRqXDsI6mLayZ37Tij6MjkOAABzd7vU7rTN3cRkaAMtIL4s6WtUbLWD2PE41
	7858slkiUsa/VNI9mseBJ/vZsM51j5zzOL6gRMbxLVFsSnC21GbHiBZA19pMypFi
	wVibfE9gQv/f7vwkeB8EcGQLETrSTm5Swok5GJdOvMwOhPGg93B3w4FuJTvwrqoc
	IJbFbvtEZmzwWxFzmzGisGc7nmkxAoaH8Y9SQRuR8ToH+uUtYRj+QDfgPGHU3mxC
	DLa9HJP/7g5zqt3p00icl279ejEt7J914d7Z0eqJm0PfaA5NANgwcMRi/V44ioIu
	Ppdidw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42uc60e0te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 03:15:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD3FiTU000592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 03:15:44 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 19:15:38 -0800
Message-ID: <ef37236d-8856-4981-82fa-c0194d7b3dfc@quicinc.com>
Date: Wed, 13 Nov 2024 11:15:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
To: Johan Hovold <johan@kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <johan+linaro@kernel.org>
References: <20241101030902.579789-1-quic_qianyu@quicinc.com>
 <20241101030902.579789-6-quic_qianyu@quicinc.com>
 <ZyjbrLEn8oSJjaZN@hovoldconsulting.com>
 <de5f40ab-90b7-4c75-b981-dd5824650660@quicinc.com>
 <c558f9eb-d190-4b77-b5a3-7af6b7de68d8@quicinc.com>
 <ZzOQi0PpRZYts-B0@hovoldconsulting.com>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <ZzOQi0PpRZYts-B0@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GcnROkpzv1BlU-MSswyL8At-npoyDzuB
X-Proofpoint-ORIG-GUID: GcnROkpzv1BlU-MSswyL8At-npoyDzuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=812 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130027


On 11/13/2024 1:29 AM, Johan Hovold wrote:
> On Mon, Nov 11, 2024 at 11:44:17AM +0800, Qiang Yu wrote:
>> On 11/5/2024 1:28 PM, Qiang Yu wrote:
>>> On 11/4/2024 10:35 PM, Johan Hovold wrote:
>>>> On Thu, Oct 31, 2024 at 08:09:02PM -0700, Qiang Yu wrote:
>>>>> +            ranges = <0x01000000 0x0 0x00000000 0x0 0x78200000 0x0
>>>>> 0x100000>,
>>>>> +                 <0x02000000 0x0 0x78300000 0x0 0x78300000 0x0
>>>>> 0x3d00000>,
>>>> Can you double check the size here so that it is indeed correct and not
>>>> just copied from the other nodes which initially got it wrong:
>>>>
>>>>      https://lore.kernel.org/lkml/20240710-topic-barman-v1-1-5f63fca8d0fc@linaro.org/
>> BTW, regions of PCIe6a, PCIe4, PCIe5 are 64MB, 32MB, 32MB, respectively.
>> Why range size is set to 0x1d00000 for PCIe6a, any issue is reported on
>> PCIe6a?
> Thanks for checking. It seems the patch linked to above was broken for
> PCIe6a then.
>
> We did see PCIe5 probe breaking due to the overlap with PCIe4 but the
> patch predates PCIe5 support being posted and merged so it was probably
> just based on inspection.
>
> Could you send a fix for PCIe6a?
Sure, will send the fix.

Thanks,
Qiang Yu
>
> Johan

