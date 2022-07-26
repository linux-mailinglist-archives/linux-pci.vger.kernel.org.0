Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962E5581357
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 14:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiGZMp1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 08:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiGZMp0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 08:45:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFECD63D5;
        Tue, 26 Jul 2022 05:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95E40B8161C;
        Tue, 26 Jul 2022 12:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EB0C341C0;
        Tue, 26 Jul 2022 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658839523;
        bh=PBX3dV218ic0+bWKkpW7iYkXLpgYrw64ydn8N4ZfCAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GoiM3xMTQq7JdhwEgWjjNZDZWIDGmKY8y47toVe48DCFZjAYfRfCgP8oXti+ortc5
         4epbacqlcH3HYngHb3rNqKgPAODeCt3xAAmqz/qCrzqMwGMfa66nVYjvbjIV+ojYzS
         098CpGeZKtl/E5KKtO7C/8cqdTldAvMrM0CbrfDmdHUXin2iwO7WBOJcmwxYCe6QQm
         /5q+I8tM093PDlRFGF/q8J2AncJkYjrXck8eSRrAAUrejVB5Fb2lf18qdmGDY9P2FE
         27x23T/INpin8++hGf8EuexBvTImQY/jBnOg6EWSvl+J6j6ti7pjYLjJT32XxYUWZD
         /3HkhcetH8NuQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oGJwM-0001MH-8L; Tue, 26 Jul 2022 14:45:34 +0200
Date:   Tue, 26 Jul 2022 14:45:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Baruch Siach <baruch.siach@siklu.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: qcom: Sort variants by Qcom IP rev
Message-ID: <Yt/h7q9OBtlyG+Sw@hovoldconsulting.com>
References: <20220722154919.1826027-1-helgaas@kernel.org>
 <20220722154919.1826027-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722154919.1826027-3-helgaas@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 22, 2022 at 10:49:19AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously the variant resource structs, ops, etc., were in no obvious
> order (mostly but not consistently in *Synopsys* IP rev order, which is not
> reflected in the naming).
> 
> Reorder them in order of the struct and function names.  No functional
> change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 732 ++++++++++++-------------
>  1 file changed, 366 insertions(+), 366 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c27e3494179f..d0237d821323 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

Moving code around like this makes code forensics harder as it messes up
git blame. At least the callbacks appears to be grouped by IP version
currently, so not sure how much you gain from moving the callbacks
around.

On the other hand, it looks like the patch doesn't touch the revision I
currently care about, so your call.

> -/* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
> -static const struct qcom_pcie_ops ops_2_1_0 = {
> -	.get_resources = qcom_pcie_get_resources_2_1_0,
> -	.init = qcom_pcie_init_2_1_0,
> -	.post_init = qcom_pcie_post_init_2_1_0,
> -	.deinit = qcom_pcie_deinit_2_1_0,
> -	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
> -};

Similar problem with git blame here, but at least this seems a bit more
warranted as these structs are small enough that you may actually search
manually among them.

> +static const struct qcom_pcie_cfg sm8150_cfg = {
> +	/* sm8150 has qcom IP rev 1.5.0. However 1.5.0 ops are same as
> +	 * 1.9.0, so reuse the same.
> +	 */
> +	.ops = &ops_1_9_0,
> +};

> +static const struct qcom_pcie_cfg sc8180x_cfg = {
> +	.ops = &ops_1_9_0,
> +	.has_tbu_clk = true,
> +};
> +
>  static const struct qcom_pcie_cfg ipq8064_cfg = {
>  	.ops = &ops_2_1_0,
>  };
> @@ -1626,42 +1662,6 @@ static const struct qcom_pcie_cfg sdm845_cfg = {
>  	.has_tbu_clk = true,
>  };
>  
> -static const struct qcom_pcie_cfg sm8150_cfg = {
> -	/* sm8150 has qcom IP rev 1.5.0. However 1.5.0 ops are same as
> -	 * 1.9.0, so reuse the same.
> -	 */
> -	.ops = &ops_1_9_0,
> -};

> -static const struct qcom_pcie_cfg sc8180x_cfg = {
> -	.ops = &ops_1_9_0,
> -	.has_tbu_clk = true,
> -};
> -
>  static const struct qcom_pcie_cfg ipq6018_cfg = {
>  	.ops = &ops_2_9_0,
>  };

But this bit I disagree with. Why sort the SoCs configurations by IP
revision, when what you typically need is to look them up by name?

Also note that this conflicts with my sc8280xp-support and IP-revision
series:

	https://lore.kernel.org/all/20220714071348.6792-1-johan+linaro@kernel.org/

The result of applying that series is that these structs are renamed
after the IP revision (and sorted alphabetically) so the end-result is
similar.

Could you consider dropping this patch, or at least the struct
qcom_pcie_cfg bits, and applying the above series for 5.20?

Or do I need to rebase on top first?

Johan
