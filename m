Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF72740849
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 04:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjF1CXO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 22:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjF1CXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 22:23:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3261BE9;
        Tue, 27 Jun 2023 19:23:11 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S2Gx6T029265;
        Wed, 28 Jun 2023 02:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=40GpdrepRnReao9iZ/H8EhFDZ6BpPWElOUcpEyI3PTQ=;
 b=G9wOpERmvflwqcCMWVIqyBqj6oKma2lsar+bP/FWYGZG+sKBcABnTqeRU9A8Iuae7vCj
 m2oLKqvrdvK47ezpMOFTyDt41oOszEa8BiH2kaytm4Gwr7ljhcvBEi3Hu04tekiwhoTT
 c+7Y5gwWf+kCI6YN6rho510YNXKK7jeRm8Mw+tVcVzDEtKVl5nmyhghdjhtHpvNd7XHM
 /J7ta6EjweZeYn4BkJpkTnXOHJ6zl8xSKkkmnNuObX7rs91Svb7INYTs966M/axLIwlW
 O1+SD6oPkb8vYpcxL0wh6/GXUZgnhYebrBzrE9phnmumQfzroQQA/n5wOUwihjQbwzak mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgaxcr3dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 02:23:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35S2N0vh013711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 02:23:00 GMT
Received: from [10.216.43.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 27 Jun
 2023 19:22:54 -0700
Message-ID: <9422aa91-4d8c-f51d-26c3-9abed579f62d@quicinc.com>
Date:   Wed, 28 Jun 2023 07:52:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
 <1687827692-6181-4-git-send-email-quic_krichai@quicinc.com>
 <20230627150118.GI5490@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230627150118.GI5490@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ud_ikQFzH4vjoEk_G_6RmgEqkLhU-KdI
X-Proofpoint-ORIG-GUID: ud_ikQFzH4vjoEk_G_6RmgEqkLhU-KdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_16,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280020
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/27/2023 8:31 PM, Manivannan Sadhasivam wrote:
> On Tue, Jun 27, 2023 at 06:31:31AM +0530, Krishna chaitanya chundru wrote:
>> Add support to vote for ICC bandwidth based on the link
>> speed and width.
>>
>> This patch is inspired from pcie-qcom driver to add basic
>> interconnect support.
>>
>> Reference: commit c4860af88d0c ("PCI: qcom: Add basic interconnect
>> support").
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 73 +++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 1435f51..b613817 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/debugfs.h>
>>   #include <linux/delay.h>
>>   #include <linux/gpio/consumer.h>
>> +#include <linux/interconnect.h>
>>   #include <linux/mfd/syscon.h>
>>   #include <linux/phy/pcie.h>
>>   #include <linux/phy/phy.h>
>> @@ -28,6 +29,7 @@
>>   #define PARF_SYS_CTRL				0x00
>>   #define PARF_DB_CTRL				0x10
>>   #define PARF_PM_CTRL				0x20
>> +#define PARF_PM_STTS				0x24
>>   #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>>   #define PARF_MHI_BASE_ADDR_LOWER		0x178
>>   #define PARF_MHI_BASE_ADDR_UPPER		0x17c
>> @@ -128,11 +130,19 @@
>>   /* DBI register fields */
>>   #define DBI_CON_STATUS_POWER_STATE_MASK		GENMASK(1, 0)
>>   
>> +#define DBI_LINKCTRLSTATUS			0x80
>> +#define DBI_LINKCTRLSTATUS_SHIFT		16
> not used?
not using these macros so I removed them in next patch.
>> +
>>   #define XMLH_LINK_UP				0x400
>>   #define CORE_RESET_TIME_US_MIN			1000
>>   #define CORE_RESET_TIME_US_MAX			1005
>>   #define WAKE_DELAY_US				2000 /* 2 ms */
>>   
>> +#define PCIE_GEN1_BW_MBPS			250
>> +#define PCIE_GEN2_BW_MBPS			500
>> +#define PCIE_GEN3_BW_MBPS			985
>> +#define PCIE_GEN4_BW_MBPS			1969
>> +
>>   #define to_pcie_ep(x)				dev_get_drvdata((x)->dev)
>>   
>>   enum qcom_pcie_ep_link_status {
>> @@ -178,6 +188,8 @@ struct qcom_pcie_ep {
>>   	struct phy *phy;
>>   	struct dentry *debugfs;
>>   
>> +	struct icc_path *icc_mem;
>> +
>>   	struct clk_bulk_data *clks;
>>   	int num_clks;
>>   
>> @@ -253,9 +265,51 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
>>   	disable_irq(pcie_ep->perst_irq);
>>   }
>>   
>> +static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
>> +{
>> +	struct dw_pcie *pci = &pcie_ep->pci;
>> +	u32 offset, status, bw;
>> +	int speed, width;
>> +	int ret;
>> +
>> +	if (!pcie_ep->icc_mem)
>> +		return;
>> +
>> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>> +
>> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>> +
>> +	switch (speed) {
>> +	case 1:
>> +		bw = MBps_to_icc(PCIE_GEN1_BW_MBPS);
>> +		break;
>> +	case 2:
>> +		bw = MBps_to_icc(PCIE_GEN2_BW_MBPS);
>> +		break;
>> +	case 3:
>> +		bw = MBps_to_icc(PCIE_GEN3_BW_MBPS);
>> +		break;
>> +	default:
>> +		dev_warn(pci->dev, "using default GEN4 bandwidth\n");
>> +		fallthrough;
>> +	case 4:
>> +		bw = MBps_to_icc(PCIE_GEN4_BW_MBPS);
>> +		break;
>> +	}
>> +
>> +	ret = icc_set_bw(pcie_ep->icc_mem, 0, width * bw);
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +			ret);
> No need of braces for single line.
done.
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
>> +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
>> +	 * for the pcie-mem path.
>> +	 */
>> +	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +			ret);
>> +		goto err_phy_exit;
> Again, you should power off the PHY in the case of error. err_phy_exit is not
> doing that for you.
>
> - Mani

added the code remove the phy power.

-KC

>> +	}
>> +
>>   	return 0;
>>   
>>   err_phy_exit:
>> @@ -550,6 +618,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>>   	if (IS_ERR(pcie_ep->phy))
>>   		ret = PTR_ERR(pcie_ep->phy);
>>   
>> +	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
>> +	if (IS_ERR(pcie_ep->icc_mem))
>> +		ret = PTR_ERR(pcie_ep->icc_mem);
>> +
>>   	return ret;
>>   }
>>   
>> @@ -573,6 +645,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>   	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
>>   		dev_dbg(dev, "Received BME event. Link is enabled!\n");
>>   		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
>> +		qcom_pcie_ep_icc_update(pcie_ep);
>>   		pci_epc_bme_notify(pci->ep.epc);
>>   	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
>>   		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
>> -- 
>> 2.7.4
>>
