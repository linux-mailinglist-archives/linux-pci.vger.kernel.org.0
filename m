Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3636B41CADD
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344114AbhI2RJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 13:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343495AbhI2RJs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 13:09:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5D4D61288;
        Wed, 29 Sep 2021 17:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632935287;
        bh=4TDyXkm6HcwC6k6GyuEZvi2ohAEIeZOw8SSV0h8L20E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SE+b343AcXe0oP3G69lICNMkltnJJzCELhskvBsS2T0cyLD9/AjBSw1uNL6kIuic7
         raDZ9rtMpsOVr1tKBoxUr2cwJysupdV7FKwFOJXnJMlqRmMz0UZVuFwJMZqIY8FBwz
         a4xM0NL5Irdokqat6kDhSyZzfxuKQD41fruJsj46YKgnMfkvVUFoBPkHhEFCQBiJI0
         BQDe1cqbahFwSb2m7p9n2WsL5+i2IQYtZiqjsN9DB3jfrIET0nCETIpgSaKq7mupaW
         p/HTzTUEf3KwCK2wOCg5fPGRRHwl4J5Hl/bK+i93WEl040YVHH67yPIZm6Ts+teBld
         b9f4IHslssTJg==
Date:   Wed, 29 Sep 2021 12:08:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 1/2] PCI: Use software node API with additional device
 properties
Message-ID: <20210929170804.GA778424@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929133729.9427-2-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Zhangfei, author of 8304a3a199ee ("PCI: Set dma-can-stall for
HiSilicon chips"), which added this]

On Wed, Sep 29, 2021 at 04:37:28PM +0300, Heikki Krogerus wrote:
> Using device_create_managed_software_node() to inject the
> properties in quirk_huawei_pcie_sva() instead of with the
> old device_add_properties() API.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This is fine with me, but please update the subject line and commit
log something like this:

  PCI: Convert to device_create_managed_software_node()

  In quirk_huawei_pcie_sva(), use device_create_managed_software_node()
  instead of device_add_properties() to set the "dma-can-stall"
  property.

  This resolves a software node lifetime issue (see 151f6ff78cdf
  ("software node: Provide replacement for device_add_properties()"))
  and paves the way for removing device_add_properties() completely.

Actually, 8304a3a199ee was merged during the v5.15 merge window, so if
this does in fact fix a lifetime issue, I can merge this before
v5.15-final.

I know *this* quirk applies to AMBA devices, and I assume they cannot
be removed, so there's no actual lifetime problem in this particular
case, but in general it looks like a problem for PCI devices.

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
