Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7F5468BE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiFJOsA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 10:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344919AbiFJOr2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 10:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4641339E9;
        Fri, 10 Jun 2022 07:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8114E61F12;
        Fri, 10 Jun 2022 14:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3357C34114;
        Fri, 10 Jun 2022 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654872445;
        bh=jFIF8/LuY5OXp1PjfRrhgWjp+rI/9N1uF6IWjZT8Wrg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kFCVIIi/T82jUj2lGrpDtAvTtYPIi/mnSvhagtQvkhqbRVKFF8b9BTWlTkbKCqL2H
         3Es9G5qMiVXpYFiFOjD07NTarCxgHWlz+5dWTk8EfgDzxH6Sh50X+srLXrlS2a60fR
         pvEUAWNpWaak9RBaOiRtF5iR2p9CUyiTeqnE0nwmBsimH9Yh65l05FQrEhFtMRsrPG
         hnUTV5J5kvUtUmqWyhT9LVCj2tzuRX1uKMGzIP3mWySjuGnExg2Ic4rERyTW5DOznm
         7mSQz6gMOjHq0YDDAgB8s1sUrDMY7axmoGvGCDL9jENuYv9rtztORupegIYpsqkqnP
         nAqM/6potRmFw==
Date:   Fri, 10 Jun 2022 09:47:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     subramanian.mohan@intel.com
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mallikarjunappa.sangannavar@intel.com,
        srikanth.thokala@intel.com
Subject: Re: [PATCH] PCI: vmd: Use devm_kasprintf instead of simple kasprintf
Message-ID: <20220610144724.GA597886@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531132617.20517-1-subramanian.mohan@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 31, 2022 at 06:56:17PM +0530, subramanian.mohan@intel.com wrote:
> From: Subramanian Mohan <subramanian.mohan@intel.com>
> 
> Use devm_kasprintf instead of simple kasprintf to free the allocated memory
> automatically when the device is freed.
> 
> Suggested-by: Srikanth Thokala <srikanth.thokala@intel.com>
> Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
> Acked-by: Nirmal Patel <nirmal.patel@linux.intel.com>

Applied to pci/ctrl/vmd for v5.20, thanks!

> ---
>  drivers/pci/controller/vmd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index eb05cceab964..7a72948e001f 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -897,7 +897,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (vmd->instance < 0)
>  		return vmd->instance;
>  
> -	vmd->name = kasprintf(GFP_KERNEL, "vmd%d", vmd->instance);
> +	vmd->name = devm_kasprintf(&dev->dev, GFP_KERNEL, "vmd%d",
> +				   vmd->instance);
>  	if (!vmd->name) {
>  		err = -ENOMEM;
>  		goto out_release_instance;
> @@ -935,7 +936,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>   out_release_instance:
>  	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> -	kfree(vmd->name);
>  	return err;
>  }
>  
> @@ -958,7 +958,6 @@ static void vmd_remove(struct pci_dev *dev)
>  	vmd_detach_resources(vmd);
>  	vmd_remove_irq_domain(vmd);
>  	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> -	kfree(vmd->name);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.17.1
> 
