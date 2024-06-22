Return-Path: <linux-pci+bounces-9106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B0913189
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 04:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B166E1C20EFA
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25C24C6B;
	Sat, 22 Jun 2024 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FHMuCZRy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED351392;
	Sat, 22 Jun 2024 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719022257; cv=none; b=sLY52QfMsYPM/g2qRSBzEHAmYIZ7RLW6PGXIkX1Ao+F4xVboAP9zaxofIKwCSlU9bZpSFvoQ9pOQnIf8RAnrLu3wBlF9Jz62LLYiajVfW7hhXdSfAWVs20wXR7kaXz9hxE3Sma+r/He0fcQVpNSUHXZo56N5yOJ7qUgOGBaSHaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719022257; c=relaxed/simple;
	bh=LQ9XI9AwLJLroNy9nG6dm5ataqAhZs4PbuHvDzKydXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TwDt593fVcfVfq1TGKInlLVxMTttgr1y+0QeMSlHpyjM1GXVWWwrW+suXBTKDaOc+YWHa/tKY7Hij0H3GYVpDGYTb/OK+uIllRfjhJeNxT3JSAIJw1HaRHwGNChHk4O7wMb+9wyHN26iwWL2CYc8CKDnwGoT4LEAXSmd+p1cgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FHMuCZRy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45M0jqLF023860;
	Sat, 22 Jun 2024 02:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hEI19Pz7eq0TrCSWx/3PjKXtkmpQFhhyDv8DrtDboeY=; b=FHMuCZRyGj2nlAnx
	y/p5138zNOxffl/x78LpI6UNqBXwP+AGpon61g7lX4d3yYRZKstuwGeVO3i9dwvl
	0Z81HdOzyhUzwfwpxSBBf3WJg7j1khQo1fr2gg0H9pH8zVMVFVUncFVYTLe1LLoI
	wyxYz6q8js1/w1Bq4+6mIbMxJXnSQ+j5oyN0bWGMNGl+6yYEl+Sfx6cmmcR/D04d
	fNML88SdeEPJRhcsnztLU4H4wecUEdWBteZ8pmsxK4e0K1K1Usu0Q6v47bOrDy3N
	wbIZuVbOEsk/QWMQUCNF11JWN9o8gNMVFgpu6Bf6+5ogD7Cm6RIRjhZiPqWNB2Nl
	v4Lf6Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywkyn03du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 02:10:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45M2AkTW017949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 02:10:46 GMT
Received: from [10.46.163.151] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Jun
 2024 19:10:45 -0700
Message-ID: <0bfb4e4f-f471-4340-aa06-74eae58bdb84@quicinc.com>
Date: Fri, 21 Jun 2024 19:10:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: qcom: Avoid DBI and ATU register space mirror to
 BAR/MMIO region
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <robh@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mrana@quicinc.com>
References: <20240621204705.GA1395276@bhelgaas>
Content-Language: en-US
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
In-Reply-To: <20240621204705.GA1395276@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IYNB-7CKq8Gp0LU_tdlj0VN7PVCZ5O9s
X-Proofpoint-GUID: IYNB-7CKq8Gp0LU_tdlj0VN7PVCZ5O9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_12,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406220012

Hi Bjorn,

Thanks for the review comments.

On 6/21/2024 1:47 PM, Bjorn Helgaas wrote:
> On Thu, Jun 20, 2024 at 02:34:05PM -0700, Prudhvi Yarlagadda wrote:
>> PARF hardware block which is a wrapper on top of DWC PCIe controller
>> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
>> register to get the size of the memory block to be mirrored and uses
>> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
>> address of DBI and ATU space inside the memory block that is being
>> mirrored.
>>
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
> 
> Nice diagram.  Run it through "expand" to convert the tabs to spaces
> so it doesn't get messed up if indented.

ACK. I will update it in the next patch.

>> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
>> used for BAR region which is why the above mentioned issue is not
>> encountered. This issue is discovered as part of internal testing when we
>> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
>> we are trying to fix this.
>>
>> As PARF hardware block mirrors DBI and ATU register space after every
>> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
>> U64_MAX to PARF_SLV_ADDR_SPACE_SIZE register to avoid mirroring DBI and
>> ATU to BAR/MMIO region. Write the physical base address of DBI and ATU
>> register blocks to PARF_DBI_BASE_ADDR (default 0x0) and PARF_ATU_BASE_ADDR
>> (default 0x1000) respectively to make sure DBI and ATU blocks are at
>> expected memory locations.
> 
> This seems ... weird.  You mention BARs, which means a PCI device, so
> that part must refer to a Root Port.
> 
> The diagram also mentions address space *outside* the BAR, so that
> cannot be a PCI device (unless the device is defective and responds to
> accesses outside its BARs).  Maybe this space belongs to the Root
> Complex (which is not a PCI device, so its resources must be described
> via DT)?

