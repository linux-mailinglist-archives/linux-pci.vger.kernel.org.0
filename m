Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DDA41BAD4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 01:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243209AbhI1XMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 19:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243184AbhI1XMy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 19:12:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1040A60EBB;
        Tue, 28 Sep 2021 23:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632870674;
        bh=cXqmRHBf3XWqhUKDHc2teaZeTbvm0dbN9oska0upCDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JQrLv0Ti6psJ9X/gj6ekRviIJx0fo0X1EBBiSmqVpzLuLzjUMLqtb7U+QCYnTrNL8
         nag/nfKh7qK8o3EvykVaU+aQYar4wCpkQdr+EwcEN6jy2lbyzOhSAFORZaiaez+ttj
         ZwlC/hzkUQexgqUifU+nWqW7ZdJ8ccFia9bd/CMw/jjqGV7Wale9PndLK2nZC0fNTW
         YAa/G1ra4PpqUp4ZXbeNaglFosfG85Seb395f+BjUhzQ3iCpyel4rCMrOvD37rRoy4
         dh9wUSgkbYgDkmrzop7A7E5EdUc2XrnlYl8xCgAOlCaLxPxcNBp9G9DvorXu2jM38y
         u8pD+zV+s2DyQ==
Date:   Tue, 28 Sep 2021 18:11:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI/sysfs: Check CAP_SYS_ADMIN before parsing
 user input
Message-ID: <20210928231112.GA746991@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210915230127.2495723-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 15, 2021 at 11:01:25PM +0000, Krzysztof Wilczyński wrote:
> Check if the "CAP_SYS_ADMIN" capability flag is set before parsing user
> input as it makes more sense to first check whether the current user
> actually has the right permissions before accepting any input from such
> user.
> 
> This will also make order in which enable_store() and msi_bus_store()
> perform the "CAP_SYS_ADMIN" capability check consistent with other
> PCI-related sysfs objects that first verify whether user has this
> capability set.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied all three to pci/sysfs for v5.16, thanks!

> ---
>  drivers/pci/pci-sysfs.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7fb5cd17cc98..6832e161be1c 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -273,15 +273,16 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	unsigned long val;
> -	ssize_t result = kstrtoul(buf, 0, &val);
> -
> -	if (result < 0)
> -		return result;
> +	ssize_t result;
>  
>  	/* this can crash the machine when done on the "wrong" device */
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	result = kstrtoul(buf, 0, &val);
> +	if (result < 0)
> +		return result;
> +
>  	device_lock(dev);
>  	if (dev->driver)
>  		result = -EBUSY;
> @@ -378,12 +379,12 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
>  	struct pci_bus *subordinate = pdev->subordinate;
>  	unsigned long val;
>  
> -	if (kstrtoul(buf, 0, &val) < 0)
> -		return -EINVAL;
> -
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
>  	/*
>  	 * "no_msi" and "bus_flags" only affect what happens when a driver
>  	 * requests MSI or MSI-X.  They don't affect any drivers that have
> -- 
> 2.33.0
> 
