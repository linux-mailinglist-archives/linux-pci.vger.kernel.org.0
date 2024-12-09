Return-Path: <linux-pci+bounces-17899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB81F9E8A6E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 05:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7454C280A54
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 04:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF5816F288;
	Mon,  9 Dec 2024 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UDE2/tBp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE187156228;
	Mon,  9 Dec 2024 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733719213; cv=none; b=fQm6q84wuoAQkxEdH9tEPbkcRpx/nJ3O8xF2cqsN3xllPR0WVw/aa7C9RbiBDLB9KuNXS/dmBJamtEqQJeKdfLGpew3M4VMEKJKLY8Xf/EjfzbOgkHZAxQfC4YgV9HIR65XuHsr2H234tYQaUTeKBclKwQwqQOXhXxpwqNzCQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733719213; c=relaxed/simple;
	bh=yZuyfSXF4y3S/DYOnOOMCaPoLzmjtOcnJAWNZlStaOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kH4RSuVptYI3hEykzZ8qAX1PWVKaTmFbP1lsRVZjc8gMMw3bkN+4DQP2zwGsacP6/eWPy2IF/bWpO5jIQoyGelerYmnRHgfzaabX2DfpnnhQDyncCK6F8DlCKetEcH344XW3ZZKu9IT6+Ge/koBvx6ineODMC8ZWK3+Nnw8Jcso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UDE2/tBp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MWKwO017070;
	Mon, 9 Dec 2024 04:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8hP9JT1ZC4yzVeTREhqlUdNj34/+AjB3Aan1CIOV354=; b=UDE2/tBplV1Xt64A
	ygT0zgHQt1ShDaRird9y34rWuq64mk5IGF3YVm2Pzw3MxIAtwKL1n7WIZaRzGerW
	Aub/cv6P/0uq6VrUWtWolMDt0wR74QoOUHBwFbHsFrO+QL+P4r9mD6YwLZTyIiiP
	w9KCU87dEeRX4EdBtX7g2yx4h29ri1vYcnEE22ICneoOUFgmKZGDe+WKZcHRYmz5
	+csbYgPZV64xegqsAuvbOcAez52IcVHoNnVOuTxYIWczaBNFy5dYqVZXTvhOn8i1
	V6o8Vj21NWKY9GzHPZRzZX0kgqib7mfOU84lkoFkZOIiELe89TT72oRVWMQF35Z8
	JxUUmA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cfhkb841-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 04:40:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B94e2S4019515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 04:40:02 GMT
Received: from [10.216.4.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 20:39:55 -0800
Message-ID: <437ad4b9-64d1-6095-8b9d-fc40760b8248@quicinc.com>
Date: Mon, 9 Dec 2024 10:09:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] PCI: qcom: Enable ECAM feature based on config size
Content-Language: en-US
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
References: <20241204224049.GA3023706@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241204224049.GA3023706@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HRwPjrbGHK-bFzN-IRwbgohjsxA2qANp
X-Proofpoint-GUID: HRwPjrbGHK-bFzN-IRwbgohjsxA2qANp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090035



On 12/5/2024 4:10 AM, Bjorn Helgaas wrote:
> On Wed, Dec 04, 2024 at 07:56:54AM +0530, Krishna Chaitanya Chundru wrote:
>> On 12/4/2024 12:29 AM, Bjorn Helgaas wrote:
>>> On Sun, Nov 17, 2024 at 03:30:20AM +0530, Krishna chaitanya chundru wrote:
>>>> Enable the ECAM feature if the config space size is equal to size required
>>>> to represent number of buses in the bus range property.
>>>>
>>>> The ELBI registers falls after the DBI space, so use the cfg win returned
>>>> from the ecam init to map these regions instead of doing the ioremap again.
>>>> ELBI starts at offset 0xf20 from dbi.
>>>>
>>>> On bus 0, we have only the root complex. Any access other than that should
>>>> not go out of the link and should return all F's. Since the IATU is
>>>> configured for bus 1 onwards, block the transactions for bus 0:0:1 to
>>>> 0:31:7 (i.e., from dbi_base + 4KB to dbi_base + 1MB) from going outside the
>>>> link through ecam blocker through parf registers.
> 
>>>> +static bool qcom_pcie_check_ecam_support(struct device *dev)
>>>> +{
>>>> +	struct platform_device *pdev = to_platform_device(dev);
>>>> +	struct resource bus_range, *config_res;
>>>> +	u64 bus_config_space_count;
>>>> +	int ret;
>>>> +
>>>> +	/* If bus range is not present, keep the bus range as maximum value */
>>>> +	ret = of_pci_parse_bus_range(dev->of_node, &bus_range);
>>>> +	if (ret) {
>>>> +		bus_range.start = 0x0;
>>>> +		bus_range.end = 0xff;
>>>> +	}
>>>
>>> I would have thought the generic OF parsing would already default to
>>> [bus 00-ff]?
>>>
>> if there is no bus-range of_pci_parse_bus_range is not updating it[1],
>> the bus ranges is being updated to default value in
>> devm_of_pci_get_host_bridge_resources()[2]
> 
> Understood.  But qcom uses dw_pcie_host_init(), which calls
> devm_pci_alloc_host_bridge(), which ultimately calls
> of_pci_parse_bus_range() and defaults to [bus 00-ff] if there's no
> bus-range in DT:
> 
>    qcom_pcie_probe
>      dw_pcie_host_init
>        devm_pci_alloc_host_bridge
>          devm_of_pci_bridge_init
>            pci_parse_request_of_pci_ranges
>              devm_of_pci_get_host_bridge_resources(0, 0xff)
>                of_pci_parse_bus_range
> 
> So the question is why you need to do that again here.
> 
> I see that qcom_pcie_probe() calls qcom_pcie_check_ecam_support()
> *before* it calls dw_pcie_host_init(), so I guess that's the immediate
> answer.
> 
> But this is another reason why I think qcom_pcie_check_ecam_support()
> is kind of a sub-optimal solution here.
> 
> I wonder if we should factor the devm_pci_alloc_host_bridge() call out
> of dw_pcie_host_init() so drivers can take advantage of the DT parsing
> it does.  It looks like mobiveil does it that way:
It makes sense to use this way in the next patch in the qcom driver will
call devm_pci_alloc_host_bridge() before calling dw_pcie_host_init() and
in dw_pcie_host_init() if the bridge is allocated dwc driver will skip
allocating the bridge so that other drivers will not be affected.

- Krishna Chaitanya.

> 
>    ls_g4_pcie_probe
>      devm_pci_alloc_host_bridge
>      mobiveil_pcie_host_probe
> 
>    mobiveil_pcie_probe
>      devm_pci_alloc_host_bridge
>      mobiveil_pcie_host_probe
> 
>> [1]https://elixir.bootlin.com/linux/v6.12.1/source/drivers/pci/of.c#L193
>> [2]https://elixir.bootlin.com/linux/v6.12.1/source/drivers/pci/of.c#L347


