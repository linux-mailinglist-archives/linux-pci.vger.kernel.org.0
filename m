Return-Path: <linux-pci+bounces-12599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F35AB967FB9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 08:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F3E1C21BB7
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 06:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848BF15575F;
	Mon,  2 Sep 2024 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B7sDofyE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F903C30;
	Mon,  2 Sep 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259908; cv=none; b=Z/hBRXzMw4sb0gOgaNP3pt20XSk9dbbOLXS90o9gAvrOttPjLXPQE1Lsnd+HxRDiVM29cA625WW9ZOdTwceFAImG/HGu0ZYNkIQOg67N7hnkwO2Qg8Y/GOlMqEHDx2lLhywSyYEcpdeHiKBaidrpbHTHdtxUSFC1eEGjkTnzEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259908; c=relaxed/simple;
	bh=+KksltFcYHKisk3G0POIQIJXB/k04TfmYh483PzQdm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=llFyL6nwplzFS3vNWCG7agvXjz6kaaFn+tkhtafPk85ISZCnFWt+mZ6wzVoc4GDhGYASBaZaZXP4uZxCWl7fi7fZQ36CoDfl30b62sqavNyNP9KWXJkE6CNxvc2Nnx7EHU+97qcc5eKSmqFOUD6Zt45MbAul8JukkzY01NTfhIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B7sDofyE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4820A2bc015608;
	Mon, 2 Sep 2024 06:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	et7m8NvEB/jnY98cZGzwbEXpTdOFe/se2m/Ug5aoYwg=; b=B7sDofyErGzool+6
	DKkDShoq8+971t7wK0hiZKMP8PF8xK9UlhZe9hoQ0Sbu4kRCssbokXz+NhvKDdBo
	JdD/NjKK9/8YAA7ov2rRCpD855/DKqc/OII9VxMV/n0RBA4xjeW/R+jrWKESaIKT
	KkdGwlhIDllfCj9WgG0pBghHx8agTjEaR0m2a8/i/8gMhOro1+kzcIzeCH8mGJ/w
	xSAEryrSj+kpcnA7jHZ8uAiVA5EvPOQVLzBJW1uTJGVhq/7EQwqEg2H5ExkmQcXQ
	evEhBI9rn4OPNJbQWMm94E6NUEE/aYS6B6Q4vY9dD1shhEwYBrGLESlw/3t+fHEN
	mPE6BA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41brveux2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 06:51:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4826pVxZ020218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Sep 2024 06:51:31 GMT
Received: from [10.216.44.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 1 Sep 2024
 23:51:25 -0700
Message-ID: <9c37c36d-1091-5d5e-58d4-4a20bda65244@quicinc.com>
Date: Mon, 2 Sep 2024 12:21:22 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 7/8] PCI: qcom: Add support for host_stop_link() &
 host_start_link()
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
References: <20240806191203.GA73014@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240806191203.GA73014@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9vI0LdtkqQ4TOkcKB3CmnmZK6AI5QKMb
X-Proofpoint-ORIG-GUID: 9vI0LdtkqQ4TOkcKB3CmnmZK6AI5QKMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-01_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409020054



On 8/7/2024 12:42 AM, Bjorn Helgaas wrote:
> On Sat, Aug 03, 2024 at 08:52:53AM +0530, Krishna chaitanya chundru wrote:
>> For the switches like QPS615 which needs to configure it before
>> the PCIe link is established.
>>
>> if the link is not up assert the PERST# and disable LTSSM bit so
>> that PCIe controller will not participate in the link training
>> as part of host_stop_link().
>>
>> De-assert the PERST# and enable LTSSM bit back in host_start_link().
>>
>> Introduce ltssm_disable function op to stop the link training.
> 
> pcie-qcom.c is a driver for a PCIe host controller.  Apparently QPS615
> is a switch in a hierarchy that could be below any PCIe host
> controller, so I'm missing the connection with pcie-qcom.c.
> 
> Does this fix a problem that only occurs with pcie-qcom.c?  What
> happens if you put a QPS615 below some other controller?
> 
Hi Bjorn,

The qps615 is the qualcomm in-house PCIe switch it is not available to
others. so we are trying to add for qualcomm soc's only.

- Krishna chaitanya.
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 39 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 0180edf3310e..f4a6df53139c 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -233,6 +233,7 @@ struct qcom_pcie_ops {
>>   	void (*host_post_init)(struct qcom_pcie *pcie);
>>   	void (*deinit)(struct qcom_pcie *pcie);
>>   	void (*ltssm_enable)(struct qcom_pcie *pcie);
>> +	void (*ltssm_disable)(struct qcom_pcie *pcie);
>>   	int (*config_sid)(struct qcom_pcie *pcie);
>>   };
>>   
>> @@ -555,6 +556,41 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
>>   	return 0;
>>   }
>>   
>> +static int qcom_pcie_host_start_link(struct dw_pcie *pci)
>> +{
>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +
>> +	if (!dw_pcie_link_up(pcie->pci))  {
>> +		qcom_ep_reset_deassert(pcie);
>> +
>> +		if (pcie->cfg->ops->ltssm_enable)
>> +			pcie->cfg->ops->ltssm_enable(pcie);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void qcom_pcie_host_stop_link(struct dw_pcie *pci)
>> +{
>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +
>> +	if (!dw_pcie_link_up(pcie->pci))  {
>> +		qcom_ep_reset_assert(pcie);
>> +
>> +		if (pcie->cfg->ops->ltssm_disable)
>> +			pcie->cfg->ops->ltssm_disable(pcie);
>> +	}
>> +}
>> +
>> +static void qcom_pcie_2_3_2_ltssm_disable(struct qcom_pcie *pcie)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(pcie->parf + PARF_LTSSM);
>> +	val &= ~LTSSM_EN;
>> +	writel(val, pcie->parf + PARF_LTSSM);
>> +}
>> +
>>   static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
>>   {
>>   	u32 val;
>> @@ -1306,6 +1342,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>>   	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>>   	.deinit = qcom_pcie_deinit_2_7_0,
>>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>> +	.ltssm_disable = qcom_pcie_2_3_2_ltssm_disable,
>>   	.config_sid = qcom_pcie_config_sid_1_9_0,
>>   };
>>   
>> @@ -1363,6 +1400,8 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>>   static const struct dw_pcie_ops dw_pcie_ops = {
>>   	.link_up = qcom_pcie_link_up,
>>   	.start_link = qcom_pcie_start_link,
>> +	.host_start_link = qcom_pcie_host_start_link,
>> +	.host_stop_link = qcom_pcie_host_stop_link,
>>   };
>>   
>>   static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>
>> -- 
>> 2.34.1
>>

