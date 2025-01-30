Return-Path: <linux-pci+bounces-20567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F6A22900
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 07:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2023A54B0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 06:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6A4199924;
	Thu, 30 Jan 2025 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bwGdSRvC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5598D149C69;
	Thu, 30 Jan 2025 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738220294; cv=none; b=fTaUMSIQKQm3bS8QeBjV0gpbCgbRMpOUteywD/mT5m2N+kgoiecpqRYaMsc/qhs0CuVxgN+8Cm27MF+Mo2ZWAFZ1dA9UG/L908mhVd74D6wNd8U4CEDG5k4ZalgpeyLq9vvAimaHBbIVkVeEQqGXkPe5eX2WSQgd0sXWFCGOyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738220294; c=relaxed/simple;
	bh=U2vLNxLklm8/C6iU80JRm0sjTLvzJjFkaqcSXfIFWh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ePosx6Mb/ZW06T1xbVJORzIbegMuyE47SJv+FONZei0ZGguAx89U8Zk8w+LgrTQ4DaQ6q+of/NhW03Cj5HEMkEfJh2ODgDVP+cxweO1+sAJBTuHIFYaeliKowN5Mp4lTq8R8DoFRio0y7A4IU2HoXgb4x/LWlNit4iCogCL3CHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bwGdSRvC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U1xSSJ032713;
	Thu, 30 Jan 2025 06:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	57ILQ2jQamDUgWHDshOh9hH0S4tX+ccyw3uksObWwOU=; b=bwGdSRvCd7aZJwiW
	0Apo8E3kTB7z8E6n4ea5R/hiwRfWhEMa81Fm2z0vYMFEFDhptGEXuBpTmqo13fPH
	3lfTw8+2X+INxZh/Kaapmw2Y/EuF/yORSa7muV5vCO6z0Thub58lcAljHon0CqLH
	r413EiOr+obF1ffvLBwctjv5CX0x/mABKSmaX2/ZzJ6DAFBJSlGduAShv9UcjLqH
	nTxtviojD82W/gm71EGNo8AmfdvjaxrKGIOT3CCDi5IYei0XHZ7paE8EcupSkuER
	HX1cRhDt+DtpWHN2eFW8yoDe9cY/Wx+pPuZGfDGWOObsHxCYi0LBu/12LBMZCAvP
	u7TAnA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44g0830exq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 06:58:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U6w4RD014361
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 06:58:04 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 22:57:58 -0800
Message-ID: <0e676657-6c9d-4fb5-a0ab-1cfc6ef75039@quicinc.com>
Date: Thu, 30 Jan 2025 12:27:56 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: ipq5424: Add PCIe PHYs and
 controller nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <andersson@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
        <bhelgaas@google.com>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
 <20250125035920.2651972-4-quic_mmanikan@quicinc.com>
 <772b211d-ca23-4810-8d92-a67892da4fbf@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <772b211d-ca23-4810-8d92-a67892da4fbf@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZuLbWG-lokDDIAQ-oJHuAc6MNAGXB7AZ
X-Proofpoint-ORIG-GUID: ZuLbWG-lokDDIAQ-oJHuAc6MNAGXB7AZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=622
 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300051



On 1/28/2025 5:08 PM, Konrad Dybcio wrote:
> On 25.01.2025 4:59 AM, Manikanta Mylavarapu wrote:
>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>> found on IPQ5424 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>> Changes in V3:
>> 	- Replace all instances of ‘0’ with ‘0x0’ wherever applicable in
>> 	  PCIe nodes.
>> 	- Place both compatible entries in a single line for each PCIe
>> 	  controller node.
>> 	- Global interrupt is defined for each PCIe controller node.
>> 	- Remove all clocks except the RCHNG clock from the assigned-clocks.
>> 	- ICC tag is defined for the interconnect path of each pcie controller
>> 	  node.
> 
> This one is wrong, please undo..

Okay, sure.

Thanks & Regards,
Manikanta.

