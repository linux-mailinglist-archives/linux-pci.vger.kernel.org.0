Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657BB776F56
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 07:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjHJFFR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 01:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjHJFFQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 01:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFBA92;
        Wed,  9 Aug 2023 22:05:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8E8460C55;
        Thu, 10 Aug 2023 05:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C926AC433C8;
        Thu, 10 Aug 2023 05:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691643915;
        bh=5A1FLVCqrQmsr8whzreucNA43gKeahzNaAsG6pZWOxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2PTM9wrDOsnxVtbTkERfeUc7djBxJeawmoecvoI088U2fVAJFiBowX3X3IOM85j26
         2V8141Iu/vSpO43+Gnis0dN7Jo6gnLr2LGGajCTrW3ZHKzAej8BnSKmiB8Y8YgHf5+
         bquTyHbz4UxtCUfboaxstzUsrM8V4tXJPnvTyLBg=
Date:   Thu, 10 Aug 2023 07:05:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <2023081005-ground-muster-63c8@gregkh>
References: <20230809232851.1004023-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809232851.1004023-1-alistair.francis@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 07:28:51PM -0400, Alistair Francis wrote:
> The PCIe 6 specification added support for the Data Object Exchange (DOE).
> When DOE is supported the Discovery Data Object Protocol must be
> implemented. The protocol allows a requester to obtain information about
> the other DOE protocols supported by the device.
> 
> The kernel is already querying the DOE protocols supported and cacheing
> the values. This patch exposes the values via sysfs. This will allow
> userspace to determine which DOE protocols are supported by the PCIe
> device.
> 
> By exposing the information to userspace tools like lspci can relay the
> information to users. By listing all of the supported protocols we can
> allow userspace to parse and support the list, which might include
> vendor specific protocols as well as yet to be supported protocols.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>  - Expose each DOE feature as a separate file

But you don't actually have anything in the sysfs files, why not?

> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -56,6 +56,10 @@ struct pci_doe_mb {
>  	wait_queue_head_t wq;
>  	struct workqueue_struct *work_queue;
>  	unsigned long flags;
> +
> +#ifdef CONFIG_SYSFS
> +	struct device_attribute *sysfs_attrs;
> +#endif

Please don't put #ifdefs in .c files if you can prevent it.  I think
this will work just fine if you don't have the #ifdef.  And who would be
using pci without sysfs?

> +		attrs[i].attr.mode = 0444;
> +		attrs[i].show = NULL;

Why set to NULL something that is already NULL?  Did you just forget to
actually set the proper show callback here?

> +#ifdef CONFIG_PCI_DOE
> +	retval = doe_sysfs_init(pdev);
> +	if (retval)
> +		return retval;
> +#endif

Again, no #ifdef in .c files please, put this in the .h file like
normal.

thanks,

greg k-h
