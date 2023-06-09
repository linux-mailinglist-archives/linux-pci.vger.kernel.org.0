Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CA4729F31
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbjFIPuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 11:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241974AbjFIPu1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 11:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C703E3C04;
        Fri,  9 Jun 2023 08:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC4961C5A;
        Fri,  9 Jun 2023 15:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFA9C4339C;
        Fri,  9 Jun 2023 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686325821;
        bh=5w5b1lGyt+7thZ9+8s+QnKfndAO2UNpN5cwTTuTu32Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjK7sByqsGckkLQFc7E/3JROzrZQiLaTvcNflvXp6OVgMV8jCoubAaSupY83Ro+/r
         5OECz/IWXRVlJ+AhWqJRoHIzlf1VH3Fz79rYtmqO0ECU0JB2JmK34JKgaS5HgDz62a
         KSDcWOv1MV4lPBFzv5L7+JieO7HkPJo7gwG1qg/7oGntHL936Xvdu7MDTaxfiQ0Gj9
         s1T+rkj5iT5B9il0b28NXaZCUnZIU28FBqJGKJfuAmkpmciNQBHh591JIoDtzquq0/
         vJksFdS+pkfuCj3P/rBemODykSzsJQ2MTzNuuoyPoWe8uK5Mcarl5DXIMWpeB7jJ2W
         i4Vpp8HSaUeXg==
Date:   Fri, 9 Jun 2023 21:20:13 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Damien Le Moal <dlemoal@kernel.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Check correct variable in
 __pci_epf_mhi_alloc_map()
Message-ID: <20230609155013.GD6847@thinkpad>
References: <258e8de1-abff-4024-89e0-1c8df761d790@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <258e8de1-abff-4024-89e0-1c8df761d790@moroto.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 09, 2023 at 01:49:33PM +0300, Dan Carpenter wrote:
> This was intended to check "*vaddr" instead of "vaddr" (without an
> asterisk).
> 
> Fixes: 7db424a84d96 ("PCI: endpoint: Add PCI Endpoint function driver for MHI bus")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 1227f059ea12..e7d64b9d12ff 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -112,7 +112,7 @@ static int __pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
>  	int ret;
>  
>  	*vaddr = pci_epc_mem_alloc_addr(epc, paddr, size + offset);
> -	if (!vaddr)
> +	if (!*vaddr)
>  		return -ENOMEM;
>  
>  	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, *paddr,
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
