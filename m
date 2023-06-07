Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771CD7265BA
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 18:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjFGQUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 12:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjFGQTo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 12:19:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A281BF8;
        Wed,  7 Jun 2023 09:19:40 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357EqFGa008486;
        Wed, 7 Jun 2023 16:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KjMFoEEq3JQC9A7F1TYLN9x5RBGgGgWsW4TBdelZ3RE=;
 b=Ot+KukExi7RgOFc/BGTIBps1iYO2v65D1I6Ntck+LRUXgbo+RpOB4d09TB7v2KmTtNJS
 Vco8cR82Mkq4o9n1J6u037JmlZgtQEoQE0ESdAIBhsTVbUNZX9m+2VU26VnTq+lRJ1U+
 XGja0jXimu3OljyAASx2AP/Rs4yJdMpE3lnlCfO+QtnoJRx4TUpSPXopVXNO0RhJFGpT
 7WMcG7Y4g1vIh+91IRGxP3g7+GuiV9pP9O76VY/XWV/ZG8jKJZZEgwz1Hq4esxxcewyl
 0jC8+rELVfcXGkiPSCIlXtRMThOJYwG/Wkb3NWyuRIF3UJfh+vvMT0I8Lz1ApQvxjkiR +A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a71ad8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 16:19:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357GJU5h013436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 16:19:30 GMT
Received: from [10.216.46.213] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 7 Jun 2023
 09:19:26 -0700
Message-ID: <6442f4aa-d077-845c-34f8-d52f29b0d0e1@quicinc.com>
Date:   Wed, 7 Jun 2023 21:49:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] PCI: qcom-ep: Add ICC bandwidth voting support
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1686030570-5439-1-git-send-email-quic_krichai@quicinc.com>
 <903bf7c5-1665-4602-a7ba-f4a0741e720f@kernel.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <903bf7c5-1665-4602-a7ba-f4a0741e720f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZnI8EqwM_il8evDpvlMJ2eeXJg9svRC4
