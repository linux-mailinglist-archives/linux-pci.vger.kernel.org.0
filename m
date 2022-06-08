Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE40543BA7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiFHSnI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 14:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiFHSnH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 14:43:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576ADEE1E;
        Wed,  8 Jun 2022 11:43:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A921B829B2;
        Wed,  8 Jun 2022 18:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23F3C34116;
        Wed,  8 Jun 2022 18:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654713783;
        bh=1lTy5PQ0SFGzkGUqaYHmRDQ8yiwyaBVzGE72ZDPIL3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bJ73OBFrjMuLws5xL9fP8cECTZLtQdsEK62y98gDvKx8FFjvur41RIvQLDb7j5ikV
         On+qj2EwGSGWhc4f4lnrM+RsTwueuriHNq+lEJZZH5X722mbH73w4LHtAXdpBP+1EJ
         B3mJj5UbuqUzBoBhINhOIv4II3LgQO9ont6PUioZhclgaOXFViMsoYeBzQuNYVGttN
         tTbaPgR2g3VvStP016hTL/FkWQsE5Ddna+xYyst+LgzJshDlpr+IKQEckbTU7Nj112
         Lm2nmqOUJLBKTbSYwdr4Dr1omKtTSba4QEcy1keErFsBUVvdqi7DdZeYsotQxSqsT6
         +t6zgjJEkDvGw==
Date:   Wed, 8 Jun 2022 13:42:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ke Liu <liuke94@huawei.com>
Cc:     bhelgaas@google.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, kurt.schwemmer@microsemi.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: pci: Directly use ida_alloc()/free()
Message-ID: <20220608184259.GA410049@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602071115.3833935-1-liuke94@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 07:11:15AM +0000, Ke Liu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove().
> 
> Signed-off-by: Ke Liu <liuke94@huawei.com>

I'd like acks from a vmd maintainer (Nirmal) and a switchtec
maintainer (Kirt, Logan) before applying this.

You don't need to post this again with those acks, but if you do post
it again for some reason, take note of the subject line history; see
"git log --oneline drivers/pci/controller/ drivers/pci/switch/"

> ---
> v2	fix sign-off name suggest by Bjorn Helgaas
> ---
>  drivers/pci/controller/vmd.c   | 6 +++---
>  drivers/pci/switch/switchtec.c | 7 +++----
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 94a14a3d7e55..49c72c2d8fe7 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -894,7 +894,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		return -ENOMEM;
>  
>  	vmd->dev = dev;
> -	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
> +	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
>  	if (vmd->instance < 0)
>  		return vmd->instance;
>  
> @@ -935,7 +935,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	return 0;
>  
>   out_release_instance:
> -	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> +	ida_free(&vmd_instance_ida, vmd->instance);
>  	kfree(vmd->name);
>  	return err;
>  }
> @@ -958,7 +958,7 @@ static void vmd_remove(struct pci_dev *dev)
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
