Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9813D41DCF1
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 17:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhI3PFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 11:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhI3PFr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 11:05:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E2B560F4A;
        Thu, 30 Sep 2021 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633014244;
        bh=nSTw+j4d2UCCKhsHid2M5WQ7GT4HxeOWxUwBItejV+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=g11GVhubWbJ/GMBOb23KR6WPBnQbnsPapEPAmH9W/CkHL4SrnZ6OSbtFjLvlWWwVA
         KI45hsV88rEDkrA4e9dQNzQPI63wb3PgbcgguUcOz9DEqcl+JUDxREpl7zAHJf05r4
         EgArSxHg4bp6ARdwVMjfAU6NZ2jMy6WYnnx3r3UcgKD1bvzo36HdVJ+yDjeaeqc6Xs
         Of2ntw2JDzgpJnzTlcyjEX4Sdl5Yx10fgBVug4nheliVVzuitooDJs+nRHUdDo95Zx
         tndStmMdbBgumBc6UaOmEvZTg+43p8gVuuMe9Td4PFvkjWILpJQIRZsJJ2a/8RI5sW
         3SmGakWn783xw==
Date:   Thu, 30 Sep 2021 10:04:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Convert to
 device_create_managed_software_node()
Message-ID: <20210930150402.GA877907@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930121246.22833-2-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 03:12:45PM +0300, Heikki Krogerus wrote:
> In quirk_huawei_pcie_sva(), use device_create_managed_software_node()
> instead of device_add_properties() to set the "dma-can-stall"
> property.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Hi,
> 
> The commit message now says what Bjorn requested, except I left out
> the claim that the patch fixes a lifetime issue.

Thanks.

The commit log should help reviewers determine whether the change is
safe and necessary.  So far it doesn't have any hints along that line.

Comparing device_add_properties() [1] and
device_create_managed_software_node() [2], the only difference in this
case is that the latter sets "swnode->managed = true".  The function
comment says "managed" means the lifetime of the swnode is tied to the
lifetime of dev, hence my question about a lifetime issue.

I can see that one reason for this change is to remove the last caller
of device_add_properties(), so device_add_properties() itself can be
removed.  That's a good reason for wanting to do it, and the commit
log could mention it.

But it doesn't help me figure out whether it's safe.  For that,
I need to know the effect of setting "managed = true".  Obviously
it means *something*, but I don't know what.  It looks like the only
test is in software_node_notify():

  device_del
    device_platform_notify_remove
      software_node_notify_remove
        sysfs_remove_link(dev_name)
        sysfs_remove_link("software_node")
        if (swnode->managed)                 <--
          set_secondary_fwnode(dev, NULL)
          kobject_put(&swnode->kobj)
    device_remove_properties
      if (is_software_node())
        fwnode_remove_software_node
          kobject_put(&swnode->kobj)
        set_secondary_fwnode(dev, NULL)

I'm not sure what's going on here; it looks like some redundancy with
multiple calls of kobject_put() and set_secondary_fwnode().  Maybe you
are in the process of removing device_remove_properties() as well as
device_add_properties()?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/property.c?id=v5.14#n533
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/swnode.c?id=v5.14#n1083

> There shouldn't be any functional impact.
> 
> thanks,
> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b6b4c803bdc94..fe5eedba47908 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1850,7 +1850,7 @@ static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
>  	 * can set it directly.
>  	 */
>  	if (!pdev->dev.of_node &&
> -	    device_add_properties(&pdev->dev, properties))
> +	    device_create_managed_software_node(&pdev->dev, properties, NULL))
>  		pci_warn(pdev, "could not add stall property");
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> -- 
> 2.33.0
> 