Sorry for the confusion caused.

Yes, it is a Root Complex. The DBI and ATU resources are passed via DT
and the BAR region is also passed using ranges property in DT.

> Is this overlap of BAR space and ATU/DBI stuff (I assume the ATU/DBI
> is *not* supposed to be part of the BAR) a result of some invalid
> configuration done by a bootloader?  Or is it a result of Linux
> assigning invalid space for the BAR?
 
No, this overlap is caused entirely by the Qcom PARF hardware block
(wrapper on top of the Root Complex) and the way NOC routing being done.
PARF doesn't know where the BAR region is and it just keeps mirroring the
memory region of size PARF_SLV_ADDR_SPACE_SIZE to the memory space accessible
by the Root Complex. This mirroring effect is causing the DBI and ATU contents
to overlap with BAR region even though there is no actual overlap in the
addresses of DBI, ATU and BAR passed in the DT.

The proposed change will help to avoid the mirroring by giving U64_MAX to
PARF_SLV_ADDR_SPACE_SIZE register. As there won't be system memory greater
than 64 bit address, PARF block will not be able to do the mirroring.

Power on reset values are good enough to use smaller BAR size (less than 16MB in
size as the default value of PARF_SLV_ADDR_SPACE_SIZE is 16MB). If we are using
bigger BAR size, then above set of registers are required to be programmed to
avoid overlap.

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
> 
> Previously these functions wrote PARF_DBI_BASE_ADDR:
> 
>   qcom_pcie_post_init_1_0_0()
>   qcom_pcie_post_init_2_3_2()
>   qcom_pcie_post_init_2_3_3()
>   qcom_pcie_init_2_7_0()      (weird that this is init, not post_init)
>   qcom_pcie_post_init_2_9_0()
> 
> This patch updates qcom_pcie_post_init_2_3_2() and
> qcom_pcie_init_2_7_0() to use PARF_DBI_BASE_ADDR_V2 instead.
> 
> I assume PARF_DBI_BASE_ADDR_V2 and PARF_ATU_BASE_ADDR are new for
> 2.3.2 and 2.7.0?  And they don't apply to 2.3.3 and 2.9.0?  And 1.0.0,
> 2.3.3, and 2.9.0 don't have this problem?

Thanks for pointing this. The new PARF_DBI_BASE_ADDR_V2, PARF_ATU_BASE_ADDR
offsets are only applicable to 2.7.0. I will update the next patchset to 
have these change only in 2.7.0 and remove the usage with 2.3.2.

The same problem is applicable for all the versions of init/post_init
functions except 2.1.0. But the PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR and
PARF_SLV_ADDR_SPACE_SIZE register offsets are different for most of the
versions compared to 2.7.0. And probably need to review all those devices
use cases and if they need more BAR size we shall come up with seperate
patch for those.

> It'd be nice to have a hint in the commit log about which versions are
> and are not affected.

ACK. I will update it in the next patch.

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
> 
> I think I would just call this "configure_dbi_atu" or similar, since I
> think it's about configuring them correctly, and the mirroring is just
> a consequence of doing it wrong.

ACK. I will update it in the next patch.

>> +{
>> +	struct dw_pcie *pci = pcie->pci;
>> +	struct platform_device *pdev;
>> +	struct resource *atu_res;
>> +	struct resource *dbi_res;
>> +
>> +	pdev = to_platform_device(pci->dev);
>> +	if (!pdev)
>> +		return;
> 
> I don't think "!pdev" is even possible.

ACK. I will update it in the next patch.

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
> 
> Why did you move this setup earlier than the previous
> PARF_DBI_BASE_ADDR write?  Is there some 2.7.0 difference that requires
> this?

No, there is no requirement to move this. I wanted to do this setup before
configuring the PARF block to be in Root Complex mode in the line below. I
will move this back to the original position in the next patch to avoid
confusion.

Thanks,
Prudhvi

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
> 
> 

