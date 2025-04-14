Return-Path: <linux-pci+bounces-25800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D69A87AE8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6610F1886084
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5625E822;
	Mon, 14 Apr 2025 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UYQCFl3O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F412580CD;
	Mon, 14 Apr 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620351; cv=none; b=az9Bi7KKqB6wmyw1RnDu/CeUHZKXXO8HzFkrlxCG4+Mq2JzTlHVzHk7hyTmzmTILGZqznFLARYSDT7D9yRCO2Dc+XUOr4Kmw6bHxUhRYWv1Ouadwse2oObQYzgUm2CM9+A8pjaQMDkMZvLtlrYH/rdUF0877sdQl5oxyeazkx4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620351; c=relaxed/simple;
	bh=pEc2TXvVNzLpSozgoDM7+YONkPktZs8pw/fQbXJIB08=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WUejbi+owN9pyy+rqrZql9+ICpU+WpKQj5OIw/WURMSHNgrIOsfo0ossCnCBKKbUJPjmGZRHiGV4DHGmjI3c2nuK7vRzut9eDR8vrQBhxlOwGaAlX7/vurklph1bPyxMYjnZ4f7dbawhgVksgIGBmqdOwuK7ybTrOuW/I1O3P7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UYQCFl3O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DNEjSx014000;
	Mon, 14 Apr 2025 08:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TC+cBorcPZtYI+BCAvI2mJGo1QM3DFfIBbzFnXVFQPA=; b=UYQCFl3OXi+wqvc2
	DZRlz6RsG7REsZfOPUwRzi9jRBUnLLc2SFee1mqbhKlXi9fXO9SsxPb733oPwZlN
	gEexTm51OqPnWVFDxEzlnKyKjO2zLbT4ZFBhis9WP0P+D/B3Js8xTNdbTELPy4SO
	3GoyvfWOcR3J6ThrSX8N0hhRXk4Mt/UOgWEyj6X2cbsi4+Ygnfh0fqDrg7v3LGK1
	B6FQ/RXjdzYLfuhlgdsgIyT52CmLvM7kxAqITNGABkF1xcCnVpOGnoyZclgLHpmB
	rdaA5oXVyDEk4ALYXYqPtW92lMQYiud69mpxhFMY4dsVkYbPnPh2dfiyXTbpN6gP
	LxUL9A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4vbybr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 08:45:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53E8jfXc021023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 08:45:42 GMT
Received: from [10.239.29.178] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Apr
 2025 01:45:39 -0700
Message-ID: <72e7ec4e-6a14-4a09-8498-42c2772da4fb@quicinc.com>
Date: Mon, 14 Apr 2025 16:45:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Set PORT_LOGIC_LINK_WIDTH to one lane
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Wenbin Yao
 (Consultant)" <quic_wenbyao@quicinc.com>
CC: <jingoohan1@gmail.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <mrana@quicinc.com>
References: <1524e971-8433-1e2d-b39e-65bad0d6c6ce@quicinc.com>
 <t7urbtpoy26muvqnvebdctm7545pllly44bymimy7wtazcd7gj@mofvna4v5sd3>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <t7urbtpoy26muvqnvebdctm7545pllly44bymimy7wtazcd7gj@mofvna4v5sd3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mvqhVk7rKe0B7SZWuqgopOFZZvbLuKFs
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=67fccb36 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=4veHE8ydySSEcrfzLuYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mvqhVk7rKe0B7SZWuqgopOFZZvbLuKFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=968 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140063


On 4/8/2025 1:51 AM, Manivannan Sadhasivam wrote:
> On Thu, Dec 12, 2024 at 04:19:12PM +0800, Wenbin Yao (Consultant) wrote:
>> PORT_LOGIC_LINK_WIDTH field of the PCIE_LINK_WIDTH_SPEED_CONTROL register
>> indicates the number of lanes to check for exit from Electrical Idle in
>> Polling.Active and L2.Idle. It is used to limit the effective link width to
>> ignore broken or unused lanes that detect a receiver to prevent one or more
>> bad Receivers or Transmitters from holding up a valid Link from being
>> configured.
>>
>> In a PCIe link that support muiltiple lanes, setting PORT_LOGIC_LINK_WIDTH
>> to 1 will not affect the link width that is actually intended to be used.
> Where in the spec it is defined?
As per DWC registers data book, NUM_OF_LANES is referred to as the 
"Predetermined Number of Lanes" in section 4.2.6.2.1 of the PCI Express 
Base 3.0 Specification, revision 1.0.
Section 4.2.6.2.1 explains the condtions need be satisfied for enter 
Poll.Configuration from Polling.Active.
The original statement is

"Next state is Polling.Configuration after at least 1024 TS1 Ordered 
Sets were transmitted, and all Lanes that detected a Receiver during 
Detect receive eight consecutive training sequences (or
their complement) satisfying any of the following conditions:
...
Otherwise, after a 24 ms timeout the next state is:
Polling.Configuration if
...
(ii) At least a predetermined set of Lanes that detected a Receiver 
during Detect have detected an exit from Electrical Idle at least once 
since entering Polling.Active.
     Note: _*This may prevent one or more bad Receivers or Transmitters 
from holding up a valid Link from being configured*_, and allow for 
additional training in Polling.Configuration. *_The exact set of 
predetermined Lanes is implementation specific_*. Note that up to the 
1.1 specification this predetermined set was equal to the total set of 
Lanes that detected a Receiver.
     Note: Any Lane that receives eight consecutive TS1 or TS2 Ordered 
Sets should have detected an exit from Electrical Idle at least once 
since entering Polling.Active."
>
>> But setting it to a value other than 1 will lead to link training fail if
>> one or more lanes are broken.
>>
> Which means the link partner is not able to downsize the link during LTSSM?
Yes, According to the theory metioned above, let's say in a 8 lanes PCIe 
link, if we set NUM_OF_LANES to 8, then all lanes that detect a Receiver 
during Detect need to receive eight consecutive training sequences, 
otherwise the LTSSM can not enter Poll.Configuration and linktraing will 
fail.
>
>> Hence, always set PORT_LOGIC_LINK_WIDTH to 1 no matter how many lanes the
>> port actually supports to make linking up more robust. Link can still be
>> established with one lane at least if other lanes are broken.
>>
> This looks like a specific endpoint/controller issue to me. Where exactly did
> you see the issue?
Althouh we met this issue on some Modem platforms where PCIe port works 
in EP mode. But this is not a specific endpoint/controller issue. This 
register will be set to 1 by default after reset in new QCOM platform. 
But upstream kernel will still program it to other value here.
>
> - Mani
>
-- 
With best wishes
Qiang Yu


