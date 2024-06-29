Return-Path: <linux-pci+bounces-9429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9406791CA72
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 04:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE1928367E
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 02:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD04C9B;
	Sat, 29 Jun 2024 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eEJ8Nadc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B52C9A;
	Sat, 29 Jun 2024 02:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719626582; cv=none; b=dD2OZiit9WfAjVWNENpY0qb4SaijuNRKGrFk01Eia0+5Zzv0lnZR3WKogzLh4usQ8LaB1+AtFyPaKdJM7BihAP2/DqgkzIhcu1bd/aOAeX9ui4kqCdmfI+KwgxpHbKn8auuTsPOfDSzaJcUsQwJrqtbd5M9OYAE1+YeSMMFJAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719626582; c=relaxed/simple;
	bh=clSqdg93X6Y8kY7/l/Gr7fmMAnemBGyIjD+YQqM0aaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GfIocZfwzVV+/2sKQNp5TF9oDjK5HsxeiiVvxvA2NzN7bHZ8pixGFNa9QXPg/9K4dwLcQwpA0qXNU6buraxHq9tqg/W6psfHS5wZEePBzhZ02qoYV+71Q30qeNXGmpW8WcCbz7spAUDQMW+2xhKK9i2PTY+tq/iG/ag7SWig8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eEJ8Nadc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T0uwr8031353;
	Sat, 29 Jun 2024 02:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	94rVeHKFTp5LaQCr/6jQoirBMQia1FYPMQ7NlEurw/w=; b=eEJ8NadcMasXh/Vj
	gWt77LDvY7m4Cgr9xQLeVvjb0qWPcXIPPCNIbMuobAGuP0l5ug+9xTg9N4PrrORg
	/pw1o2KBbaI4DranzHaKpkMqCibdjkOWKZDeXCZmDRxdknoTjwWxrJjUTLLrhBXN
	DhnUNQ9pINiMD2MM8mnJrYvWn+YhOc856b5TNvtLd+671WE/NeiMavB7DEJvsYgV
	+YXWu2+LiyoK2gc1Zmx3gRJBgyZOBbsWmjlv/2aWTKCASNj2dqMAwfQbQ8sXmRfj
	bAs8RpG9THdr1ETDuIvT+KfTExKGQQFYcW+b1b2oKZWWtuQVadU+isd2RPjA41Ra
	ltk+Gw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027yf03je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 02:02:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T22qH1022100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 02:02:52 GMT
Received: from [10.110.120.123] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 19:02:51 -0700
Message-ID: <a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com>
Date: Fri, 28 Jun 2024 19:02:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: qcom: Avoid DBI and ATU register space mirror to
 BAR/MMIO region
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mrana@quicinc.com>, <quic_devipriy@quicinc.com>
References: <20240620213405.3120611-1-quic_pyarlaga@quicinc.com>
 <20240622035444.GA2922@thinkpad>
Content-Language: en-US
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
In-Reply-To: <20240622035444.GA2922@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: te9XIV61HRjJoI2hHPmYE65r9s27dag1
X-Proofpoint-ORIG-GUID: te9XIV61HRjJoI2hHPmYE65r9s27dag1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290014

Hi Manivannan,

Thanks for the review comments.

On 6/21/2024 8:54 PM, Manivannan Sadhasivam wrote:
> On Thu, Jun 20, 2024 at 02:34:05PM -0700, Prudhvi Yarlagadda wrote:
>> PARF hardware block which is a wrapper on top of DWC PCIe controller
>> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
>> register to get the size of the memory block to be mirrored and uses
>> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
>> address of DBI and ATU space inside the memory block that is being
>> mirrored.
>>
> 
> This PARF_SLV_ADDR_SPACE register is a mystery to me. I tried getting to the
> bottom of it, but nobody could explain it to me clearly. Looks like you know
> more about it...
> 
> From your description, it seems like this register specifies the size of the
> mirroring region (ATU + DBI), but the response from your colleague indicates
> something different [1].
> 
> [1] https://lore.kernel.org/linux-pci/f42559f5-9d4c-4667-bf0e-7abfd9983c36@quicinc.com/
> 

