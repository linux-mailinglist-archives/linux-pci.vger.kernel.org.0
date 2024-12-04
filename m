Return-Path: <linux-pci+bounces-17619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864539E3157
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 03:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E19163168
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 02:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676ED13AD39;
	Wed,  4 Dec 2024 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aLHq6++H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF68172A;
	Wed,  4 Dec 2024 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278723; cv=none; b=i3XxJjFdBL0QrNX4lMpUD/jdHG+crRK9drE9Clr3u14ui2ltIvnYAAPH0SVKKE3d0WLL1asXeLVmgR0YKkOvADdAiZ0s9UE9wyUfv/DuBgifoia5mF2sVG3aJeMCcUB5shLGwbj3XnhMkMACcbIyiaoaMLiGTZxLF9q6A+kaI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278723; c=relaxed/simple;
	bh=+kEMO7rGw+KeheCipiC3trpAyN0T9xh2czyl3i+Q6KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NjivLJG8OlFDxPq8DfU6IZUo4Op5YsjE61+6hkK7c3O8K8/J8lAGRhw24l+1VTW33gaSDj0x2KfHM/84R2aXovTEWoQVn7Du8OmTQpyftb9pPNFEw+z2lABbgpwLZ4++tziKcml68IzHw18rLlO4GV5NlCfMBvBB62j5HviDilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aLHq6++H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3E6nEA032117;
	Wed, 4 Dec 2024 02:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2AB+M/PmUMKeW8e1s13hUrW6/+2lZdTuq/nO5hGHVCo=; b=aLHq6++H/eL2l1Nj
	EBYNwW36AwGo6g3R7caPLDNgWFXIDgd7fIMFxPpi2eaRH8zThfk+VaY1CJlTLJCB
	EGUUp1LYIEqmJ+zJO1JMtODaMAu+ep66Pcktk8PhFQAllFgMou6oxgP+N9uV7/wQ
	fHD5AftoKr5HjibYQjplG+cBQHhf9yt2mCzxb/f/3CYHepUceBXIBpRh5HSiyLU3
	NEO3zddvlTdmNusiWjkY08WGA8jrXRIRjXkmVp/Zw2+baxmRUFpR658y04iBlwWg
	NlDr2oHYDFrs/7wHttBejpe1+e+2FGVnN36T0OrY7Qp2OyXo97MwS0WaK4BArsBC
	iyCucQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a3faspay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 02:18:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B42ISvJ003944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 02:18:28 GMT
Received: from [10.216.45.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 18:18:19 -0800
Message-ID: <0a6110c3-0e20-6afb-b266-952ef9c1ff1e@quicinc.com>
Date: Wed, 4 Dec 2024 07:48:15 +0530
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
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
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
References: <20241117-ecam-v1-0-6059faf38d07@quicinc.com>
 <20241117-ecam-v1-3-6059faf38d07@quicinc.com>
 <20241202165349.iwaqfugyewyq6or2@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241202165349.iwaqfugyewyq6or2@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qY7M8vChkdIhR9aJVau0QweJSASVktbH
X-Proofpoint-GUID: qY7M8vChkdIhR9aJVau0QweJSASVktbH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040018



On 12/2/2024 10:23 PM, Manivannan Sadhasivam wrote:
> On Sun, Nov 17, 2024 at 03:30:20AM +0530, Krishna chaitanya chundru wrote:
>> Enable the ECAM feature if the config space size is equal to size required
>> to represent number of buses in the bus range property.
>>
> 
> Please move this change to DWC core.
> 
>> The ELBI registers falls after the DBI space, so use the cfg win returned
>> from the ecam init to map these regions instead of doing the ioremap again.
>> ELBI starts at offset 0xf20 from dbi.
>>
>> On bus 0, we have only the root complex. Any access other than that should
>> not go out of the link and should return all F's. Since the IATU is
>> configured for bus 1 onwards, block the transactions for bus 0:0:1 to
>> 0:31:7 (i.e., from dbi_base + 4KB to dbi_base + 1MB) from going outside the
>> link through ecam blocker through parf registers.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 104 +++++++++++++++++++++++++++++++--
>>   1 file changed, 100 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index ef44a82be058..266de2aa3a71 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -61,6 +61,17 @@
>>   #define PARF_DBI_BASE_ADDR_V2_HI		0x354
>>   #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
>>   #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
>> +#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
>> +#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
>> +#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
>> +#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
>> +#define PARF_ECAM_BASE				0x380
>> +#define PARF_ECAM_BASE_HI			0x384
>> +
>>   #define PARF_NO_SNOOP_OVERIDE			0x3d4
>>   #define PARF_ATU_BASE_ADDR			0x634
>>   #define PARF_ATU_BASE_ADDR_HI			0x638
>> @@ -68,6 +79,8 @@
>>   #define PARF_BDF_TO_SID_TABLE_N			0x2000
>>   #define PARF_BDF_TO_SID_CFG			0x2c00
>>   
>> +#define ELBI_OFFSET				0xf20
>> +
>>   /* ELBI registers */
>>   #define ELBI_SYS_CTRL				0x04
>>   
>> @@ -84,6 +97,7 @@
>>   
>>   /* PARF_SYS_CTRL register fields */
>>   #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
>> +#define PCIE_ECAM_BLOCKER_EN			BIT(26)
>>   #define MST_WAKEUP_EN				BIT(13)
>>   #define SLV_WAKEUP_EN				BIT(12)
>>   #define MSTR_ACLK_CGC_DIS			BIT(10)
>> @@ -293,15 +307,68 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>>   	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>>   }
>>   
>> +static int qcom_pci_config_ecam_blocker(struct dw_pcie_rp *pp)
> 
> 'config_ecam_blocker' is one of the use of this function, not the only one. So
> use something like, 'qcom_pci_config_ecam()'.
> 
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
> 
> s/"for bus 0:0:1 to 0:31:7"/"starting from 0:0.1 to 0:31:7"
> 
>> +	 * going outside the link.
>> +	 */
>> +	addr = pci->dbi_phys_addr + SZ_4K;
>> +	writel(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
>> +	writel(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
>> +
>> +	writel(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
>> +	writel(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
>> +
>> +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
>> +
>> +	writel(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
>> +	writel(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
>> +
>> +	writel(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
>> +	writel(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
>> +
>> +	val = readl(pcie->parf + PARF_SYS_CTRL);
>> +	val |= PCIE_ECAM_BLOCKER_EN;
>> +	writel(val, pcie->parf + PARF_SYS_CTRL);
>> +	return 0;
>> +}
>> +
>> +static int qcom_pcie_ecam_init(struct dw_pcie *pci, struct pci_config_window *cfg)
>> +{
>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +
>> +	pcie->elbi = pci->dbi_base + ELBI_OFFSET;
> 
> Can't you derive this offset from DT?
> 
> - Mani
instread of macro & dt In the next patch we will read a parf register
which will give the offset value from dbi, PARF_SLV_DBI_ELBI (0x1C001B4)

- Krishna Chaitanya.
> 

