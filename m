Return-Path: <linux-pci+bounces-5874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C65C89BB1F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 11:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D6D28399B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4AE3B290;
	Mon,  8 Apr 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NHK5iYx6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED83FB2C;
	Mon,  8 Apr 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566964; cv=none; b=vAIq/LUMZOb0BOLLVgy5W3cgURNYlLUzMAyFoxZ+ibSUMuhMna8eFJCm/QaPjhAu0GkwRdydX6Mw6K5ZjHXch3q8jS2uSRTTVYEw8oHWswAgagAfqr8+46cd3QNE7bHBO0ZvEP5hLT8r5MPCjwOaOy6f+AvDogQhVN/lkysRxF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566964; c=relaxed/simple;
	bh=0aNBd9zisQqXxBIaoFkcYdj26S5EKA61Nkf5X3bcjf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NpX8MHjXvvVINo6mtOhpqv66DKf6AJx0U1FmeDKZB8ljRA4i7dHTdSP3ul/3ga5U0XSyutRs8odh0C5PcEWN/KYEUCybjHFfdrvw2hRDyBsZfMMoOGByrg1IY+hxhCTxASrNSOObZ+9UOUqQVz8gEMe69gTH9DuePwLq7LB4QYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NHK5iYx6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4386cf12031108;
	Mon, 8 Apr 2024 09:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=F/OW5DE1hnqTJO6f0QTP3IDZETZqVELNL792BdSC0Hs=; b=NH
	K5iYx6C1tOeTMhHGLS8Uk3yRG0d/qAeRWPiGChLKqKZMOZ1xT1WEuNu+inuHyFJj
	t2T/VQHUc1pOs61pQiG1o5TuKHnYMfeke8UmfEKHugm6KbABFbY/I+oozHeYAnQ1
	H6ftKGa4942I+s178fBdl5uCdnU58TfNag4MOZXhLWC/7GLN0oDSgmQNOkd/dKtz
	3PBobNW45kwX8Bx8OSXQ3fqOfb8+K9XwulEN5GtTIkK5bchE4cLJhrtPm+RvXGjv
	yyHdrjpULyYrI9Zf9fHgUmx/VlS10wC0EcnlgNkVg6t2ZXCqV0NeyBOiuZTgoqyV
	ciX+oaONbpZbKlZCnBJA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg008xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:02:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43892WCA030199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 09:02:32 GMT
