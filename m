Return-Path: <linux-pci+bounces-14501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92AD99D5B3
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE140282BF9
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C731C3051;
	Mon, 14 Oct 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BMg/5VDv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52331B85C2;
	Mon, 14 Oct 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927640; cv=none; b=qnGZYyTxPvUDclzsTAvj1ImVoh1uRCwfv4Q0g+BTAvBygHl7S1D9uOKTzYi/f3FmyvI5VtHnRfqhXf1IAco8S4kseyICC3vFtF7Jl9e/h3Sp9qgOu+1w6tjlOSIT6vA9iY3bqC/nwa49a7r4zm0vLB8H0GemaZfxZFSF0IlzuCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927640; c=relaxed/simple;
	bh=CE2jAihREu31K2gSwN/JmJLC0IVQkicu4On1Qb6A8x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q6g8AXGI3Y/AFavjt0f6XnlVk0n8g/u3X57ZnMf377t7FFtBNhPhFbQUPuY56AQOpyxZzFkSEAwpX2RU+6gonUFN+eHye4togmo6JMz5cOR9LxKbU5/1gRAeEYPznE9er9pReRNOTY/gDzaa404JCuYpiyjVyQJtb1dKpE5AmYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BMg/5VDv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAimx6002048;
	Mon, 14 Oct 2024 17:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F5hZ5EUZXMbCP1ZXJ2JWDyH5ysO7SiX/CMGlhtAacwg=; b=BMg/5VDvEaaohuP3
	25KifaB1w+1ItGlT+GH6ixrp79xrVqnQo5UHZQHTUM8ysQ40olkiJBQmP1dINLVk
	a0wqZvCZ5atd6AuxsB1wBVXyHu6wvQ3ei1KILqBFoLmpooH25CgXhdgwk/+EQCR6
	KgRY8556Szce/vBbiIONrZp5fRbsw5P4pvkw33doJJTSj9ckuJ44iMOLAiHsj5u5
	91pTreAIUKO+m0H28kB4p5BxemEsjPBksrteAaMS1nM3GqPqZFlXUgi4zH6ctNqm
	omYRK9CdaZPft2XoxLvumMYhcWX5Uc1FO5m2oMipEnjT17MTnqatBf/D3WVpka6o
	BstlBw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427g45d9da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 17:40:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49EHeDDG031148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 17:40:13 GMT
Received: from [10.110.64.87] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Oct
 2024 10:40:13 -0700
Message-ID: <7ba5148d-8a82-4312-8fcb-45cb7ca34b5e@quicinc.com>
Date: Mon, 14 Oct 2024 10:40:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <kevin.xie@starfivetech.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_krichai@quicinc.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20241014172321.GA612738@bhelgaas>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20241014172321.GA612738@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bvlx5p7ShDuAHMvJ3u_yxGWi3ijNPc00
X-Proofpoint-ORIG-GUID: Bvlx5p7ShDuAHMvJ3u_yxGWi3ijNPc00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=837
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140127

Hi Bjorn

On 10/14/2024 10:23 AM, Bjorn Helgaas wrote:
> On Mon, Oct 14, 2024 at 09:26:07AM -0700, Mayank Rana wrote:
>> PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
>> bridge device. To enable runtime PM of PCIe host bridge device (child
>> device), it is must to enable parent device's runtime PM to avoid seeing
>> the below warning from PM core:
>>
>> pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
>> with active children
>>
>> Fix this issue by enabling starfive pcie controller device's runtime PM
>> before calling pci_host_probe() in plda_pcie_host_init().
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I want this in the same series as Krishna's patch to turn on runtime
> PM of host bridges.  That's how I know they need to be applied in
> order.  If they're not in the same series, they're likely to be
> applied out of order.Thank you for quick response and suggestion.


Hi Krishna

Please add this proposed change as part of your changes to enable 
runtime PM of host bridges.

Regards,
Mayank

