Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18601D36B6
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgENQmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 12:42:03 -0400
Received: from foss.arm.com ([217.140.110.172]:40370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgENQmD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 12:42:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D48861FB;
        Thu, 14 May 2020 09:42:00 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3065A3F71E;
        Thu, 14 May 2020 09:42:00 -0700 (PDT)
Date:   Thu, 14 May 2020 17:41:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] PCI: Fix pci_register_host_bridge()
 device_register() error handling
Message-ID: <20200514164154.GA24211@e121166-lin.cambridge.arm.com>
References: <20200513223859.11295-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513223859.11295-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
> ---
>  drivers/pci/probe.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