X-Proofpoint-ORIG-GUID: ZnI8EqwM_il8evDpvlMJ2eeXJg9svRC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070139
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/6/2023 4:18 PM, Georgi Djakov wrote:
> Hi Krishna,
>
> Thanks for the patch!
>
> On 6.06.23 8:49, Krishna chaitanya chundru wrote:
>> Add support to vote for ICC bandwidth based up on the link
>> speed and width.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 73 
>> +++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c 
>> b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 19b3283..79e7559 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/phy/pcie.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/interconnect.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/regmap.h>
>>   #include <linux/reset.h>
>> @@ -28,6 +29,7 @@
>>   #define PARF_SYS_CTRL                0x00
>>   #define PARF_DB_CTRL                0x10
>>   #define PARF_PM_CTRL                0x20
>> +#define PARF_PM_STTS                0x24
>>   #define PARF_MHI_CLOCK_RESET_CTRL        0x174
>>   #define PARF_MHI_BASE_ADDR_LOWER        0x178
>>   #define PARF_MHI_BASE_ADDR_UPPER        0x17c
>> @@ -128,6 +130,9 @@
>>   /* DBI register fields */
>>   #define DBI_CON_STATUS_POWER_STATE_MASK        GENMASK(1, 0)
>>   +#define DBI_LINKCTRLSTATUS            0x80
>> +#define DBI_LINKCTRKSTATUS_SHIFT    16
>> +
>>   #define XMLH_LINK_UP                0x400
>>   #define CORE_RESET_TIME_US_MIN            1000
>>   #define CORE_RESET_TIME_US_MAX            1005
>> @@ -187,6 +192,8 @@ struct qcom_pcie_ep {
>>       enum qcom_pcie_ep_link_status link_status;
>>       int global_irq;
>>       int perst_irq;
>> +
>> +    struct icc_path *icc;
>>   };
>>     static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
>> @@ -253,9 +260,56 @@ static void qcom_pcie_dw_stop_link(struct 
>> dw_pcie *pci)
>>       disable_irq(pcie_ep->perst_irq);
>>   }
>>   +static void qcom_pcie_icc_update(struct qcom_pcie_ep *pcie_ep)
>> +{
>> +    struct dw_pcie *pci = &pcie_ep->pci;
>> +    u32 val, bw;
>> +    int speed, width;
>> +    int ret;
>> +
>> +    if (!pcie_ep->icc)
>> +        return;
>> +
>> +    val = dw_pcie_readl_dbi(pci, DBI_LINKCTRLSTATUS);
>> +    val = val >> DBI_LINKCTRKSTATUS_SHIFT;
>> +
>> +    speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
>> +    width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
>> +
>> +    /*
>> +     * ICC needs avg bw in KBps.
>> +     *
>> +     * For example for 2Gbps the avg BW = 2x1000x1000x1000/8*1000 = 
>> 250000
>> +     */
>> +    switch (speed) {
>> +    case 1:
>> +        bw = 250000;    /* avg bw for GEN1 per lane: 2Gbps, peak bw: 
>> no vote */
>> +        break;
>> +    case 2:
>> +        bw = 500000;    /* avg bw for GEN2 per lane: 4Gbps, peak bw 
>> no vote */
>> +        break;
>> +    case 3:
>> +        bw = 1000000;    /* avg bw for GEN3 per lane: 8Gbps, peak bw 
>> no vote */
>> +        break;
>> +    default:
>> +        WARN_ON_ONCE(1);
>> +        fallthrough;
>> +    case 4:
>> +        bw = 2000000;    /* avg bw for GEN4 per lane: 16Gbps, peak 
>> bw no vote */
>> +        break;
>> +    }
>> +
>> +    ret = icc_set_bw(pcie_ep->icc, width * bw, 0);
>
> Here you should use a non-zero value for peak bandwidth. You can use 
> the average value also as peak. There are some existing macros like 
> GBps_to_icc(). Please use them.
updated the logic in the new patch.
>
>> +    if (ret) {
>> +        dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +            ret);
>> +    }
>> +}
>> +
>>   static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>>   {
>>       int ret;
>> +    struct dw_pcie *pci = &pcie_ep->pci;
>>         ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
>>       if (ret)
>> @@ -277,6 +331,20 @@ static int qcom_pcie_enable_resources(struct 
>> qcom_pcie_ep *pcie_ep)
>>       if (ret)
>>           goto err_phy_exit;
>>   +    /*
>> +     * Some Qualcomm platforms require interconnect bandwidth 
>> constraints
>> +     * to be set before enabling interconnect clocks.
>> +     *
>> +     * Set an initial average bandwidth corresponding to single-lane 
>> Gen 1
>> +     * for the pcie to mem path.
>> +     */
>> +    ret = icc_set_bw(pcie_ep->icc, 250000, 0); /* avg bw: 2Gbps, 
>> peak bw: no vote */
>
> Ditto.
>
done
>> +    if (ret) {
>> +        dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +            ret);
>> +        goto err_phy_exit;
>> +    }
>> +
>>       return 0;
>>     err_phy_exit:
>> @@ -550,6 +618,10 @@ static int qcom_pcie_ep_get_resources(struct 
>> platform_device *pdev,
>>       if (IS_ERR(pcie_ep->phy))
>>           ret = PTR_ERR(pcie_ep->phy);
>>   +    pcie_ep->icc = devm_of_icc_get(dev, "pci");
>
> Is this "pci" path documented in the bindings?
>
> Thanks,
> Georgi
>
Added the bindings patch in new patch

Thanks,

Krishna Chaitanya.

>> +    if (IS_ERR(pcie_ep->icc))
>> +        ret = PTR_ERR(pcie_ep->icc);
>> +
>>       return ret;
>>   }
>>   @@ -572,6 +644,7 @@ static irqreturn_t 
>> qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>       } else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
>>           dev_dbg(dev, "Received BME event. Link is enabled!\n");
>>           pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
>> +        qcom_pcie_icc_update(pcie_ep);
>>       } else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
>>           dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
>>           val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>
