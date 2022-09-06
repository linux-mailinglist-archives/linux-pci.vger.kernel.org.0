Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067CC5AF6DF
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 23:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIFVdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIFVdC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:33:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038FBB5E54;
        Tue,  6 Sep 2022 14:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA550B81A50;
        Tue,  6 Sep 2022 21:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12491C433D6;
        Tue,  6 Sep 2022 21:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662499979;
        bh=/rRirmx2WKlA8STHOH+EvLi0TzK5ylTe8NH36YqtFW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PQle1Ma/wSyg/bOlF//cxoeDyslBDocy5hCoBnXZLTVl4RxwztLVS89djPusyPo5h
         x+X7RBRrpVhufQEKi3Ay3c4sG7n7p3OZTK6hw3THgHq8XtxogPlVBd8vJ6qQYZUAVu
         HkujmVZ4mZMxHdIydCqTKDDLSstqfrqM+qO2MP1i3mZsSxUBxvl3chTQTKQ0RJnUlA
         PJrT25Y30Q+x0fXSRE8yMOG6FtZ/1GGz+FOO5HFXD/q7TmNV44dN5p2+sc5uzZ8gIF
         mYO+1vzHVYlomlquB/2FCCFN+NN0f6iB+igs26CWMG509wEScnQfaT2O8lZSnpmwTJ
         iRp16qZ9NK9rQ==
Date:   Tue, 6 Sep 2022 16:32:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jingyu Wang <jingyuwang_vip@163.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: cleanup coding styling in pci-driver.c
Message-ID: <20220906213257.GA45793@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905140136.25066-1-jingyuwang_vip@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 10:01:36PM +0800, Jingyu Wang wrote:
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>

I'm not going to take this because:

  - Subject line doesn't follow drivers/pci capitalization convention.

  - Minor style changes by themselves aren't really worth it unless
    you are also doing more substantive improvements.

  - It contains a non-cosmetic return value change (ENOSYS/ENODEV)
    that is unrelated to the rest and not mentioned in the commit log.

> ---
>  drivers/pci/pci-driver.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 49238ddd39ee..bba486f5e5fe 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -204,6 +204,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
>  
>  	if (fields != 7) {
>  		struct pci_dev *pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
> +
>  		if (!pdev)
>  			return -ENOMEM;
>  
> @@ -222,8 +223,8 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
>  			return retval;
>  	}
>  
> -	/* Only accept driver_data values that match an existing id_table
> -	   entry */
> +	/* Only accept driver_data values that match an existing id_table entry
> +	 */
>  	if (ids) {
>  		retval = -EINVAL;
>  		while (ids->vendor || ids->subvendor || ids->class_mask) {
> @@ -272,6 +273,7 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
>  	spin_lock(&pdrv->dynids.lock);
>  	list_for_each_entry_safe(dynid, n, &pdrv->dynids.list, node) {
>  		struct pci_device_id *id = &dynid->id;
> +
>  		if ((id->vendor == vendor) &&
>  		    (id->device == device) &&
>  		    (subvendor == PCI_ANY_ID || id->subvendor == subvendor) &&
> @@ -537,6 +539,7 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
>  
>  	if (pci_dev->current_state != PCI_D0) {
>  		int error = pci_set_power_state(pci_dev, PCI_D0);
> +
>  		if (error)
>  			return error;
>  	}
> @@ -705,6 +708,7 @@ static int pci_pm_prepare(struct device *dev)
>  
>  	if (pm && pm->prepare) {
>  		int error = pm->prepare(dev);
> +
>  		if (error < 0)
>  			return error;
>  
> @@ -1364,7 +1368,7 @@ static int pci_pm_runtime_idle(struct device *dev)
>  		return 0;
>  
>  	if (!pm)
> -		return -ENOSYS;
> +		return -ENODEV;
>  
>  	if (pm->runtime_idle)
>  		return pm->runtime_idle(dev);
> @@ -1471,6 +1475,7 @@ struct pci_driver *pci_dev_driver(const struct pci_dev *dev)
>  		return dev->driver;
>  	else {
>  		int i;
> +
>  		for (i = 0; i <= PCI_ROM_RESOURCE; i++)
>  			if (dev->resource[i].flags & IORESOURCE_BUSY)
>  				return &pci_compat_driver;
> 
> base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
> -- 
> 2.34.1
> 
