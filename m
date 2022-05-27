Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332FE536616
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 18:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344760AbiE0QmM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiE0QmL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 12:42:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4417640A23;
        Fri, 27 May 2022 09:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1D9DB825AE;
        Fri, 27 May 2022 16:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD3DC385A9;
        Fri, 27 May 2022 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653669726;
        bh=zglyA33t8Bhax6x2hK4aQE0hBcZgy78FCZh1HsYWP5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EUJTlgaEE0bBgBJEX1j/V1QiUNB84hN62hWLTUgWBT/GgmTmH4ml4wmqQZ3+ntc2c
         zj9asOP0cokWrZSFx8ZpFaW+DmK5c19p2/gv3FM4pvCGbGOlSJVXuFARwx+sscy3MF
         LtFIMeQ0tg2OqnHm181tlZSHBYvZJOq+k8Fae/3TMPi+G8T1h0BbPVW4j+PgcUmgur
         5D/Sht8IQ+szcKsdce+wLh7oi90TxpjRwjQscR2tYDbMQlL1LxAncrbyyQAUYJRyrL
         MXA4XyDDu90ZMgkDKY2CsYDiTQQzkX0qd9vHQI+EtI1JCaUlTj+u0TOjDCyq7MRyUI
         ti7hwsBE1I92A==
Date:   Fri, 27 May 2022 11:42:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     keliu <liuke94@huawei.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, kurt.schwemmer@microsemi.com,
        logang@deltatee.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: pci: Directly use ida_alloc()/free()
Message-ID: <20220527164204.GA481720@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527072005.2360176-1-liuke94@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 27, 2022 at 07:20:05AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

I see you got some feedback about a full name already (here's a
reference:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.17#n407)
so I'll wait for the update.  When you do, please also update the
subject line to match previous drivers/pci/ history (use
"git log --oneline drivers/pci/" to see it).

The patch itself looks good to me.  Thanks for doing this!

> ---
>  drivers/pci/controller/vmd.c   | 6 +++---
>  drivers/pci/switch/switchtec.c | 7 +++----
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index eb05cceab964..efcb3a3ca65e 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -893,7 +893,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		return -ENOMEM;
>  
>  	vmd->dev = dev;
> -	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
> +	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
>  	if (vmd->instance < 0)
>  		return vmd->instance;
>  
> @@ -934,7 +934,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	return 0;
>  
>   out_release_instance:
> -	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> +	ida_free(&vmd_instance_ida, vmd->instance);
>  	kfree(vmd->name);
>  	return err;
>  }
> @@ -957,7 +957,7 @@ static void vmd_remove(struct pci_dev *dev)
>  	vmd_cleanup_srcu(vmd);
>  	vmd_detach_resources(vmd);
>  	vmd_remove_irq_domain(vmd);
> -	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> +	ida_free(&vmd_instance_ida, vmd->instance);
>  	kfree(vmd->name);
>  }
>  
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index c36c1238c604..75be4fe22509 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1376,8 +1376,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
>  	dev->groups = switchtec_device_groups;
>  	dev->release = stdev_release;
>  
> -	minor = ida_simple_get(&switchtec_minor_ida, 0, 0,
> -			       GFP_KERNEL);
> +	minor = ida_alloc(&switchtec_minor_ida, GFP_KERNEL);
>  	if (minor < 0) {
>  		rc = minor;
>  		goto err_put;
> @@ -1692,7 +1691,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
>  err_devadd:
>  	stdev_kill(stdev);
>  err_put:
> -	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
> +	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>  	put_device(&stdev->dev);
>  	return rc;
>  }
> @@ -1704,7 +1703,7 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
>  	pci_set_drvdata(pdev, NULL);
>  
>  	cdev_device_del(&stdev->cdev, &stdev->dev);
> -	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
> +	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>  	dev_info(&stdev->dev, "unregistered.\n");
>  	stdev_kill(stdev);
>  	put_device(&stdev->dev);
> -- 
> 2.25.1
> 
