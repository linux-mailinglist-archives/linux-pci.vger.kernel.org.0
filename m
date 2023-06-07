Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43FD7265C4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjFGQWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 12:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFGQWg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 12:22:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE701BD9;
        Wed,  7 Jun 2023 09:22:34 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357FK57G000559;
        Wed, 7 Jun 2023 16:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O4wVILqdigiF7Al6+HgYOaCC79kMZRRBTl3zPy5Pr7U=;
 b=iH52lVEER3rtXhRjDcyTjRcPucOk7OsuSqgaWjcLEXyanQmMHrJDKxD5HeE5RNQsxxKc
 GoKrKDTWSdUd3oNThA0VX2Mylhn5mzJGf7XP3pUBjGEtJauEfuW9qZQwUHPlCR8m+0DE
 dWGqGG0DuD1k7sI+DNA4Ug/p9S4MOu+2oZhyJUlxAxoqi7bxep97SbkP9cj84JZe4IaY
 6WCTDfPhH8tUqsW+QU55LyPFPkIeigU1QcDb4z3vAKTT80y2AVOED6lYnpTuFZZTd/Pk
 IObsUNZdMRHPN09FU25PXFBDGQ0mnlCUtLbTg8q+9JaodPAjtSaxBJkzbF6hhMACrCwy Gg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a76aanx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 16:22:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357GMSHx023673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 16:22:28 GMT
Received: from [10.216.46.213] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 7 Jun 2023
 09:22:24 -0700
Message-ID: <93063313-7462-1b7a-4116-0f613c5470b2@quicinc.com>
Date:   Wed, 7 Jun 2023 21:52:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] PCI: qcom-ep: Add ICC bandwidth voting support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
 <20230606112452.GA51623@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230606112452.GA51623@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JQQtoJW_un9y0d6TTpOAmQxpcrdTENsp
