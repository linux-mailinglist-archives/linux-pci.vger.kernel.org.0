Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CF56B914E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 12:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjCNLOs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 07:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjCNLOX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 07:14:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F2C241DC;
        Tue, 14 Mar 2023 04:13:53 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EAStMn011960;
        Tue, 14 Mar 2023 10:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iuYODt/BIaTecACDqyh4KGwhpgU9lb9OttnSUYRLZGc=;
 b=FQNsKetSmzXdDRQ9la7L71PxnYh5hPOFcCeD5RL2x2OPicjBRFgrvZxvDHLPZJ6+hs/c
 oyLq5ctVSDcOZkcJ95t+2KMrwdZ0pOy41LLDgUh60jNrWhZS+Iu9fcbuAJHgu200FfP9
 My+nakQSZUHvIyLSZlG8J3y+Mg1AhSp82CF3blciHUFanmamBLTDqd+eGw48db+VmP/t
 dPfvGRP1h8+ctFahKDWaVvYHWUu7c0I3MAd+iErUOcR9NLXlTOyaZm/jFke7YsdZSEDK
 YgBHGucZXF9t1o+3ec1hVJoFlDe+W1ADCZhs8vMS3VdqR4tZQ/q7U3qrZzRPVV5egcge xQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa203ufqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 10:36:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32EAaP1U032647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 10:36:25 GMT
Received: from [10.201.3.182] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 14 Mar
 2023 03:36:21 -0700
Message-ID: <e02980a9-34ca-9b9a-389a-01c599612140@quicinc.com>
Date:   Tue, 14 Mar 2023 16:06:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 19/19] PCI: qcom: Expose link transition counts via
 debugfs for v2.4.0
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <andersson@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh@kernel.org>
CC:     <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
 <20230310040816.22094-20-manivannan.sadhasivam@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230310040816.22094-20-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mVH93BPhgc0AC0-Lq2E8qKoJzNaeZ-zm
X-Proofpoint-GUID: mVH93BPhgc0AC0-Lq2E8qKoJzNaeZ-zm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/10/2023 9:38 AM, Manivannan Sadhasivam wrote:
> Qualcomm PCIe controllers of version v2.4.0 have debug registers in the
> PARF region that count PCIe link transitions. Expose them over debugfs to
> userspace to help debug the low power issues.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 33 ++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index f99b7e7f3f73..0b41f007fa90 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -37,6 +37,7 @@
>   /* PARF registers */
>   #define PARF_SYS_CTRL				0x00
>   #define PARF_PM_CTRL				0x20
> +#define PARF_PM_STTS				0x24
>   #define PARF_PCS_DEEMPH				0x34
>   #define PARF_PCS_SWING				0x38
>   #define PARF_PHY_CTRL				0x40
> @@ -84,6 +85,12 @@
>   /* PARF_PM_CTRL register fields */
>   #define REQ_NOT_ENTR_L1				BIT(5)
>   
> +/* PARF_PM_STTS register fields */
> +#define PM_LINKST_IN_L1SUB			BIT(8)
> +#define PM_LINKST_IN_L0S			BIT(7)
> +#define PM_LINKST_IN_L2				BIT(5)
> +#define PM_LINKST_IN_L1				BIT(4)
> +
>   /* PARF_PCS_DEEMPH register fields */
>   #define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		FIELD_PREP(GENMASK(21, 16), x)
>   #define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	FIELD_PREP(GENMASK(13, 8), x)
> @@ -737,6 +744,31 @@ static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
>   	return 0;
>   }
>   
> +static int qcom_pcie_debugfs_func_2_4_0(struct seq_file *s, void *data)
> +{
> +	struct qcom_pcie *pcie = (struct qcom_pcie *) dev_get_drvdata(s->private);
> +
> +	seq_printf(s, "L0s transition count: %u\n",
> +		   readl_relaxed(pcie->parf + PM_LINKST_IN_L0S));
> +
> +	seq_printf(s, "L1 transition count: %u\n",
> +		   readl_relaxed(pcie->parf + PM_LINKST_IN_L1));
> +
> +	seq_printf(s, "L1.1 transition count: %u\n",
> +		   readl_relaxed(pcie->parf + PM_LINKST_IN_L1SUB));
> +
> +	seq_printf(s, "L2 transition count: %u\n",
> +		   readl_relaxed(pcie->parf + PM_LINKST_IN_L2));
> +

  Using bitmask as register offset ? instead use PM_STTS and bitmask it ?

Regards,
  Sricharan
