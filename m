Return-Path: <linux-pci+bounces-11000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC8A9401DA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 01:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6951F22F44
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 23:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C55618D4A4;
	Mon, 29 Jul 2024 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sqfzsm6N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8FA1E49E;
	Mon, 29 Jul 2024 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722297496; cv=none; b=NLFEFjWOIAem4VWAbcWUL7KCcUNqP9+CjZm0jX/aHKS79QfPm68lwf3Y0PiuxcARssVI2I00L8P11NWM0Pu2bAqDFtchskwsL+JTWuXr8w4jp6fESstWmZVyudKhrpayd+tLMTcnPa0h8kKRXSKyxxUwFnCcbG+AYzQ3YBDdsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722297496; c=relaxed/simple;
	bh=0JnTojU8EeCLJw+zfm7ioDfWkNQvetMdzoq7Znr+H9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CnMQqax6uqCbX4tyGLvcMD6zk5vN+t7LOMw94CbYnN204fcnZLpU2cd6f+fqp+jSnb9PcyWAs+EdoL1ZNLF2ePmmdddxgxluv6FiM2cqPmqBdRw25jJUlB5t9SpizkLc64wRveTFsRuVq3gJLMhwlnZb3YlTOOq8pvrA/9VQDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sqfzsm6N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TAkBf8020946;
	Mon, 29 Jul 2024 23:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nENGhiNZISMiSicI2eXh7IQVBNmUMpbS5gGPHPD7UEU=; b=Sqfzsm6NQvVtRz9B
	JvXuBd4W1IiElKz8xB02chw3UqzGyMo5OuuZNiKlXOboIR7BvTTtV0eT9ef3gEW2
	L6di0puxa5glJZ4FDDwR9HPkk+nnlmiIArA1PtVkoQlUyRw+oRnc+5An6p3HuJUc
	gb0HvbR5JiRV8uM99P591wtd/8ChjV6qxxv5jfRaaXwNWro7jHoXJMmWrp3aIX/M
	ZFoQ79ks6KkOgNT7S7ZJpfZ/zS2vJOxtbVT1HDQH4T5EuTNGkPYYz+ZebWk//Z6M
	/U1c2B0K5m4xoZq06Rn7mxA0gxQRIl6w1CCDnI9qzxcLzlF6oDeh7wyEPa2G+eco
	QF0ROQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mt68nj85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:58:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TNw6sI014683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:58:06 GMT
Received: from [10.46.163.151] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 16:58:06 -0700
Message-ID: <aaaf044c-0c8c-425d-83b4-e9180cf63689@quicinc.com>
Date: Mon, 29 Jul 2024 16:57:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: qcom: Avoid DBI and ATU register space mirror
 to BAR/MMIO region
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_mrana@quicinc.com>
References: <20240729225102.GA8214@bhelgaas>
Content-Language: en-US
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
In-Reply-To: <20240729225102.GA8214@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E7IHQBWcshjzL6VKwcdEWpzwOV0_X_Lq
X-Proofpoint-GUID: E7IHQBWcshjzL6VKwcdEWpzwOV0_X_Lq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_21,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290165

Hi Bjorn,

