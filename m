Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9C77DCD2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 10:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbjHPIyP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243157AbjHPIxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 04:53:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B6F13D;
        Wed, 16 Aug 2023 01:53:43 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G7ldEF006071;
        Wed, 16 Aug 2023 08:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=N8pAXBarq5a+zUCq5m202B9YAGdwbDmkS5Fv+6+22rc=;
 b=aeqk4pgmAYX09ogaQCoB/L5gNXDEKPkO2IASEC98MD81wkaLzbANXMMO/drPInjAFwNf
 JMpMnGAtFiZhszKSW2gs4I0wIdsgAFTvAeH25INfrLkazjvYF6SSsmvXl0eo+zwYN9ys
 HknKtK608XmqS1I4dtdVIzmYRb2AjL9Vgt4xnlrywxxdd8tV+x52y7SmrFjy0vYSIlmh
 BxCghT7jfsPYewuBSX3kzxNZHAkqxWi+xHXeDzWq3jJIxATHOZPnBGupn6UgkHq4sN2T
 QiQ5GU1OGUqekSK3uOLL4GgqxJjXa+3b5x8avKQpWr6Jtvqd1LpUIKT8SnHcmU27CzeY yQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfuj8kac1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 08:53:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37G8rYX5026145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 08:53:34 GMT
Received: from [10.218.41.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 01:53:28 -0700
Message-ID: <2b61913c-d93b-af30-f75d-0958d912dc8f@quicinc.com>
Date:   Wed, 16 Aug 2023 14:23:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 3/3] PCI: qcom: Add OPP suuport for speed based
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
References: <1692102408-7010-1-git-send-email-quic_krichai@quicinc.com>
 <1692102408-7010-4-git-send-email-quic_krichai@quicinc.com>
 <076196e4-36e5-4a90-b3cc-b0ffd61627a3@quicinc.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <076196e4-36e5-4a90-b3cc-b0ffd61627a3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FZitCQzzO_zTzkrRat30Q6w-7caZd3E1
X-Proofpoint-GUID: FZitCQzzO_zTzkrRat30Q6w-7caZd3E1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_06,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160078
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/16/2023 11:54 AM, Pavan Kondeti wrote:
> On Tue, Aug 15, 2023 at 05:56:48PM +0530, Krishna chaitanya chundru wrote:
>> Before link training vote for the maximum performance state of RPMH
>> and once the link is up, vote for the performance state based upon
>> the link speed.
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 61 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 7a87a47..e29a986 100644
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
>> @@ -1357,6 +1358,51 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>   	return 0;
>>   }
>>   
>> +static void qcom_pcie_opp_update(struct qcom_pcie *pcie)
>> +{
>> +	struct dw_pcie *pci = pcie->pci;
>> +	struct dev_pm_opp *opp;
>> +	u32 offset, status;
>> +	uint32_t freq;
>> +	int speed;
>> +	int ret = 0;
>> +
>> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>> +
>> +	/* Only update constraints if link is up. */
>> +	if (!(status & PCI_EXP_LNKSTA_DLLLA))
>> +		return;
>> +
>> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>> +
>> +	switch (speed) {
>> +	case 1:
>> +		freq = 2500000;
>> +		break;
>> +	case 2:
>> +		freq = 5000000;
>> +		break;
>> +	case 3:
>> +		freq = 8000000;
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		fallthrough;
>> +	case 4:
>> +		freq = 16000000;
>> +		break;
>> +	}
>> +
>> +	opp = dev_pm_opp_find_freq_exact(pci->dev, freq, true);
>> +
>> +	if (!IS_ERR(opp)) {
>> +		ret = dev_pm_opp_get_voltage(opp);
>> +		dev_pm_opp_put(opp);
>> +	}
>> +
> Where are we setting the OPP here?
>
>> +}
>> +
>>   static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>>   {
>>   	struct dw_pcie *pci = pcie->pci;
>> @@ -1439,8 +1485,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
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
>> @@ -1511,6 +1559,17 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
>> +	opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
>> +	if (!IS_ERR(opp))
>> +		dev_pm_opp_put(opp);
>> +
> This OPP (corresponding to max freq) is not used, so how are we voting
> for max perf state during probe?
>
>>   	ret = pcie->cfg->ops->get_resources(pcie);
>>   	if (ret)
>>   		goto err_pm_runtime_put;
>> @@ -1531,6 +1590,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   
>>   	qcom_pcie_icc_update(pcie);
>>   
>> +	qcom_pcie_opp_update(pcie);
>> +
> commit description says, OPP voting is done as per the link speed after
> probe? I don't see any calls to qcom_pcie_opp_update() outside probe.

my mistake dev_pm_opp_set_opp somehow missed here I will update in next 
patch.

- KC

>>   	if (pcie->mhi)
>>   		qcom_pcie_init_debugfs(pcie);
>>   
>>
> Thanks,
> Pavan
