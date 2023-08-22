Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080147838D3
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 06:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjHVE2f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 00:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjHVE2e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 00:28:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BF5138;
        Mon, 21 Aug 2023 21:28:32 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M0QX5v009244;
        Tue, 22 Aug 2023 04:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=APc38RrnCys9JAHKEC7xgdRfIVVU0U3Kapsm/M1geX8=;
 b=DYZuw+sGSqFgBCpMPLWYvxScM8CePyNwtpG9x3a0mkIatxxzOyOAoLVtI7vHPZrj6m8b
 IOXicU2a1ET4Em3kLTil/JWKbTihaYbOGsos4ECqu3LOojCPcdrzB4XOgZc4G8+oqMNv
 3L5lmR0idFJIbm0utdre+c918ngRFRBWzksKuA6ozXvpMse0wZnqdep3OcmBmPNSatFG
 m7/MwIgUK9qC00UAFSFSs2OhiONBzantMqgzWgLHV/CLJ8NP/c2hKSyt8Op0xF5QQbQ0
 4ihlJI/w37dzQ1QlAokOUW7MJ5N0RHg0WoDQAcjyZa9rj/4+xz6UH4/rTuFZdIHw1jW5 RQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm5mct3kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 04:28:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37M4SFe5028963
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 04:28:15 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 21 Aug
 2023 21:28:09 -0700
Message-ID: <162b135d-7e27-bf3b-df8f-45e2a5e73897@quicinc.com>
Date:   Tue, 22 Aug 2023 09:57:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 3/3] PCI: qcom: Add OPP support for speed based
 performance state of RPMH
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_parass@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1692627343-4380-1-git-send-email-quic_krichai@quicinc.com>
 <1692627343-4380-4-git-send-email-quic_krichai@quicinc.com>
 <95078a8b-857d-4900-8737-a495212db935@quicinc.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <95078a8b-857d-4900-8737-a495212db935@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jdaBYln4q4moE9F69mhnIIbuBRRjQrY_
X-Proofpoint-ORIG-GUID: jdaBYln4q4moE9F69mhnIIbuBRRjQrY_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_02,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220034
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/22/2023 9:33 AM, Pavan Kondeti wrote:
> On Mon, Aug 21, 2023 at 07:45:43PM +0530, Krishna chaitanya chundru wrote:
>> Before link training vote for the maximum performance state of RPMH
>> and once link is up, vote for the performance state based upon the link
>> speed.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 47 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 7a87a47..c57ca1a 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/of_device.h>
>>   #include <linux/of_gpio.h>
>>   #include <linux/pci.h>
>> +#include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/phy/pcie.h>
>> @@ -1357,6 +1358,32 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>   	return 0;
>>   }
>>   
>> +static void qcom_pcie_opp_update(struct qcom_pcie *pcie)
>> +{
>> +	struct dw_pcie *pci = pcie->pci;
>> +	struct dev_pm_opp *opp;
>> +	u32 offset, status;
>> +	int speed, ret = 0;
>> +
>> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>> +
>> +	/* Only update constraints if link is up. */
>> +	if (!(status & PCI_EXP_LNKSTA_DLLLA))
>> +		return;
>> +
> What happens if link is not up during probe? We set max vote before
> this, should not we bring it down in suspend and vote it back again in
> resume?

ok, I will set to lower value in the suspend path if the link is not 
up.  If the link is already up driver will not

do any modifications.

>
>> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>> +
>> +	opp = dev_pm_opp_find_level_exact(pci->dev, speed);
>> +	if (!IS_ERR(opp)) {
>> +		ret = dev_pm_opp_set_opp(pci->dev, opp);
>> +		if (ret)
>> +			dev_err(pci->dev, "Failed to set opp: %d\n", ret);
>> +		dev_pm_opp_put(opp);
>> +	}
> Since you added an error message, make it more useful by printing the
> opp level also. dev_pm_opp_get_level().
Sure I will add this in next patch.
>
>> +
>> +}
>> +
>>   static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>>   {
>>   	struct dw_pcie *pci = pcie->pci;
>> @@ -1439,8 +1466,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
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
>> @@ -1511,6 +1540,22 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_pm_runtime_put;
>>   
>> +	/* OPP table is optional */
>> +	ret = devm_pm_opp_of_add_table(dev);
>> +	if (ret && ret != -ENODEV) {
>> +		dev_err(dev, "Invalid OPP table in Device tree\n");
>> +		goto err_pm_runtime_put;
>> +	}
>> +
>> +	/* vote for max level in the opp table */
>> +	opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
>> +	if (!IS_ERR(opp)) {
>> +		ret = dev_pm_opp_set_opp(dev, opp);
>> +		if (ret)
>> +			dev_err(pci->dev, "Failed to set opp: %d\n", ret);
>> +		dev_pm_opp_put(opp);
>> +	}
>> +
> This needs an update since you moved from frequency based voting to link
> speed based voting.

dev_pm_opp_find_freq_floor will give us the max the opp level opp we 
don't have a similar API to get max opp-level

For that reason we are using this API.

- KC

>
>>   	ret = pcie->cfg->ops->get_resources(pcie);
>>   	if (ret)
>>   		goto err_pm_runtime_put;
>> @@ -1531,6 +1576,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   
>>   	qcom_pcie_icc_update(pcie);
>>   
>> +	qcom_pcie_opp_update(pcie);
>> +
>>   	if (pcie->mhi)
>>   		qcom_pcie_init_debugfs(pcie);
>>   
>>
> Thanks,
> Pavan