PARF_SLV_ADDR_SPACE_SIZE is used for mirroring the region containing ATU + DBI.
But the issue being observed in the patch pointed above and the issue I am
observing are a bit different even though the same fix could be used for both issues.

The issue I am observing is that the DBI and ATU region is getting mirrored into the
BAR/MMIO region and thereby the DBI and ATU registers contents are getting modified
while accessing the BAR region content.

As per my discussions internally with Devi Priya (author of the patch pointed above),
the issue being seen there is that the DBI register contents are not available
at the expected address by software and this is causing enumeration failures.

Below is the memory map of the IPQ9574 platform being mentioned in the above patch
along with the memory locations of the DBI of respective PCIe Root Complexes.

                      |--------------------|
                      |                    |
                      |                    |
                      |                    |
                      |                    |
                      |--------------------|
                      |                    |
                      |       PCIe2        |
                      |                    |
                      |--------------------|---->0x2000_0000 ->DBI
                      |                    |
                      |       PCIe3        |
                      |                    |
                      |--------------------|---->0x1800_0000 ->DBI
                      |                    |
                      |       PCIe1        |
                      |                    |
                      |--------------------|---->0x1000_0000 ->DBI
                      |                    |
                      |                    |
                      |                    |
                      |--------------------|

Previously PARF_SLV_ADDR_SPACE_SIZE is configured as 256MB (0x1000_0000) and
PARF_DBI_BASE_ADDR is configured as 0x0 for each of the PCIe Root complex. With
this configuration, in the case of PCIe1 DBI contents get accessible at 0x0,
0x1000_0000 and 0x2000_0000 and so on due to mirroring. Although NOC allows access
only to region 0x1000_0000 to 0x1800_0000 for PCIe1. So in the case of PCIe1 DBI
is accessible at the expected location 0x1000_0000.

Similarly in the case of PCIe3 its DBI contents are accessible at 0x0, 0x1000_0000
and 0x2000_0000 but the expectation is to have DBI at 0x1800_0000 (as 0x1800_0000 is
the physical address of DBI per devicetree). This is causing enumeration failures as
DBI is not at the expected location (same issue w.r.t ATU).

When PARF_SLV_ADDR_SPACE_SIZE is modified to 128MB (0x800_0000) and PARF_DBI_BASE_ADDR
is kept 0x0, for PCIe3 the DBI gets accessible at 0x0, 0x800_0000, 0x1000_0000,
0x1800_0000, 0x2000_0000 and so on. So, now the DBI becomes accessible at the
expected location of 0x1800_0000 and its fixing the issue in the above patch.

Alternate way to fix the above issue is if we use the current patch to disable
mirroring and configure the PARF_DBI_BASE_ADDR then the DBI gets accessible only at
the location given in PARF_DBI_BASE_ADDR register which will be the same location
mentioned in devicetree.

