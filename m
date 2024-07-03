Return-Path: <linux-pci+bounces-9710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE3D92573E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 11:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E93B21DCA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD35C13DDCF;
	Wed,  3 Jul 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fgOb2eyl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3C13DDA3;
	Wed,  3 Jul 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000213; cv=none; b=Nyn4XIsjvW+XQbX/zPVSAwb+sar0zqG80iBx52pWu1I14LJE5XRz/vsW8KO4H7NmQghPWyoGSHeK6sGGe9/1Npu4VJJypKXuEleJZ8nhfE0NeSWXdCzzCdFAagR/xnJi4S4wDkeEw1l1KeO4yxOVdYeMWpoB881rjPX0MBna5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000213; c=relaxed/simple;
	bh=acghGTS4hAklAZ2imwEsU8Dr1XC4qbENVq+v8SXSkhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ia8bafeTbzJNe0UbNIP4d/ReUae/VTS3H0bbiSpc+epnvedDCWFTXjIiB0mBH/aROdUDz4LMTE+55HOio9F1jIURN2nysTDNdZUbUklhPcWiDJPOQFzv61U7wvayS6zuX9xHQbD5NnFpUPvu59TKp3dW6AGvQOmGAKd1yu6U4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fgOb2eyl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4637uuPo026176;
	Wed, 3 Jul 2024 09:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r6PDo3ZmiND29AWr6xwATv2xdbzZhoXvEb3979p8hvo=; b=fgOb2eylbajis5N8
	ilInFJsChuMPbqsDA/wN7LFmAn5tS+jCd49TPxAQklol/D7qgTGt0Y1EZeZjsxuY
	EgALPNsEoSpujmS1DMKVxI7BJ/iK9yyKw3DROVe/RAPYMthBoNT07ja1G9QJybJ1
	3ijh0MmK4g5PkY5yjhqjVCeT9QtxVwDh2KBfC0Rq3X33uHZeJdTluSYNSyHr/DUh
	d+SuPBMD7VYAPUN80xDPa45ckZvYduMHTxgOH++tG6zHEW4U6qJrupzkB8Q1zzd/
	cRHhAiktD1GpLNCL7l7cLRyhcIWKrcCoNeSx2d/n35tuRSbwR/rcEQQJk+BLdxYk
	qB58XA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027mnrqvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:48:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4639mSdZ005772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 09:48:28 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 02:48:06 -0700
Message-ID: <d60e0658-b670-44eb-bf6a-60a58c1742be@quicinc.com>
Date: Wed, 3 Jul 2024 17:48:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/47] dt-bindings: arm: qcom: Document QCS9100 SoC and
 RIDE board
To: Krzysztof Kozlowski <krzk@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <djakov@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <manivannan.sadhasivam@linaro.org>, <will@kernel.org>,
        <joro@8bytes.org>, <conor@kernel.org>, <tglx@linutronix.de>,
        <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <linus.walleij@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <vkoul@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>
CC: <robimarko@gmail.com>, <bartosz.golaszewski@linaro.org>,
        <kishon@kernel.org>, <quic_wcheng@quicinc.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <agross@kernel.org>, <gregkh@linuxfoundation.org>,
        <quic_tdas@quicinc.com>, <robin.murphy@arm.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <quic_rjendra@quicinc.com>,
        <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <otto.pflueger@abscue.de>, <luca@z3ntu.xyz>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>,
        <bhupesh.sharma@linaro.org>, <alexandre.torgue@foss.st.com>,
        <peppe.cavallaro@st.com>, <joabreu@synopsys.com>,
        <netdev@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <ahalaney@redhat.com>,
        <krzysztof.kozlowski@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <dmitry.baryshkov@linaro.org>, <quic_cang@quicinc.com>,
        <danila@jiaxyga.com>, <quic_nitirawa@quicinc.com>,
        <mantas@8devices.com>, <athierry@redhat.com>,
        <quic_kbajaj@quicinc.com>, <quic_bjorande@quicinc.com>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_tsoni@quicinc.com>, <quic_rgottimu@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-gpio@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <kernel@quicinc.com>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703025850.2172008-2-quic_tengfan@quicinc.com>
 <665f6c8c-4f43-4d20-90e9-9e037a942066@kernel.org>
 <fbeb5969-0b3a-455e-88eb-b83734bf2c50@quicinc.com>
 <97c9484b-e257-4163-a104-3457d59bc69b@kernel.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <97c9484b-e257-4163-a104-3457d59bc69b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4iQ3c_4SVvTyiCWE8YBXnnMoC_qGpXdF
X-Proofpoint-GUID: 4iQ3c_4SVvTyiCWE8YBXnnMoC_qGpXdF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030072



On 7/3/2024 5:33 PM, Krzysztof Kozlowski wrote:
> On 03/07/2024 11:21, Tengfei Fan wrote:
>>>>          - items:
>>>>              - enum:
>>>> +              - qcom,qcs9100-ride
>>>>                  - qcom,sa8775p-ride
>>>> +          - const: qcom,qcs9100
>>>
>>> This changes existing compatible for sa8775p without any explanation in
>>> commit msg.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> In the next verion patch series, I will provide relevant explanatory
>> information in this patch commit message.
> 
> TBH, I cannot think of any reasonable explanation for this, especially
> considering rest of the patchset which does not fix resulting dtbs_check
> warning.
> 
> Best regards,
> Krzysztof
> 

This patch may need to be updated based on the results of dtbs_check. In 
the new version patch series, I will revise the commit message according 
to the patch updates made.

-- 
Thx and BRs,
Tengfei Fan

