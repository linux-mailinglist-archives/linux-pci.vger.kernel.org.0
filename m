Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC56697A59
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 15:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfHUNIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 09:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfHUNI3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Aug 2019 09:08:29 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B1AF2339E;
        Wed, 21 Aug 2019 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566392909;
        bh=e14VTMsNwxA7Ghv8QAnsIB1kvLhHM18xsQFgrXEACNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4+uhL1MuZvKoV+gxQrT8q0kTYHp4prhnqmfRoJ/m4e6JVqT9nquVJIpnC8ciWInc
         qrlXmXRi90/7ywGmk0BflaHQAVm5rCJ65ItY8smBGGCM5eZittt9huICZs3aQz59pG
         S5CHBPLQvxBiZ/8JTfTaouN4WbpUokyIKvE36dNg=
Date:   Wed, 21 Aug 2019 08:08:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RFC/PATCH] PCI: Protect pci_reassign_bridge_resources() against
 concurrent addition/removal
Message-ID: <20190821130827.GF14450@google.com>
References: <02ca29627597445442bb14c069678e549429dace.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ca29627597445442bb14c069678e549429dace.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 24, 2019 at 02:32:19PM +1000, Benjamin Herrenschmidt wrote:
> pci_reassign_bridge_resources() can be called by pci_resize_resource()
> at runtime.
> 
> It will walk the PCI tree up and down, and isn't currently protected
> against any changes or hotplug operation.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to pci/resource for v5.4, thanks!

> ---
> 
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2104,6 +2104,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  	unsigned int i;
>  	int ret;
>  
> +	down_read(&pci_bus_sem);
> +
>  	/* Walk to the root hub, releasing bridge BARs when possible */
>  	next = bridge;
>  	do {
> @@ -2160,6 +2162,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  	}
>  
>  	free_list(&saved);
> +	up_read(&pci_bus_sem);
>  	return 0;
>  
>  cleanup:
> @@ -2188,6 +2191,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  		pci_setup_bridge(bridge->subordinate);
>  	}
>  	free_list(&saved);
> +	up_read(&pci_bus_sem);
>  
>  	return ret;
>  }
> 
