Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65D9699352
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 12:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBPLjl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 06:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPLjk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 06:39:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2843C659D;
        Thu, 16 Feb 2023 03:39:32 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G8cWKG021972;
        Thu, 16 Feb 2023 11:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uVOo0wi1aHKMoaXZgIN5GZV7uFyg9xnchXiFYkyFCdI=;
 b=GCQjX6a9WKQn70jzXJSRUdTNWoEjTYnkaTfBGgngwTzMSmsr50iGsY05BmkyEz4eWMPE
 cuYdQG/yVvDQF5B7X9WZEmUmeRPVxgBpTjDNdQk5NQPEknuImyY1tYJNyn3vfeejfU8k
 XZqjJx3zGECzkQMJaI4TwBfHW8ofEMowksm+x3KE+tp+y53qWoFr4fyoCBAh0pHR3/mI
 4qrMu9q8NL4+LHCgG9mnbcClAi0UqbRh0IZQORk74UIXWXjAv+0KaSs2G2xZE/duGkVA
 FuH/RZl1MP2iYjLQeOXr++SZ1o3QmPobVtBq90nhohJiXIWQjt6qja++tCK5yt1mHrQK 2Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ns0hkjwrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 11:39:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GBd5Xe031736
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 11:39:05 GMT
Received: from [10.242.242.255] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 03:38:56 -0800
Message-ID: <6ea43d8d-7b9c-5a11-097f-906e10ac3627@quicinc.com>
Date:   Thu, 16 Feb 2023 17:08:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/7] PCI: qcom: Add IPQ9574 PCIe support
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <svarbanov@mm-sol.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-3-quic_devipriy@quicinc.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230214164135.17039-3-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sGl2UNFWHiU0g3pN-jS9I8SkIK4q0k2T
X-Proofpoint-GUID: sGl2UNFWHiU0g3pN-jS9I8SkIK4q0k2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_08,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160099
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Devi,

On 2/14/2023 10:11 PM, Devi Priya wrote:
> Adding PCIe support for IPQ9574 SoC
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 119 +++++++++++++++++++++++++
>   1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a232b04af048..57606c113d45 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -193,6 +193,12 @@ struct qcom_pcie_resources_2_9_0 {
>   	struct reset_control *rst;
>   };
>   
> +struct qcom_pcie_resources_1_27_0 {
> +	struct clk_bulk_data *clks;
> +	struct reset_control *rst;
> +	int num_clks;
> +};
> +
>   union qcom_pcie_resources {
>   	struct qcom_pcie_resources_1_0_0 v1_0_0;
>   	struct qcom_pcie_resources_2_1_0 v2_1_0;
> @@ -201,6 +207,7 @@ union qcom_pcie_resources {
>   	struct qcom_pcie_resources_2_4_0 v2_4_0;
>   	struct qcom_pcie_resources_2_7_0 v2_7_0;
>   	struct qcom_pcie_resources_2_9_0 v2_9_0;
> +	struct qcom_pcie_resources_1_27_0 v1_27_0;
>   };
>   
>   struct qcom_pcie;
> @@ -1409,6 +1416,104 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>   	return 0;
>   }
>   
> +static int qcom_pcie_get_resources_1_27_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_1_27_0 *res = &pcie->res.v1_27_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +
> +	res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
> +	if (res->clks < 0)
> +		return res->num_clks;
> +
> +	res->rst = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(res->rst))
> +		return PTR_ERR(res->rst);
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_deinit_1_27_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_1_27_0 *res = &pcie->res.v1_27_0;
> +
> +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> +}
> +
> +static int qcom_pcie_init_1_27_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_1_27_0 *res = &pcie->res.v1_27_0;
> +	struct device *dev = pcie->pci->dev;
> +	int ret;
> +
> +	ret = reset_control_assert(res->rst);
> +	if (ret) {
> +		dev_err(dev, "reset assert failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Delay periods before and after reset deassert are working values
> +	 * from downstream Codeaurora kernel
> +	 */
> +	usleep_range(2000, 2500);
> +
> +	ret = reset_control_deassert(res->rst);
> +	if (ret) {
> +		dev_err(dev, "reset deassert failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(2000, 2500);
> +
> +	return clk_bulk_prepare_enable(res->num_clks, res->clks);
> +}
> +
> +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u32 val;
> +	int i;
> +
> +	writel(0x8000000, pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> +
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	val &= ~BIT(0);
> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +
> +	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> +	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
> +	       pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +	writel(GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS |
> +	       GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL,
> +	       pci->dbi_base + GEN3_RELATED_OFF);
> +
> +	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS |
> +	       SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
> +	       AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
> +	       pcie->parf + PCIE20_PARF_SYS_CTRL);
> +
> +	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> +
> +	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +	val &= ~PCI_EXP_LNKCAP_ASPMS;
> +	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +
> +	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
> +	       PCI_EXP_DEVCTL2);
> +
> +	for (i = 0; i < 256; i++)
> +		writel(0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N + (4 * i));
> +
> +	return 0;
> +}
> +
>   static int qcom_pcie_link_up(struct dw_pcie *pci)
>   {
>   	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -1620,6 +1725,15 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>   };
>   
> +/* Qcom IP rev.: 1.27.0 Synopsys IP rev.: 5.80a */
> +static const struct qcom_pcie_ops ops_1_27_0 = {
> +	.get_resources = qcom_pcie_get_resources_1_27_0,
> +	.init = qcom_pcie_init_1_27_0,
> +	.post_init = qcom_pcie_post_init_1_27_0,
> +	.deinit = qcom_pcie_deinit_1_27_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +};
> +
>   static const struct qcom_pcie_cfg cfg_1_0_0 = {
>   	.ops = &ops_1_0_0,
>   };
> @@ -1652,6 +1766,10 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
>   	.ops = &ops_2_9_0,
>   };
>   
> +static const struct qcom_pcie_cfg cfg_1_27_0 = {
> +	.ops = &ops_1_27_0,
> +};
> +
>   static const struct dw_pcie_ops dw_pcie_ops = {
>   	.link_up = qcom_pcie_link_up,
>   	.start_link = qcom_pcie_start_link,
> @@ -1829,6 +1947,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>   	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>   	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>   	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> +	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_1_27_0 },

   I do not see much difference between 2_9_0 and 1_27_0. Is this patch
   really required. Can you check if it works with 2_9_0 itself ?

Regards,
  Sricharan
