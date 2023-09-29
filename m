Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2597B7B3CA7
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 00:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjI2WhY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 18:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjI2WhX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 18:37:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38681B9;
        Fri, 29 Sep 2023 15:37:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AD2C433C8;
        Fri, 29 Sep 2023 22:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696027040;
        bh=+FQSIscV9bqF6D32g6rcCgdI77KM9F6e8NRJftItj7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nHTf1To0ChjzbhV1T/9z1W1L5KJpJqgPQ/nDjvgh2b2zZTkOjJ+jM7SpH5f8Sh9ma
         AQeyYKoWeOfqHnJVSZofA8QWDN1GT695GJf0glmYDxw0w+drOuUTjr9yul2v8Bziav
         5Oq4SLHYkZtprKmZWIoexApRS1txHTfzueQq9lQao54pWDtUThjhjAo/9ZyYI4L0pI
         3leK2elL54RqphCRfdXLA3R8ppBQUtDyBNwLOwaQzsnLk27oJHa6xXuFjlVGZ/i9p7
         Tpz2gfVgcSYyja4qC0C3TRJEpCxvGGJUaHzLrqQfvDt5vmjo9Xe8sHk8zvDd673/ed
         zHO9EzwaH/bLA==
Date:   Fri, 29 Sep 2023 17:37:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, herve.codina@bootlin.com,
        Jonathan.Cameron@huawei.com, bhelgaas@google.com, robh@kernel.org
Subject: Re: [PATCH v3] PCI: of: Fix memory leak when
 of_changeset_create_node() failed
Message-ID: <20230929223718.GA558826@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696007417-42059-1-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 29, 2023 at 10:10:17AM -0700, Lizhi Hou wrote:
> In function of_pci_make_dev_node(), the cset needs to be destroyed and
> freed when of_changeset_create_node() returns null.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/all/20230911171319.495bb837@bootlin.com/
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Applied with Herve's Reviewed-by to for-linus for v6.6, since
407d1a51921e appeared in v6.6-rc1, thanks!

> ---
>  drivers/pci/of.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 2af64bcb7da3..51e3dd0ea5ab 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -657,30 +657,33 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  
>  	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
>  	if (!cset)
> -		goto failed;
> +		goto out_free_name;
>  	of_changeset_init(cset);
>  
>  	np = of_changeset_create_node(cset, ppnode, name);
>  	if (!np)
> -		goto failed;
> -	np->data = cset;
> +		goto out_destroy_cset;
>  
>  	ret = of_pci_add_properties(pdev, cset, np);
>  	if (ret)
> -		goto failed;
> +		goto out_free_node;
>  
>  	ret = of_changeset_apply(cset);
>  	if (ret)
> -		goto failed;
> +		goto out_free_node;
>  
> +	np->data = cset;
>  	pdev->dev.of_node = np;
>  	kfree(name);
>  
>  	return;
>  
> -failed:
> -	if (np)
> -		of_node_put(np);
> +out_free_node:
> +	of_node_put(np);
> +out_destroy_cset:
> +	of_changeset_destroy(cset);
> +	kfree(cset);
> +out_free_name:
>  	kfree(name);
>  }
>  #endif
> -- 
> 2.34.1
> 
