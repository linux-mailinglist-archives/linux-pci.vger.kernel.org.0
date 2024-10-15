Return-Path: <linux-pci+bounces-14507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 907E599DC63
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 04:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265D71F23426
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 02:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CF1158535;
	Tue, 15 Oct 2024 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T46TAodU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735C6AB8;
	Tue, 15 Oct 2024 02:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728960400; cv=none; b=kM1jDnlNoMHd7mio+1czPEc96lgCzKZRopgk4d6nBPLsN1m3PwN4IWNzs31JtisUGHl8LOUitywgwZGcmp81OSIoXzS3O5OhDcnElnHd5gH3xL1mIHujFrxCC7h7E/L9X59iRlXBQdRNtbzfM+kFw5yeFa3ZVX2IvBSV1mozxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728960400; c=relaxed/simple;
	bh=hb/tXU639KZVM7PWEVuCMASmkvuahxNCAt+oTq3QPNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U7yr+CNSVEH3f/sgMEcWWErFMsHhjf50ldRiJq2oyRJdsMUHkFCP8/rqZh6YXv+lEyB84UNlH5sEr0oyRqQ3E6CGoXk3NMa+Kxct1pvcH4/OlUwv8B13XnJhSOh550XJKMZmohDjKi5doteavcjGhK08G4zCK+6rgdXz7JyUvto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T46TAodU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1pLdg028934;
	Tue, 15 Oct 2024 02:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pbEGIR5/6gy6kLcA5WidgDGnLnhumHi9DVqfOYna3Nk=; b=T46TAodUUVjBk9FV
	lN+2YsTYwPAP8uHgd3/C+l+dGKcGfqVj6wQdQ5mxpAsTOSw7cZYyICXKGxjjf7VG
	kAX1sjF2fbkvN1Dclq7q1bdhd54VoW/zvEjx/bWrpprmFprdOP6NIGRro3xAtpRt
	jX0oDHghoS90XNPDhgQAJPZosbibbDkMnhyvgLm1OitWmyT2RAzBTdQnkTxPk11d
	DZWTvgyJNcQrUJ6HCcVW6EMEVyUrt5DxPbEdPpNWSt09y+rggeqvjraAvlLuIN8x
	eCj7S2Hlw4Ix0142SJlS0gqlotvAftKOmd7Bq5UC7gWmsa6KWuDkuC39Tu6bnPSr
	Wy5U5g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4292evhwcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 02:46:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49F2kNHt003772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 02:46:23 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Oct
 2024 19:46:17 -0700
Message-ID: <28567b77-9d0c-421a-8c2e-88a310a20704@quicinc.com>
Date: Tue, 15 Oct 2024 10:46:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] PCI: qcom: Fix the ops for SC8280X family SoC
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Johan Hovold <johan+linaro@kernel.org>
References: <20241014171807.GA612411@bhelgaas>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20241014171807.GA612411@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3wDoqdW48Ll3OwwhzQMMW2xvx-lvC8Qx
X-Proofpoint-ORIG-GUID: 3wDoqdW48Ll3OwwhzQMMW2xvx-lvC8Qx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410150017


On 10/15/2024 1:18 AM, Bjorn Helgaas wrote:
> [+cc Johan; if you tag a commit with Fixes:, please cc the author of
> that commit!]
>
> On Fri, Oct 11, 2024 at 03:41:40AM -0700, Qiang Yu wrote:
>> On SC8280X family SoC, PCIe controllers are connected to SMMUv3, hence
>> they don't need the config_sid() callback in ops_1_9_0 struct. Fix it by
>> introducing a new ops struct, namely ops_1_21_0, so that BDF2SID mapping
>> won't be configured during init.
> Can you make the subject line say something specific about what this
> patch does?  "Fix the ops" really doesn't include any useful
> information.
Sure, will directly say Remove BDF2SID mapping config for SC8280XP in 
subject.
>
> Based on the Fixes: below, this has to do with ASPM, so the subject
> line (and the commit log) should probably say something about ASPM.
>
> I don't see the connection between your mention of SMMUv3 and ASPM.
> Are there two logical changes here that should be two separate
> patches?
This patch is to remove config_sid callback for sc8280x as it
supports SMMUv3.

This patch is not related to ASPM. Look like using
70574511f3f ("PCI: qcom: Add support for SC8280XP")
in Fixes tag is better. Sorry for the confusion.

Thanks,
Qiang
>> Fixes: d1997c987814 ("PCI: qcom: Disable ASPM L0s for sc8280xp, sa8540p and sa8295p")
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
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
>> @@ -1405,7 +1415,7 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
>>   };
>>   
>>   static const struct qcom_pcie_cfg cfg_sc8280xp = {
>> -	.ops = &ops_1_9_0,
>> +	.ops = &ops_1_21_0,
>>   	.no_l0s = true,
>>   };
>>   
>> -- 
>> 2.34.1
>>

