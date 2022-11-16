Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D092562C16E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiKPOxP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 09:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiKPOw4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 09:52:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8393F056;
        Wed, 16 Nov 2022 06:51:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 740DD61E6F;
        Wed, 16 Nov 2022 14:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73A5C433D7;
        Wed, 16 Nov 2022 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668610288;
        bh=ua2SmIHmfrN/HL4JmO/Y+Pm6lBJ0aqfUQvZIhIz5SZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqiCT6mXuKeFWWqBBNmLM0BHcHxB/B9ds35B2R9jcwntjfGBqPZO6cvCYxXjQy+k7
         I2ncPP1RznmLkNGQwlJ128FdRzKPa4CFRQOm6P9nYCQY3cGVDqg3iKiRliDtnYO4D1
         HMjaKbpwvjn8+AzPVpw/AzitRti1I7pmzsNXNqgklnNgnjPGNfUuD5Lj42fPgUkJKn
         hlzDujD47bcjc0BLLKKqqqOJfYC+lXQym9Wd14AZMX1CUuV8mA/PvN00qTH1e6/b7G
         K3XWIj8lou0D75QtOysU3dSKWWqZPhKdwyD2SwdxIgYqkN7gqHVDFxIoWWsjroiPpw
         3OrOA0T5dd96A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovJkh-0003Pi-63; Wed, 16 Nov 2022 15:50:59 +0100
Date:   Wed, 16 Nov 2022 15:50:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 8/8] arm64: dts: qcom: sm8350-hdk: enable PCIe devices
Message-ID: <Y3T405atm45IMsGa@hovoldconsulting.com>
References: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
 <20221110183158.856242-9-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110183158.856242-9-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 09:31:58PM +0300, Dmitry Baryshkov wrote:
> Enable PCIe0 and PCIe1 hosts found on SM8350 HDK board.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index 0fcf5bd88fc7..d3c851ec3501 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -222,6 +222,26 @@ &mpss {
>  	firmware-name = "qcom/sm8350/modem.mbn";
>  };
>  
> +&pcie0 {
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	status = "okay";

The 'status' property should generally go last.

> +	vdda-phy-supply = <&vreg_l5b_0p88>;
> +	vdda-pll-supply = <&vreg_l6b_1p2>;
> +};
> +
> +&pcie1 {
> +	status = "okay";
> +};
> +
> +&pcie1_phy {
> +	status = "okay";

Same here.

> +	vdda-phy-supply = <&vreg_l5b_0p88>;
> +	vdda-pll-supply = <&vreg_l6b_1p2>;
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };

Johan
