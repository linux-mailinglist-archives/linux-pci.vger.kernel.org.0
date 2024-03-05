Return-Path: <linux-pci+bounces-4516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0B871D2B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 12:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AC92886E1
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 11:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F5A52F68;
	Tue,  5 Mar 2024 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BDJTQf2w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F854799;
	Tue,  5 Mar 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637301; cv=none; b=L1r0nMyYubMN5KNo36Lp4s2IjRRdLD90m4wYSD2WylQ4+xOej0T+THo3+juAkwJy4ZqGgyExsj0p0pZrP4D9MOXRZzl9j6s4htVvGmleMyZ460IxCI5d2Mjc6Oq31fYj6jxsNmhHJHKwveXQG6uXvamPznMqvtHGo5vmh21oGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637301; c=relaxed/simple;
	bh=0KjWMP9fva99DlpfeRqslIk3Rzl805Fa+fnGKVQjvlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p8XK2Ub6kkA4Akd09VkfMVpOVYqGizPLLpYWtT6yrji80rgx5L7WWdPrs/46IAHJjV81khoGLXfwJVmFct3UTJSPgepocLFappcojqhFeE2Ma0io2bJIQvZBMYlQFixhrfqnGtbCIq4+QuQ7wDI3qSheGtcp7LqUqhzo5IbTFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BDJTQf2w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4259lwij004908;
	Tue, 5 Mar 2024 11:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HJToT9oyBXiM4evzSSpbgKhLE/ZDVHfUM7DXlS+ift4=; b=BD
	JTQf2wT8+6HkY65AeM7jTbqB1QZgFaqjd/5SCDE93WwFioIJ6S2Fp7UPjotE4GOg
	Pn/IF82/8uvkO6bLkKQedC8aKLZ37MFr8q73NFKaoM4vMjiiYUy0WF5srzcRRCub
	2k17MdcJRg89z6aEArkAzSz9Q3XGCvnoLmnm09WhzWBdn8IEbNIS3ZCTvwb4W2gU
	HqT68xhee7zyIFY9GusZ5ziN9ciCiN3YkentvBafO+ykTNg7/mauhIOhlaQLah93
	6ZgqqJGSGcEhPJ1l90GoncL7ZyAK/1PW9w4kJXJU6ZTxSFYlJ06IjjkU4hGJCCog
	DLgsFen/9A7dGvOR/jzQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp07w09nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 11:14:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425BEi3F012067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 11:14:44 GMT
Received: from [10.216.9.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 03:14:36 -0800
Message-ID: <c74e326e-285d-854e-5e54-329079152df2@quicinc.com>
Date: Tue, 5 Mar 2024 16:44:20 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v8 7/7] PCI: qcom: Add OPP support to scale performance
 state of power domain
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-7-158285b86b10@quicinc.com>
 <20240304180506.GE31079@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240304180506.GE31079@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HQpSpwPwZJy0fFHCjfGnEBHponY2c6j5
X-Proofpoint-GUID: HQpSpwPwZJy0fFHCjfGnEBHponY2c6j5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050090



