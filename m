Return-Path: <linux-pci+bounces-26652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D268BA9A056
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 07:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE67B1946871
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573319ABC3;
	Thu, 24 Apr 2025 05:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eRefqykN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B20C46B8;
	Thu, 24 Apr 2025 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745471439; cv=none; b=bT+ypgr8qBa1gfFyBam3ShMY/hCt6mI1LkkYo8aYJc7uoODUt3DkTI9/3XrybABbwwOeQPOXdyHROj9aPpxJOCYqNECIk7nE5ZyMIh108QlYFCF4Nafreves4MS/UR1e7GJHoIykOuhm8buXGWC2Pkh+H+f8Kl/LP+cGHvRC+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745471439; c=relaxed/simple;
	bh=aUibNOi4wIJ1AXiiBvpHR5w08ZL2ufaUMo0mWDBPf0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mtNk70mSVEbUib7ey8ZyCvJe/lhNtbGawyzaIbDadJY9AV9RkLtk0I/6E//lfTTHAhwfOJecdf8mNlAPbtUX7K6dOAqSdPppPrQmiptTjJ+AOYNPvp68SApTTo5N8babDFBQDKXhYzv1kKzcoD1czmQlpibfp5u4kPNsNS3Rl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eRefqykN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0F7Ik010247;
	Thu, 24 Apr 2025 05:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y6uklshMzdSMHuZH+J6BxTcK8hg8qxnv2flF+CFCLBM=; b=eRefqykN2CiEnTK6
	J4q6Mum6vCsAlOorafqAD1Ti3iLAZFgVclfPJIAL7QlYIrWWHw6+O2QMzgk/ncUK
	Cs9g5Eb64kpXqaj0FpGCOcBMBjwLRnWY4Q6kMJ45wGjmIdTO2L62n60I0Aib9AE6
	CZtI7Tq0iJw8+RxUtjyZOdNCAXQGuVOLXvNa4toZ7kqxI5UiNFN3o9HYzsS62/8e
	S+i1iNUyoqklQyRWP5hV7YKQWDfhA/727su8Mr++mciXyzxVjdiuwNCD8APs0f+y
	Q3ObRywY14yEeYVb6lR9b3cLAxOr82Hdqra9fDmGUnYiB+dv0YHzz5qKSA4wg0kX
	Bx/YEQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3m8j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 05:10:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O5AQik000529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 05:10:26 GMT
Received: from [10.239.29.178] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 22:10:22 -0700
Message-ID: <854259d9-c9e6-4b25-8787-0999099bbf4d@quicinc.com>
Date: Thu, 24 Apr 2025 13:09:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: dwc: Set PORT_LOGIC_LINK_WIDTH to one lane
To: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>,
        Niklas Cassel
	<cassel@kernel.org>
CC: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krishna.chundru@oss.qualcomm.com>,
        <quic_vbadigan@quicinc.com>, <quic_mrana@quicinc.com>,
        <quic_cang@quicinc.com>
References: <20250422103623.462277-1-quic_wenbyao@quicinc.com>
 <aAjqEUifc-W-MmJy@ryzen> <d862f711-428c-4e3a-b80d-e45d14e7b781@quicinc.com>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <d862f711-428c-4e3a-b80d-e45d14e7b781@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 74Rsdrto-fSODPcKzVf1pO7S-VLDt8Xi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAzMCBTYWx0ZWRfX7PP8Yfr33IBz +t4FKfkbJvE9NcGu/gnOrok+a1AQNUQjnSZ06HOtPromcgx8YVeed5IINrceyIEybe5rCw+A3M5 m45afVdpkosWmY93mp+yDqsb5dMP+MoBaii24VYkXnPmmNEhmxnvqf3wW8ZdyUYe23LapfRymNt
 PCSc8E9Myg+GdhnKUwqdnovHsRk+IeQNub0bi+jl2YSLc8hdHDHBdE/sXWLNRG88ZSzaZ460fxk XIbNEAEfFkUGPYauiRdVafk5V3sPgA3YLwBDGiLztsqfLv1IP72oXcfLS66TfWYFGfsbYOPiZmc 59za+7omOmQYA9uPSbLMMcg+5MnjPkKEMMUoyGj9qYLLpx1b6Py6pFVijYZ8nCHFwx9J5o+02t6
 06TK2h1r0Fa+Hevblu1zDc3r3lcYx94kRr7qEqFH+18xOAKUDTo1d9j3kQvsTnvrMu5T0ClA
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=6809c7c3 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=tzRSLQwXOsdqKkk70FoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 74Rsdrto-fSODPcKzVf1pO7S-VLDt8Xi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240030


