Return-Path: <linux-pci+bounces-4168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B8086A870
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 07:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40191C23900
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 06:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02B222619;
	Wed, 28 Feb 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pDV1kGw9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248411D689;
	Wed, 28 Feb 2024 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102344; cv=none; b=H+zbKVpWz+8aiyNFvVz4OrpoLn1750eW/arjhQnBcAdmvNUiAVdy8heZmtvbh9R521c/LUSsTWJTlhMeLxrdIkjreheAACPEm7qp+3WhmS6VX04d1r8SW6b1LFDbcKPSBYR7SJVXck7GfuWF4cFa4oR/P/ovSJHOGtn9aT/cDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102344; c=relaxed/simple;
	bh=GaIuDDftg63Pi2OrFl6WV1sAWCA8dIeGF8X+3sE8U0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oDglktSqFR85HHKSGqr2XR/HpDpLrlTCd4l4GiR9KMFPjgxsDhrruY9zUB1u7iT93y608eENyt+XfCcHBupDHhHbMNLIrPSwcNB76K3WHS41nPrYCl1e3Y6n0g2YIQm0idnlUHb1VGwh/aktbAwSAhMdaSuipUo0RdEspU6vi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pDV1kGw9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S2OUDs025134;
	Wed, 28 Feb 2024 06:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yEsPn9GSp7vrEJijyIX2lOAPt6LbAnSDCfGstYnezu8=; b=pD
	V1kGw9hZd4GwvCyZxbw8Zw+tgg8p8lLb1hdyB+nbBR9Lv3DjtCA2cZG3FV7extRI
	uTFlm2RdwM/JZuHW0ZzrIYhpab6x6X/4YYSDiy1osaREuWiw+l+Hx0Tm9VdUeGD2
	aOnabmD39i/RwxdOt3vCfZC5XNQlfsjjFjOm0owuqUqUyxdfIW9y5YgHFLhkunaj
	asewKXRxMzJAVaUxGqiXf8rHWy+3dmG82ior86B/CUOKeYIFQb2FbEfZRIe6Q3u4
	ucquS2oQd2Tmh5eD9hS1feQmh8c1/q10PodhQbLkRVnAU2k4U/M07fIw2L8zaVqJ
	oomyDbAVpxOGmAB00WyQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whthv0hnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 06:38:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S6cofA002687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 06:38:50 GMT
Received: from [10.216.14.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 22:38:42 -0800
Message-ID: <b2e136ba-a7fd-ee8d-e71a-dce1442ada03@quicinc.com>
Date: Wed, 28 Feb 2024 12:08:37 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v7 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20240227232235.GA251235@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240227232235.GA251235@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I-cPpAz1F3izauMNu9J6HK0YhGTFsMRP
X-Proofpoint-GUID: I-cPpAz1F3izauMNu9J6HK0YhGTFsMRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280050



On 2/28/2024 4:52 AM, Bjorn Helgaas wrote:
> On Fri, Feb 23, 2024 at 08:18:00PM +0530, Krishna chaitanya chundru wrote:
>> To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
>> ICC(interconnect consumers) path should be voted otherwise it may
>> lead to NoC(Network on chip) timeout. We are surviving because of
>> other driver vote for this path.
>> As there is less access on this path compared to PCIe to mem path
>> add minimum vote i.e 1KBps bandwidth always.
> 
> Add blank line between paragraphs or wrap into a single paragraph.
> 
> Add space before open paren, e.g., "ICC (interconnect consumers)",
> "NoC (Network on Chip)".
> 
>> In suspend remove the disable this path after register space access
>> is done.
> 
> "... remove the disable this path ..." has too many verbs :)
> Maybe "When suspending, disable this path ..."?
> 
>> +	 * The config space, BAR space and registers goes through cpu-pcie path.
>> +	 * Set peak bandwidth to 1KBps as recommended by HW team for this path all the time.
> 
> Wrap to fit in 80 columns.
> 
>> +	/* Remove cpu path vote after all the register access is done */
> 
> One of the other patches has s/cpu/CPU/ in it.  Please do the same
> here.
> 
> Bjorn
I will update the commit message as suggested in next series.

We have limit up to 100 columns in the driver right, I am ok to change 
to 80 but just checking if I misunderstood something.

- Krishna Chaitanya.

