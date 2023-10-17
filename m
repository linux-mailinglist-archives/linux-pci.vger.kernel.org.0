Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5829D7CC5DC
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 16:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbjJQOYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343820AbjJQOYo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 10:24:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BB2F0;
        Tue, 17 Oct 2023 07:24:42 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HDe2WB030531;
        Tue, 17 Oct 2023 14:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Z1BbkLfJM1dZsoZ8hAA5FBScRtYnqgna6SeRcoxVwi4=;
 b=MlalrgBDnO/UN61jsGkKwPMBQ9o5BgzREIGtVrTtqdd6d8kAt126rdrB1RmrSzQPoOQK
 3+oJPynhiWPBOz1R+iYdkL886LhQSE92J1Yj7voJKYr9qFrQ7dcoJqMEjs4ECCTPUeNR
 0LGOPKB3Kf8HherLvxHq4ukS5PmQZ4MKsLTTDe2DJXN3t77GT2k22Z0hiaLqVwr+QlzD
 pNIQ3uaxvErGwKQJzqKhV5xAeB8L3FM1kRISsRTdx6yD5KJ3sk40oaZAzCVYZja+QgLc
 ZzhuMhIZwoRw2rXsNEWARbL+gVbP0MwAjdaHE2w1vkTSdJ9mFOC3BXbSPzURhKup/8xy 9g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsd1rsumn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 14:24:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HEOXT7028004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 14:24:33 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 07:24:32 -0700
Date:   Tue, 17 Oct 2023 07:24:31 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: qcom-ep: Implement dbi_cs2_access() function
 callback for DBI CS2 access
Message-ID: <20231017142431.GR3553829@hu-bjorande-lv.qualcomm.com>
References: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
 <20231017-pcie-qcom-bar-v1-2-3e26de07bec0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231017-pcie-qcom-bar-v1-2-3e26de07bec0@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M27n39Tcjrvr17biD81g-GEg8TMVBnYF
X-Proofpoint-ORIG-GUID: M27n39Tcjrvr17biD81g-GEg8TMVBnYF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 clxscore=1011 mlxlogscore=708 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 11:47:55AM +0530, Manivannan Sadhasivam wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>

Your S-o-b should match this.

> 
> Qcom EP platforms require enabling/disabling the DBI CS2 access while
> programming some read only and shadow registers through DBI. So let's
> implement the dbi_cs2_access() callback that will be called by the DWC core
> while programming such registers like BAR mask register.
> 
> Without DBI CS2 access, writes to those registers will not be reflected.
> 
> Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 32c8d9e37876..4653cbf7f9ed 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -124,6 +124,7 @@
>  
>  /* ELBI registers */
>  #define ELBI_SYS_STTS				0x08
> +#define ELBI_CS2_ENABLE				0xa4
>  
>  /* DBI registers */
>  #define DBI_CON_STATUS				0x44
> @@ -262,6 +263,18 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
>  	disable_irq(pcie_ep->perst_irq);
>  }
>  
> +static void qcom_pcie_dbi_cs2_access(struct dw_pcie *pci, bool enable)
> +{
> +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> +
> +	writel_relaxed(enable, pcie_ep->elbi + ELBI_CS2_ENABLE);

Don't you want to maintain the ordering of whatever write came before
this?

Regards,
Bjorn

> +	/*
> +	 * Do a dummy read to make sure that the previous write has reached the
> +	 * memory before returning.
> +	 */
> +	readl_relaxed(pcie_ep->elbi + ELBI_CS2_ENABLE);
> +}
> +
>  static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
>  {
>  	struct dw_pcie *pci = &pcie_ep->pci;
> @@ -500,6 +513,7 @@ static const struct dw_pcie_ops pci_ops = {
>  	.link_up = qcom_pcie_dw_link_up,
>  	.start_link = qcom_pcie_dw_start_link,
>  	.stop_link = qcom_pcie_dw_stop_link,
> +	.dbi_cs2_access = qcom_pcie_dbi_cs2_access,
>  };
>  
>  static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
> 
> -- 
> 2.25.1
> 
