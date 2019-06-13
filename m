Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E944EB6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 23:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFMVuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 17:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfFMVuL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 17:50:11 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4367821537;
        Thu, 13 Jun 2019 21:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560462610;
        bh=qCRcrp0HOwMnB3fac1d2H0LwpHaQcFZWwqb+IXLewTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdSryiXB4u6olTXPqQYTrJoZCLs/5VXjUqYqj42vzt2Nv+Gk8d6CBwA/VOn4D19t4
         tr+KdWXKOqSyXbEx7HkRuwyomr2PzNM980WkOAlbG5ZL/yzFSPVP7gSerU8Eqj1oVB
         nEL0bsyJJLHV/pSK1y7Vft1dTgZQigFwzTLya7yA=
Date:   Thu, 13 Jun 2019 16:50:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        myron.stowe@redhat.com, bodong@mellanox.com, eli@mellanox.com,
        laine@redhat.com
Subject: Re: [PATCH] PCI: Always allow probing with driver_override
Message-ID: <20190613215008.GN13533@google.com>
References: <155742996741.21878.569845487290798703.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155742996741.21878.569845487290798703.stgit@gimli.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 09, 2019 at 01:27:22PM -0600, Alex Williamson wrote:
> Commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control
> VF driver binding") introduced the sriov_drivers_autoprobe attribute
> which allows users to prevent the kernel from automatically probing a
> driver for new VFs as they are created.  This allows VFs to be spawned
> without automatically binding the new device to a host driver, such as
> in cases where the user intends to use the device only with a meta
> driver like vfio-pci.  However, the current implementation prevents any
> use of drivers_probe with the VF while sriov_drivers_autoprobe=0.  This
> blocks the now current general practice of setting driver_override
> followed by using drivers_probe to bind a device to a specified driver.
> 
> The kernel never automatically sets a driver_override therefore it seems
> we can assume a driver_override reflects the intent of the user.  Also,
> probing a device using a driver_override match seems outside the scope
> of the 'auto' part of sriov_drivers_autoprobe.  Therefore, let's allow
> driver_override matches regardless of sriov_drivers_autoprobe, which we
> can do by simply testing if a driver_override is set for a device as a
> 'can probe' condition.
> 
> Fixes: 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control VF driver binding")
> Link: https://lore.kernel.org/linux-pci/155672991496.20698.4279330795743262888.stgit@gimli.home/T/#u
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/enumeration for v5.3, thanks!

> ---
> 
>  drivers/pci/pci-driver.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index da7b82e56c83..9b9e9c63cde8 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -399,7 +399,8 @@ void __weak pcibios_free_irq(struct pci_dev *dev)
>  #ifdef CONFIG_PCI_IOV
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
>  {
> -	return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe);
> +	return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe ||
> +		pdev->driver_override);
>  }
>  #else
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
> 
