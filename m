Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6355A30DC
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 23:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiHZVOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 17:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiHZVOE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 17:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E562E58A9;
        Fri, 26 Aug 2022 14:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 858B161F68;
        Fri, 26 Aug 2022 21:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A498DC433C1;
        Fri, 26 Aug 2022 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661548442;
        bh=7azrnsiCu14tEupZXXCpNTjljV0a/zloctCANgEak44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kjbW75aBgkj/vd6Em/TorngQ+aIIuyl75Eb8oCububNQSjqk5bAkw8bPWCIqMYZfs
         09mAnflYPx+wM4D/DxksBBmfbTwIeyE4d36g3JSRF1V7qF+piTggxa2qdyhxNjejgQ
         gByqr/PuEZUWmYej2JmeJz9UfMk0m0L02ljQZSOGOWstnPXjI1KDBnhOjQ9zPiHkXT
         MRd4QcujuEV9qqi6F1jaSJ3cHHV69KNLkQbEVt4vnXTJPHmmsHVRQz/lT9lrSEv+vo
         VNiz8SlsYFBgKDOCeOUfLXR5ZtpBhsTMYCpaQ1rNy1nXxLeld/UCTZLKA9NyJ6w7p9
         JsxBDYm6A8Nmw==
Date:   Fri, 26 Aug 2022 16:14:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH -next 1/3] PCI: fix double put_device() in error case in
 pci_create_root_bus()
Message-ID: <20220826211401.GA2959769@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825122753.1838930-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

On Thu, Aug 25, 2022 at 08:27:51PM +0800, Yang Yingliang wrote:
> If device_add() fails in pci_register_host_bridge(), the brigde device will
> be put once, and it will be put again in error path of pci_create_root_bus().
> Move the put_device() from pci_create_root_bus() to pci_register_host_bridge()
> to fix this problem. And use device_unregister() instead of del_device() and
> put_device().

s/brigde/bridge/

> Fixes: 9885440b16b8 ("PCI: Fix pci_host_bridge struct device release/free handling")

If you're fixing a commit from somebody else, please always cc: the
author because the author can help review the change.

> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pci/probe.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c5286b027f00..e500eb9d6468 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1027,7 +1027,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  
>  unregister:
>  	put_device(&bridge->dev);
> -	device_del(&bridge->dev);
> +	device_unregister(&bridge->dev);

I don't understand this part.  device_unregister() looks like this:

  void device_unregister(struct device *dev)
  {
    device_del(dev);
    put_device(dev);
  }

So this calls put_device(&bridge->dev) twice, doesn't it?

The "unregister" label looks poorly named.  We only get there if
device_register() *failed*.  We shouldn't need to unregister anything
in that case.

>  free:
>  	kfree(bus);
> @@ -3037,13 +3037,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  
>  	error = pci_register_host_bridge(bridge);
>  	if (error < 0)
> -		goto err_out;
> +		return NULL;
>  
>  	return bridge->bus;
> -
> -err_out:
> -	put_device(&bridge->dev);
> -	return NULL;

This part looks right to me.  The get_device() is in
pci_register_host_bridge(), and if pci_register_host_bridge() returns
failure, I think it should first do the corresponding put_device().

>  }
>  EXPORT_SYMBOL_GPL(pci_create_root_bus);
>  
> -- 
> 2.25.1
> 
