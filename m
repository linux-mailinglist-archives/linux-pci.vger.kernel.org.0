Return-Path: <linux-pci+bounces-17621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0E69E3165
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 03:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2604161A3F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 02:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024027453;
	Wed,  4 Dec 2024 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KHGIcJEO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CDA848C;
	Wed,  4 Dec 2024 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279243; cv=none; b=FPk5SMU6QSs8bZTalnPNny7Owu5DhtkGjnoZe8yyhfNYB2l2Ue+yypkZYbTQPX1jvkhg1cpDWZzc3csVSA8DpzOc9eGUu/6mxxAW4ovsEf08I1gvUUI3M5lZb9GI3pwLWVvxAjJHONrDGXglzkevHIPPpzjvQr2d/009s4aTNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279243; c=relaxed/simple;
	bh=hx7v1B76dY053B26XoQD504O+I06ilPZ43rOw9Yqivc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=enDQ9D3TSA6asxjsTCDn8N2mBrh0b6/7i3DvW0g6uGEQww2aUZbPrB7J95RYYJbXjlSD+jFoCKAsMpmYU8+tu4gDo1ipF2PVr0hHOwCvxzgH5EJOOtm7q3ioYbpvTVbh4z3cUoQA46CvK14s0D8sLc9ow9JycrXbxGjgYI0+xv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KHGIcJEO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3F7hKX010056;
	Wed, 4 Dec 2024 02:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4X3SSLIuY8M2ZOHAWH5VFOFsrGomUxA4d6wWDghmVHg=; b=KHGIcJEO1Cvcq7ol
	vF36q+Wj7SZCeuMXC9JS15Mp5QaORgKzIsWlR+fx8VJZzq6bXZ733jJKT9HLawAY
	LTgFmad9W9zkFR1SAFvvaXRTS70Og4xftpqIuUHcO4q+ygPoRpLGTB/6tMTctyfV
	0Tc0GKgBovB6u00iTVkUXA/9HZL80aNOtwbzCcwXXrq7vRMOxvMHveWVBgzGXAgj
	7N6TnL+5XiAmCS1SHMwSjeYWetwp4T9hVdVyOjeWR3/FmiV9g38tM0jEJRdTyqSh
	/2sYuUYMhLQ9bLjATMmIi326oRFRsdHgr8tu6P09VnDbvJUExuOdtN1TGjSvziwd
	FmhZvA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a4by1hpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 02:27:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B42R854014979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 02:27:08 GMT
Received: from [10.216.45.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 18:26:59 -0800
Message-ID: <5bb0d96d-0d11-99c2-a569-7c928e0ae4fe@quicinc.com>
Date: Wed, 4 Dec 2024 07:56:54 +0530
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
References: <20241203185940.GA2910223@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241203185940.GA2910223@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yUl1Y0VGFPKtIWk0Smd_9C-HNUe7Bts5
X-Proofpoint-ORIG-GUID: yUl1Y0VGFPKtIWk0Smd_9C-HNUe7Bts5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040020



On 12/4/2024 12:29 AM, Bjorn Helgaas wrote:
> On Sun, Nov 17, 2024 at 03:30:20AM +0530, Krishna chaitanya chundru wrote:
>> Enable the ECAM feature if the config space size is equal to size required
>> to represent number of buses in the bus range property.
>>
>> The ELBI registers falls after the DBI space, so use the cfg win returned
>> from the ecam init to map these regions instead of doing the ioremap again.
>> ELBI starts at offset 0xf20 from dbi.
>>
>> On bus 0, we have only the root complex. Any access other than that should
>> not go out of the link and should return all F's. Since the IATU is
>> configured for bus 1 onwards, block the transactions for bus 0:0:1 to
>> 0:31:7 (i.e., from dbi_base + 4KB to dbi_base + 1MB) from going outside the
>> link through ecam blocker through parf registers.
> 
> s/ecam/ECAM/
> s/dbi/DBI/
> s/IATU/iATU/ (Seems to be the convention?  Also below)
> s/parf/PARF/ (I assume an initialism?)
> 
> Use conventional format for PCI bus addresses ... I assume "0:0:1"
> means bus 0, device 0, function 1, which would normally be formatted
> as "00:00.1" (also below).
> 
>> +static int qcom_pci_config_ecam_blocker(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +	u64 addr, addr_end;
>> +	u32 val;
>> +
>> +	/* Set the ECAM base */
>> +	writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
>> +	writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
>> +
>> +	/*
>> +	 * On bus 0, we have only the root complex. Any access other than that
>> +	 * should not go out of the link and should return all F's. Since the
>> +	 * IATU is configured for bus 1 onwards, block the transactions for
>> +	 * bus 0:0:1 to 0:31:7 (i.e from dbi_base + 4kb to dbi_base + 1MB) from
>> +	 * going outside the link.
> 
> s/IATU/iATU/ to match other usage.
> 
> Use conventional formatting of PCI bus/device/function addresses.
> 
> Unless the root bus number is hard-wired to be zero, maybe this should
> say "root bus" instead of "bus 0"?
> 
> There is no architected presence of a PCIe Root Complex as a PCI
> device.  Maybe this should say "the only device on bus 0 is the *Root
> Port*"?
> 
> Or maybe there's a PCI device with some sort of device-specific
> interface to Root Complex registers?  But if that were the *only*
> device on bus 0, there would be no Root Port to reach other devices,
> so this doesn't seem likely.
> 
>> +static bool qcom_pcie_check_ecam_support(struct device *dev)
> 
> Rename to be an assertion that can be either true or false, e.g.,
> "ecam_supported".  "Check" doesn't hint about what true/false mean.
> 
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct resource bus_range, *config_res;
>> +	u64 bus_config_space_count;
>> +	int ret;
>> +
>> +	/* If bus range is not present, keep the bus range as maximum value */
>> +	ret = of_pci_parse_bus_range(dev->of_node, &bus_range);
>> +	if (ret) {
>> +		bus_range.start = 0x0;
>> +		bus_range.end = 0xff;
>> +	}
> 
> I would have thought the generic OF parsing would already default to
> [bus 00-ff]?
> 
if there is no bus-range of_pci_parse_bus_range is not updating it[1],
the bus ranges is being updated to default value in
devm_of_pci_get_host_bridge_resources()[2]

[1]https://elixir.bootlin.com/linux/v6.12.1/source/drivers/pci/of.c#L193
[2]https://elixir.bootlin.com/linux/v6.12.1/source/drivers/pci/of.c#L347

- Krishna Chaitanya.
>> +	config_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>> +	if (!config_res)
>> +		return false;
> 
> Move of_pci_parse_bus_range() (if it's needed) down here so it's
> together with the use of the results.  No point in calling it before
> looking for "config".
> 
>> +	bus_config_space_count = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
>> +	if (resource_size(&bus_range) > bus_config_space_count)
>> +		return false;
>> +
>> +	return true;
>> +}

