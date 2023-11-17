Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095377EEE13
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 10:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjKQJFe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 04:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjKQJFe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 04:05:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46ADD52;
        Fri, 17 Nov 2023 01:05:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F46FC433C7;
        Fri, 17 Nov 2023 09:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700211930;
        bh=CRcBtu19n+PndQnrzEF4vcUcLQOW1EwvMXHrCXvikac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXqyJl2c200zNl9Fb+ks/yfpk04iMRehm+4xpX8AAc+7ZEBB3DOEtHpp4kxZ2X59T
         +gQlHr/8WBht8H8aq2wT5Dcchk7n7oKAbRoV4xVqs24Q/NHHy44+/onhCOJrJsYWlo
         /1FEoXoVzTirhxrZv9kLPc8peuPHqQzq+LZcAyNU5CzeYxDgcdgTCyK2BYuuU+3T6B
         wgrrybCZ0DFNrWbEHjWWxYGzl74uz6FKhlqMMmCu3dSp7z9gPQmVCrPDjc/O6G/yPj
         1VgfYojN7Bp6hVspr3g0e3/sr8yeJ1ye952uiLFe5GutIt6Z72F3ZuuvzMmmrO89hT
         saGBuERF72nYw==
Date:   Fri, 17 Nov 2023 14:35:19 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/3] PCI: qcom-ep: Enable cache coherency for SA8775P
 EP
Message-ID: <20231117090519.GA250770@thinkpad>
References: <1700051821-1087-1-git-send-email-quic_msarkar@quicinc.com>
 <1700051821-1087-3-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1700051821-1087-3-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 15, 2023 at 06:07:00PM +0530, Mrinmay Sarkar wrote:
> This change will enable cache snooping logic to support
> cache coherency for 8775 EP platform.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Same comment as patch 1/3.

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 3a53d97..ee99fb1 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -47,6 +47,7 @@
>  #define PARF_DBI_BASE_ADDR_HI			0x354
>  #define PARF_SLV_ADDR_SPACE_SIZE		0x358
>  #define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35c
> +#define PCIE_PARF_NO_SNOOP_OVERIDE		0x3d4
>  #define PARF_ATU_BASE_ADDR			0x634
>  #define PARF_ATU_BASE_ADDR_HI			0x638
>  #define PARF_SRIS_MODE				0x644
> @@ -86,6 +87,10 @@
>  #define PARF_DEBUG_INT_CFG_BUS_MASTER_EN	BIT(2)
>  #define PARF_DEBUG_INT_RADM_PM_TURNOFF		BIT(3)
>  
> +/* PARF_NO_SNOOP_OVERIDE register fields */
> +#define WR_NO_SNOOP_OVERIDE_EN                 BIT(1)
> +#define RD_NO_SNOOP_OVERIDE_EN                 BIT(3)
> +
>  /* PARF_DEVICE_TYPE register fields */
>  #define PARF_DEVICE_TYPE_EP			0x0
>  
> @@ -489,6 +494,11 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  	val |= BIT(8);
>  	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
>  
> +	/* Enable cache snooping for SA8775P */
> +	if (of_device_is_compatible(dev->of_node, "qcom,sa8775p-pcie-ep"))
> +		writel_relaxed(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
> +				pcie_ep->parf + PCIE_PARF_NO_SNOOP_OVERIDE);
> +
>  	return 0;
>  
>  err_disable_resources:
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
