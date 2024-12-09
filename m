Return-Path: <linux-pci+bounces-17897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E589E8A50
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 05:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EC8163800
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 04:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2777156228;
	Mon,  9 Dec 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bDPi664h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072B73446;
	Mon,  9 Dec 2024 04:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718630; cv=none; b=iJ3xr8R8+HHyxfCnPvmHaQHBqCD9hlNdL99gY+2g4hXa0RoK/Bel/PannLySCKQocfJgopQlB7/ckV1WB8kWLLqVx+QXRCLNAxKk2YTYSCWNxPBVKoTTIt/6kXsK/23VUi20IR8v2IcJ1uf2N6NkkxP/a9yCU4Kh+3Kc/ND463Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718630; c=relaxed/simple;
	bh=qoBVCsPj9LSkNYkv+fShXevsElwvzFhBnbVMk+TP180=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sh5cekPPJ5+LH/fCqmDDS15g4AIprcIB1dx92MyJJaHiTWwfD9K1Dyr3wPL52TYPHlbpn4D3yNHFd3mQF1+E0EVpdry5ZGk8x33G/T5baPvnSpJSdC+/gtC9NBPQaH1/Iuu6nwHe3he1dj8J73wnlJ0ghujqxE85f48W5+aLXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bDPi664h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MTMZX018941;
	Mon, 9 Dec 2024 04:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fzXSH1rhYvfdhTHAq6+nsYTA7iJW008iqtbY+N7KRvk=; b=bDPi664hLXIyVd3P
	hc2uDNSA60VSJtvbiWhPzlpm4CNWHW/4Zlv5hvmanbE9ZOOULjuFchnmx+CV42ew
	FbVRZZb/4Ppju+J6AIfEYaXOZPDDFCGiu47UhthZiVuB1lMKTKaEIq0btEPieC4r
	ExSeo2YhyyX7tUiZu5LonG538FkqJe8PCzHzDPDFga4fdnvJxpU00ouztpO4HJBV
	dnwCoYDVMu4AHYgG9HkCQpsQT08Sq0qkTF/MORJvV6G5sIYTB68djjZ4cswwthDm
	B9LbZcGguao89xNJqzMw/7AtgctchDWafuiPFJgGgpDmLNfYD0suuurZXd3WjKeL
	SYoAJA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cc2ebh87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 04:30:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B94UHt0005868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 04:30:17 GMT
Received: from [10.216.4.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 20:30:10 -0800
Message-ID: <17c9839d-c61e-3c2f-4d77-5e8813f3a9c8@quicinc.com>
Date: Mon, 9 Dec 2024 10:00:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] PCI: dwc: Add ECAM support with iATU configuration
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_vpernami@quicinc.com>,
        <quic_mrana@quicinc.com>, <mmareddy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20241204221714.GA3023492@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241204221714.GA3023492@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8DbU83nimCF42SVCvQNf9-IrGLpTh27j
X-Proofpoint-GUID: 8DbU83nimCF42SVCvQNf9-IrGLpTh27j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090034



On 12/5/2024 3:47 AM, Bjorn Helgaas wrote:
> On Wed, Dec 04, 2024 at 07:45:29AM +0530, Krishna Chaitanya Chundru wrote:
>> On 12/4/2024 12:25 AM, Bjorn Helgaas wrote:
>>> On Sun, Nov 17, 2024 at 03:30:19AM +0530, Krishna chaitanya chundru wrote:
>>>> The current implementation requires iATU for every configuration
>>>> space access which increases latency & cpu utilization.
>>>>
>>>> Configuring iATU in config shift mode enables ECAM feature to access the
>>>> config space, which avoids iATU configuration for every config access.
> 
>>>> +static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>>>> +{
>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>> +	struct dw_pcie_ob_atu_cfg atu = {0};
>>>> +	struct resource_entry *bus;
>>>> +	int ret, bus_range_max;
>>>> +
>>>> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
>>>> +
>>>> +	/*
>>>> +	 * Bus 1 config space needs type 0 atu configuration
>>>> +	 * Remaining buses need type 1 atu configuration
>>>
>>> I'm confused about the bus numbering; you refer to "bus 1" and "bus
>>> 2".  Is bus 1 the root bus, i.e., the primary bus of a Root Port?
>>>
>>> The root bus number would typically be 0, not 1, and is sometimes
>>> programmable.  I don't know how the DesignWare core works, but since
>>> you have "bus" here, referring to "bus 1" and "bus 2" here seems
>>> overly specific.
>>>
>> root bus is bus 0 and we don't need any iATU configuration for it as
>> its config space is accessible from the system memory, for usp port of
>> the switch or the direct the endpoint i.e bus 1 we need to send
>> Configuration Type 0 requests and for other buses we need to send
>> Configuration Type 1 requests this is as per PCIe spec, I will try to
>> include PCIe spec details in next patch.
> 
> I understand the Type 0/Type 1 differences.  The question is whether
> the root bus number is hard-wired to 0.
> 
It is not hard-wired to 0, we can configure it though bus-range property
> I don't think specifying "bus 1" really adds anything.  The point is
> that we need Type 0 accesses for anything directly below a Root Port
> (regardless of what the RP's secondary bus number is), and Type 1 for
> things deeper.
> 
I will update the comment without mentioning the buses as suggested.
> When DWC supports multiple Root Ports in a Root Complex, they will not
> all have a secondary bus number of 1.
mostly they should be in bus number 0 with different device numbers, but
it mostly depends upon the design, currently we don't have any multiple
root ports.

- Krishna Chaitanya.
> 
> Bjorn

