Return-Path: <linux-pci+bounces-3668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51E685923F
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D462834DF
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 20:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627517E590;
	Sat, 17 Feb 2024 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F/IiSYaa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1EF7E581;
	Sat, 17 Feb 2024 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200192; cv=none; b=K10fpkDzqVFxeYJYvMxeiSabHM75TRCmLEkVZlv6InuQTfxY05tG0hdjPY1LZokHitHMI+GHAgW50WOHaon8z1zv+gN+ZYPu6WWGqapkg8A6LfYqmq4kDW95VcNiNuQkwNLmD7evJzQtKLyd1+Y0+favkVnz51ydikqOCLlNKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200192; c=relaxed/simple;
	bh=657CVr7tfJs38s/e+riEk+9HfKOiiqg4XsfObmLlsco=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l3rTffRrH3mP3lQT7BN/mQI+FNK3ryN6LVucpCly5s3+t2fHPV7o75woVcxQq7MbezM+FyuFnf3E+g3s6aNcH9dfvial6+sZpUo07BjjL6HabMKXTTcDc3QpPMAlELcIt0/1MJ0yM3ZuK3s8a/otg2wt6jgfsh2sPHTegKIM5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F/IiSYaa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41HK0vqP012879;
	Sat, 17 Feb 2024 20:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RoEi4O8xbtRc7rlAK2bkzLD3VTDSIZBvlHQgm7CqB4I=; b=F/
	IiSYaa+61kDkR/B1A+0O7XDmgL0DNBQNJKTlCHeMOvoOFIE2v16kcwvpzZD2FDoY
	1B2W/7ud5ob6R5TJx7sfnOWfgsNFFKjiD3pP4A7YdbRwDSpvcEuiLnX2eU8nYoVk
	UfwyyBvfb1b+Rab/85w+j7C6QvvhPg2JArFJcR+8rO3L3ZiaDpLFdjo6ZbqEJVv4
	EBBOFO2gevblf9AvkswAaGeLWI15bhn3t1n73BMxVfMBDIi6hkZqqUjWfLM+fu3a
	wGlgNO1rHDqCziYU2VtpNTgUCAMIwsFSw+AsJNuUmG2gr4yImxcVQE8exIv43XQc
	YA5vBVdhJMNgqYVaQ5Xg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wam4q0yny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 20:02:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41HK2cCk026372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 20:02:38 GMT
Received: from [10.110.11.212] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 17 Feb
 2024 12:02:36 -0800
Message-ID: <c084edd6-22cf-49a4-9dac-75163a1f4088@quicinc.com>
Date: Sat, 17 Feb 2024 12:02:35 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/18] dt-bindings: new: wireless: describe the ath12k
 PCI module
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan
	<saravanak@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd
 Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Marek
 Szyprowski <m.szyprowski@samsung.com>,
        Alex Elder <elder@linaro.org>,
        Srini
 Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Manivannan
 Sadhasivam <mani@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-7-brgl@bgdev.pl> <87cysvd2er.fsf@kernel.org>
 <CAMRc=Md10bNPswsLqdCmqzEmD+QmyZ+Eb4SUWknH-j5kK-speQ@mail.gmail.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAMRc=Md10bNPswsLqdCmqzEmD+QmyZ+Eb4SUWknH-j5kK-speQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cfNhiVdKuQrXnHOS8wjzgI2PKgKw5PcM
X-Proofpoint-GUID: cfNhiVdKuQrXnHOS8wjzgI2PKgKw5PcM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_18,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170165

On 2/17/2024 10:30 AM, Bartosz Golaszewski wrote:
> On Sat, Feb 17, 2024 at 7:35 AM Kalle Valo <kvalo@kernel.org> wrote:
>>
>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>>
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Add device-tree bindings for the ATH12K module found in the WCN7850
>>> package.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>>  .../net/wireless/qcom,ath12k-pci.yaml         | 103 ++++++++++++++++++
>>>  1 file changed, 103 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
>>> new file mode 100644
>>> index 000000000000..063c576b99a0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
>>> @@ -0,0 +1,103 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (c) 2024 Linaro Limited
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k-pci.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Technologies ath12k wireless devices (PCIe)
>>> +
>>> +maintainers:
>>> +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Jeff and me are the ath12k driver maintainers so shouldn't we listed
>> here as well?
>>
> 
> Sure will do. I also noticed the subject is wrong, should have been
> "net" not "new".
> 
> Also, Jeff is not showing up for ath12k bindings in get_maintainer.pl.
> You could consider adding an N: ath12k entry to MAINTAINERS.
> 
> Bartosz
> 
>> Jeff, this reminds me that we should add you to qcom,ath10k.yaml,
>> qcom,ath11k-pci.yaml and qcom,ath11k.yaml as maintainer.

OK, I'll update those files.

And looking at MAINTAINERS, in ath10 we have an explicit path:
F:	Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml

And in ath11k we have an explicit path:
F:	Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml

However the ath11k entry is missing:
Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml

So it looks like I have a few patches:
- update my entries in MAINTAINERS to use my @kernel.org e-mail
- add myself to the existing *ath1*k*.yaml files as a maintainer
- update MAINTAINERS to replace F: *.yaml with N: ath1*k to match any
related files, including the YAML files

/jeff

