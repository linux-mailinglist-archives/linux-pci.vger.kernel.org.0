Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98B06E8CA3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 10:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjDTIXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjDTIXZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 04:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984BD4C3A;
        Thu, 20 Apr 2023 01:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E442C61435;
        Thu, 20 Apr 2023 08:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D19C433EF;
        Thu, 20 Apr 2023 08:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681978985;
        bh=Ab68JqQLfY+jSqDEDD3C5HmCaqo0RsufHI6L372P1gM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rbm+N3RnJJevpEOSi49wnJA0CEF/1wW9Z9RjYvx5Do52m/c7wazbxQFIif7SoKsii
         qmeP65bmlV0cgvftyZaFCszAkwoVtUVXKNeANuJuJKjsbowN9sx7tovJnRpE8t1o7P
         vjHswVMRsSxvOkDXysDMjbievi9eCSLK8XLptOwvMk2BdHyO3KMahhDUS+7zGxIhTx
         YvmYXMWM/WBuXVapHG4C1D19lyhskkBIUG5N+hPZhWnfzzL4ckBBHCW2QGT++2HLtQ
         KqdKh/j28c+DMIiHBsd7ZLvbCu/Ly/z8TT6Le+2DxhIqkX9QDD1msyIRBuEkfy/ADp
         TZQ1uYkAWdDaA==
Message-ID: <3b711d73-ac46-7a37-e835-f9dadeb96dd3@kernel.org>
Date:   Thu, 20 Apr 2023 17:23:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] PCI: vmd: Fix two issues reported by Smatch
Content-Language: en-US
To:     korantwork@gmail.com, helgaas@kernel.org,
        nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230420081957.1440423-1-korantwork@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230420081957.1440423-1-korantwork@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/20/23 17:19, korantwork@gmail.com wrote:
> From: Xinghui Li <korantli@tencent.com>
> 
> There is one uninitialized symbol error reported by smatch:
> "drivers/pci/controller/vmd.c:931 vmd_enable_domain()
> error: uninitialized symbol 'ret'."
> 
> Fix it by assigning ret with pci_reset_bus return.

This is a bug so clearly needs a fixes tag.

> 
> And one inconsistent indenting warning:
> "drivers/pci/controller/vmd.c:1058 vmd_resume()
> warn: inconsistent indenting"
> 
> Fix it by formating its indenting.

But this is cosmetic and does not need backporting/fixes tag in my opinion. So
better split this into 2 different patches.

> 
> Fixes: 0a584655ef89 ("PCI: vmd: Fix secondary bus reset for Intel bridges")
> Fixes: d899aa668498 ("PCI: vmd: Disable MSI remapping after suspend")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Xinghui Li <korantli@tencent.com>
> ---
>  drivers/pci/controller/vmd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 7e1fd959e00d..0a7c1fdfeec0 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -943,7 +943,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		if (!list_empty(&child->devices)) {
>  			dev = list_first_entry(&child->devices,
>  					       struct pci_dev, bus_list);
> -			if (pci_reset_bus(dev))
> +			ret = pci_reset_bus(dev);
> +			if (ret)
>  				pci_warn(dev, "can't reset device: %d\n", ret);
>  
>  			break;
> @@ -1084,10 +1085,10 @@ static int vmd_resume(struct device *dev)
>  	struct vmd_dev *vmd = pci_get_drvdata(pdev);
>  	int err, i;
>  
> -       if (vmd->irq_domain)
> -               vmd_set_msi_remapping(vmd, true);
> -       else
> -               vmd_set_msi_remapping(vmd, false);
> +	if (vmd->irq_domain)
> +		vmd_set_msi_remapping(vmd, true);
> +	else
> +		vmd_set_msi_remapping(vmd, false);
>  
>  	for (i = 0; i < vmd->msix_count; i++) {
>  		err = devm_request_irq(dev, vmd->irqs[i].virq,

