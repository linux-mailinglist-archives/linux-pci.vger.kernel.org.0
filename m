Return-Path: <linux-pci+bounces-5126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E288B0C8
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 21:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12583024F2
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 20:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1AC3C6A4;
	Mon, 25 Mar 2024 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SomlfL+H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286F10940;
	Mon, 25 Mar 2024 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397061; cv=none; b=pAKuCscD2od867yhXbdUTsPEzIQ2KuUitpZ2I4+z15m4ZPxdZmQhdXem1kXKvDPokCjYvjYIuW8rUS4O9XuPWk6MF976PiJ3luq3bJMBqinuMy/ZsH3K9CFLyfo7q3CD20xK9rT5r8m2j1M7AGgsV7zhu29pWNwJroIfXsLmV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397061; c=relaxed/simple;
	bh=7LbosvrRoSaOFVXQNHiQGzHq/d1asJ/LAmMmK1qoAOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uZ9XpgQ9agVbCYDc8NnSxR6j8tAmnLIdp2L/j+/nAEVWi0rhWFuQHVgAx74p2sMSQdkhV3wgnXx4qzZRZ0xoS49VZpYnLtmaz4tOXRHzbKjlHe4+E9LCQvLZFbAN/AdqNSeDq93Hm3xce/JW4rPIwBt4P5H2ac6EHCqVLNGKgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SomlfL+H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PIuBuO017962;
	Mon, 25 Mar 2024 20:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=h+1UxwxuvCslZU2aNyiMM9f3pn/NiRqoN5yz+kk6g5M=; b=So
	mlfL+HDTZJC1n3IMkgeXNeqt1HUmnWw6VJ03VK+CJ6SDIWdofyQdB9DoVuaCtpYK
	7vFB/JC803KoaRTgSGWX1PJrR6FAH7tVfAEW5P6mOmjtmu6hmFjcuSrFwfQywpnN
	RQK760jtY3C0n+qV4AD+ynWyNzoyfO1HezeRJ9KeCu85B2OOyzAGXSmFXF4pXLmV
	p72il8IfVsl8zz9S/Nnq2E5fkKfa/htkMcJqBAMoM2CO0cQey3CyKWlsdXcDmfRY
	yN7HzpZZCmfhlKOnNEEjbEQdExAP+22NBvOsX6U/K+lP5bqkGR5SmdyB5VmsclXM
	DOtgk/Dph0FZOJpqh08A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x34hssqwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 20:03:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PK3lQt002408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 20:03:47 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 13:03:45 -0700
Message-ID: <8019f005-efaa-4b31-90d7-fdefd5f6191e@quicinc.com>
Date: Mon, 25 Mar 2024 13:03:44 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/16] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
Content-Language: en-US
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
References: <20240325131624.26023-1-brgl@bgdev.pl>
 <20240325131624.26023-5-brgl@bgdev.pl> <87r0fy8lde.fsf@kernel.org>
 <CAMRc=Mc2Tc8oHr5NVo=aHAADkJtGCDAVvJs+7V-19m2zGi-vbw@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAMRc=Mc2Tc8oHr5NVo=aHAADkJtGCDAVvJs+7V-19m2zGi-vbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: amv7YH_YeBwotbXxq6Rf_df94OWD9htV
X-Proofpoint-GUID: amv7YH_YeBwotbXxq6Rf_df94OWD9htV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_18,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250121

On 3/25/2024 7:09 AM, Bartosz Golaszewski wrote:
> On Mon, Mar 25, 2024 at 2:57 PM Kalle Valo <kvalo@kernel.org> wrote:
>>
>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>>
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Add a PCI compatible for the ATH11K module on QCA6390 and describe the
>>> power inputs from the PMU that it consumes.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> [...]
>>
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: pci17cb,1101
>>> +    then:
>>> +      required:
>>> +        - vddrfacmn-supply
>>> +        - vddaon-supply
>>> +        - vddwlcx-supply
>>> +        - vddwlmx-supply
>>> +        - vddrfa0p8-supply
>>> +        - vddrfa1p2-supply
>>> +        - vddrfa1p7-supply
>>> +        - vddpcie0p9-supply
>>> +        - vddpcie1p8-supply
>>
>> I don't know DT well enough to know what the "required:" above means,
>> but does this take into account that there are normal "plug&play" type
>> of QCA6390 boards as well which don't need any DT settings?
>>
> 
> Do they require a DT node though for some reason?

I would not expect the "PC" flavor of the card to require DT.
The "mobile" and "automotive" flavors would probably require it.


