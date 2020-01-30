Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7114E4C8
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 22:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgA3V06 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 16:26:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbgA3V06 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jan 2020 16:26:58 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4746120674;
        Thu, 30 Jan 2020 21:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580419617;
        bh=dRznU3cHG7z911n91/jMMCGs7kZiZZ0FisIfcG8X+bg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OsaId0RNgBk/TMOAtPhQejA+cQkv/5uSEPnUaRJZRYzy+tGLbzRxpjehbx+pyDKSS
         9WI/wPkmtRxSKBUFytv1NPN1G3N2c7hBZ3GSzpb0OtxJEECAA5eDASRp+mwldLboM9
         ZCVFkd8m/p9g5fiAExYLk6roNvrP7ppG0/zLa6tE=
Date:   Thu, 30 Jan 2020 15:26:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        linux@yadro.com
Subject: Re: [PATCH v7 09/26] PCI: hotplug: Calculate immovable parts of
 bridge windows
Message-ID: <20200130212655.GA128349@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129152937.311162-10-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 29, 2020 at 06:29:20PM +0300, Sergei Miroshnichenko wrote:
> When movable BARs are enabled, and if a bridge contains a device with fixed
> (IORESOURCE_PCI_FIXED) or immovable BARs, the corresponding windows can't

What is the difference between fixed (IORESOURCE_PCI_FIXED) and
immovable BARs?  I'm hesitant to add a new concept ("immovable") with
a different name but very similar meaning.

I understand that in the case of bridge windows, you may need to track
only part of the window, as opposed to a BAR where the entire BAR has
to be either fixed or movable, but I think adding a new term will be
confusing.

> be moved too far away from their original positions - they must still
> contain all the fixed/immovable BARs, like that:
> 
> 1) Window position before a bus rescan:
> 
>    | <--                    root bridge window                        --> |
>    |                                                                      |
>    | | <--     bridge window    --> |                                     |
>    | | movable BARs | **fixed BAR** |                                     |
>        ^^^^^^^^^^^^
> 
> 2) Possible valid outcome after rescan and move:
> 
>    | <--                    root bridge window                        --> |
>    |                                                                      |
>    |                | <--     bridge window    --> |                      |
>    |                | **fixed BAR** | Movable BARs |                      |
>                                       ^^^^^^^^^^^^
> 
> An immovable area of a bridge window is a range that covers all the fixed
> and immovable BARs of direct children, and all the fixed area of children
> bridges:
> 
>    | <--                    root bridge window                        --> |
>    |                                                                      |
>    |  | <--                  bridge window level 1                --> |   |
>    |  | ******************** immovable area *******************       |   |
>    |  |                                                               |   |
>    |  | **fixed BAR** | <--      bridge window level 2     --> | BARs |   |
>    |  |               | *********** immovable area *********** |      |   |
>    |  |               |                                        |      |   |
>    |  |               | **fixed BAR** |  BARs  | **fixed BAR** |      |   |
>                                          ^^^^
> 
> To store these areas, the .immovable_range field has been added to struct
> pci_bus for every bridge window type: IO, MEM and PREFETCH. It is filled
> recursively from leaves to the root before a rescan.
> 
> Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/pci.h   | 14 ++++++++
>  drivers/pci/probe.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  6 ++++
>  3 files changed, 108 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3b4c982772d3..5f2051c8531c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -404,6 +404,20 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>  	return dev->error_state == pci_channel_io_perm_failure;
>  }
>  
> +static inline int pci_get_bridge_resource_idx(struct resource *r)
> +{
> +	int idx = 1;
> +
> +	if (r->flags & IORESOURCE_IO)
> +		idx = 0;
> +	else if (!(r->flags & IORESOURCE_PREFETCH))
> +		idx = 1;
> +	else if (r->flags & IORESOURCE_MEM_64)
> +		idx = 2;

Random nit: No variables or elses required:

  if (r->flags & IORESOURCE_IO)
    return 0;
  if (!(r->flags & IORESOURCE_PREFETCH))
    return 1;
  ...

> +	return idx;
> +}