X-Proofpoint-GUID: JQQtoJW_un9y0d6TTpOAmQxpcrdTENsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306070139
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/6/2023 4:54 PM, Manivannan Sadhasivam wrote:
> On Tue, Jun 06, 2023 at 11:19:29AM +0530, Krishna chaitanya chundru wrote:
>> Add support to vote for ICC bandwidth based up on the link
> based on
done
>
>> speed and width.
>>
> Looks like the code got inspiration from pcie-qcom driver. So it should be
> mentioned in the commit message.
done
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Devicetree bindings update should precede this patch.
done
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 73 +++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 19b3283..79e7559 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/phy/pcie.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/interconnect.h>
> Includes are sorted alphabetically
>
>>   #include <linux/pm_domain.h>
>>   #include <linux/regmap.h>
>>   #include <linux/reset.h>
>> @@ -28,6 +29,7 @@
>>   #define PARF_SYS_CTRL				0x00
>>   #define PARF_DB_CTRL				0x10
>>   #define PARF_PM_CTRL				0x20
>> +#define PARF_PM_STTS				0x24
>>   #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>>   #define PARF_MHI_BASE_ADDR_LOWER		0x178
>>   #define PARF_MHI_BASE_ADDR_UPPER		0x17c
>> @@ -128,6 +130,9 @@
>>   /* DBI register fields */
>>   #define DBI_CON_STATUS_POWER_STATE_MASK		GENMASK(1, 0)
>>   
>> +#define DBI_LINKCTRLSTATUS			0x80
>> +#define DBI_LINKCTRKSTATUS_SHIFT	16
> Use GENMASK macro
>
>> +
>>   #define XMLH_LINK_UP				0x400
>>   #define CORE_RESET_TIME_US_MIN			1000
>>   #define CORE_RESET_TIME_US_MAX			1005
>> @@ -187,6 +192,8 @@ struct qcom_pcie_ep {
>>   	enum qcom_pcie_ep_link_status link_status;
>>   	int global_irq;
>>   	int perst_irq;
>> +
>> +	struct icc_path *icc;
> Place this under debugfs entry.
done
>>   };
>>   
>>   static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
>> @@ -253,9 +260,56 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
>>   	disable_irq(pcie_ep->perst_irq);
>>   }
>>   
>> +static void qcom_pcie_icc_update(struct qcom_pcie_ep *pcie_ep)
> qcom_pcie_ep_icc_update
done
>> +{
>> +	struct dw_pcie *pci = &pcie_ep->pci;
>> +	u32 val, bw;
>> +	int speed, width;
>> +	int ret;
>> +
> Follow reverse Xmas tree order for local variables.
>
>> +	if (!pcie_ep->icc)
>> +		return;
>> +
>> +	val = dw_pcie_readl_dbi(pci, DBI_LINKCTRLSTATUS);
>> +	val = val >> DBI_LINKCTRKSTATUS_SHIFT;
>> +
> Use FIELD_GET macro combined with GENMASK
I didn't get this logic you are suggesting can you please elaborate
>> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
>> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
>> +
>> +	/*
>> +	 * ICC needs avg bw in KBps.
> s/avg bw/BW
> ...everywhere
done
>> +	 *
>> +	 * For example for 2Gbps the avg BW = 2x1000x1000x1000/8*1000 = 250000
>> +	 */
>> +	switch (speed) {
>> +	case 1:
>> +		bw = 250000;	/* avg bw for GEN1 per lane: 2Gbps, peak bw: no vote */
> To align with pcie-qcom driver, specify the value in MBps. Also, use the
> MBps_to_icc() macro.
done
>> +		break;
>> +	case 2:
>> +		bw = 500000;	/* avg bw for GEN2 per lane: 4Gbps, peak bw no vote */
>> +		break;
>> +	case 3:
>> +		bw = 1000000;	/* avg bw for GEN3 per lane: 8Gbps, peak bw no vote */
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		fallthrough;
>> +	case 4:
>> +		bw = 2000000;	/* avg bw for GEN4 per lane: 16Gbps, peak bw no vote */
>> +		break;
>> +	}
>> +
>> +	ret = icc_set_bw(pcie_ep->icc, width * bw, 0);
> AFAIU, avg bandwidth should be less than peak bandwidth. So use the vote for
> peak bandwidth, leaving 0 as avg. Also, the comment above should be adjusted
> accordingly.
done
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +			ret);
>> +	}
>> +}
>> +
>>   static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>>   {
>>   	int ret;
>> +	struct dw_pcie *pci = &pcie_ep->pci;
>>   
>>   	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
>>   	if (ret)
>> @@ -277,6 +331,20 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>>   	if (ret)
>>   		goto err_phy_exit;
>>   
>> +	/*
>> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
>> +	 * to be set before enabling interconnect clocks.
>> +	 *
>> +	 * Set an initial average bandwidth corresponding to single-lane Gen 1
>> +	 * for the pcie to mem path.
>> +	 */
>> +	ret = icc_set_bw(pcie_ep->icc, 250000, 0); /* avg bw: 2Gbps, peak bw: no vote */
> Same as above
done
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +			ret);
>> +		goto err_phy_exit;
>> +	}
>> +
>>   	return 0;
>>   
>>   err_phy_exit:
>> @@ -550,6 +618,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>>   	if (IS_ERR(pcie_ep->phy))
>>   		ret = PTR_ERR(pcie_ep->phy);
>>   
>> +	pcie_ep->icc = devm_of_icc_get(dev, "pci");
> This should specify the icc path like pcie-mem as specified in pcie-qcom driver.
> This helps in adding other icc paths if required in the future.
>
> - Mani

done

Thanks,

Krishna chaitanya.

>> +	if (IS_ERR(pcie_ep->icc))
>> +		ret = PTR_ERR(pcie_ep->icc);
>> +
>>   	return ret;
>>   }
>>   
>> @@ -572,6 +644,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>   	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
>>   		dev_dbg(dev, "Received BME event. Link is enabled!\n");
>>   		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
>> +		qcom_pcie_icc_update(pcie_ep);
>>   	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
>>   		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
>>   		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>> -- 
>> 2.7.4
>>
