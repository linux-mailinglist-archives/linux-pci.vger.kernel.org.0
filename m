Return-Path: <linux-pci+bounces-15164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 433369ADC5E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 08:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D641F2272C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A3188907;
	Thu, 24 Oct 2024 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Aa7Aw1qR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D36F305;
	Thu, 24 Oct 2024 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752026; cv=none; b=scZJ9miHFstDXG/ULpZeBSN4FSXy0hUrzGz71zVTqaQMRqZSIvUDR3eRB5VefPRUna07GRhLDVut+Gk1S/cXgPCtflTzJub8SWFtPBIUhqVIaAnw9b7OkF2PPz7Y00h2l5hdwli/NgoI0Nr78U7Euq3Qk4rt6vm21Ls00I+m3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752026; c=relaxed/simple;
	bh=G+AGmdhRLFZdNq3pgGY+mTanCncv7kh/SDalcTQTNeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FeBq6uXhznPMmbJCr0g94VC2MEgitDII+qRscDfgWEWoqBvYAMoKhZJ45lOskZtoJnRYDjzMJrLVie/l6qQgCNUqHC19jV7UxIRNRzI6FgC+SH5wWMZQjksWUc6VHWskALXiGj6NbEi2MAhu19vzLbOcHvOpu2BxngviGyYIzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Aa7Aw1qR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NLg2Tl017697;
	Thu, 24 Oct 2024 06:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fk26zDPuQfok9dl0kGUbFQvIezkCct5ynjCixGyvLcQ=; b=Aa7Aw1qRXAyrdU/k
	2ZbXvyDxBD5paQLpvB7LQO8T5hiAjG1OP/pmEGhggP7SIw1XOsULY5QxP8hFTZsZ
	9Gqa9sXvZ37IPMbdlDf0hFRbM9EI8+bAWdKjmKUGMcnKm9xXa18exHYAaZnTLxYB
	OLa4Xd3/+/7xhzcnCxoX6BY1EKrJA7DcXr3PSVZ1/p875VhSQT+pLbSaKTORUPPC
	PrMDqKQ0oNmBypuY6CjhUSYZ9bTK1/zV7iuIZlijqVQxi5kD4XY2YmNagMF+mKjW
	ERXBWiVi2b4KePQjVlsoT09siPXVJ/AZCYznuPZS9O4VwkBbvMthUZdcuvyviXxw
	wHpQiA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3wcq0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:39:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49O6dqjn007427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:39:52 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 23:39:47 -0700
Message-ID: <e3e75d14-94dc-4ec5-a72b-4df0ae66655b@quicinc.com>
Date: Thu, 24 Oct 2024 14:39:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] PCI: qcom: Remove BDF2SID mapping config for
 SC8280X family SoC
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
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
 <20241017030412.265000-6-quic_qianyu@quicinc.com>
 <ZxJn_Xf4NO3eAfey@hovoldconsulting.com>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <ZxJn_Xf4NO3eAfey@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nTg7MJty3ekN0XfECM95-k_nBPjfK-ke
X-Proofpoint-ORIG-GUID: nTg7MJty3ekN0XfECM95-k_nBPjfK-ke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410240048


On 10/18/2024 9:51 PM, Johan Hovold wrote:
> On Wed, Oct 16, 2024 at 08:04:10PM -0700, Qiang Yu wrote:
>> On SC8280X family SoC, PCIe controllers are connected to SMMUv3, hence
>> they don't need the config_sid() callback in ops_1_9_0 struct. Fix it by
>> introducing a new ops struct, namely ops_1_21_0 which is same as ops_1_9_0
>> without config_sid() callback so that BDF2SID mapping won't be configured
>> during init.
> The sc8280xp PCIe devicetree nodes do not specify an 'iommu-map' so the
> config_sid() callback is effectively a no-op. Please rephrase this so
> that it becomes obvious that this is a clean up rather than fix.
>
>> Fixes: 70574511f3fc ("PCI: qcom: Add support for SC8280XP")
> And drop the Fixes tag.
>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 88a98be930e3..468bd4242e61 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1367,6 +1367,16 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>>   };
>>   
>> +/* Qcom IP rev.: 1.21.0 */
> Is this the actual IP revision on sc8280xp (and not just the revision
> used on x1e80100)?
Get confirmation from HW team. 1.21.0 is Qcom IP rev of sc8280xp,
Synopsis IP rev is 5.60a.

Thanks,
Qiang
> Please also provide the Synopsis IP rev like the other configs do.
>
>> +static const struct qcom_pcie_ops ops_1_21_0 = {
>> +	.get_resources = qcom_pcie_get_resources_2_7_0,
>> +	.init = qcom_pcie_init_2_7_0,
>> +	.post_init = qcom_pcie_post_init_2_7_0,
>> +	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>> +	.deinit = qcom_pcie_deinit_2_7_0,
>> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>> +};
>> +
>>   static const struct qcom_pcie_cfg cfg_1_0_0 = {
>>   	.ops = &ops_1_0_0,
>>   };
> And try to keep these structs sorted by revision. At least put this one
> after ops_1_9_0.
>
> Johan

