Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32876B2373
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 12:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCILv4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 06:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjCILvx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 06:51:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BD0E6835;
        Thu,  9 Mar 2023 03:51:51 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3298QivW009122;
        Thu, 9 Mar 2023 11:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DNOlz2EYTj6weFcohqxG0NnpJE4xB0UXowa/63Q892w=;
 b=BWLzr8NZdvaEdimvictYzpPUd7ujpjmZBI3GgiDwXkZ6PhARNXOwN2t9iFHHcIcQIW5p
 DU6tkAarZ970FAtXfn3dDi6Bc/LIyl2vwusneKbeblFgCoEWKmGbjnUQ3T0gxx+o1ABf
 QYKx+33uALemidDt5054wxL9g2PrkVXzexnkZUTJV+UGrRfGYV3eoaWeIoZhpZ1YTWPE
 7Fdky2qICPpO3DjxEmkXnJIlynienapTsp37qjwvR+aPf7AvYibAsz6z8qY9PXTzkrMU
 P4Vlt1afSETdnr+hfyqle+oHocZ0rSWe0he6Wb/4Lu1SkG5OVrB3TPYwYS1rKTYX3JgQ RA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p74drhkxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 11:51:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 329BpjFS014867
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 11:51:45 GMT
Received: from [10.201.3.182] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Mar 2023
 03:51:41 -0800
Message-ID: <73269ad0-5662-519c-f6c0-e5e2f918cd4e@quicinc.com>
Date:   Thu, 9 Mar 2023 17:21:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 17/17] PCI: qcom: Expose link transition counts via
 debugfs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <andersson@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh@kernel.org>
CC:     <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
 <20230309085102.120977-18-manivannan.sadhasivam@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230309085102.120977-18-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VrZ95vLubBXKCvrVPVzCJ29OTewhHoUI
X-Proofpoint-ORIG-GUID: VrZ95vLubBXKCvrVPVzCJ29OTewhHoUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_06,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 clxscore=1011 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/9/2023 2:21 PM, Manivannan Sadhasivam wrote:
> Qualcomm PCIe controllers have debug registers in the MHI region that
> count PCIe link transitions. Expose them over debugfs to userspace to
> help debug the low power issues.
> 
> Note that even though the registers are prefixed as PARF_, they don't
> live under the "parf" register region. The register naming is following
> the Qualcomm's internal documentation as like other registers.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 59 ++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index e1180c84f0fa..6d9bde64c9e9 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -10,6 +10,7 @@
>   
>   #include <linux/clk.h>
>   #include <linux/crc8.h>
> +#include <linux/debugfs.h>
>   #include <linux/delay.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/interconnect.h>
> @@ -62,6 +63,13 @@
>   #define AXI_MSTR_RESP_COMP_CTRL1		0x81c
>   #define MISC_CONTROL_1_REG			0x8bc
>   
> +/* MHI registers */
> +#define PARF_DEBUG_CNT_PM_LINKST_IN_L2		0xc04
> +#define PARF_DEBUG_CNT_PM_LINKST_IN_L1		0xc0c
> +#define PARF_DEBUG_CNT_PM_LINKST_IN_L0S		0xc10
> +#define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1	0xc84
> +#define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2	0xc88
> +
>   /* PARF_SYS_CTRL register fields */
>   #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
>   #define MST_WAKEUP_EN				BIT(13)
> @@ -229,11 +237,13 @@ struct qcom_pcie {
>   	struct dw_pcie *pci;
>   	void __iomem *parf;			/* DT parf */
>   	void __iomem *elbi;			/* DT elbi */
> +	void __iomem *mhi;
>   	union qcom_pcie_resources res;
>   	struct phy *phy;
>   	struct gpio_desc *reset;
>   	struct icc_path *icc_mem;
>   	const struct qcom_pcie_cfg *cfg;
> +	struct dentry *debugfs;
>   };
>   
>   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1385,6 +1395,37 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>   	}
>   }
>   
> +static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> +{
> +	struct qcom_pcie *pcie = (struct qcom_pcie *)
> +				     dev_get_drvdata(s->private);
> +
> +	seq_printf(s, "L0s transition count: %u\n",
> +		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L0S));
> +
> +	seq_printf(s, "L1 transition count: %u\n",
> +		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L1));
> +
> +	seq_printf(s, "L1.1 transition count: %u\n",
> +		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1));
> +
> +	seq_printf(s, "L1.2 transition count: %u\n",
> +		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2));
> +
> +	seq_printf(s, "L2 transition count: %u\n",
> +		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L2));
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	debugfs_create_devm_seqfile(pci->dev, "link_transition_count", pcie->debugfs,
> +				    qcom_pcie_link_transition_count);
> +}
> +
>   static int qcom_pcie_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -1392,6 +1433,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   	struct dw_pcie *pci;
>   	struct qcom_pcie *pcie;
>   	const struct qcom_pcie_cfg *pcie_cfg;
> +	char *name;
>   	int ret;
>   
>   	pcie_cfg = of_device_get_match_data(dev);
> @@ -1439,6 +1481,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   		goto err_pm_runtime_put;
>   	}
>   
> +	pcie->mhi = devm_platform_ioremap_resource_byname(pdev, "mhi");
> +	if (IS_ERR(pcie->mhi)) {
> +		ret = PTR_ERR(pcie->mhi);
> +		goto err_pm_runtime_put;
> +	}
> +

  Tested this series on ipq4019-ap.dk07.1-c1 board and the above hunk
  breaks enumeration because there is no 'mhi' region. All the debug bits
  used in the transition_count function is inside the PARF_STTS register
  at offset 0x24 inside the PARF region.

  Register: PCIE_0_PCIE20_PARF_PM_STTS | 0x80024
  Offset:    0x24    Reset State:    0x00040000

Bits    Field Name
31    LINK_REQ_RST_NOT
30    XMLH_LINK_UP
29    PM_DSTATE_0
0x0: D0
0x1: D3
28    PHYSTATUS
27:16    PM_DSTATE
15:12    PM_PME_EN
11    PHYCLK_REQ_N
10    L1SS_CLKREQN_OE
9    L1SS_CLKREQN_IN
8    PM_LINKST_IN_L1SUB
7    PM_LINKST_IN_L0S
6    PM_LINKST_L2_EXIT
5    PM_LINKST_IN_L2
4    PM_LINKST_IN_L1
3:0    PM_STATUS

Otherwise, with rest of the patches enumeration was fine.
Tested with a pcie ethernet adapter.

Regards,
  Sricharan
