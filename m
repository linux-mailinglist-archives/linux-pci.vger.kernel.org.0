Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC272435804
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 03:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhJUBC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 21:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJUBC7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Oct 2021 21:02:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 866A86109F;
        Thu, 21 Oct 2021 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634778044;
        bh=k99wuXsaylfYov8RVTNBZrBrDeSF4wpxhJLFuC19V+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rcCFedztLvwxIYWKi6DDMqKdho3My4jT/O1z82+nOGB1PumQ41oPVhfJ4kGIod7JN
         D1VO+PPUm2ydatp85xMdRqeWx+ziW3AKzsqzJTPZZfzBzhP/cwUJTHw6XD72lKVYbc
         0iLFHb7CNRt0kk4hOnY7Takz7RDKTTFIkfDhxvlaYSADUG1liN1lwJ2EDg6wu3Yqza
         E9jCoTyGiJ4QXRD9PZdJyXr/bJ3tUZfvJ7A6kprxHnJVKr8EQqKZk1xfKUH7WhLK5W
         +UyRMAJXgGChu2FD2Gh5pL9fBvp8c7nT745h7d001szIn3NzBYgTS9b3Q+G+Y6odc8
         RjCJnDG9yHtNg==
Date:   Wed, 20 Oct 2021 20:00:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: PM: Fix ordering of operations in
 pci_back_from_sleep()
Message-ID: <20211021010041.GA2655223@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11844217.O9o76ZdvQC@kreacher>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 06:45:59PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ordering of operations in pci_back_from_sleep() is incorrect,
> because the device may be in D3cold when it runs and pci_enable_wake()
> needs to access the device's configuration space which cannot be
> done in D3cold.
> 
> Fix this by calling pci_set_power_state() to put the device into D0
> before calling pci_enable_wake() for it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> ---
>  drivers/pci/pci.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -2638,8 +2638,13 @@ EXPORT_SYMBOL(pci_prepare_to_sleep);
>   */
>  int pci_back_from_sleep(struct pci_dev *dev)
>  {
> +	int ret = pci_set_power_state(dev, PCI_D0);
> +
> +	if (ret)
> +		return ret;
> +
>  	pci_enable_wake(dev, PCI_D0, false);
> -	return pci_set_power_state(dev, PCI_D0);
> +	return 0;
>  }
>  EXPORT_SYMBOL(pci_back_from_sleep);
>  
> 
> 
> 
