Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BFF614B30
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 13:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKAMyV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKAMyV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 08:54:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B8DDF66;
        Tue,  1 Nov 2022 05:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E82161170;
        Tue,  1 Nov 2022 12:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3E7C433D6;
        Tue,  1 Nov 2022 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667307259;
        bh=n3TjX1sm6RjcJuc/37BVgiZ+KSbJEbj+8nRbtpJHptQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9LgXoLcuGOpXV3hiVqBmCCtUMgVXhja9k5Yh+s6FvbvHKkHZQTa+4m53XZjf3ep2
         0125eAKOAUWMuEhbqJTpJXlxD273yM4+dK7uGISOH0/z5ZS/3O6g8BdvTOm4BQbBho
         OzMm32SXm2ty/IdT1i2gNpxCbVN7mkDMJF3dsPN300FykMcJihyX2Z/DBEQ86nCDbf
         DEVn8yZ1RxSEQKa2/t/ICxFgxd/YURMOGyrG99/q6IPE5Z5JtL0iuyI3XriDn6og3H
         NxK6rDpvVd9uYk1DrX1N5KJfWWIyyrvW4Sa8mg+tSMjxfDv1YCo0OKr/glmZ934J1z
         vzr7tsr8RtdpA==
Date:   Tue, 1 Nov 2022 18:24:05 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@ti.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 4/4] PCI: endpoint: Add deinit in epf test driver
Message-ID: <20221101125405.GN54667@thinkpad>
References: <20221013181815.2133-1-vidyas@nvidia.com>
 <20221013181815.2133-5-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221013181815.2133-5-vidyas@nvidia.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 11:48:15PM +0530, Vidya Sagar wrote:
> Add support for clearing the BAR info during the deinitialization phase of
> the epf test driver.
> 

BAR is currently cleared during unbind() time. With this deinit callback, it
has to be removed from unbind().

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * This is a new patch in this series
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 136470019a24..25ac3d161fac 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -826,6 +826,35 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static int pci_epf_test_clear_bar(struct pci_epf *epf)
> +{
> +	int bar, add;

I don't think "add" is a good variable name. Maybe "bar_type"?

Thanks,
Mani

> +	struct pci_epf_bar *epf_bar;
> +	struct pci_epc *epc = epf->epc;
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	const struct pci_epc_features *epc_features;
> +
> +	epc_features = epf_test->epc_features;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
> +		epf_bar = &epf->bar[bar];
> +		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> +
> +		if (!!(epc_features->reserved_bar & (1 << bar)))
> +			continue;
> +
> +		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pci_epf_test_core_deinit(struct pci_epf *epf)
> +{
> +	pci_epf_test_clear_bar(epf);
> +	return 0;
> +}
> +
>  int pci_epf_test_link_up(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> @@ -839,6 +868,7 @@ int pci_epf_test_link_up(struct pci_epf *epf)
>  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
>  	.core_init = pci_epf_test_core_init,
>  	.link_up = pci_epf_test_link_up,
> +	.core_deinit = pci_epf_test_core_deinit,
>  };
>  
>  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
