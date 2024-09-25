Return-Path: <linux-pci+bounces-13476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718BD9851A0
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DF61F22795
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 03:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D88114AD2E;
	Wed, 25 Sep 2024 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CB+9O0z7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2220E6;
	Wed, 25 Sep 2024 03:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727236056; cv=none; b=GnEnWunObZj/mZldf26tYZP7OeDHqcXnxjs7miZ/sihGNVJhsBODzO+dklyAS7u6qntepolL6+zQ1qyruKkuF2SEdAtEJxbWRuehAKEeKdFfgIqOq7ippm6TV9voWQqhw+D8QnUOit8rA3UrlJmh9Jq2SCEN9OurlLqewWUViNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727236056; c=relaxed/simple;
	bh=wJSHAGZB1yAp8bC3kr3qM6wzwbQEe1vWjbioPCAdcuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QFTZLgqkLjRHuMtbsIdORlpDcsAMMYw4WNfykaPU8gJwznmml03bHQYtljbXOAn18rUbI8lD0UTirKOB03HS1H+sSUgVmvWqPmN0OIcpgxO2N7ROL1yvpNs2wFk0vAkGaGzXBDdvvIpWbyAN/FeZ/6hA2obWkfMh6IqWHj6neFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CB+9O0z7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHo2VZ026410;
	Wed, 25 Sep 2024 03:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wJSHAGZB1yAp8bC3kr3qM6wzwbQEe1vWjbioPCAdcuQ=; b=CB+9O0z78jCek4kR
	772c9wdrOYtwJj61NwVs33VSAEidUxV1gTRXFGvqZmnPP3bAOaZ8jB/4e6Ys8YiD
	0ckw5SagUVy1mBU8i3dtAL57nwJgpSeddak3N2rxkGmjR2xqysRO5T/zZW+3yr8u
	zTUs63286hW1dUDrs+aVgDYfMqTr6SQ7Pm7lZ8qj6WuFwRXCdU7hLw7TrBxGNTgA
	fdIc8gJ5L35x/4Wno+Xi2A76CFgJql+4FQUeZMUooJ//CGSxN/pONkh7FAG5i5y0
	MGaomcB+DnwvJSIAUV1616fx18NdQCfXFX1JsDoS74j6tQB3rKdmVdXnnO5BC54Z
	jijupA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqakjd5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 03:47:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P3l93T030053
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 03:47:09 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 20:47:04 -0700
Message-ID: <4368503f-fb33-4e6a-bef4-517e2b959400@quicinc.com>
Date: Wed, 25 Sep 2024 11:47:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] PCI: qcom: Add support for X1E80100 SoC
To: Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <abel.vesa@linaro.org>, <quic_msarkar@quicinc.com>,
        <quic_devipriy@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <kw@linux.com>, <lpieralisi@kernel.org>, <neil.armstrong@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-6-quic_qianyu@quicinc.com>
 <20240924135021.ybpyoahlpuvedma5@thinkpad>
 <ZvLX_wkh7_y7sjPZ@hovoldconsulting.com>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <ZvLX_wkh7_y7sjPZ@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nKJX1farwRB5J1ChEqRFcKmEIGJMqx-p
X-Proofpoint-GUID: nKJX1farwRB5J1ChEqRFcKmEIGJMqx-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250026


On 9/24/2024 11:17 PM, Johan Hovold wrote:
> On Tue, Sep 24, 2024 at 03:50:21PM +0200, Manivannan Sadhasivam wrote:
>> On Tue, Sep 24, 2024 at 03:14:43AM -0700, Qiang Yu wrote:
>>> X1E80100 has PCIe ports that support up to Gen4 x8 based on hardware IP
>>> version 1.38.0.
>>>
>>> Currently the ops_1_9_0 which is being used for X1E80100 has config_sid
>>> callback to config BDF to SID table. However, this callback is not
>>> required for X1E80100 because it has smmuv3 support and BDF to SID table
>>> will be not present.
>>>
>>> Hence add support for X1E80100 by introducing a new ops and cfg structures
>>> that don't require the config_sid callback. This could be reused by the
>>> future platforms based on SMMUv3.
>>>
>> Oops... I completely overlooked that you are not adding the SoC support but
>> fixing the existing one :( Sorry for suggesting a commit message that changed
>> the context.
>>
>> For this, you can have something like:
>>
>> "PCI: qcom: Fix the ops for X1E80100 SoC
>>
>> X1E80100 SoC is based on SMMUv3, hence it doesn't need the BDF2SID mapping
>> present in the existing cfg_1_9_0 ops. This is fixed by introducing new ops
>> 'ops_1_38_0' and cfg 'cfg_1_38_0' structures. These are exactly same as the
>> 1_9_0 ones, but they don't have the 'config_sid()' callback that handles the
>> BDF2SID mapping in the hardware. These new structures could also be used by the
>> future SoCs making use of SMMUv3."
> Don't we need something like this for sc8280xp and other platforms using
> SMMUv3 as well?
 From what I know, sc8280xp and other qcom platforms are not using SMMUv3.
X1E80100 and newer platforms will use SMMUv3.

Thanks,
Qiang
>
> Johan

