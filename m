Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B94658FE6
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 18:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiL2RcS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 12:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiL2Rbs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 12:31:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897B015825;
        Thu, 29 Dec 2022 09:31:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46DC0B81A13;
        Thu, 29 Dec 2022 17:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E31C433EF;
        Thu, 29 Dec 2022 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672335097;
        bh=j3qG4bGdaEXrYNRPEIJY/y6BAFFyj1LA3ARl7FLkrLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4sAGzauvpyN7efg6S4Tt8IiUEpZ0pASvRe3oGUwwaLxVTNcPdlHIqrN58hpmaUUa
         RiM42MzPJVTqIJe9AaD62iuWZQDB/STAAszJSBI2BMPdbPDzp12xY7nk22is9soD/t
         qeAX9Bgon5afLZcXNpUckXI7DxqyBeEwUt64BhPYSf+TO3ZMWipEzT9+/gAokNa6Zi
         OLE8z+ltM47ZoJsjQZ68IRB+FhS46sZIC60r2C2e59Y/m931blIbdT9TWtfKHb428C
         kUWSuVrFYQNjK6TN89D+dVXgmG2KxR40igx+ARV/vRLI+B3j68ZLaNOBJz5bP5SClB
         QjsaX0jrHUlFw==
Date:   Thu, 29 Dec 2022 11:31:34 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/8] PCI: qcom: Add support for SM8350
Message-ID: <20221229173134.ul2kzupf4yjvbvgk@builder.lan>
References: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
 <20221118233242.2904088-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118233242.2904088-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 19, 2022 at 01:32:37AM +0200, Dmitry Baryshkov wrote:
> Add support for the PCIe host on Qualcomm SM8350 platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 77e5dc7b88ad..b9350d93b4ba 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1826,6 +1826,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
>  	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sm8350", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ }
> -- 
> 2.35.1
> 