On 4/24/2025 10:49 AM, Wenbin Yao (Consultant) wrote:
> On 4/23/2025 9:24 PM, Niklas Cassel wrote:
>> On Tue, Apr 22, 2025 at 06:36:23PM +0800, Wenbin Yao wrote:
>>> As per DWC PCIe registers description 4.30a, section 1.13.43, 
>>> NUM_OF_LANES
>>> named as PORT_LOGIC_LINK_WIDTH in PCIe DWC driver, is referred to as 
>>> the
>>> "Predetermined Number of Lanes" in section 4.2.6.2.1 of the PCI Express
>>> Base 3.0 Specification, revision 1.0. This section explains the 
>>> conditions
>>> need be satisfied for entering Polling.Configuration:
>>>
>>> "Next state is Polling.Configuration after at least 1024 TS1 Ordered 
>>> Sets
>>> were transmitted, and all Lanes that detected a Receiver during Detect
>>> receive eight consecutive training sequences.
>>>
>>> Otherwise, after a 24 ms timeout the next state is:
>>> Polling.Configuration if
>>> (i) Any Lane, which detected a Receiver during Detect, received eight
>>> consecutive training sequences and a minimum of 1024 TS1 Ordered 
>>> Sets are
>>> transmitted after receiving one TS1 or TS2 Ordered Set.
>>> And
>>> (ii) At least a predetermined set of Lanes that detected a Receiver 
>>> during
>>> Detect have detected an exit from Electrical Idle at least once since
>>> entering Polling.Active.
>>>
>>> Note: This may prevent one or more bad Receivers or Transmitters from
>>> holding up a valid Link from being configured, and allow for additional
>>> training in Polling.Configuration. The exact set of predetermined 
>>> Lanes is
>>> implementation specific.
>>>
>>> Note: Any Lane that receives eight consecutive TS1 or TS2 Ordered Sets
>>> should have detected an exit from Electrical Idle at least once since
>>> entering Polling.Active."
>>>
>>> In a PCIe link that supports multiple lanes, if 
>>> PORT_LOGIC_LINK_WIDTH is
>>> set to lane width hardware supports, all lanes that detect a receiver
>>> during the Detect phase must receive eight consecutive training 
>>> sequences.
>>> Otherwise, the LTSSM cannot enter Polling.Configuration and link 
>>> training
>>> will fail.
>>>
>>> Therefore, always set PORT_LOGIC_LINK_WIDTH to 1, regardless of the 
>>> number
>>> of lanes the port actually supports, to make linking up more robust. 
>>> This
>>> setting will not affect the intended link width if all lanes are
>>> functional. Additionally, the link can still be established with at 
>>> least
>>> one lane if other lanes are faulty.
>>>
>>> Co-developed-by: Qiang Yu <quic_qianyu@quicinc.com>
>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
>>> ---
>>> Changes in v2:
>>> - Reword commit message.
>>> - Link to v1: 
>>> https://lore.kernel.org/all/1524e971-8433-1e2d-b39e-65bad0d6c6ce@quicinc.com/
>>>
>>>   drivers/pci/controller/dwc/pcie-designware.c | 5 +----
>>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c 
>>> b/drivers/pci/controller/dwc/pcie-designware.c
>>> index 97d76d3dc..be348b341 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>> @@ -797,22 +797,19 @@ static void 
>>> dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>>>       /* Set link width speed control register */
>>>       lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>>>       lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
>>> +    lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
>>>       switch (num_lanes) {
>>>       case 1:
>>>           plc |= PORT_LINK_MODE_1_LANES;
>>> -        lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
>>>           break;
>>>       case 2:
>>>           plc |= PORT_LINK_MODE_2_LANES;
>>> -        lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
>>>           break;
>>>       case 4:
>>>           plc |= PORT_LINK_MODE_4_LANES;
>>> -        lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
>>>           break;
>>>       case 8:
>>>           plc |= PORT_LINK_MODE_8_LANES;
>>> -        lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
>>>           break;
>>>       default:
>>>           dev_err(pci->dev, "num-lanes %u: invalid value\n", 
>>> num_lanes);
>>> -- 
>>> 2.34.1
>>>
>> I still see the link to my EP (which also have this patch) using all
>> four lanes according to lspci, so:
>>
>> Tested-by: Niklas Cassel <cassel@kernel.org>
Thank you, Niklas, for kindly testing this patch and providing feedback.
Wenbin seems to have misunderstood you; sorry for this.
>
> This setting will not affect the intended link width if all lanes are
> functional. Additionally, the link can still be established with at least
> one lane if other lanes are faulty.
>
-- 
With best wishes
Qiang Yu


