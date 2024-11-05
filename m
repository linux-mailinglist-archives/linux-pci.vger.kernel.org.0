Return-Path: <linux-pci+bounces-16030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B79BC4B4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 06:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57FC1C2156C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 05:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8DB1BAEDC;
	Tue,  5 Nov 2024 05:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UNrqmaKF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4509A76C61;
	Tue,  5 Nov 2024 05:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730784540; cv=none; b=rxlMGHSjdH7M6hGpfnphPqfZSTUhE4gJal8lWO7JJXjsSPIezykkk4IwiFdZujbJx4E4TU/GTzwDjUJADbN3qfUQS9nPAPPeS092OijQnPxZClOzbZf2eS8r5gW3aY4gmkTAsuixXNo2qUIqYnxqCyIkvi/BkL2bsryihXIJ5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730784540; c=relaxed/simple;
	bh=6F2AfV2KDVQjs5OaTPOzNEGAArtar9LRx4uPjN1pzno=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VJ4EtojHdL3a6Q5IukpElRpqb3+HsYscqBHZVbjTL41FbatWFQTwz4xjZzToKGipVHGRRSRHIN5rKu+hHDhnrTlBlQ7ytGfrTIFyVWHn3KhCWSKDlTWMq8Qe3b+SmJhndReAQpElER6avW8n1U2q0NxbRiLyU6uTacApYIpTRpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UNrqmaKF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4LJlT2031387;
	Tue, 5 Nov 2024 05:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gXEhXPOP+Mqn4mzjrY2u7twKAWMpRp+PxdP/brBj3vk=; b=UNrqmaKFH6dJRFym
	CoLtg8xFinKShF/9fKYl3AsqdmMpaOq+J9lOuzCLzwMeOYqTUZ46yI2vxLudaL46
	MGB422BDxQk2KJqdg/nxDWZINGAQEKP9v4Z6dzkMVzQcCGtw+LBkWdJAmiS6Apt2
	xOMXlSMiB14iPH7/PNBVugPtq/jJQdZaeEei1GxrRJy8ZW1aYj+QEeWtCrovCBBp
	ngaCqd5wztQgBd9XYStwz7LIsAQzp81m8vlCZ8YGo0jv/IrD5VpT/abNyf39iYEW
	0PtIGm1bmaKA87tMxCTSyVoG8EZoni9Iw1KI+0gNVn02C5WFt6P+jgRxXp95ajfr
	czwmvw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd286fje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 05:28:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A55Slwb010713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 05:28:47 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 21:28:41 -0800
Message-ID: <de5f40ab-90b7-4c75-b981-dd5824650660@quicinc.com>
Date: Tue, 5 Nov 2024 13:28:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
To: Johan Hovold <johan@kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <johan+linaro@kernel.org>
References: <20241101030902.579789-1-quic_qianyu@quicinc.com>
 <20241101030902.579789-6-quic_qianyu@quicinc.com>
 <ZyjbrLEn8oSJjaZN@hovoldconsulting.com>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <ZyjbrLEn8oSJjaZN@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zf0OywGt1z_V4G9bDkX0nPa9tCHrXwCY
X-Proofpoint-GUID: zf0OywGt1z_V4G9bDkX0nPa9tCHrXwCY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050038


On 11/4/2024 10:35 PM, Johan Hovold wrote:
> On Thu, Oct 31, 2024 at 08:09:02PM -0700, Qiang Yu wrote:
>> Describe PCIe3 controller and PHY. Also add required system resources like
>> regulators, clocks, interrupts and registers configuration for PCIe3.
>>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>   
>> +		pcie3: pcie@1bd0000 {
>> +			device_type = "pci";
>> +			compatible = "qcom,pcie-x1e80100";
>> +			reg = <0x0 0x01bd0000 0x0 0x3000>,
>> +			      <0x0 0x78000000 0x0 0xf1d>,
>> +			      <0x0 0x78000f40 0x0 0xa8>,
>> +			      <0x0 0x78001000 0x0 0x1000>,
>> +			      <0x0 0x78100000 0x0 0x100000>,
>> +			      <0x0 0x01bd3000 0x0 0x1000>;
>> +			reg-names = "parf",
>> +				    "dbi",
>> +				    "elbi",
>> +				    "atu",
>> +				    "config",
>> +				    "mhi";
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x78200000 0x0 0x100000>,
>> +				 <0x02000000 0x0 0x78300000 0x0 0x78300000 0x0 0x3d00000>,
> Can you double check the size here so that it is indeed correct and not
> just copied from the other nodes which initially got it wrong:
>
> 	https://lore.kernel.org/lkml/20240710-topic-barman-v1-1-5f63fca8d0fc@linaro.org/
 From memory maps, region of PCIe3 is 64MB, the size here is correct.

Thanks,
Qiang Yu
>
>> +				 <0x03000000 0x7 0x40000000 0x7 0x40000000 0x0 0x40000000>;
>> +			bus-range = <0x00 0xff>;
>> +			clocks = <&gcc GCC_PCIE_3_AUX_CLK>,
>> +				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
>> +				 <&gcc GCC_PCIE_3_MSTR_AXI_CLK>,
>> +				 <&gcc GCC_PCIE_3_SLV_AXI_CLK>,
>> +				 <&gcc GCC_PCIE_3_SLV_Q2A_AXI_CLK>,
>> +				 <&gcc GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK>,
>> +				 <&gcc GCC_CNOC_PCIE_NORTH_SF_AXI_CLK>;
>> +			clock-names = "aux",
>> +				      "cfg",
>> +				      "bus_master",
>> +				      "bus_slave",
>> +				      "slave_q2a",
>> +				      "noc_aggr",
>> +				      "cnoc_sf_axi";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE_3_AUX_CLK>;
>> +			assigned-clock-rates = <19200000>;
>> +
>> +			interconnects = <&pcie_south_anoc MASTER_PCIE_3 QCOM_ICC_TAG_ALWAYS
> This should be &pcie_north_anoc
>
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
>> +					 &cnoc_main SLAVE_PCIE_3 QCOM_ICC_TAG_ALWAYS>;
>> +			interconnect-names = "pcie-mem",
>> +					     "cpu-pcie";
> With the above addressed, feel free to keep my Reviewed-by tag.
>
> Johan

