Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8BE68F3D9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 17:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjBHQ6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 11:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjBHQ6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 11:58:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619391557E;
        Wed,  8 Feb 2023 08:58:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E824B81EFB;
        Wed,  8 Feb 2023 16:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4968C433D2;
        Wed,  8 Feb 2023 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675875479;
        bh=Tof45ntgajqPw7Zum1B89hupdFG6GLRd0E+ZClwzSlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DshPxF9pRrwDTzjAMaCq3Q6G/pPXJ4L/CIzU/PKGrNR9OGO6+n2H0gY6L2Dlf1yvy
         +qaUqq08kh11DZvS6CmD8RSAoF0WvykNyWlT1Da4nJ5w7FTEmjh2mU5v3VHezA4iRW
         CFmaNy3FE46ehFOGXuQPmbFIPJN4DZPTfZPZlezfU0lO7buFTOOykFAgcwuQ4ydLOm
         0LRvhNzDS8xNN/tGeg+2hMLeNwxYVfsFGBekoNfjWe8iYadgpJ8TvD/z8a8Xrhw+F0
         f4mmolm2M0exBrpdVP2z7hIFYB0cBUIaEWJtB/ppCE80Jb66KK6sVrQ20O9i/834Vo
         rHdHqQexvS5UA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPnmF-00062i-Pj; Wed, 08 Feb 2023 17:58:36 +0100
Date:   Wed, 8 Feb 2023 17:58:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 10/11] PCI: qcom: Add SM8550 PCIe support
Message-ID: <Y+PUuy0qbO9EWOXb@hovoldconsulting.com>
References: <20230206212619.3218741-1-abel.vesa@linaro.org>
 <20230206212619.3218741-11-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206212619.3218741-11-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 11:26:18PM +0200, Abel Vesa wrote:
> Add compatible for both PCIe found on SM8550.
> Also add the noc_aggr and cnoc_sf_axi clocks needed by the SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---

> @@ -1237,17 +1239,17 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	if (ret < 0)
>  		goto err_disable_regulators;
>  
> -	ret = reset_control_assert(res->pci_reset);
> -	if (ret < 0) {
> -		dev_err(dev, "cannot assert pci reset\n");
> +	ret = reset_control_assert(res->rst);
> +	if (ret) {
> +		dev_err(dev, "reset assert failed (%d)\n", ret);
>  		goto err_disable_clocks;
>  	}
>  
>  	usleep_range(1000, 1500);
>  
> -	ret = reset_control_deassert(res->pci_reset);
> -	if (ret < 0) {
> -		dev_err(dev, "cannot deassert pci reset\n");
> +	ret = reset_control_deassert(res->rst);
> +	if (ret) {
> +		dev_err(dev, "reset deassert failed (%d)\n", ret);
>  		goto err_disable_clocks;
>  	}

I'd still like to know if it's indeed ok the deassert the 'pci' reset
before the new 'link_down' reset here which is what this code currently
would do (i.e. same order as for assert, while if you had used the bulk
reset API it would have deasserted in the reverse order).

Other than that:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
