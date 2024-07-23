Return-Path: <linux-pci+bounces-10681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3531893A98E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 00:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8781F22D4F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 22:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1241482F0;
	Tue, 23 Jul 2024 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eHbDlyrM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93725760;
	Tue, 23 Jul 2024 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775460; cv=none; b=Dda+bu4MzK/AFgSQJaLuJM4nUyL/UnJ3726Lqi6iiNq8M7XwoA8TpL7ZZaR9ZKCYUUn76+BZXM3hAiF6/DgWbWCVser1ut61OeBOh7FWY/uJIU6RkEvWrGfEpKHWM5/ROvCa/TIMkEiAwjEE/azspmPEahwLBpolleYhN+IUG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775460; c=relaxed/simple;
	bh=4HkF86r2tTWndomkjDKrfJ3vDAdjfYG+k0T/xRQJz7s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ugLWCHdxEP7LaqQ6Ka2K8Y+M2KmYb3DjZcrFtaC5V1Qi6CDyYxdRQGap7VjmXOfa3+lT6MyXDhG9l+2ywxRhbdj48L4yva5HubTzAaqrgdz07LnTjBZKs/wvC2mHOHjF5DpEuvMUrX9ifZE31vUAyx77wu9M72zSaxJaIAj/zMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eHbDlyrM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NHlj3S028604;
	Tue, 23 Jul 2024 22:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VpGSOjbGGSiM7Uoe2VHK5VFOWUwuexM+cF923++NpXU=; b=eHbDlyrMfUBhgRtM
	1wn9T9Aqeq0Fehqrr+KtopXEuvJqImtpwsdmvHg4pnIebmt4bgtFqY0crjTizgYg
	YJhcCBDFEyH1X7F2NcgFjyok4XMZ5W5sDYcJ5VM74T3qyhDf8zop0AIrwp6lZZLv
	8j82ATBnAU2jpRn/Whir2TXEMEGup4VGLA07GvKIsdcnmkGSwiNdDttmkEB6+TC3
	RDD+jW+gXsixTq1YoUqqPcxbNrL+dNAw8kE1OVYTaqy/6agM+kmzV6UOPK/zn+g/
	uBvpZau1jdvbLelg4HmC7x4rGVYdLntc3K0zLN14Y69mMK0NT1PF2xslcGxmlyow
	Rwji1g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5m70fe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 22:56:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NMuawk032209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 22:56:36 GMT
Received: from [10.110.63.227] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 15:56:35 -0700
Message-ID: <6038632d-92ec-4034-bc68-add9d47f2bad@quicinc.com>
Date: Tue, 23 Jul 2024 15:56:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/7] PCI: host-generic: Add dwc PCIe controller based
 MSI controller usage
From: Mayank Rana <quic_mrana@quicinc.com>
To: Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <cassel@kernel.org>, <yoshihiro.shimoda.uh@renesas.com>,
        <s-vadapalli@ti.com>, <u.kleine-koenig@pengutronix.de>,
        <dlemoal@kernel.org>, <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-8-git-send-email-quic_mrana@quicinc.com>
 <20240716085811.GA19348@willie-the-truck>
 <20240716134210.GA3534018-robh@kernel.org>
 <9b6eac04-f377-4afa-8712-ab916f831bba@quicinc.com>
Content-Language: en-US
In-Reply-To: <9b6eac04-f377-4afa-8712-ab916f831bba@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yMIb1vZTjHzgrE0Sw94Z46179o6FJvrl
X-Proofpoint-ORIG-GUID: yMIb1vZTjHzgrE0Sw94Z46179o6FJvrl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_15,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230160

Hi Rob

