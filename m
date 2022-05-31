Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192C653965C
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347031AbiEaSjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 14:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiEaSjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 14:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590D9159D;
        Tue, 31 May 2022 11:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F068C61197;
        Tue, 31 May 2022 18:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136A9C385A9;
        Tue, 31 May 2022 18:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654022362;
        bh=KgCpEMyJxQnsJEV+rCvfMHd/nBFucSHXe1H/DIHotl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eWs+l0W2pwhhSpOT+qukJT25IbE4mw5F9LS9DkYuLOXl21zqFiuvqQBP0XSK9+wcy
         +tNVu2sRDyYfKYQ4P258Tdr2oRcZRmWpd0UhF/vHlL4xEq+RcQuME3ss+iS6kfPl7E
         3W7L4/mGlcvwDDlTux3zOB1A6HeScsA6QqFkIPmWaeHof/0iJAy64oVQy/0pRHMUbp
         kxlVOYxU9K4Lk5PEPCASM0s1HMTAztFzaz7Vkd3UgvfnK9Frx4TNePslHFoGZSqcsm
         P5hrHEYZRKKkLHXuu+f4NtHj8ZYRvI/iOPii3LA+aOzaCYR9gX9pqyk1xBlxHSsDPU
         GoBB6FbpeC7rg==
Date:   Tue, 31 May 2022 13:39:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     subramanian.mohan@intel.com
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mallikarjunappa.sangannavar@intel.com,
        srikanth.thokala@intel.com
Subject: Re: [PATCH] PCI: vmd: Use devm_kasprintf instead of simple kasprintf
Message-ID: <20220531183920.GA770895@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531132617.20517-1-subramanian.mohan@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

I guess this is pure simplification, not a bug fix, since we *did*
free the buffer in the error path and in vmd_remove(), right?

> Suggested-by: Srikanth Thokala <srikanth.thokala@intel.com>
> Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
> Acked-by: Nirmal Patel <nirmal.patel@linux.intel.com>
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
