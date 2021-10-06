Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D973D424642
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 20:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhJFSts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 14:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhJFSts (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 14:49:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A03B061151;
        Wed,  6 Oct 2021 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633546075;
        bh=HrcL0ayDMOGay/UhADOzS58AHR+GsrQecIN7HiwSvuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lGyN9UqI/uVwEdNf9IrccA50HTO/SX495o/8pmJ9Dik/1vQVNHT72fnYNGtmt1m56
         aR6Dz2yOJz6gzzkLWPLvtLRiEm2JVNEoJ3k3EK6MXPJMdIdkhHed3uHBzfCgwaRpPp
         59GpfoT0FL6H4Xknq+LeormFEtwXqxnuhvYcns2z/QtmulHwKCD/WoIVkkgT/x9r+O
         hnkASyIxZ4n1jywojTVmggmbuqeK5lhW5jW3dxzDnOzhf6pzT/7VgNoH6CC2LZN3sm
         QJHQCgdgRmHcvoqbMNUqsCPR6La/z0bqGsR5S90yHWWSczSc8/yaVB45vNQNOP50cO
         JHJHzLULM+l5g==
Date:   Wed, 6 Oct 2021 13:47:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: Convert to
 device_create_managed_software_node()
Message-ID: <20211006184754.GA1171384@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006112643.77684-2-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 02:26:41PM +0300, Heikki Krogerus wrote:
> In quirk_huawei_pcie_sva(), use device_create_managed_software_node()
> instead of device_add_properties() to set the "dma-can-stall"
> property.
> 
> This is the last user of device_add_properties() that relied on
> device_del() to take care of also calling device_remove_properties().
> After this change we can finally get rid of that
> device_remove_properties() call in device_del().
> 
> After that device_remove_properties() call has been removed from
> device_del(), the software nodes that hold the additional device
> properties become reusable and shareable as there is no longer a
> default assumption that those nodes are lifetime bound the first
> device they are associated with.

This does not help me determine whether this patch is safe.
device_create_managed_software_node() sets swnode->managed = true,
but device_add_properties() did not.  I still don't know what the
effect of that is.

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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