On 3/4/2024 11:35 PM, Manivannan Sadhasivam wrote:
> On Sat, Mar 02, 2024 at 09:30:01AM +0530, Krishna chaitanya chundru wrote:
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
>> As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
>> is supported.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 81 +++++++++++++++++++++++++++-------
>>   1 file changed, 66 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index a0266bfe71f1..2ec14bfafcfc 100644
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
>> @@ -244,6 +245,7 @@ struct qcom_pcie {
>>   	const struct qcom_pcie_cfg *cfg;
>>   	struct dentry *debugfs;
>>   	bool suspended;
>> +	bool opp_supported;
> 
> You can just use "pcie->icc_mem" to differentiate between OPP and ICC. No need
> of a new flag.
>
Ack.

>>   };
>>   
>>   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>> @@ -1405,15 +1407,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
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
>> @@ -1425,11 +1425,30 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>>   	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>>   	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>>   
>> -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
>> -	if (ret) {
>> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> -			ret);
>> +	if (pcie->opp_supported) {
>> +		mbps = pcie_link_speed_to_mbps(pcie_link_speed[speed]);
>> +		if (mbps < 0)
>> +			return;
>> +
>> +		freq = mbps * 1000;
>> +		opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);
>> +		if (!IS_ERR(opp)) {
>> +			ret = dev_pm_opp_set_opp(pci->dev, opp);
>> +			if (ret)
>> +				dev_err(pci->dev, "Failed to set opp: freq %ld ret %d\n",
>> +					dev_pm_opp_get_freq(opp), ret);
>> +			dev_pm_opp_put(opp);
>> +		}
>> +	} else {
>> +		ret = icc_set_bw(pcie->icc_mem, 0,
>> +				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
>> +		if (ret) {
>> +			dev_err(pci->dev,
>> +				"failed to set interconnect bandwidth for pcie-mem: %d\n", ret);
> 
> "PCIe-MEM"
> 
Ack.
>> +		}
>>   	}
>> +
>> +	return;
>>   }
>>   
>>   static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
>> @@ -1472,8 +1491,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
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
>> @@ -1540,9 +1561,36 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   		goto err_pm_runtime_put;
>>   	}
>>   
>> -	ret = qcom_pcie_icc_init(pcie);
>> -	if (ret)
>> +	 /* OPP table is optional */
>> +	ret = devm_pm_opp_of_add_table(dev);
>> +	if (ret && ret != -ENODEV) {
>> +		dev_err_probe(dev, ret, "Failed to add OPP table\n");
>>   		goto err_pm_runtime_put;
>> +	}
>> +
>> +	/*
>> +	 * Use highest OPP here if the OPP table is present. At the end of
> 
> Why highest opp? For ICC, we set minimal bandwidth before.
>
In OPP we are voting for both ICC and voltage corner also, if we didn't 
vote for maximum voltage core the PCIe link may not come in maximum 
supported speed. Due to that we are voting for Maximum value.

Anyway we are updating them based upon the link speed and width this 
should not create any issues.
>> +	 * the probe(), OPP will be updated using qcom_pcie_icc_opp_update().
>> +	 */
>> +	if (ret != -ENODEV) {
> 
> if (!ret)
> 
>> +		opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
>> +		if (!IS_ERR(opp)) {
>> +			ret = dev_pm_opp_set_opp(dev, opp);
>> +			if (ret)
>> +				dev_err_probe(pci->dev, ret,
>> +					      "Failed to set opp: freq %ld\n",
> 
> 	"Failed to set OPP for freq: %ld\n"
> 
Ack
>> +					      dev_pm_opp_get_freq(opp));
>> +			dev_pm_opp_put(opp);
>> +		}
>> +		pcie->opp_supported = true;
>> +	}
>> +
>> +	/* Skip ICC init if OPP is supported as ICC bw is handled by OPP */
>> +	if (!pcie->opp_supported) {
>> +		ret = qcom_pcie_icc_init(pcie);
> 
> First check whether ICC is present or not and then check OPP as a fallback. This
> avoids an extra flag.
> 
> - Mani
Ack.

- Krishna Chaitanya.
> 
>> +		if (ret)
>> +			goto err_pm_runtime_put;
>> +	}
>>   
>>   	ret = pcie->cfg->ops->get_resources(pcie);
>>   	if (ret)
>> @@ -1562,7 +1610,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   		goto err_phy_exit;
>>   	}
>>   
>> -	qcom_pcie_icc_update(pcie);
>> +	qcom_pcie_icc_opp_update(pcie);
>>   
>>   	if (pcie->mhi)
>>   		qcom_pcie_init_debugfs(pcie);
>> @@ -1621,10 +1669,13 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>   			qcom_pcie_host_init(&pcie->pci->pp);
>>   			pcie->suspended = false;
>>   		}
>> -		qcom_pcie_icc_update(pcie);
>> +		qcom_pcie_icc_opp_update(pcie);
>>   		return ret;
>>   	}
>>   
>> +	if (pcie->opp_supported)
>> +		dev_pm_opp_set_opp(pcie->pci->dev, NULL);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1647,7 +1698,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
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

