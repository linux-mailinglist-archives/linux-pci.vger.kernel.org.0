Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDA968E992
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 09:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjBHIJT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 03:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjBHIJS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 03:09:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7993BD84;
        Wed,  8 Feb 2023 00:09:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2455AB81C3B;
        Wed,  8 Feb 2023 08:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9D5C433EF;
        Wed,  8 Feb 2023 08:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675843754;
        bh=p/cu2EE0PL6kcAI9w+0dhQ76KmczGXbJVrX84SjEBjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCKyo3UJB5WGldndIGZuxRlj/sDgCZ+TK6zcCRwZIAuFyjAFOw2PhylYgcjgPIicA
         JWXNMyQmVRe17RMuKsVGM2HIhmyg4TqT5YjNPFSe/hI01pyyR7gWRYcrkR6cwaaGY4
         pVvy1q89Wq1DlIYz15ehQfGVy0kYOfB75HtmeWl4MPtG7POBL2tMmdoT+7OBi2c07j
         i8Ilj+gm8mwAjaDLbmXMT8s27OnE21Im3l1jHIr2tzaiIdKI+z1EaiuXi18VFmlOH8
         +pQXKSjdAZV8DX0T2rZHa7zeRY9cQUK/ZPZwAsBIpJQdufcVR3YBn0U0uhMA/yA56N
         mgPsHfH1q6TGw==
Date:   Wed, 8 Feb 2023 10:09:10 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Seunggyun Lee <sglee97@dankook.ac.kr>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci/mmap: add pci device EBUSY check
Message-ID: <Y+NYphb8hmzlVFaV@unreal>
References: <20230207113949.17943-1-sglee97@dankook.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207113949.17943-1-sglee97@dankook.ac.kr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 07, 2023 at 08:39:49PM +0900, Seunggyun Lee wrote:
> When using a pci device through the vfio-pci driver, other software was
> also able to access the pci device memory through sysfs.

And why is it wrong?

> 
> To prevent this, when mmap is performed through sysfs, a process of
> checking whether the device is in use is added.
> 
> Signed-off-by: Seunggyun Lee <sglee97@dankook.ac.kr>
> ---
>  drivers/pci/mmap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
> index 4504039056d1..4c9df2e23e03 100644
> --- a/drivers/pci/mmap.c
> +++ b/drivers/pci/mmap.c
> @@ -25,6 +25,8 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
>  {
>  	unsigned long size;
>  	int ret;
> +	if (pdev->driver)
> +		return -1;

I doubt that it is correct/needed as every call to
pci_mmap_resource_range() is guarded by iomem_is_exclusive() check.

Also I'm not sure that pdev->driver can be accessed without any lock in
this flow.

Thanks

>  
>  	size = ((pci_resource_len(pdev, bar) - 1) >> PAGE_SHIFT) + 1;
>  	if (vma->vm_pgoff + vma_pages(vma) > size)
> -- 
> 2.25.1
> 
