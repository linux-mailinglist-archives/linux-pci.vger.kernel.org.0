Return-Path: <linux-pci+bounces-3700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B36859C84
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 08:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE12281265
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4919C20320;
	Mon, 19 Feb 2024 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A7owrrWm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16520B03;
	Mon, 19 Feb 2024 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708326226; cv=none; b=B5R4gatd0E7MsJuscpBkfKAEfPubgJ13HGS1bfk+qsKoe63OJYny3AYmTR/TFUx5QL7WPtBKGUZ5GP2yb/1pCh3jq3tUxOEZ8KtRainv8JuPyY5yaSu66wU/6h5W8Lw0CzZ49KeSq3mFhlAgLSeWb62AF6VQyEYgKAyR9iCe4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708326226; c=relaxed/simple;
	bh=CEvh88rZpLUQbzg6+eIeSpYMzTgDsjQUThjIa04uo7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QDrsev1CjmlOZszAr1lXbN8JHi1J+QJXgXQsoBUZITP7MMFCEIsOOuo4H3MWEMAX5+aKW558rzdNCGFkEfuXAL1NlGpfwHnzlYrxdw3Ekmv3NpxdL/hsO0hw2o9+u0OEdHruy04hqVb7CnyElZ7a5A+VNwUt2yKK2kywcFs0caI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A7owrrWm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J4ondp029299;
	Mon, 19 Feb 2024 07:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yh0NWSGrRwAfD0E6fbrLCz1mw/LX2iV5zdfaEdpd23c=; b=A7
	owrrWmYI1gAWl+ByD79ktOzMeQPblRwn7npLfj2XeRb1gtb/E/cRwyHOVEMhmFnE
	jY9hxZq8tR8zZMenhEbSK3q8l/nVxgwvTA2ugWlQ3JzbTY8SLtB4vgiDZN7vKoi6
	s3pzwPAHXlc41o8mJEOeEBgSFAg3HLTfqItHKdN8axN+VsMa3GS6mEiFOzaKDtnl
	AjPDgd0EduRgvxTOO3wY868CNNOLb4M3MyBAJPjEnYtXwxeYauNvdlQrK7GvzueF
	0Hb32hwDaTJSkNZ5F/aH7C+HMVPrD+duBvUT+ocPhASrRde6xvKZ9Rmtbfzuv6/6
	C/QYUWkqPB5pkwOVY+bQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3waktcu4s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 07:03:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41J73QVa007441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 07:03:26 GMT
Received: from [10.216.36.13] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 18 Feb
 2024 23:03:19 -0800
Message-ID: <f3f3329b-0dc9-4652-9f23-d55852f046d8@quicinc.com>
Date: Mon, 19 Feb 2024 12:32:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Brian
 Masney" <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
 <20240129160420.GA27739@thinkpad>
 <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>
 <20240130071449.GG32821@thinkpad>
 <20240130083619.lqbj47fl7aa5j3k5@vireshk-i7>
 <20240130094804.GD83288@thinkpad>
 <20240130095508.zgufudflizrpxqhy@vireshk-i7> <20240130131625.GA2554@thinkpad>
 <20240131052335.6nqpmccgr64voque@vireshk-i7>
 <610d5d7c-ec8d-42f1-81a2-1376b8a1a43f@linaro.org>
 <20240202073334.mkabgezwxn3qe7iy@vireshk-i7>
 <8a7b63a8-0583-43cf-9876-8a964c8b77ee@linaro.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <8a7b63a8-0583-43cf-9876-8a964c8b77ee@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8GZTPcrQNmOCcxvP5bshh10s7VcDcAhl
X-Proofpoint-ORIG-GUID: 8GZTPcrQNmOCcxvP5bshh10s7VcDcAhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_04,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=874 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190051



On 2/10/2024 2:44 AM, Konrad Dybcio wrote:
> On 2.02.2024 08:33, Viresh Kumar wrote:
>> On 01-02-24, 15:45, Konrad Dybcio wrote:
>>> I'm lukewarm on this.
>>>
>>> A *lot* of hardware has more complex requirements than "x MBps at y MHz",
>>> especially when performance counters come into the picture for dynamic
>>> bw management.
>>>
>>> OPP tables can't really handle this properly.
>>
>> There was a similar concern for voltages earlier on and we added the capability
>> of adjusting the voltage for OPPs in the OPP core. Maybe something similar can
>> be done here ?
>>
> I really don't think it's fitting.. At any moment the device may require any
> bandwidth value between 0 and MAX_BW_PER_LINK_GEN * LINK_WIDTH..
> 
> Konrad
Viresh & konrad can you both come to conclusion on this.

- Krishna Chaitanya.

