Return-Path: <linux-pci+bounces-16856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AF89CDC18
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E9DB239CC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB11B3948;
	Fri, 15 Nov 2024 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pbkLVcQW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C91E1B392C;
	Fri, 15 Nov 2024 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665078; cv=none; b=QhiSVUC7UGaWsDdvHecTsgutDuoJnopOEq+b1Uw90gBD+MaLMQmHjhwPxY4K701nfa1qc9IU8EhprWO/CaXtrfTyXprbQV4c4KT0pwQP0SGo3aDTwSww46hWTvzhJSEE2yqT1tUyfe6f67y/rB5FoDJ6r0hVtb5yk/0o4fxyhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665078; c=relaxed/simple;
	bh=rOj7bOrixdZPTyqng5O9ucV5bQSQm4MFqsK0aFWgcWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rb/tYh694yRFVB3z09/JSFYQ12xahJUxSE7oSRDFYUv9+tukeYJRz4E10X63j/7J0DePE08aoeF7Wf9AROXA7EG6UVd5Ii5LcSTztip3CrX7+TEtKEyUY5KhTwuyc5ZvSNdWz3crqGNFsCYa+8cskT5dKyvCEOE6zGAXaKFObnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pbkLVcQW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF9E4pv005348;
	Fri, 15 Nov 2024 10:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YBEDWQZtdymf1KBKctBQPowv3p8NG/u/Z9yDmTzan6k=; b=pbkLVcQWJP80ohAY
	IxYePwVcLi8wpuzqNZDztu8jUIkR6izt2xNI+eh86n5Tdgx0NSZ50jAULSDSfmoD
	gFTx0vKdlDuYzplZm2j4AvUicZHzIXh/jpgIatNkqWT2dOkde+6J6RhwywVrYI9w
	mNoykMiih3xhE4Wp6TbomvMO0TV4QavMVcw1f6c6pYmb17bdCgqnbIBbW9Y5bqdU
	X0oDrf96GDTpJX05Hd7w7j47p/t3aijkkOV/cKXyzYYoFrRuKQOg5ax4W408HI1H
	yGaf1LTiSK5GejECn69Y1IdTTWphB1BxNtlizkB2+k2Ylomzx+3xAv8bWn44aXeD
	ushMMw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42x3g0r5du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:04:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFA4OPb014965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:04:24 GMT
Received: from [10.50.13.152] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 02:04:14 -0800
Message-ID: <558364dc-d701-4996-83d7-56afab37eb08@quicinc.com>
Date: Fri, 15 Nov 2024 15:34:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Add PCIe support for Qualcomm IPQ5332
To: Manivannan Sadhasivam <mani@kernel.org>,
        Praveenkumar I
	<quic_ipkumar@quicinc.com>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <quic_nsekar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
 <20240310132915.GE3390@thinkpad>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20240310132915.GE3390@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4wvOCydZtOm9zbwrUAVBPnncYQvO79Sa
X-Proofpoint-GUID: 4wvOCydZtOm9zbwrUAVBPnncYQvO79Sa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1011 spamscore=0 mlxlogscore=704
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150085



On 3/10/2024 6:59 PM, Manivannan Sadhasivam wrote:
> On Thu, Dec 14, 2023 at 11:58:37AM +0530, Praveenkumar I wrote:
>> Patch series adds support for enabling the PCIe controller and
>> UNIPHY found on Qualcomm IPQ5332 platform. PCIe0 is Gen3 X1 and
>> PCIe1 is Gen3 X2 are added.
>>
>> UNIPHY changes depends on
>> https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/
>> PCIe driver change depends on
>> https://lore.kernel.org/all/20230519090219.15925-1-quic_devipriy@quicinc.com/
>>
> 
> Any plan on this series and the dependencies?
> 
Yeah, Sorry for the delay, will post in the coming week.

Regards,
  Sricharan


