Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483214F6083
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiDFNtu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 09:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiDFNtc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 09:49:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00B66D1B68;
        Wed,  6 Apr 2022 04:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68401B82014;
        Wed,  6 Apr 2022 11:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE273C385A3;
        Wed,  6 Apr 2022 11:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649243874;
        bh=7LHnVNHcEpVspRSCfG1S+Ca+XYKk7J8eU7YTFtzdfYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r3tjcj3EM5yCFNFZOvxZ8VmWUC2KgykSEsAsh26vJHbZc8GehVMB58ImJfzOJOCHN
         l/CUQltVX6S2BK5NhGYZXYg3+G2gPIQs0mQ4eV08paTjUnMv0bjJ3PVX2Rgta96Yi6
         2eoZUhFtXk313tib0tsUbGV+TaWqT7ORMqxgFzcUCM69x/46qwOlm/IofdiVsLTEgk
         Nu9LhLVwZXaxDAn0DJQMiADlfyf02NHxANnWXmIfV+t7i/Po4ycMjfPE6p7raFdVxY
         urq7Fm9JuXlK1DbDwfohaxpaxD0b4LzIyqS3GWDXrBra9Ei7t0lceqh95uADMOcL6B
         9olZAcSnD8m1g==
Date:   Wed, 6 Apr 2022 06:17:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC] PCI: sysfs: add bypass for config read admin check
Message-ID: <20220406111751.GA132418@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406071131.2930035-1-stevensd@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kees]

On Wed, Apr 06, 2022 at 04:11:31PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Add a moduleparam that can be set to bypass the check that limits users
> without CAP_SYS_ADMIN to only being able to read the first 64 bytes of
> the config space. This allows systems without problematic hardware to be
> configured to allow users without CAP_SYS_ADMIN to read PCI
> capabilities.

Can you expand this a bit to explain the purpose of this?  I guess it
makes "lspci -v" work without having to be root?  How much of a
problem is that?  Is there some specific use case that needs this
change?  Maybe there's some way to address that without having to add
a new parameter that bypasses CAP_SYS_ADMIN.

> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  drivers/pci/pci-sysfs.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 602f0fb0b007..162423b3c052 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -28,10 +28,17 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
> +#include <linux/moduleparam.h>
>  #include "pci.h"
>  
>  static int sysfs_initialized;	/* = 0 */
>  
> +static bool allow_unsafe_config_reads;
> +module_param_named(allow_unsafe_config_reads,
> +		   allow_unsafe_config_reads, bool, 0644);
> +MODULE_PARM_DESC(allow_unsafe_config_reads,
> +		 "Enable full read access to config space without CAP_SYS_ADMIN.");
> +
>  /* show configuration fields */
>  #define pci_config_attr(field, format_string)				\
>  static ssize_t								\
> @@ -696,7 +703,8 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
>  	u8 *data = (u8 *) buf;
>  
>  	/* Several chips lock up trying to read undefined config space */
> -	if (file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
> +	if (allow_unsafe_config_reads ||
> +	    file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
>  		size = dev->cfg_size;
>  	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
>  		size = 128;
> -- 
> 2.35.1.1094.g7c7d902a7c-goog
> 
