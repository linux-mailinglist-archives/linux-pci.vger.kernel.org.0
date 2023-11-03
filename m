Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7017E0868
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 19:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjKCSqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 14:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjKCSqT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 14:46:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6099D5B;
        Fri,  3 Nov 2023 11:46:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17007C433C7;
        Fri,  3 Nov 2023 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699037176;
        bh=P0GHG19/4iw0ox6hx9mtG+hToP4M7ROVdsXTBzKx6co=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NjTYtwdD39CobA/RYnvoO4jFK5jr1tJlkWbdXavgMSmbgpy5mMFbiAuIGIQl77NXd
         +rz9X92g+RAhLAbu0ovkBHyxewswxAe04PF/+yX6YbqUEZCSgIjZgsO6f/rT89sHrF
         CUTucvG+YZeu9C2kyEuWZsPyDPiK3b7F7xPqUJ6Hk7FV++2vi2Fvru0cPoVcsSBItb
         JXUWBEFcBD7X4EB+KSVa3oJOeGiqyhf2DtjT4aiNCEY43MFwaCEA/FgwzZw5h8oT2T
         eLh7+j/rUW4Sok+LRnTPTr1Bo/i63SRay1BOwDsLQsJWQVx5PdKbn/j24J74z2oFvh
         IllzhgKSuSTFQ==
Date:   Fri, 3 Nov 2023 13:46:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH v1 1/1] PCI: Avoid potential out-of-bounds read in
 pci_dev_for_each_resource()
Message-ID: <20231103184614.GA163110@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030114218.2752236-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 30, 2023 at 01:42:18PM +0200, Andy Shevchenko wrote:
> Coverity complains that pointer in the pci_dev_for_each_resource()
> may be wrong, i.e. mighe be used for the out-of-bounds read.
> 
> There is no actual issue right now, because we have another check
> afterwards and the out-of-bounds read is not being performed. In any
> case it's better code with this get fixed, hence the proposed change.
> 
> As Jonas pointed out "It probably makes the code slightly less
> performant as res will now be checked for being not NULL (which will
> always be true), but I doubt it will be significant (or in any hot
> paths)."
> 
> Fixes: 09cc90063240 ("PCI: Introduce pci_dev_for_each_resource()")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/r/20230509182122.GA1259567@bhelgaas
> Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, Andy, I'll look at this soon after v6.7-rc1 (probably Nov 12).

> ---
>  include/linux/pci.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60ca768bc867..19adad23a204 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2127,14 +2127,14 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
>  	(pci_resource_end((dev), (bar)) ? 				\
>  	 resource_size(pci_resource_n((dev), (bar))) : 0)
>  
> -#define __pci_dev_for_each_res0(dev, res, ...)				\
> -	for (unsigned int __b = 0;					\
> -	     res = pci_resource_n(dev, __b), __b < PCI_NUM_RESOURCES;	\
> +#define __pci_dev_for_each_res0(dev, res, ...)					\
> +	for (unsigned int __b = 0;						\
> +	     __b < PCI_NUM_RESOURCES && (res = pci_resource_n(dev, __b));	\
>  	     __b++)
>  
> -#define __pci_dev_for_each_res1(dev, res, __b)				\
> -	for (__b = 0;							\
> -	     res = pci_resource_n(dev, __b), __b < PCI_NUM_RESOURCES;	\
> +#define __pci_dev_for_each_res1(dev, res, __b)					\
> +	for (__b = 0;								\
> +	     __b < PCI_NUM_RESOURCES && (res = pci_resource_n(dev, __b));	\
>  	     __b++)
>  
>  #define pci_dev_for_each_resource(dev, res, ...)			\
> -- 
> 2.40.0.1.gaa8946217a0b
> 