Received: from [10.216.26.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 02:02:24 -0700
Message-ID: <6e9b4379-5849-73cd-4d89-5e809b4c71a4@quicinc.com>
Date: Mon, 8 Apr 2024 14:32:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v9 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>
References: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
 <20240407-opp_support-v9-6-496184dc45d7@quicinc.com>
 <20240407150048.GE2679@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240407150048.GE2679@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i-PlhEQAnee6g3UntA013vT1Hl92-9Yz
X-Proofpoint-ORIG-GUID: i-PlhEQAnee6g3UntA013vT1Hl92-9Yz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080069



On 4/7/2024 8:30 PM, Manivannan Sadhasivam wrote:
> On Sun, Apr 07, 2024 at 10:07:39AM +0530, Krishna chaitanya chundru wrote:
>> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
>> maintains hardware state of a regulator by performing max aggregation of
>> the requests made by all of the clients.
>>
>> PCIe controller can operate on different RPMh performance state of power
>> domain based on the speed of the link. And this performance state varies
>> from target to target, like some controllers support GEN3 in NOM (Nominal)
>> voltage corner, while some other supports GEN3 in low SVS (static voltage
>> scaling).
>>
>> The SoC can be more power efficient if we scale the performance state
>> based on the aggregate PCIe link bandwidth.
>>
>> Add Operating Performance Points (OPP) support to vote for RPMh state based
>> on the aggregate link bandwidth.
>>
>> OPP can handle ICC bw voting also, so move ICC bw voting through OPP
>> framework if OPP entries are present.
>>
>> Different link configurations may share the same aggregate bandwidth,
>> e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same bandwidth
>> and share the same OPP entry.
>>
> 
> This info should be part of the dts change.
> 
ok I will move this to dts patch in next patch series.
>> As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
>> is supported.
>>
>> Before PCIe link is initialized vote for highest OPP in the OPP table,
>> so that we are voting for maximum voltage corner for the link to come up
>> in maximum supported speed.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 72 +++++++++++++++++++++++++++-------
>>   1 file changed, 58 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index b4893214b2d3..4ad5ef3bf8fc 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_gpio.h>
>>   #include <linux/pci.h>
>> +#include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/phy/pcie.h>
>> @@ -1442,15 +1443,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>   	return 0;
>>   }
>>   
>> -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>> +static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>>   {
>>   	struct dw_pcie *pci = pcie->pci;
>> -	u32 offset, status;
>> +	u32 offset, status, freq;
>> +	struct dev_pm_opp *opp;
>>   	int speed, width;
>> -	int ret;
>> -
>> -	if (!pcie->icc_mem)
>> -		return;
>> +	int ret, mbps;
>>   
>>   	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>   	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>> @@ -1462,10 +1461,26 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>>   	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>>   	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>>   
>> -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
>> -	if (ret) {
>> -		dev_err(pci->dev, "failed to set interconnect bandwidth for PCIe-MEM: %d\n",
>> -			ret);
>> +	if (pcie->icc_mem) {
>> +		ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
>> +		if (ret) {
>> +			dev_err(pci->dev, "failed to set interconnect bandwidth for PCIe-MEM: %d\n",
> 
> s/failed/Failed
> 
>> +				ret);
>> +		}
>> +	} else {
>> +		mbps = pcie_link_speed_to_mbps(pcie_link_speed[speed]);
>> +		if (mbps < 0)
>> +			return;
>> +
>> +		freq = mbps * 1000;
>> +		opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);
> 
> As per the API documentation, dev_pm_opp_put() should be called for both success
> and failure case.
> 
ACK.
>> +		if (!IS_ERR(opp)) {
> 
> So what is the action if OPP is not found for the freq?
> 
There is already a vote for maximum freq in the probe, so if it fails
here we can continue here.
If you feel otherwise let me know I Can make changes as suggested.
>> +			ret = dev_pm_opp_set_opp(pci->dev, opp);
>> +			if (ret)
>> +				dev_err(pci->dev, "Failed to set opp: freq %ld ret %d\n",
> 
> 'Failed to set OPP for freq (%ld): %d'
> 
>> +					dev_pm_opp_get_freq(opp), ret);
>> +			dev_pm_opp_put(opp);
>> +		}
>>   	}
>>   }
>>   
>> @@ -1509,8 +1524,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>>   static int qcom_pcie_probe(struct platform_device *pdev)
>>   {
>>   	const struct qcom_pcie_cfg *pcie_cfg;
>> +	unsigned long max_freq = INT_MAX;
>>   	struct device *dev = &pdev->dev;
>>   	struct qcom_pcie *pcie;
>> +	struct dev_pm_opp *opp;
>>   	struct dw_pcie_rp *pp;
>>   	struct resource *res;
>>   	struct dw_pcie *pci;
>> @@ -1577,9 +1594,33 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   		goto err_pm_runtime_put;
>>   	}
>>   
>> -	ret = qcom_pcie_icc_init(pcie);
>> -	if (ret)
>> +	/* OPP table is optional */
>> +	ret = devm_pm_opp_of_add_table(dev);
>> +	if (ret && ret != -ENODEV) {
>> +		dev_err_probe(dev, ret, "Failed to add OPP table\n");
>>   		goto err_pm_runtime_put;
>> +	}
>> +
>> +	/*
>> +	 * Use highest OPP here if the OPP table is present. At the end of
> 
> I believe I asked you to add the information justifying why the highest OPP
> should be used.
>
I added the info in the commit message, I will add as the comment in the
next patch.

>> +	 * the probe(), OPP will be updated using qcom_pcie_icc_opp_update().
>> +	 */
>> +	if (!ret) {
>> +		opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
> 
> Same comment as dev_pm_opp_find_freq_exact().
> 
>> +		if (!IS_ERR(opp)) {
>> +			ret = dev_pm_opp_set_opp(dev, opp);
>> +			if (ret)
>> +				dev_err_probe(pci->dev, ret,
>> +					      "Failed to set OPP: freq %ld\n",
> 
> Same comment as above.
> 
>> +					      dev_pm_opp_get_freq(opp));
>> +			dev_pm_opp_put(opp);
> 
> So you want to continue even in the case of failure?
> 
I wil make changes to fallback to driver voting for icc bw if it fails here.
- Krishna chaitanya,
> - Mani
> 
>> +		}
>> +	} else {
>> +		/* Skip ICC init if OPP is supported as it is handled by OPP */
>> +		ret = qcom_pcie_icc_init(pcie);
>> +		if (ret)
>> +			goto err_pm_runtime_put;
>> +	}
>>   
>>   	ret = pcie->cfg->ops->get_resources(pcie);
>>   	if (ret)
>> @@ -1599,7 +1640,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   		goto err_phy_exit;
>>   	}
>>   
>> -	qcom_pcie_icc_update(pcie);
>> +	qcom_pcie_icc_opp_update(pcie);
>>   
>>   	if (pcie->mhi)
>>   		qcom_pcie_init_debugfs(pcie);
>> @@ -1658,6 +1699,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>   	if (ret)
>>   		dev_err(dev, "failed to disable icc path of CPU-PCIe: %d\n", ret);
>>   
>> +	if (!pcie->icc_mem)
>> +		dev_pm_opp_set_opp(pcie->pci->dev, NULL);
>> +
>>   	return ret;
>>   }
>>   
>> @@ -1680,7 +1724,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>>   		pcie->suspended = false;
>>   	}
>>   
>> -	qcom_pcie_icc_update(pcie);
>> +	qcom_pcie_icc_opp_update(pcie);
>>   
>>   	return 0;
>>   }
>>
>> -- 
>> 2.42.0
>>
> 

