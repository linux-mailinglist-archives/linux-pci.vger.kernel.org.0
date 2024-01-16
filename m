Return-Path: <linux-pci+bounces-2193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CCE82E915
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 06:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778A81F23B02
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 05:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FC3101E8;
	Tue, 16 Jan 2024 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DHmzyzpW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F179F5;
	Tue, 16 Jan 2024 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G4drl7031441;
	Tue, 16 Jan 2024 05:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DssaXwDwKvCdECOwdklNfKbpsuqHcpH1F+oDFVCaXe4=; b=DH
	mzyzpWn/ReQwOuhHfRbUZ+k3JsKyBqpcayFp8jM38yOEnsKvgfu6lXxkrFzAmUVA
	yFMGt4Q5c5V0mlp1qyMnUH2hdHqotvKNeDPktNC6NfM/vy6vD4HWaBtH3q1JSAhr
	qTNiKZNy78mLDuNumX1UpfTQMGTLQF9lgRSnML7QhJuGj9is6mdyJ6RI2LEn1oYN
	k6SfWkaPcjf0ne518zW//TQFRdFdMTuvF8uV4gV8qWeSvfjbzV8BXenTFpRm5cz1
	/b7ihr+ys+H8Ep+rnEygV6QuPqGa0ZK8VfIzl+m9e4JuE1R9OS4wY+I/PuJQFW72
	/oX0W3X9MjKFx5GcOuYg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vn02ct636-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:07:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G57JZd022820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:07:19 GMT
Received: from [10.216.3.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 21:07:12 -0800
Message-ID: <9127808c-ab0c-83ce-9bc7-27f5daae30d1@quicinc.com>
Date: Tue, 16 Jan 2024 10:37:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <vireshk@kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240112165010.GA2271863@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240112165010.GA2271863@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sO4Y5leZX9IHp2ObmzYG5Y_aUzuD-6pD
X-Proofpoint-GUID: sO4Y5leZX9IHp2ObmzYG5Y_aUzuD-6pD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 mlxlogscore=776 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160037



On 1/12/2024 10:20 PM, Bjorn Helgaas wrote:
> On Fri, Jan 12, 2024 at 07:52:05PM +0530, Krishna chaitanya chundru wrote:
>> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
>> maintains hardware state of a regulator by performing max aggregation of
>> the requests made by all of the processors.
>>
>> PCIe controller can operate on different RPMh performance state of power
>> domain based up on the speed of the link. And this performance state varies
>> from target to target.
>>
>> It is manadate to scale the performance state based up on the PCIe speed
>> link operates so that SoC can run under optimum power conditions.
>>
>> Add Operating Performance Points(OPP) support to vote for RPMh state based
>> upon GEN speed link is operating.
> 
> Thanks for this "OPP" expansion!  Maybe "GEN" is unnecessary in this
> sentence?  And below, could be replaced with actual speeds?
> 
ACK
>> OPP can handle ICC bw voting also, so move icc bw voting through opp
>> framework if opp entries are present.
> 
> s/opp/OPP/ to match
> s/icc/ICC/ similarly (and perhaps expand once)
> Also below in comments, etc.
> 
ACK.

-Krishna Chaitanya.
>> In PCIe certain gen speeds like GEN1x2 & GEN2X1 or GEN3x2 & GEN4x1 use
>> same icc bw and has frequency, so use frequency based search to reduce
>> number of entries in the opp table.
>>
>> Don't initialize icc if opp is supported.
> 
> Bjorn

