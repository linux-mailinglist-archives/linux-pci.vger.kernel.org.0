Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164BC4F5DFF
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 14:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiDFMYR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 08:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiDFMXf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 08:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABA713F86;
        Wed,  6 Apr 2022 01:09:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B1960B1E;
        Wed,  6 Apr 2022 08:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65C3C385A1;
        Wed,  6 Apr 2022 08:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649232576;
        bh=goZBLwAg/DZhzYNdKCEzCGND7F9xwBbARNccVJHZ20o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7MFHBL8kTnITP06VCPKeg+RSuNthXQrEzl+3zsnZC7CwNsjzGGqO90VIPWO42YI2
         9CY1aZA1U4L3uSSb51+WK9/+o6J4ETlBUxGn6R6Rcbs2Na6wJNZU0hmfKGIqoiUJfd
         BiCg8k8fLTOYwlZSjM8+PyRBY1F0TgbGqq96F+Nw=
Date:   Wed, 6 Apr 2022 10:09:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI: sysfs: add bypass for config read admin check
Message-ID: <Yk1KveOnYfSrUJLD@kroah.com>
References: <20220406071131.2930035-1-stevensd@google.com>
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

On Wed, Apr 06, 2022 at 04:11:31PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Add a moduleparam that can be set to bypass the check that limits users
> without CAP_SYS_ADMIN to only being able to read the first 64 bytes of
> the config space. This allows systems without problematic hardware to be
> configured to allow users without CAP_SYS_ADMIN to read PCI
> capabilities.
> 
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

No, this is not the 1990's, please do not add system-wide module
parameters like this.  Especially ones that circumvent security
protections.

Also, where did you document this new option?

Why not just add this to a LSM instead?

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

This feels really dangerous.  What benifit are you getting here by
allowing an unpriviliged user to read this information?

What userspace problem are you trying to solve here that deserves this
change?

thanks,

greg k-h
