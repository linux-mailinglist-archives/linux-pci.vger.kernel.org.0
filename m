Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028EA40B962
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 22:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhINUld (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 16:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233145AbhINUld (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 16:41:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BED660FED;
        Tue, 14 Sep 2021 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631652015;
        bh=G6qy/eJfLrlW0dc677GgqYigdXmrXLbW1t4lBWM7zv4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UNbSYbx0i5R0051TDoHxgucE7n/xl95iQ4B8XqrFHxrs3lPZtmUk73H9hxaL5R0oX
         txN1opB9HYzZiyQV54Rqs813D9t+HUPI92kCBT5mbEA+MJaonNo83Xq57MU99wnnDU
         VwVypsq4OxgOoazbi9ZCq+Fm/sbjwSS3Sf75wu/ZUcbXFj2y1u3iGGVpR6v7kErINy
         +cLI9+8wALfugIz3lKoMz17J0JJ44Zqdk1wVgywFlciBwCl0DWABpp0n9NbJZw0C8T
         J3ikmqoAfxGmDIRID06B+qbKtTq+/839jOTdjY2IpN/wtuPlM9mrMSRxds+tvBjoxL
         yp2UjBbNjYZww==
Date:   Tue, 14 Sep 2021 15:40:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI/sysfs: Check CAP_SYS_ADMIN before parsing user
 input
Message-ID: <20210914204014.GA1455147@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210705212308.3050976-2-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 05, 2021 at 09:23:06PM +0000, Krzysztof Wilczyński wrote:
> Check if the "CAP_SYS_ADMIN" capability flag is set before parsing user
> input as it makes more sense to first check whether the current user
> actually has the right permissions before accepting any input from such
> user.
> 
> This will also make order in which enable_store() and msi_bus_store()
> perform the "CAP_SYS_ADMIN" capability check consistent with other
> PCI-related sysfs objects that first verify whether user has this
> capability set.

I like this one.  Can you rebase it to skip patch 1/4 (unless you
convince me that 1/4 is safe)?

> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/pci-sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 0f98c4843764..bc4c141e4c1c 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -275,13 +275,13 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	ssize_t result = 0;
>  
> -	if (kstrtobool(buf, &enable) < 0)
> -		return -EINVAL;
> -
>  	/* this can crash the machine when done on the "wrong" device */
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (kstrtobool(buf, &enable) < 0)
> +		return -EINVAL;
> +
>  	device_lock(dev);
>  	if (dev->driver)
>  		result = -EBUSY;
> @@ -377,12 +377,12 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct pci_bus *subordinate = pdev->subordinate;
>  
> -	if (kstrtobool(buf, &enable) < 0)
> -		return -EINVAL;
> -
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (kstrtobool(buf, &enable) < 0)
> +		return -EINVAL;
> +
>  	/*
>  	 * "no_msi" and "bus_flags" only affect what happens when a driver
>  	 * requests MSI or MSI-X.  They don't affect any drivers that have
> -- 
> 2.32.0
> 
