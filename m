Return-Path: <linux-pci+bounces-4186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8686B2D2
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 16:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622741F25269
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B11415B99B;
	Wed, 28 Feb 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U9uKYkbr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BA2D022;
	Wed, 28 Feb 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133109; cv=none; b=ifPPQ0HVVVALl8wB0s2NrtB/wySnA6eKj4D02shS7X8b40LU4I7Ra+aiIZA6dTZy7vF1guD3Yfsc8Eom1JnvsaG0T/S8QGA7T7PQ3K+XiIzLE48eg+8DWGh3abZCoeBJu57Kgi6O8sNEmNjugEIA9FvTcHQHRDYhDDhOxL7IXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133109; c=relaxed/simple;
	bh=vMPtC0P6kj5OKOx0oZX/3NpIKMdeW8bIJGtlsp0RhbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JrF+aqk2nl0cr4OFMr1n2kkaNhZX0Yu+vGIcQD6oe7lC7Qbdb+vlNvi5GcvOsvuE4yYEa4+hpNz3HHNXWtn9MPDvFUNATXABPknfoO0fN5Q8yx9FgJaN2kdIlh3rPhKmtR/+iNsD3FeFTKoLNZ+ebKX2a8V9AG7RPv06yQfGxqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U9uKYkbr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S7LJbE005021;
	Wed, 28 Feb 2024 15:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WQwMVbuHD29gVKeUPgQfDeQmg0TH8Q84YBFEqP82N4s=; b=U9
	uKYkbr93JkEeygQi9noVg6VyioqEjSxmBrAK4Apox95ExMect929Jjf9Tnr2LfvZ
	VWrPbSDPgGoXJSNJZ8CdLO1KcERYx4Q97irarVLtqX2rcUSNL4BCtXInqTQ6Sa8Z
	tGJhOCxQMvg8WDm/lXVrYqa0E/sQfSvZsJJ7xXnEiP2CaC2UT2AO/Rab9clGXTXc
	6udv7s2rBiJjo0X5aEO6XDQFk9keJuXp4TG0rn8MZ9yZ3XZia7KAxdsgO+ZBLk67
	ZDY01+TakFMozFACiIhMzS9PYJB0+e7vZBPLlDqYGLFigvAGShc3w34sVuVnY7zl
	kF7iDLAthT+HKDo0D5zQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whw3f1f98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:11:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SFBaCK010479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:11:36 GMT
Received: from [10.216.14.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 07:11:27 -0800
Message-ID: <2e8ff010-2129-55e0-55b7-5a1589d27798@quicinc.com>
Date: Wed, 28 Feb 2024 20:41:22 +0530
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
References: <20240228145051.GA271533@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240228145051.GA271533@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LitNJhq6cC_bjasrp6uvlpEFM25PtURf
X-Proofpoint-GUID: LitNJhq6cC_bjasrp6uvlpEFM25PtURf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280119



On 2/28/2024 8:20 PM, Bjorn Helgaas wrote:
> On Wed, Feb 28, 2024 at 12:08:37PM +0530, Krishna Chaitanya Chundru wrote:
>> On 2/28/2024 4:52 AM, Bjorn Helgaas wrote:
>>> On Fri, Feb 23, 2024 at 08:18:00PM +0530, Krishna chaitanya chundru wrote:
>>>> To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
>>>> ICC(interconnect consumers) path should be voted otherwise it may
>>>> lead to NoC(Network on chip) timeout. We are surviving because of
>>>> other driver vote for this path.
>>>> As there is less access on this path compared to PCIe to mem path
>>>> add minimum vote i.e 1KBps bandwidth always.
> 
>>>> +	 * The config space, BAR space and registers goes through cpu-pcie path.
>>>> +	 * Set peak bandwidth to 1KBps as recommended by HW team for this path all the time.
>>>
>>> Wrap to fit in 80 columns.
> 
>> We have limit up to 100 columns in the driver right, I am ok to change to 80
>> but just checking if I misunderstood something.
> 
> I should have said "wrap to fit in 80 columns to match the rest of the
> file."  I looked at pcie-qcom.c, and with a few minor exceptions, it
> fits in 80 columns, and maintaining that consistency makes it easier
> to browse.  Sometimes exceptions make sense for code, but for
> comments, having some that fit in 80 columns and some that require 100
> just makes life harder.
> 
> Bjorn
> 

Sure I will wrap in 80 columns, in my next patch series.
- Krishna Chaitanya.

