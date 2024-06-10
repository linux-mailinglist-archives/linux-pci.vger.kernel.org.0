Return-Path: <linux-pci+bounces-8507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BB6901A5B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 07:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D949A1C20FED
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 05:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE5107B3;
	Mon, 10 Jun 2024 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k7eUvGal"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E8D17F6;
	Mon, 10 Jun 2024 05:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998453; cv=none; b=RzAOJH4PgvypkPILgPHoG4lga8/MrbKNJMYid3HsBpoRWt5AJl+AzuoTpCUGYv3LCckUFBKTdLfJ2IXYoF1VTugN1lGlYeGpOiYztxWGHt/Kj0mfn+wBtmQv9wC2gIdiraKjlRES2myVvhBSqpO8SBT9iw/ucg8xFFKpIX/cX94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998453; c=relaxed/simple;
	bh=rPZUnmp8Y/gQg+BfsdhZPJbSD2TpXw4r6sGsyRhKDcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eC9p4+QOSyN9BMVjaiNKDZD4SZopA5Nvkz8mHvmivn8AYGsdVAFVOdHwsvwxAqobkDjQz1XxOcoiVkrICLPqbBD27v7UavzEYg7hZ2y4Jq2tpG1j6nDUyaSXENUoQg97/XQ9lGec8181huog7uqnh1GpGXbc+pUV4RFcWsoAcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k7eUvGal; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A0UKq2021412;
	Mon, 10 Jun 2024 05:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+8hc+GJRw5bYKA1HZbG0gEfYcd9szFBSrHA7WvS9Vvc=; b=k7eUvGal4RbGv/pK
	t+OcZSOqB3Q4jWrlh0i4RTGubAH2vqSGUtyzhhoIBZmEM7FW4g07xw53nhYgAKNB
	Hlw5eekChw9hFRuqRA28It/egxx555IQJjRtyRWx1vZjwHxJterKhCry8qTpymUn
	63REKQ9r1ATueJ6qIGul+9DNGusnKPmU09kqERtnV7Q2/iOs/kMQgRY44u3NWPQ/
	gFi4na/p5VrZX4+aXMUcMvU9H3//MYET6sDvAl54B0e26QFEqp0cCI0Ic0LLq94L
	MuEai8MQiP21YQBgEoRDgtJP5YxckpIUyGaHyG0YYudlWdy6IAVLmyuh9qNTskjO
	bHPjsg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymgk8tsps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 05:47:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45A5l4rH025863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 05:47:04 GMT
Received: from [10.50.54.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 9 Jun 2024
 22:46:58 -0700
Message-ID: <fea90522-dec4-4bba-be57-3a1be9e6b59c@quicinc.com>
Date: Mon, 10 Jun 2024 11:16:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 6/6] PCI: qcom: Add support for IPQ9574
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240530171116.GA551131@bhelgaas>
Content-Language: en-US
From: Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20240530171116.GA551131@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oQ2GERKZl0yI3W1TvAS-KbQJpS9sLzcB
X-Proofpoint-ORIG-GUID: oQ2GERKZl0yI3W1TvAS-KbQJpS9sLzcB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100043



On 5/30/2024 10:41 PM, Bjorn Helgaas wrote:
> On Sun, May 12, 2024 at 01:58:58PM +0530, devi priya wrote:
>> The IPQ9574 platform has 4 Gen3 PCIe controllers:
>> two single-lane and two dual-lane based on SNPS core 5.70a
> 
> s/4/four/ to match "two"
okay
> 
>> The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
>> Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
> 
> s/Added/Add/ (use imperative mood:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.9#n94)
> 
>> which reuses all the members of 'ops_2_9_0' except for the post_init
>> as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
>> and 1_27_0.
> 
> Add periods at end of sentences.  Rewrap to fill 75 columns.
okay
> 
>> +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
>> +{
>> +	writel(SLV_ADDR_SPACE_SZ_1_27_0,
>> +	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> 
> Fits on one line.
sure
> 
>> +	return qcom_pcie_post_init(pcie);
>> +}
>> +
>> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>> +{
>> +	writel(SLV_ADDR_SPACE_SZ,
>> +	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> 
> Fits on one line.
okay
> 
>> +	return qcom_pcie_post_init(pcie);
>> +}
Thanks,
Devi priya

