Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA02D79D3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 16:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405027AbgLKPrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 10:47:53 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41122 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbgLKPrf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 10:47:35 -0500
Received: by mail-oi1-f196.google.com with SMTP id 15so10264841oix.8;
        Fri, 11 Dec 2020 07:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xDsLY5toXg//VxcXGzy5JqaCKZTPLtUIx6A9MNnFwrs=;
        b=FaKOfvAspJyyxxnFpn471ObuyhZfSJauAnSRYzJ6qzFOdF0GshJOUjVA4urq0bGsY4
         2t8UwEr2Uj72QQcXsCkHWkFBMqW2MYb7uOPUKmve6QtoFIj3HF1z4524TvZWH5yKVuwG
         LfXKgN9sTlHvC49svUEoyfPqJQVZgdT45+FR3InXeZJ5UwBz8YJVWpRLtI1GN5nZZ9Yx
         RIbASCFyKLqPJPTgrLyxRi1MqpX+MB4Fl+eDv3gDGHzn+RdCf+taTkGpZwA9XU86Ab9T
         wkUYUF1m9a6Bn9iuGA/UdVretduPgEbKjV3uFWhzBsx9u0pLpovFg5EIoNY2L4K7vEv+
         fEXw==
X-Gm-Message-State: AOAM531VD+eOUZYwhCY1kjpfB6dh1SdAGHLoaB00HJf1jpxDJguFqDFP
        MhL8gNAMQzpRyNiAzrkabw==
X-Google-Smtp-Source: ABdhPJz9RSdLsVAV1MSmPfnRJf6AhUickmg/zkRj6FStNxymkRRK8pQiN0v/RAdWhEN7+yZ4Ns9+1Q==
X-Received: by 2002:aca:d908:: with SMTP id q8mr9761566oig.161.1607701614041;
        Fri, 11 Dec 2020 07:46:54 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y8sm1638720oix.43.2020.12.11.07.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 07:46:53 -0800 (PST)
Received: (nullmailer pid 345121 invoked by uid 1000);
        Fri, 11 Dec 2020 15:46:52 -0000
Date:   Fri, 11 Dec 2020 09:46:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: fix use-after-free in pci_register_host_bridge
Message-ID: <20201211154652.GA313883@robh.at.kernel.org>
References: <20201120074848.31418-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120074848.31418-1-miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 20, 2020 at 03:48:48PM +0800, Qinglang Miao wrote:
> When put_device(&bridge->dev) being called, kfree(bridge) is inside
> of release function, so the following device_del would cause a
> use-after-free bug.
> 
> Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")

That commit did have some problems, but this patch doesn't apply to that 
commit. See commits 1b54ae8327a4 and 9885440b16b8.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4289030b0..82292e87e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -991,8 +991,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	return 0;
>  
>  unregister:
> -	put_device(&bridge->dev);
>  	device_del(&bridge->dev);
> +	put_device(&bridge->dev);

I don't think this is right. 

Let's look at pci_register_host_bridge() with only the relevant 
sections:

static int pci_register_host_bridge(struct pci_host_bridge *bridge)
{
	...

	err = device_add(&bridge->dev);
	if (err) {
		put_device(&bridge->dev);
		goto free;
	}
	bus->bridge = get_device(&bridge->dev);

        ...
	if (err)
		goto unregister;
	...

	return 0;

unregister:
	put_device(&bridge->dev);
	device_del(&bridge->dev);

free:
	kfree(bus);
	return err;
}

The documentation for device_add says this:
 * Rule of thumb is: if device_add() succeeds, you should call
 * device_del() when you want to get rid of it. If device_add() has
 * *not* succeeded, use *only* put_device() to drop the reference
 * count.

The put_device at the end is to balance the get_device after device_add. 
It will *only* decrement the use count. Then we call device_del as the 
documentation says.

Rob
