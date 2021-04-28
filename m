Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F5B36DD90
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 18:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhD1QyG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 12:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhD1QyG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 12:54:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3DB76143A;
        Wed, 28 Apr 2021 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619628801;
        bh=TVF7ngIeGAAI48JjMpH3tV/oTMla6V5fgEtmoWG2xkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=du5VZyB+RM4IkssG8iol6tkY70VLeW2v6jkkWKMcZBABNQZBK8zgZ1yh1NQN1u6gw
         OjS5dnM9AHYT9BUGTs3iSg8i/dNz+wQ9Yh9HINOs/um6gV0Z8mmm3etLb41jUS0io+
         vzMIHenzB0l/myJCPxzW0ARrf8/B/jCBvp6QZhMUfgEcVexChGOup7Fjf2IiPVrM8l
         Rfiog29G30Mt1j9y3KUNlE1EAdNGPma1xz/rjvSsFa80EVJ5+IOvQswRMQ9TMdyRH4
         Xg61h9PFjKIGoTx7WrAoDd4eMg+lczRiqOEvBe/Nuh4k47E2Jbmq6NjZIbiLTvnJHQ
         cb/atsm9Mcxnw==
Date:   Wed, 28 Apr 2021 11:53:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com,
        ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, Felix.Kuehling@amd.com
Subject: Re: [PATCH v5 08/27] PCI: add support for dev_groups to struct
 pci_device_driver
Message-ID: <20210428165318.GA239081@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428151207.1212258-9-andrey.grodzovsky@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject:

s/PCI: add support/PCI: Add support/

to match convention ("git log --oneline drivers/pci/pci-driver.c" to
learn this).

On Wed, Apr 28, 2021 at 11:11:48AM -0400, Andrey Grodzovsky wrote:
> This is exact copy of 'USB: add support for dev_groups to
> struct usb_device_driver' patch by Greg but just for
> the PCI case.

Ideally this would be an imperative sentence telling us what the patch
*does*, not just that it's a copy of something else.

I'd also like a brief comment about why this is useful, i.e., why you
need this and what you're going to use it for.

The usual commit citation format is 7d9c1d2f7aca ("USB: add support
for dev_groups to struct usb_device_driver") so it's easier to locate
the commit.

I see there is also b71b283e3d6d ("USB: add support for dev_groups to
struct usb_driver").  I don't know enough about USB to know whether
7d9c1d2f7aca or b71b283e3d6d is a closer analogue to what you're doing
here, but I do see that struct usb_driver is far more common than
struct usb_device_driver.

PCI has struct pci_driver, but doesn't have the concept of a struct
pci_device_driver.

> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/pci/pci-driver.c | 1 +
>  include/linux/pci.h      | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index ec44a79e951a..3a72352aa5cf 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1385,6 +1385,7 @@ int __pci_register_driver(struct pci_driver *drv, struct module *owner,
>  	drv->driver.owner = owner;
>  	drv->driver.mod_name = mod_name;
>  	drv->driver.groups = drv->groups;
> +	drv->driver.dev_groups = drv->dev_groups;
>  
>  	spin_lock_init(&drv->dynids.lock);
>  	INIT_LIST_HEAD(&drv->dynids.list);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97b77..b57755b03009 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -858,6 +858,8 @@ struct module;
>   *		number of VFs to enable via sysfs "sriov_numvfs" file.
>   * @err_handler: See Documentation/PCI/pci-error-recovery.rst
>   * @groups:	Sysfs attribute groups.
> + * @dev_groups: Attributes attached to the device that will be
> + *              created once it is bound to the driver.
>   * @driver:	Driver model structure.
>   * @dynids:	List of dynamically added device IDs.
>   */
> @@ -873,6 +875,7 @@ struct pci_driver {
>  	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
>  	const struct pci_error_handlers *err_handler;
>  	const struct attribute_group **groups;
> +	const struct attribute_group **dev_groups;
>  	struct device_driver	driver;
>  	struct pci_dynids	dynids;
>  };
> -- 
> 2.25.1
> 
