Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014D2699BBD
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 19:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjBPSCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 13:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjBPSB6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 13:01:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B253A87D;
        Thu, 16 Feb 2023 10:01:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A8A62058;
        Thu, 16 Feb 2023 18:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1894BC433D2;
        Thu, 16 Feb 2023 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676570516;
        bh=BKZpcfBPqkmkKr8H1rBrV++rPdS3LX38h2UDgL1OtX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZDOXjn37te66mMdvuohiM2mnWJWZtG2TBtWS4idX43TKWBhnvs6GK6XUwAaZc/+rK
         dwyAXHFGx1MFiZSAejUbX1DRC4R4OnrjWwS3AGru3Fb7k8Iw3CUDhbMFJ84duCK7DD
         Pu1OkEWSIn4Zk6XBxhz9g8BG9x9PFJA1zzLYqhbigekJmNkuKYBrGA3p3yRzdAQzJw
         PyJR2K2XeVBDoVs8rySrQcRWUBU/f4CWV73/9MFW1N9dkhvM4i9KpJM9Q9LYTS9Ijo
         TqBdtBIdPDmwj/7oYO2fL3A4XbeyoDp7aNz8SBi2GfJ4VYyMCeSsj8sSskMNp7pY9d
         wJ/IQK5W3TACQ==
Date:   Thu, 16 Feb 2023 12:01:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Make kobj_type structure constant
Message-ID: <20230216180154.GA3322464@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216-kobj_type-pci-v1-1-46a63c8612b5@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 16, 2023 at 01:12:25AM +0000, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied to pci/misc for v6.13, thanks, Thomas!

> ---
>  drivers/pci/slot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index a0c67191a8b9..0f87cade10f7 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -98,7 +98,7 @@ static struct attribute *pci_slot_default_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(pci_slot_default);
>  
> -static struct kobj_type pci_slot_ktype = {
> +static const struct kobj_type pci_slot_ktype = {
>  	.sysfs_ops = &pci_slot_sysfs_ops,
>  	.release = &pci_slot_release,
>  	.default_groups = pci_slot_default_groups,
> 
> ---
> base-commit: 033c40a89f55525139fd5b6342281b09b97d05bf
> change-id: 20230216-kobj_type-pci-56120c1c0bcb
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
