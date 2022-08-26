Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04D35A321D
	for <lists+linux-pci@lfdr.de>; Sat, 27 Aug 2022 00:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbiHZWiQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 18:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiHZWiP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 18:38:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A32E68D6;
        Fri, 26 Aug 2022 15:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7375AB83342;
        Fri, 26 Aug 2022 22:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2097C433C1;
        Fri, 26 Aug 2022 22:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661553492;
        bh=2x8oP1av/GgT8wp1V9gUhZRtYrQh72Wv7er/tjyinjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ALuZPJWezJXRb3tYWtqYGTLy6XeWMSS4Vq8DUkpHSm9lZPvL6w988PTfJN779hiKH
         okGVloewqOtEkX2cE2Osvtrpc5LAAW8KXfswXk4m4mnKQzShUzD7me7KeLLrQx3feA
         46cnW2wwoEABzc6ThPnVEk0aPXpB3K6vBiJcx+Im3YTEWpbZpeKFafeTNKrv7eFHiD
         24rE1LRk2UcBxAOufVNnKZOLgXg9jI+hES0H8YYj9Q5sm6/uIj6cxzQ07zNVVrpUr7
         XQZqK38+/pdBJmhaffDINEUB/yOju2oAKDVY/3ISuApnAYaMni5s9tGWA3zyxxgxzg
         gkdKHyBd9rdOg==
Date:   Fri, 26 Aug 2022 17:38:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH -next 2/3] PCI: fix possible memory leak in error case in
 pci_register_host_bridge()
Message-ID: <20220826223810.GA2961041@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825122753.1838930-2-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Arnd, Rob]

On Thu, Aug 25, 2022 at 08:27:52PM +0800, Yang Yingliang wrote:
> If device_register() fails in pci_register_host_bridge(), the refcount
> of bus device is leaked, so device name that set by dev_set_name() can
> not be freed. Fix this by calling put_device() when device_register()
> fails, so the device name will be freed in kobject_cleanup().
>
> Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pci/probe.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e500eb9d6468..292d9da146ce 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -948,8 +948,17 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	name = dev_name(&bus->dev);
>  
>  	err = device_register(&bus->dev);
> -	if (err)
> -		goto unregister;
> +	if (err) {
> +		/*
> +		 * release_pcibus_dev() will decrease the refcount of bridge
> +		 * device and free the memory of bus.
> +		 * The memory of bus device name will be freed when the refcount
> +		 * get to zero.
> +		 */
> +		put_device(&bus->dev);
> +		device_unregister(&bridge->dev);
> +		return err;
> +	}

Calling put_device(X) after device_register(X) returns failure doesn't
need explanation because that's the standard pattern.  I think that
was just missing before.

In this error case, we previously did called put_device() for the
*bridge* instead of the bus.  That was likely a typo and seems like
the important thing here.

>  	pcibios_add_bus(bus);
>  
> @@ -1025,10 +1034,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  
>  	return 0;
>  
> -unregister:
> -	put_device(&bridge->dev);
> -	device_unregister(&bridge->dev);
> -
>  free:
>  	kfree(bus);
>  	return err;
> -- 
> 2.25.1
> 
