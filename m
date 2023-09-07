Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7EE7974FF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 17:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjIGPmq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbjIGPYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 11:24:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D33184;
        Thu,  7 Sep 2023 08:24:08 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3875TWcf007672;
        Thu, 7 Sep 2023 06:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CKwRgqbJvHygU72KygwHdHjBPWUhP4F5Rq7IPfnXhS8=;
 b=BGAVEDWq97GF2tX6w/LXCJ0UzaNRgcONyFib/JhFN6ir2/6MoijKi219Jl6JFF7rk0de
 uUZSTiTJnSMaQ2vidvj/0yiZXE0ZuPpOUazfg2DCVM2GCGAu0/oCxmFgD6FZSL1xP3Y9
 cbe08KM0EKVUxtXo2SWAMmBGV+C+VpVGOJ0UNIzxQwQfY7S6TssmtqTD2BN8Nibzdo7b
 USGClTclvP/kUU+qd7wbXqGYey1KbnhZE/z4ZXqytyp8C97CKayiN7RlJvKIJuHUpZE2
 v8ZPXMxWzW5aDKbJdwWgkHREiMjuLEKTPEI5NPeW2+Iyn1vZP1l+pIwoCMwlYTArGM3e Ww== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy4bqgggd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 06:05:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38765gMV003424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 06:05:42 GMT
Received: from [10.216.2.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 6 Sep
 2023 23:05:35 -0700
Message-ID: <9d472323-56c0-d5b2-c17c-e2a8bae2153f@quicinc.com>
Date:   Thu, 7 Sep 2023 11:35:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 4/4] PCI: qcom: Add OPP support for speed based
 performance state of RPMH
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_parass@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
 <1692717141-32743-5-git-send-email-quic_krichai@quicinc.com>
 <20230823070652.GE3737@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230823070652.GE3737@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k3viDRAivDuyldGRdxI0GUsktTJgBVXh
X-Proofpoint-ORIG-GUID: k3viDRAivDuyldGRdxI0GUsktTJgBVXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070053
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/23/2023 12:36 PM, Manivannan Sadhasivam wrote:
> Subject should be, "PCI: qcom: Add OPP support to scale performance state of
> power domain"
>
> On Tue, Aug 22, 2023 at 08:42:21PM +0530, Krishna chaitanya chundru wrote:
>> Before link training vote for the maximum performance state of RPMH
>> and once link is up, vote for the performance state based upon the link
>> speed.
>>
> Commit message should have the justification on why OPP support should be
> addded, not just how you add it. The reasoning should be, "While scaling the
> interconnect clocks based on PCIe link speed, it is also mandatory to scale the
> power domain performance state so that the SoC can run under optimum power
> conditions."
done
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 7a87a47..161fdad 100644
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
>> @@ -1357,6 +1358,33 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
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
>> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>> +
> Since icc_update() also queries link status register, this could be moved inside
> icc_update() to avoid code duplication and probably the function con be renamed
> to "qcom_pcie_icc_opp_update()".
done
>> +	opp = dev_pm_opp_find_level_exact(pci->dev, speed);
>> +	if (!IS_ERR(opp)) {
> As we decided for pcie-qcom-ep, let's return error from _update() function if
> icc paths/opp support were specified in DT.
>
> Use a separate patch for returning error from existing qcom_pcie_icc_update()
> function and add opp support on top.
done
>> +		ret = dev_pm_opp_set_opp(pci->dev, opp);
>> +		if (ret)
>> +			dev_err(pci->dev, "Failed to set opp: level %d ret %d\n",
>> +						dev_pm_opp_get_level(opp), ret);
>> +		dev_pm_opp_put(opp);
>> +	}
>> +
>> +}
>> +
>>   static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>>   {
>>   	struct dw_pcie *pci = pcie->pci;
>> @@ -1439,8 +1467,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>>   static int qcom_pcie_probe(struct platform_device *pdev)
>>   {
>>   	const struct qcom_pcie_cfg *pcie_cfg;
>> +	unsigned long max_level = INT_MAX;
>>   	struct device *dev = &pdev->dev;
>>   	struct qcom_pcie *pcie;
>> +	struct dev_pm_opp *opp;
>>   	struct dw_pcie_rp *pp;
>>   	struct resource *res;
>>   	struct dw_pcie *pci;
>> @@ -1511,6 +1541,23 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_pm_runtime_put;
>>   
>> +	/* OPP table is optional */
>> +	ret = devm_pm_opp_of_add_table(dev);
>> +	if (ret && ret != -ENODEV) {
>> +		dev_err(dev, "Invalid OPP table in Device tree\n");
> "Failed to add OPP table"
>
> Also, use dev_err_probe() here and below.
>
>> +		goto err_pm_runtime_put;
>> +	}
>> +
>> +	/* vote for max level in the opp table */
>> +	opp = dev_pm_opp_find_level_floor(dev, &max_level);
> Use a bool flag to check whether opp support is present or not and use that to
> decide calling these APIs.
done
>> +	if (!IS_ERR(opp)) {
>> +		ret = dev_pm_opp_set_opp(dev, opp);
>> +		if (ret)
>> +			dev_err(pci->dev, "Failed to set opp: level %d ret %d\n",
>> +						dev_pm_opp_get_level(opp), ret);
>> +		dev_pm_opp_put(opp);
>> +	}
>> +
>>   	ret = pcie->cfg->ops->get_resources(pcie);
>>   	if (ret)
>>   		goto err_pm_runtime_put;
>> @@ -1531,6 +1578,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   
>>   	qcom_pcie_icc_update(pcie);
>>   
>> +	qcom_pcie_opp_update(pcie);
>> +
>>   	if (pcie->mhi)
>>   		qcom_pcie_init_debugfs(pcie);
>>   
>> @@ -1577,6 +1626,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>   	 */
>>   	if (!dw_pcie_link_up(pcie->pci)) {
>>   		qcom_pcie_host_deinit(&pcie->pci->pp);
>> +		dev_pm_opp_set_opp(dev, NULL);
> This will print error when OPP table was not specified in DT. So use the flag as
> I suggested above.
>
> - Mani

done

- KC

>>   		pcie->suspended = true;
>>   	}
>>   
>> @@ -1593,6 +1643,8 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>>   		if (ret)
>>   			return ret;
>>   
>> +		qcom_pcie_opp_update(pcie);
>> +
>>   		pcie->suspended = false;
>>   	}
>>   
>> -- 
>> 2.7.4
>>
