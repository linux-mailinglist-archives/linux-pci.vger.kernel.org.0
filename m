Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FFC729882
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjFILvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbjFILv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 07:51:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859A2359C;
        Fri,  9 Jun 2023 04:50:49 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359AwngO007397;
        Fri, 9 Jun 2023 11:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1tO+vMCwVSzp2ttsZ3VYY6XHId3IBH2pyyZo9zgUtkw=;
 b=YL7GQHZUrd22A5ui4d1mCgjA+07SfwcjsyVYQqRbdaCgHor5OOw2b47AIiHrpSUldNia
 U3I1HnfU/N9jtzsKkZbGWaPAgdQSKI2PaqXVv5hEdit/lwXQUoTRKMk0cjnk5V762aqe
 ucCr9GGMeAV6cSE1pxkqVTYqE9X9A5Epnk5YFMwZ59xfAvHW6p3fQ5apCf0eytaaaKKo
 JLP3yFgH7D3Fmni8tzV1kkx0I5KFl3pDXBNyXoIm/1ZAkmSMYvLoiOMXGunHPzOTICS5
 rwLHzB2aB09JD9K5zuI4yDNUobkT7U7AWTX2prhjNjXbjDlHN6f7+5cDFk6xJeIyBlRK oA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3vu4grts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:50:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359Boagh017284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 11:50:36 GMT
Received: from [10.216.57.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 04:50:32 -0700
Message-ID: <fe0f836a-0710-28dc-41a2-5144c9e11875@quicinc.com>
Date:   Fri, 9 Jun 2023 17:20:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, Manivannan Sadhasivam <mani@kernel.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230607164326.GA1167111@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230607164326.GA1167111@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aGGKTkJ7c3s-sSKScW2gy0nkzLCFGHCi
X-Proofpoint-ORIG-GUID: aGGKTkJ7c3s-sSKScW2gy0nkzLCFGHCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090099
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/7/2023 10:13 PM, Bjorn Helgaas wrote:
> On Wed, Jun 07, 2023 at 09:48:07PM +0530, Krishna chaitanya chundru wrote:
>> Add support to vote for ICC bandwidth based on the link
>> speed and width.
>>
>> This patch is inspired from pcie-qcom driver to add basic
>> interconnect support.
> Wrap to fill 75 columns like the rest of the git history.
>
>> Link:https://patchwork.kernel.org/project/linux-pci/patch/20221102090705.23634-3-johan+linaro@kernel.org/
> Add space after "Link:"
>
> Probably better to use a lore link
> (https://lore.kernel.org/r/20221102090705.23634-3-johan+linaro@kernel.org/)
> because I think lore is more general-purpose than patchwork and we
> don't get any benefit from the patchwork features here.
done
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 68 +++++++++++++++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 19b3283..5f9139d 100644
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
>> @@ -128,6 +130,9 @@
>>   /* DBI register fields */
>>   #define DBI_CON_STATUS_POWER_STATE_MASK		GENMASK(1, 0)
>>   
>> +#define DBI_LINKCTRLSTATUS			0x80
>> +#define DBI_LINKCTRLSTATUS_SHIFT		16
>> +
>>   #define XMLH_LINK_UP				0x400
>>   #define CORE_RESET_TIME_US_MIN			1000
>>   #define CORE_RESET_TIME_US_MAX			1005
>> @@ -178,6 +183,8 @@ struct qcom_pcie_ep {
>>   	struct phy *phy;
>>   	struct dentry *debugfs;
>>   
>> +	struct icc_path *icc;
> Seems gratuitously different from the "icc_mem" name used in
> pcie-qcom.  Use the same name unless there's a reason to be different.
done
>>   	struct clk_bulk_data *clks;
>>   	int num_clks;
>>   
>> @@ -253,9 +260,51 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
>>   	disable_irq(pcie_ep->perst_irq);
>>   }
>>   
>> +static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
>> +{
>> +	struct dw_pcie *pci = &pcie_ep->pci;
>> +	int speed, width;
>> +	u32 val, bw;
>> +	int ret;
>> +
>> +	if (!pcie_ep->icc)
>> +		return;
>> +
>> +	val = dw_pcie_readl_dbi(pci, DBI_LINKCTRLSTATUS);
>> +	val = val >> DBI_LINKCTRLSTATUS_SHIFT;
>> +
>> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
>> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
> This whole function is basically identical to qcom_pcie_icc_update().
> Could a single implementation be shared?  qcom_pcie_icc_update() uses
> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) instead of the hard-coded
> DBI_LINKCTRLSTATUS, but there are other instances of
> dw_pcie_find_capability() in pcie-qcom-ep.c, so it seems possible that
> the same code could be used both places.
done
>> +	switch (speed) {
>> +	case 1:
>> +		bw = MBps_to_icc(250);	/* BW for GEN1 per lane: 250MBps */
>> +		break;
>> +	case 2:
>> +		bw = MBps_to_icc(500);	/* BW for GEN2 per lane: 500MBps */
>> +		break;
>> +	case 3:
>> +		bw = MBps_to_icc(985);	/* BW for GEN3 per lane: 985MBps */
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		fallthrough;
>> +	case 4:
>> +		bw = MBps_to_icc(1969);	/* BW for GEN4 per lane: 985MBps */
>> +		break;
>> +	}
>> +
>> +	ret = icc_set_bw(pcie_ep->icc, 0, width * bw);
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
>> @@ -277,6 +326,20 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
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
>> +	ret = icc_set_bw(pcie_ep->icc, 0, MBps_to_icc(250)); /* BW for GEN1 per lane: 250MBps */
> Reformat the comment so this all fits in 80 columns like the rest of
> the file.
done
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +			ret);
>> +		goto err_phy_exit;
>> +	}
> This plus the pcie_ep->icc init below is basically identical to
> qcom_pcie_icc_init() in pcie_qcom.c.  Why not use the same structure
> here, with a qcom_pcie_icc_init() function?  It's better to be the
> same than different (when possible, of course).

In pcie_qcom.c driver the resources will be turned on the probe itself.

But in pcie-qcom-ep.c driver will wait for the host to toggle the perst 
to enable all the resources

that is reason it is different here.

- Krishna chaitanya.

>>   	return 0;
>>   
>>   err_phy_exit:
>> @@ -550,6 +613,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>>   	if (IS_ERR(pcie_ep->phy))
>>   		ret = PTR_ERR(pcie_ep->phy);
>>   
>> +	pcie_ep->icc = devm_of_icc_get(dev, "pcie-mem");
>> +	if (IS_ERR(pcie_ep->icc))
>> +		ret = PTR_ERR(pcie_ep->icc);
>> +
>>   	return ret;
>>   }
>>   
>> @@ -572,6 +639,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>   	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
>>   		dev_dbg(dev, "Received BME event. Link is enabled!\n");
>>   		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
>> +		qcom_pcie_ep_icc_update(pcie_ep);
>>   	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
>>   		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
>>   		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>> -- 
>> 2.7.4
>>
