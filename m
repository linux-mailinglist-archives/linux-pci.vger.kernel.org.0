Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2D1D4032
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 23:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgENViC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 17:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgENViC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 17:38:02 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48B2320709;
        Thu, 14 May 2020 21:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589492281;
        bh=RwuYZkt7WJHFil5hx9ssMf/OF/Z1FaWM63laCoQtpBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jha/DdRR33qk4/drdIkPP0DYXbcSu+iT7CIhAIjfqW32AJvvcwTnPfDosR8eXnRY8
         y2JkTKBsEUZogcTxrnKBQHX1xyPFC+ZR+dxPrkHvSi56VL7ogcrT9piHquZgHb5nlm
         ug9GJ2TYGBB58OQWY4rLrFL4/5kBdkeVAhROaDIk=
Date:   Thu, 14 May 2020 16:37:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] PCI: Fix pci_register_host_bridge()
 device_register() error handling
Message-ID: <20200514213759.GA473614@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513223859.11295-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 13, 2020 at 05:38:58PM -0500, Rob Herring wrote:
> If device_register() has an error, we should bail out of
> pci_register_host_bridge() rather than continuing on.
> 
> Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Both applied to pci/enumeration for v5.8, thanks!

> ---
>  drivers/pci/probe.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 77b8a145c39b..e21dc71b1907 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -909,9 +909,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  		goto free;
>  
>  	err = device_register(&bridge->dev);
> -	if (err)
> +	if (err) {
>  		put_device(&bridge->dev);
> -
> +		goto free;
> +	}
>  	bus->bridge = get_device(&bridge->dev);
>  	device_enable_async_suspend(bus->bridge);
>  	pci_set_bus_of_node(bus);
> -- 
> 2.20.1
> 
