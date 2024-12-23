Return-Path: <linux-pci+bounces-18978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E2A9FB351
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 17:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2F4163273
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9925B1B0F2D;
	Mon, 23 Dec 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XhN37A5W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DAD19DFB4;
	Mon, 23 Dec 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734972529; cv=none; b=WWJsIpOyLaP9JK8QxugC3+pEotF0+JtGQExnX/GlvsK7z+Q4Qx9sQ2HTkguWo8GhYupkaVH2t1oAXLbcO3EDcwR1c2fR+VCERRds9+PfOqjSNXsNjzwec8SVwOKTVFPkvj4NFiCktTgAb4dXBhFUun8d+u2YHlg6Qs8f5U9tx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734972529; c=relaxed/simple;
	bh=JKVVZ8h6pvui8g5pFna5Wb78q6p5q9rEgum20M2rYeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p5kkfwk+5qc6uAcAgbPu3JsmRrTJa5+h3saiIHXA6cN68Mn8RHQEPJYP6QgWt3xqL1IksB54FUDFvuvo6jhh4hIG51otN7KU+ghe0FH5SZy/MsG3HFw5GXsXn8dwONw7RfOuuJWtf5w3Osz6FsAa4OQacvxQ4jZJ6KWKLYfqB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XhN37A5W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNBveF5018159;
	Mon, 23 Dec 2024 16:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qgXoM3qZD93P9y7fdeuMK7YtPmiYP1Ht8W3TZcJbghA=; b=XhN37A5W7xnRvers
	JqY0cWI2pDT+jzmzSwn7K/aha+G9TSdG+F6LE57/NDjBO+Jjz/eOIVHqnNmyTDHy
	kw2DlFP1buqGxUKcf3tVeUrtiaZoSwXLcyl5bYUilnR+PCS0HvK1O3Pwd2f8Sqb5
	kkvI/fXBIAe0P9vxYaWyN5y4LHYMEAthF0w8kndxx56dtI+p5vdMGg+M/WqDtYm0
	1J4aRLpTviIRaXyXS2khwPIV02BqAWVTUZgDzZq/xf6wdTkYckEsNxp/CTSmhPE1
	qPxgr3opar+C7MG5rA1B+6iT0jOALk9FH/5JZeq+mvxXQf9MeoIN6aANer+WeZ9k
	BBP1aw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q7ev13a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 16:48:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BNGmZ7D025085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 16:48:35 GMT
Received: from [10.216.2.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Dec
 2024 08:48:29 -0800
Message-ID: <bf57eca8-69b5-9c21-0350-bf1c07de786f@quicinc.com>
Date: Mon, 23 Dec 2024 22:18:24 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas
	<helgaas@kernel.org>, Rob Herring <robh@kernel.org>
CC: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han
	<jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <20241204212559.GA3007963@bhelgaas>
 <20241211060000.3vn3iumouggjcbva@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241211060000.3vn3iumouggjcbva@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uHZtNFkhffwq2ItHoC8DYL8pwgHJSffz
X-Proofpoint-GUID: uHZtNFkhffwq2ItHoC8DYL8pwgHJSffz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230149



On 12/11/2024 11:30 AM, Manivannan Sadhasivam wrote:
> On Wed, Dec 04, 2024 at 03:25:59PM -0600, Bjorn Helgaas wrote:
>> On Tue, Nov 12, 2024 at 08:31:33PM +0530, Krishna chaitanya chundru wrote:
>>> Add binding describing the Qualcomm PCIe switch, QPS615,
>>> which provides Ethernet MAC integrated to the 3rd downstream port
>>> and two downstream PCIe ports.
>>
>>> +$defs:
>>> +  qps615-node:
>>> +    type: object
>>> +
>>> +    properties:
>>> +      qcom,l0s-entry-delay-ns:
>>> +        description: Aspm l0s entry delay.
>>> +
>>> +      qcom,l1-entry-delay-ns:
>>> +        description: Aspm l1 entry delay.
>>
>> To match spec usage:
>> s/Aspm/ASPM/
>> s/l0s/L0s/
>> s/l1/L1/
>>
>> Other than the fact that qps615 needs the driver to configure these,
>> there's nothing qcom-specific here, so I suggest the names should omit
>> "qcom" and include "aspm".
>>
> 
> In that case, these properties should be documented in dt-schema:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml
> 
> - Mani
I am fine to move to pci-bus-common.yaml but currently these are being 
used by qps615 only I hope that is fine.

- Krishna Chaitanya.
> 