On 7/29/2024 3:51 PM, Bjorn Helgaas wrote:
> On Thu, Jul 25, 2024 at 04:03:56PM -0700, Prudhvi Yarlagadda wrote:
>> Hi Bjorn,
>>
>> Thanks for the review comments.
>>
>> On 7/24/2024 11:43 AM, Bjorn Helgaas wrote:
>>> On Tue, Jul 23, 2024 at 07:27:19PM -0700, Prudhvi Yarlagadda wrote:
>>>> PARF hardware block which is a wrapper on top of DWC PCIe controller
>>>> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
>>>> register to get the size of the memory block to be mirrored and uses
>>>> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
>>>> address of DBI and ATU space inside the memory block that is being
>>>> mirrored.
>>>>
>>>> When a memory region which is located above the SLV_ADDR_SPACE_SIZE
>>>> boundary is used for BAR region then there could be an overlap of DBI and
>>>> ATU address space that is getting mirrored and the BAR region. This
>>>> results in DBI and ATU address space contents getting updated when a PCIe
>>>> function driver tries updating the BAR/MMIO memory region. Reference
>>>> memory map of the PCIe memory region with DBI and ATU address space
>>>> overlapping BAR region is as below.
>>>>
>>>>                         |---------------|
>>>>                         |               |
>>>>                         |               |
>>>>         ------- --------|---------------|
>>>>            |       |    |---------------|
>>>>            |       |    |       DBI     |
>>>>            |       |    |---------------|---->DBI_BASE_ADDR
>>>>            |       |    |               |
>>>>            |       |    |               |
>>>>            |    PCIe    |               |---->2*SLV_ADDR_SPACE_SIZE
>>>>            |    BAR/MMIO|---------------|
>>>>            |    Region  |       ATU     |
>>>>            |       |    |---------------|---->ATU_BASE_ADDR
>>>>            |       |    |               |
>>>>         PCIe       |    |---------------|
>>>>         Memory     |    |       DBI     |
>>>>         Region     |    |---------------|---->DBI_BASE_ADDR
>>>>            |       |    |               |
>>>>            |    --------|               |
>>>>            |            |               |---->SLV_ADDR_SPACE_SIZE
>>>>            |            |---------------|
>>>>            |            |       ATU     |
>>>>            |            |---------------|---->ATU_BASE_ADDR
>>>>            |            |               |
>>>>            |            |---------------|
>>>>            |            |       DBI     |
>>>>            |            |---------------|---->DBI_BASE_ADDR
>>>>            |            |               |
>>>>            |            |               |
>>>>         ----------------|---------------|
>>>>                         |               |
>>>>                         |               |
>>>>                         |               |
>>>>                         |---------------|
>>>>
>>>> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
>>>> used for BAR region which is why the above mentioned issue is not
>>>> encountered. This issue is discovered as part of internal testing when we
>>>> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
>>>> we are trying to fix this.
>>>>
>>>> As PARF hardware block mirrors DBI and ATU register space after every
>>>> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
>>>> U32_MAX (all 0xFF's) to PARF_SLV_ADDR_SPACE_SIZE register to avoid
>>>> mirroring DBI and ATU to BAR/MMIO region. Write the physical base address
>>>> of DBI and ATU register blocks to PARF_DBI_BASE_ADDR (default 0x0) and
>>>> PARF_ATU_BASE_ADDR (default 0x1000) respectively to make sure DBI and ATU
>>>> blocks are at expected memory locations.
>>>>
>>>> The register offsets PARF_DBI_BASE_ADDR_V2, PARF_SLV_ADDR_SPACE_SIZE_V2
>>>> and PARF_ATU_BASE_ADDR are applicable for platforms that use PARF
>>>> Qcom IP rev 1.9.0, 2.7.0 and 2.9.0. PARF_DBI_BASE_ADDR_V2 and
>>>> PARF_SLV_ADDR_SPACE_SIZE_V2 are applicable for PARF Qcom IP rev 2.3.3.
>>>> PARF_DBI_BASE_ADDR and PARF_SLV_ADDR_SPACE_SIZE are applicable for PARF
>>>> Qcom IP rev 1.0.0, 2.3.2 and 2.4.0. Updating the init()/post_init()
>>>> functions of the respective PARF versions to program applicable
>>>> PARF_DBI_BASE_ADDR, PARF_SLV_ADDR_SPACE_SIZE and PARF_ATU_BASE_ADDR
>>>> register offsets. And remove the unused SLV_ADDR_SPACE_SZ macro.
>>>>
>>>> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>>>> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
>>>> ---
>>>>  drivers/pci/controller/dwc/pcie-qcom.c | 62 +++++++++++++++++++-------
>>>>  1 file changed, 45 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> index 0180edf3310e..6976efb8e2f0 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> @@ -45,6 +45,7 @@
>>>>  #define PARF_PHY_REFCLK				0x4c
>>>>  #define PARF_CONFIG_BITS			0x50
>>>>  #define PARF_DBI_BASE_ADDR			0x168
>>>> +#define PARF_SLV_ADDR_SPACE_SIZE		0x16C
>>>>  #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>>>>  #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>>>>  #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>>>> @@ -52,8 +53,13 @@
>>>>  #define PARF_LTSSM				0x1b0
>>>>  #define PARF_SID_OFFSET				0x234
>>>>  #define PARF_BDF_TRANSLATE_CFG			0x24c
>>>> -#define PARF_SLV_ADDR_SPACE_SIZE		0x358
>>>> +#define PARF_DBI_BASE_ADDR_V2			0x350
>>>> +#define PARF_DBI_BASE_ADDR_V2_HI		0x354
>>>> +#define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
>>>> +#define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35C
>>>>  #define PARF_NO_SNOOP_OVERIDE			0x3d4
>>>> +#define PARF_ATU_BASE_ADDR			0x634
>>>> +#define PARF_ATU_BASE_ADDR_HI			0x638
>>>>  #define PARF_DEVICE_TYPE			0x1000
>>>>  #define PARF_BDF_TO_SID_TABLE_N			0x2000
>>>>  #define PARF_BDF_TO_SID_CFG			0x2c00
>>>> @@ -107,9 +113,6 @@
>>>>  /* PARF_CONFIG_BITS register fields */
>>>>  #define PHY_RX0_EQ(x)				FIELD_PREP(GENMASK(26, 24), x)
>>>>  
>>>> -/* PARF_SLV_ADDR_SPACE_SIZE register value */
>>>> -#define SLV_ADDR_SPACE_SZ			0x10000000
>>>> -
>>>>  /* PARF_MHI_CLOCK_RESET_CTRL register fields */
>>>>  #define AHB_CLK_EN				BIT(0)
>>>>  #define MSTR_AXI_CLK_EN				BIT(1)
>>>> @@ -324,6 +327,39 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>>>>  	dw_pcie_dbi_ro_wr_dis(pci);
>>>>  }
>>>>  
>>>> +static void qcom_pcie_configure_dbi_base(struct qcom_pcie *pcie)
>>>> +{
>>>> +	struct dw_pcie *pci = pcie->pci;
>>>> +
>>>> +	if (pci->dbi_phys_addr) {
>>>> +		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
>>>> +							PARF_DBI_BASE_ADDR);
>>>> +		writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>>>> +	}
>>>> +}
>>>> +
>>>> +static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
>>>> +{
>>>> +	struct dw_pcie *pci = pcie->pci;
>>>> +
>>>> +	if (pci->dbi_phys_addr) {
>>>> +		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
>>>> +							PARF_DBI_BASE_ADDR_V2);
>>>> +		writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf +
>>>> +						PARF_DBI_BASE_ADDR_V2_HI);
>>>> +
>>>> +		if (pci->atu_phys_addr) {
>>>> +			writel(lower_32_bits(pci->atu_phys_addr), pcie->parf +
>>>> +							PARF_ATU_BASE_ADDR);
>>>> +			writel(upper_32_bits(pci->atu_phys_addr), pcie->parf +
>>>> +							PARF_ATU_BASE_ADDR_HI);
>>>> +		}
>>>> +
>>>> +		writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2);
>>>> +		writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2_HI);
>>>> +	}
>>>> +}
>>>
>>> These functions write CPU physical addresses into registers.  I don't
>>> know where these registers live.  If they are on the PCI side of the
>>> world, they most likely should contain PCI bus addresses, not CPU
>>> physical addresses.
>>>
>>> In some systems, PCI bus addresses are the same as CPU physical
>>> addresses, but on many systems they are not the same, so it's better
>>> if we don't make implicit assumptions that they are the same.  
>>
>> On Qualcomm platforms, CPU physical address and PCI bus addresses
>> for DBI and ATU registers are same. PARF registers live outside the
>> PCI address space in the system memory.
>>
>> There is a mapping logic in the QCOM PARF wrapper which detects any
>> incoming read/write transactions from the NOC towards PCIe
>> controller and checks its addresses against PARF_DBI_BASE_ADDR and
>> PARF_ATU_BASE_ADDR registers so that these transactions can be
>> routed to DBI and ATU registers inside the PCIe controller.
>>
>> So, these PARF registers needs to be programmed with base CPU
>> physical addresses of DBI and ATU as the incoming DBI and ATU
>> transactions from the NOC contain CPU physical adresses.
> 
> Can you add a comment to this effect that these registers are
> effectively in the CPU address domain, not the PCI bus domain?
> Otherwise the next person who reviews this will have the same
> question, and somebody may even try to "fix" this by converting it to
> a PCI bus address.
> 
> Bjorn

ACK. I will add a comment in the next patch.

Thanks,
Prudhvi

