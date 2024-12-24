Return-Path: <linux-pci+bounces-18994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACDB9FBAF0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 10:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0AA163D2C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D161922D4;
	Tue, 24 Dec 2024 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F+JFdO/y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C686250;
	Tue, 24 Dec 2024 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735031491; cv=none; b=SFDCdjVpFcBMQFT8K+YoUqrH+yEv68AT/OcyNUlqG1MmuNC48kTZV4bGq016mZeheudCk4DL83Q6b7rPafOlFEjquHpdGaHN3TL1MKi4OEWV5FFipz4FnlxuCTSe3uic508RUBh6cIyD9dCxxiHH/3X1YvuvaoFZBDXDRIMH3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735031491; c=relaxed/simple;
	bh=E1uydebJJnOgAYjXZz9uOCOldczooOuTgy9GEv1Vy1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SibgI8ow8ppwhYgkPTrEKHZpYUquIkuL09mXe0FAPqbUdGgOSHYichqsL+Doz5fK7qFCl3lN+Q39pIC95R7ywTeByZGZLeEYCBFV9g0mfpVbKkMkAjDa14uDEX8uP4HmxImUn8rV8B7bgD8wpfA7078C030vgiUU1ecYzjM3MP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F+JFdO/y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO6vUU2025265;
	Tue, 24 Dec 2024 09:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kd1qiHSiBu+HCMl46bwAd5NnHZq+wTR+OX7WCtQbf78=; b=F+JFdO/yEU5A01po
	naNCZrfH5KrgOGB6f0pai51jfvMAcB6j+eXFvbwDvObPPBv6tnbB6axl7iFibwIh
	ltH6tmrHcEIMAW0wBBongGFnQBqIRPKbxrrk5llFzPParqQ/sjnIUGpOaHzfcfwd
	8urzlv8tk80wGI/tpdXZGtGfXmDzaOdaq8PCe+cDB0lwlKHF9BPtXLzoY8zrE3Tu
	cLSLVM4Qz9gHkU1gzcJ1GjZ6GrM8U4uiAMbjS7GvMuR8iLbuBEQe6Q0wM5e31P/n
	iC8VHeI71JeKBRPZbxEnFnHJI+qRxcO6GYT0SZyGVPAOK2Pnxcg7GCh2oYdxbq1E
	LkAb0Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qr55rnx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 09:11:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BO9BI87004189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 09:11:18 GMT
Received: from [10.216.2.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Dec
 2024 01:11:13 -0800
Message-ID: <3d37e1b2-a658-5de9-c575-6baf9cdaa40f@quicinc.com>
Date: Tue, 24 Dec 2024 14:41:10 +0530
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
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        <quic_vbadigan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241204212559.GA3007963@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241204212559.GA3007963@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uszCFr4uBfXIdlltj5nTR6H3FjhTPJOb
X-Proofpoint-GUID: uszCFr4uBfXIdlltj5nTR6H3FjhTPJOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412240077



On 12/5/2024 2:55 AM, Bjorn Helgaas wrote:
> On Tue, Nov 12, 2024 at 08:31:33PM +0530, Krishna chaitanya chundru wrote:
>> Add binding describing the Qualcomm PCIe switch, QPS615,
>> which provides Ethernet MAC integrated to the 3rd downstream port
>> and two downstream PCIe ports.
> 
>> +$defs:
>> +  qps615-node:
>> +    type: object
>> +
>> +    properties:
>> +      qcom,l0s-entry-delay-ns:
>> +        description: Aspm l0s entry delay.
>> +
>> +      qcom,l1-entry-delay-ns:
>> +        description: Aspm l1 entry delay.
> 
> To match spec usage:
> s/Aspm/ASPM/
> s/l0s/L0s/
> s/l1/L1/
> 
> Other than the fact that qps615 needs the driver to configure these,
> there's nothing qcom-specific here, so I suggest the names should omit
> "qcom" and include "aspm".
> 
>> +    pcie {
>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +
>> +        pcie@0 {
>> +            device_type = "pci";
>> +            reg = <0x0 0x0 0x0 0x0 0x0>;
>> +
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            ranges;
>> +            bus-range = <0x01 0xff>;
>> +
>> +            pcie@0,0 {
>> +                compatible = "pci1179,0623";
>> +                reg = <0x10000 0x0 0x0 0x0 0x0>;
>> +                device_type = "pci";
>> +                #address-cells = <3>;
>> +                #size-cells = <2>;
>> +                ranges;
>> +                bus-range = <0x02 0xff>;
> 
> This binding describes a switch.  I don't think bus-range should
> appear here at all because it is not a feature of the hardware (unless
> the switch ports are broken and their Secondary/Subordinate Bus
> Numbers are hard-wired).
> 
> The Primary/Secondary/Subordinate Bus Numbers of all switch ports
> should be writable and the PCI core knows how to manage them.
> 
Bjorn,

The dt binding check is throwing an error if we don't keep bus-range
property for that reason we added it, from dt binding perspective i 
think it is mandatory to add this property.

- Krishna Chaitanya.
> Bjorn