>> When a memory region which is located above the SLV_ADDR_SPACE_SIZE
>> boundary is used for BAR region then there could be an overlap of DBI and
>> ATU address space that is getting mirrored and the BAR region. This
>> results in DBI and ATU address space contents getting updated when a PCIe
>> function driver tries updating the BAR/MMIO memory region. Reference
>> memory map of the PCIe memory region with DBI and ATU address space
>> overlapping BAR region is as below.
>>
>> 			|---------------|
>> 			|		|
>> 			|		|
>> 	-------	--------|---------------|
>> 	   |	   |	|---------------|
>> 	   |	   |	|	DBI	|
>> 	   |	   |	|---------------|---->DBI_BASE_ADDR
>> 	   |	   |	|		|
>> 	   |	   |	|		|
>> 	   |	PCIe	|		|---->2*SLV_ADDR_SPACE_SIZE
>> 	   |	BAR/MMIO|---------------|
>> 	   |	Region	|	ATU	|
>> 	   |	   |	|---------------|---->ATU_BASE_ADDR
>> 	   |	   |	|		|
>> 	PCIe	   |	|---------------|
>> 	Memory	   |	|	DBI	|
>> 	Region	   |	|---------------|---->DBI_BASE_ADDR
>> 	   |	   |	|		|
>> 	   |	--------|		|
>> 	   |		|		|---->SLV_ADDR_SPACE_SIZE
>> 	   |		|---------------|
>> 	   |		|	ATU	|
>> 	   |		|---------------|---->ATU_BASE_ADDR
>> 	   |		|		|
>> 	   |		|---------------|
>> 	   |		|	DBI	|
>> 	   |		|---------------|---->DBI_BASE_ADDR
>> 	   |		|		|
>> 	   |		|		|
>> 	----------------|---------------|
>> 			|		|
>> 			|		|
>> 			|		|
>> 			|---------------|
>>
>> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
>> used for BAR region which is why the above mentioned issue is not
>> encountered. This issue is discovered as part of internal testing when we
>> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
>> we are trying to fix this.
>>
> 
> I don't quite understand this. PoR value of SLV_ADDR_SPACE_SIZE is 16MB and most
> of the platforms have the size of whole PCIe region defined in DT as 512MB
> (registers + I/O + MEM). So the range is already crossing the
> SLV_ADDR_SPACE_SIZE boundary.
> 
> Ironically, the patch I pointed out above changes the value of this register as
> 128MB, and the PCIe region size of that platform is also 128MB. The author of
> that patch pointed out that if the SLV_ADDR_SPACE_SIZE is set to 256MB, then
> they are seeing enumeration failures. If we go by your description of that
> register, the SLV_ADDR_SPACE_SIZE of 256MB should be > PCIe region size of
> 128MB. So they should not see any issues, right?
> 

As mentioned above, configuring PARF_SLV_ADDR_SPACE_SIZE as 256MB is causing
issue with the PCIe instances in which DBI is not aligned with the multiples of
256MB and due to PARF_DBI_BASE_ADDR being configured as 0x0 instead of the
actual DBI address given in devicetree.

>> As PARF hardware block mirrors DBI and ATU register space after every
>> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
>> U64_MAX to PARF_SLV_ADDR_SPACE_SIZE register to avoid mirroring DBI and
>> ATU to BAR/MMIO region.
> 
> Looks like you are trying to avoid this mirroring on a whole. First of all, what
> is the reasoning behind this mirroring?
> 

The reason is to have more control over where to have the DBI and ATU register
contents in the system memory using the PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR.
For the PARF_SLV_ADDR_SPACE_SIZE register we don't have an existing use case
to utilize mirroring functionality.

>> Write the physical base address of DBI and ATU
>> register blocks to PARF_DBI_BASE_ADDR (default 0x0) and PARF_ATU_BASE_ADDR
>> (default 0x1000) respectively to make sure DBI and ATU blocks are at
>> expected memory locations.
>>
> 
> Why is this needed? Some configs in this driver writes 0 to PARF_DBI_BASE_ADDR.
> Does the hardware doesn't know where the registers are located?
> 

Yes, hardware doesn't know where the DBI, ATU registers are located in the
PARF_SLV_ADDR_SPACE_SIZE memory block or system memory. Hardware gets the location
of DBI and ATU registers from the PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR
registers. So these registers must be programmed to have the DBI and ATU at
expected memory locations.

>> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 40 ++++++++++++++++++++++----
>>  1 file changed, 35 insertions(+), 5 deletions(-)
>>
>> Tested:
>> - Validated NVME functionality with PCIe6a on x1e80100 platform.
>> - Validated WiFi functionality with PCIe4 on x1e80100 platform.
>> - Validated NVME functionality with PCIe0 and PCIe1 on SA8775p platform.
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 5f9f0ff19baa..864548657551 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -49,7 +49,12 @@
>>  #define PARF_LTSSM				0x1b0
>>  #define PARF_SID_OFFSET				0x234
>>  #define PARF_BDF_TRANSLATE_CFG			0x24c
>> +#define PARF_DBI_BASE_ADDR_V2			0x350
>> +#define PARF_DBI_BASE_ADDR_V2_HI		0x354
>>  #define PARF_SLV_ADDR_SPACE_SIZE		0x358
>> +#define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35C
>> +#define PARF_ATU_BASE_ADDR			0x634
>> +#define PARF_ATU_BASE_ADDR_HI			0x638
>>  #define PARF_NO_SNOOP_OVERIDE			0x3d4
>>  #define PARF_DEVICE_TYPE			0x1000
>>  #define PARF_BDF_TO_SID_TABLE_N			0x2000
>> @@ -319,6 +324,33 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>>  	dw_pcie_dbi_ro_wr_dis(pci);
>>  }
>>  
>> +static void qcom_pcie_avoid_dbi_atu_mirroring(struct qcom_pcie *pcie)
>> +{
>> +	struct dw_pcie *pci = pcie->pci;
>> +	struct platform_device *pdev;
>> +	struct resource *atu_res;
>> +	struct resource *dbi_res;
>> +
>> +	pdev = to_platform_device(pci->dev);
>> +	if (!pdev)
>> +		return;
>> +
>> +	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>> +	if (dbi_res) {
>> +		writel(lower_32_bits(dbi_res->start), pcie->parf + PARF_DBI_BASE_ADDR_V2);
>> +		writel(upper_32_bits(dbi_res->start), pcie->parf + PARF_DBI_BASE_ADDR_V2_HI);
>> +	}
>> +
>> +	atu_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
>> +	if (atu_res) {
>> +		writel(lower_32_bits(atu_res->start), pcie->parf + PARF_ATU_BASE_ADDR);
>> +		writel(upper_32_bits(atu_res->start), pcie->parf + PARF_ATU_BASE_ADDR_HI);
>> +	}
>> +
> 
> Above 2 resources are already fetched by dw_pcie_get_resources(). So we should
> just store the phys addresses in 'struct dw_pcie' and make use of them here.
> 
> - Mani
> 

This function is using the DBI and ATU physical addresses here to program PARF registers
that are specific to pcie-qcom driver. Currently there is no use for DBI and ATU physical
addresses for other platform drivers that us dwc PCIe controller. Could you please let
me know if you still want me to save the DBI and ATU physical addresses in dw_pcie structure ?

Thanks,
Prudhvi

>> +	writel(lower_32_bits(U64_MAX), pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>> +	writel(upper_32_bits(U64_MAX), pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_HI);
>> +}
>> +
>>  static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
>>  {
>>  	u32 val;
>> @@ -623,8 +655,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
>>  	val &= ~PHY_TEST_PWR_DOWN;
>>  	writel(val, pcie->parf + PARF_PHY_CTRL);
>>  
>> -	/* change DBI base address */
>> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
>> +	qcom_pcie_avoid_dbi_atu_mirroring(pcie);
>>  
>>  	/* MAC PHY_POWERDOWN MUX DISABLE  */
>>  	val = readl(pcie->parf + PARF_SYS_CTRL);
>> @@ -900,6 +931,8 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>>  	/* Wait for reset to complete, required on SM8450 */
>>  	usleep_range(1000, 1500);
>>  
>> +	qcom_pcie_avoid_dbi_atu_mirroring(pcie);
>> +
>>  	/* configure PCIe to RC mode */
>>  	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
>>  
>> @@ -908,9 +941,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>>  	val &= ~PHY_TEST_PWR_DOWN;
>>  	writel(val, pcie->parf + PARF_PHY_CTRL);
>>  
>> -	/* change DBI base address */
>> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
>> -
>>  	/* MAC PHY_POWERDOWN MUX DISABLE  */
>>  	val = readl(pcie->parf + PARF_SYS_CTRL);
>>  	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
>> -- 
>> 2.25.1
>>
> 

