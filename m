Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748CA55948C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiFXICj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 04:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiFXICj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 04:02:39 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA75C6B8E9;
        Fri, 24 Jun 2022 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656057758; x=1687593758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cdLPF9xWzLEpA3ElIMUudQ7EhDFLIG+dPdxU0C2bjoo=;
  b=CXzjNURLm5L+1L5HBTjOQkGkxUVNXXeocfigervXLMfkLiZ2ChQJnb01
   Usj0ICKfBCpsjZp79YOi7t8myyOwoggK7qgJyi6bev4Z8ygxCZqztDC3D
   50ysW6iocNY5MfvcZRX1zH7hzvOyHot4Qz0mrlaDXBnTSZDKKvJrWLC8e
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Jun 2022 01:02:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 01:02:38 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 01:02:37 -0700
Received: from [10.216.16.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 24 Jun
 2022 01:02:31 -0700
Message-ID: <59ab9423-c0ea-ae5e-2f2e-c2f06c881559@quicinc.com>
Date:   Fri, 24 Jun 2022 13:32:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] PCI: qcom: Allow L1 and its sub states
Content-Language: en-US
To:     <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Stanimir Varbanov" <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
 <1655298939-392-1-git-send-email-quic_krichai@quicinc.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <1655298939-392-1-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A gentle remainder.

On 6/15/2022 6:45 PM, Krishna chaitanya chundru wrote:
> Allow L1 and its sub-states in the qcom pcie driver.
> By default this is disabled in the hardware. So enabling it explicitly.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab9089..0d8efcc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -41,6 +41,9 @@
>   #define L23_CLK_RMV_DIS				BIT(2)
>   #define L1_CLK_RMV_DIS				BIT(1)
>   
> +#define PCIE20_PARF_PM_CTRL			0x20
> +#define REQ_NOT_ENTR_L1				BIT(5)
> +
>   #define PCIE20_PARF_PHY_CTRL			0x40
>   #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
>   #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> @@ -1267,6 +1270,11 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>   	val |= BIT(4);
>   	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
>   
> +	/* Enable L1 and L1ss */
> +	val = readl(pcie->parf + PCIE20_PARF_PM_CTRL);
> +	val &= ~REQ_NOT_ENTR_L1;
> +	writel(val, pcie->parf + PCIE20_PARF_PM_CTRL);
> +
>   	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>   		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
>   		val |= BIT(31);
