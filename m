Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239412E215F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Dec 2020 21:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgLWUeq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Dec 2020 15:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgLWUeq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Dec 2020 15:34:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5B93224B0;
        Wed, 23 Dec 2020 20:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608755645;
        bh=KjJsg8AZUftQqGocU/eSTcEZqpjvbqUtQRkYl1ogUiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZVEW79RSwD4+/ME2eRqrtJc8rv/gDoR9dz7klfUU94kloC3EqChVrBKp/VoAmUtfx
         hKjIqvgNZwoMKFg3XpHSwO6pPJgbGk8Sdoo+aP6MWkFi31DSxTESDGDa22WphkajVx
         x8xIYsOkbd2e3o/TfC0wJSMoZEZVZgPVK1AlcA7DSiVx24/rnxid+2w5KcaXAATCet
         6seWXT2wUDyCGBj7XrHVennonWRZaAdg5L2AjhkniX45eEPES/zBhMGXDkhRy09PrT
         CyNr2hOLJKWYzz/r7FrUyu13aF9/K7w1bElRK9ymLxi+BSeIvvB72XaBEE0bWkZiTr
         cobx2kzEau82A==
Date:   Wed, 23 Dec 2020 14:34:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        pankaj.dubey@samsung.com, Sriram Dash <sriram.dash@samsung.com>
Subject: Re: [PATCH v2] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Message-ID: <20201223203403.GA320059@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608306316-32096-1-git-send-email-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 18, 2020 at 09:15:16PM +0530, Shradha Todi wrote:
> get_features ops of pci_epc_ops may return NULL, causing NULL pointer
> dereference in pci_epf_test_bind function. Let us add a check for
> pci_epc_feature pointer in pci_epf_test_bind before we access it to
> avoid any such NULL pointer dereference and return -ENOTSUPP in case
> pci_epc_feature is not found.

Can you add a Fixes: tag to identify where this broke to help people
decide where to backport the fix?

> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
> v2:
>  rebase on v1
>  v1: https://lore.kernel.org/patchwork/patch/1208269/
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 66723d5..f1842e6 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -835,13 +835,16 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  		return -EINVAL;
>  
>  	epc_features = pci_epc_get_features(epc, epf->func_no);
> -	if (epc_features) {
> -		linkup_notifier = epc_features->linkup_notifier;
> -		core_init_notifier = epc_features->core_init_notifier;
> -		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
> -		pci_epf_configure_bar(epf, epc_features);
> +	if (!epc_features) {
> +		dev_err(&epf->dev, "epc_features not implemented\n");
> +		return -EOPNOTSUPP;
>  	}
>  
> +	linkup_notifier = epc_features->linkup_notifier;
> +	core_init_notifier = epc_features->core_init_notifier;
> +	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
> +	pci_epf_configure_bar(epf, epc_features);
> +
>  	epf_test->test_reg_bar = test_reg_bar;
>  	epf_test->epc_features = epc_features;
>  
> -- 
> 2.7.4
> 