On 7/16/2024 3:32 PM, Mayank Rana wrote:
> Hi Will and Rob
> 
> Thank you for your quick review comments.
> 
> On 7/16/2024 6:42 AM, Rob Herring wrote:
>> On Tue, Jul 16, 2024 at 09:58:12AM +0100, Will Deacon wrote:
>>> On Mon, Jul 15, 2024 at 11:13:35AM -0700, Mayank Rana wrote:
>>>> Add usage of Synopsys Designware PCIe controller based MSI 
>>>> controller to
>>>> support MSI functionality with ECAM compliant Synopsys Designware PCIe
>>>> controller. To use this functionality add device compatible string as
>>>> "snps,dw-pcie-ecam-msi".
>>>>
>>>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>>>> ---
>>>>   drivers/pci/controller/pci-host-generic.c | 92 
>>>> ++++++++++++++++++++++++++++++-
>>>>   1 file changed, 91 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/controller/pci-host-generic.c 
>>>> b/drivers/pci/controller/pci-host-generic.c
>>>> index c2c027f..457ae44 100644
>>>> --- a/drivers/pci/controller/pci-host-generic.c
>>>> +++ b/drivers/pci/controller/pci-host-generic.c
>>>> @@ -8,13 +8,73 @@
>>>>    * Author: Will Deacon <will.deacon@arm.com>
>>>>    */
>>>> -#include <linux/kernel.h>
>>>>   #include <linux/init.h>
>>>> +#include <linux/kernel.h>
>>>>   #include <linux/module.h>
>>>> +#include <linux/of_address.h>
>>>>   #include <linux/pci-ecam.h>
>>>>   #include <linux/platform_device.h>
>>>>   #include <linux/pm_runtime.h>
>>>> +#include "dwc/pcie-designware-msi.h"
>>>> +
>>>> +struct dw_ecam_pcie {
>>>> +    void __iomem *cfg;
>>>> +    struct dw_msi *msi;
>>>> +    struct pci_host_bridge *bridge;
>>>> +};
>>>> +
>>>> +static u32 dw_ecam_pcie_readl(void *p_data, u32 reg)
>>>> +{
>>>> +    struct dw_ecam_pcie *ecam_pcie = (struct dw_ecam_pcie *)p_data;
>>>> +
>>>> +    return readl(ecam_pcie->cfg + reg);
>>>> +}
>>>> +
>>>> +static void dw_ecam_pcie_writel(void *p_data, u32 reg, u32 val)
>>>> +{
>>>> +    struct dw_ecam_pcie *ecam_pcie = (struct dw_ecam_pcie *)p_data;
>>>> +
>>>> +    writel(val, ecam_pcie->cfg + reg);
>>>> +}
>>>> +
>>>> +static struct dw_ecam_pcie *dw_pcie_ecam_msi(struct platform_device 
>>>> *pdev)
>>>> +{
>>>> +    struct device *dev = &pdev->dev;
>>>> +    struct dw_ecam_pcie *ecam_pcie;
>>>> +    struct dw_msi_ops *msi_ops;
>>>> +    u64 addr;
>>>> +
>>>> +    ecam_pcie = devm_kzalloc(dev, sizeof(*ecam_pcie), GFP_KERNEL);
>>>> +    if (!ecam_pcie)
>>>> +        return ERR_PTR(-ENOMEM);
>>>> +
>>>> +    if (of_property_read_reg(dev->of_node, 0, &addr, NULL) < 0) {
>>
>> Using this function on MMIO addresses is wrong. It is an untranslated
>> address.
> ok. do you prefer me to use of_address_to_resource() instead here ?
> 
>>>> +        dev_err(dev, "Failed to get reg address\n");
>>>> +        return ERR_PTR(-ENODEV);
>>>> +    }
>>>> +
>>>> +    ecam_pcie->cfg = devm_ioremap(dev, addr, PAGE_SIZE);
>>>> +    if (ecam_pcie->cfg == NULL)
>>>> +        return ERR_PTR(-ENOMEM);
>>>> +
>>>> +    msi_ops = devm_kzalloc(dev, sizeof(*msi_ops), GFP_KERNEL);
>>>> +    if (!msi_ops)
>>>> +        return ERR_PTR(-ENOMEM);
>>>> +
>>>> +    msi_ops->readl_msi = dw_ecam_pcie_readl;
>>>> +    msi_ops->writel_msi = dw_ecam_pcie_writel;
>>>> +    msi_ops->pp = ecam_pcie;
>>>> +    ecam_pcie->msi = dw_pcie_msi_host_init(pdev, msi_ops, 0);
>>>> +    if (IS_ERR(ecam_pcie->msi)) {
>>>> +        dev_err(dev, "dw_pcie_msi_host_init() failed\n");
>>>> +        return ERR_PTR(-EINVAL);
>>>> +    }
>>>> +
>>>> +    dw_pcie_msi_init(ecam_pcie->msi);
>>>> +    return ecam_pcie;
>>>> +}
>>>
>>> Hmm. This looks like quite a lot of not-very-generic code to be adding
>>> to pci-host-generic.c. The file is now, what, 50% designware logic?
>>
>> Agreed.
>>
>> I would suggest you add ECAM support to the DW/QCom driver reusing some
>> of the common ECAM support code.
> I can try although there is very limited reusage of code with 
> pcie-qcom.c and pcie-designware-host.c except reusing MSI functionality. 
> That would make more new OPs within pcie-designware-host.c and 
> pcie-qcom.c just to perform few operation. As now MSI functionality is 
> available outside pcie core designware driver (although those changes 
> are under review), will you be ok to allow separate Qualcomm PCIe ECAM 
> driver as previously submitted RFC as 
> https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/
> 
> I can modify above ECAM driver to call into PCIe designware module based 
> MSI ops as doing here and that would allow reusing of MSI functionality 
> at same time allowing separate driver for handling firmware VM based 
> implementation.
Can you consider above request to have separate driver here ?
Please suggest on this.

>>
>> I suppose another option would be to define a node and driver which is
>> just the DW MSI controller. That might not work given the power domain
>> being added (which is not very generic either).
> yes, I did consider this approach, and haven't used this due to concern 
> as you mentioned, and also that ask for modifying devicetree usage for 
> existing user of PCIe Designware controller based MSI controller.
> 
> Regards,
> Mayank
> 

