Return-Path: <linux-pci+bounces-13481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32FE9851F5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 06:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EB9285442
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 04:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD4214B06A;
	Wed, 25 Sep 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JDrQwnqA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10C2CA6;
	Wed, 25 Sep 2024 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237865; cv=none; b=Q3ZV/nCCy4DmP+JXrdZ0Idse16qXTgp+uzg4CoPrwxkGImCsUb7F0GkCn3tI+DSAN/yiUiaLbWQXd1dP4ZPOQPf6sFjwl5CP+2Tf0EqNsnkatNYHTA4etByE44BE/kUkB9do3uAWZ9iFqcTGKZdeQWr5VZpnuJtsdNhfXJDOIG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237865; c=relaxed/simple;
	bh=KOtJjfbQO25dIwdv+f4iH8x+aV0gECM+IZPInPTm17U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xi16XM5JDMS+bieJd6aNdBP5krM74RUNcyfuY0IVLyEbqQpFx1NaAMuAxjHA68xGD00OmA8Sg2wCVyCmZYQcfWGvmtT/4E0W1s5nMqj+Qr10uIBQcQNzae1gjd5SJTg/GvdOObfsJzIfzTdTKDMIn3QWPyU8DM4FVtVd7TSeRdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JDrQwnqA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHOk64006035;
	Wed, 25 Sep 2024 03:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZhbqxxGnNn6iWuWZcW4la2E8zNouyHAN9O3d1uNJ50A=; b=JDrQwnqAeHFbZEBb
	3cATDigDpyfO5/dAknAPPdebAnb0nHiwdG7exO2p0zv0tM9wgFumjYIEGnsvzGq4
	AtPbC9naAgNM7XRrPJ4kZPEJYHw4kB4iVz3YWhB1WkaHuTfV0oc/GkovNu042SgT
	JowtNhBbrKc+TRK5tQgbZzhChVes1d6e4Is0/tzYe4EXMc/IeIZZ7aGFsMqB9IG5
	11b52V5Ieytr+vtn2tzC+qAlH+zJV7JrD69+H044cu3MioQu2wJ1Vr3JIg27N4sl
	kB7w0q9R4J6HfhVbM9U7zdrBBP2HteVjIfXWaehSBIOieVJ5FZ83VJbdmhh3/SiP
	Pb+72Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqe9ag98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 03:44:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P3iwj6018823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 03:44:58 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 20:44:54 -0700
Message-ID: <3f454d6f-b40e-49e5-89eb-b77bcca35043@quicinc.com>
Date: Wed, 25 Sep 2024 11:44:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] PCI: qcom: Add support for X1E80100 SoC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <abel.vesa@linaro.org>, <quic_msarkar@quicinc.com>,
        <quic_devipriy@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <kw@linux.com>, <lpieralisi@kernel.org>, <neil.armstrong@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-6-quic_qianyu@quicinc.com>
 <20240924135021.ybpyoahlpuvedma5@thinkpad>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240924135021.ybpyoahlpuvedma5@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NEvl7Hnmhc16mCowiCBdCrSnCaYaxu0v
X-Proofpoint-GUID: NEvl7Hnmhc16mCowiCBdCrSnCaYaxu0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250025


On 9/24/2024 9:50 PM, Manivannan Sadhasivam wrote:
> On Tue, Sep 24, 2024 at 03:14:43AM -0700, Qiang Yu wrote:
>> X1E80100 has PCIe ports that support up to Gen4 x8 based on hardware IP
>> version 1.38.0.
>>
>> Currently the ops_1_9_0 which is being used for X1E80100 has config_sid
>> callback to config BDF to SID table. However, this callback is not
>> required for X1E80100 because it has smmuv3 support and BDF to SID table
>> will be not present.
>>
>> Hence add support for X1E80100 by introducing a new ops and cfg structures
>> that don't require the config_sid callback. This could be reused by the
>> future platforms based on SMMUv3.
>>
> Oops... I completely overlooked that you are not adding the SoC support but
> fixing the existing one :( Sorry for suggesting a commit message that changed
> the context.
>
> For this, you can have something like:
>
> "PCI: qcom: Fix the ops for X1E80100 SoC
>
> X1E80100 SoC is based on SMMUv3, hence it doesn't need the BDF2SID mapping
> present in the existing cfg_1_9_0 ops. This is fixed by introducing new ops
> 'ops_1_38_0' and cfg 'cfg_1_38_0' structures. These are exactly same as the
> 1_9_0 ones, but they don't have the 'config_sid()' callback that handles the
> BDF2SID mapping in the hardware. These new structures could also be used by the
> future SoCs making use of SMMUv3."
Never mind, thanks for your suggestions. Will update the commit msg in next
version.

Thanks,
Qiang Yu
>
> - Mani
>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 88a98be930e3..56ba8bc72f78 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1367,6 +1367,16 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>>   };
>>   
>> +/* Qcom IP rev.: 1.38.0 */
>> +static const struct qcom_pcie_ops ops_1_38_0 = {
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
>> @@ -1409,6 +1419,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>>   	.no_l0s = true,
>>   };
>>   
>> +static const struct qcom_pcie_cfg cfg_1_38_0 = {
>> +	.ops = &ops_1_38_0,
>> +};
>> +
>>   static const struct dw_pcie_ops dw_pcie_ops = {
>>   	.link_up = qcom_pcie_link_up,
>>   	.start_link = qcom_pcie_start_link,
>> @@ -1837,7 +1851,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>>   	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>>   	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>>   	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
>> -	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
>> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_38_0 },
>>   	{ }
>>   };
>>   
>> -- 
>> 2.34.1
>>

