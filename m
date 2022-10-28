Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404C26118EB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 19:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiJ1RJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 13:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiJ1RJa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 13:09:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9DA237FB1;
        Fri, 28 Oct 2022 10:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3120DB82B8F;
        Fri, 28 Oct 2022 17:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2148C433C1;
        Fri, 28 Oct 2022 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666976808;
        bh=qrYBe3FQd2LFQCnU0ZqAp4miEqAlwMF6aGPtr+QClD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sWwTdSt/ReHpRI0HFbC8plyoeupkpPL2SYH7ZhvkFwUBvKkssKwYQ5ktcFcSdW9DH
         XUX4zAESAhEIDN6n9tYZAWn08ijQl+MI3vb1uvWg5Bs3NdECsXS+DQH6S6gjX1yYPy
         28BaUEvVp3YP92EGSbUp56MPsBcHrjlg3yA2t4rER3pQw1J+v+ZPia+jY3kMKUTPIW
         KjSpLCVfQuSVYKVngbhv99c36iynkqoKAEEWvFqAqVrHKsTmez4irq9NbZfYnDzuq8
         pN9302tinvFN1NF7FfD75w5Lor6WPo9nnu4gFU1o++4EWAVm5Dn+GV6jLHnIcvE4yk
         DKNFtY3EPIcWQ==
Date:   Fri, 28 Oct 2022 12:06:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: pci-epf-test: Register notifier if only
 core_init_notifier is enabled
Message-ID: <20221028170647.GA898435@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825090101.20474-1-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 25, 2022 at 06:01:01PM +0900, Kunihiko Hayashi wrote:
> Need to register pci_epf_test_notifier function event if only
> core_init_notifier is enabled.
> 
> Fixes: 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer core initialization")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Om Prakash Singh <omp@nvidia.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This patch is a part of series "PCI: endpoint: Fix core_init_notifier feature".
> The rest of the patches have been withdrawn.
> 
> Changes since v2:
> - Add Acked-by lines
> 
> Changes since v1:
> - Add Acked-by lines
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 36b1801a061b..55283d2379a6 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -979,7 +979,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (ret)
>  		epf_test->dma_supported = false;
>  
> -	if (linkup_notifier) {
> +	if (linkup_notifier || core_init_notifier) {
>  		epf->nb.notifier_call = pci_epf_test_notifier;
>  		pci_epc_register_notifier(epc, &epf->nb);

Why does pci_epc_register_notifier() even exist?  It's not used at all
except for this test code.

It would be better if infrastructure like this were connected with
some user of it.

>  	} else {
> -- 
> 2.17.1
> 
