Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0D367A05
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 08:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhDVGnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 02:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhDVGnt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Apr 2021 02:43:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5B4361448;
        Thu, 22 Apr 2021 06:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619073795;
        bh=L+NEFXtJpE3c8ji8SNF+vnnM2qrMMLJx0iPDUNzK/jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oy4DpFpSb58iJ3sHew8raiEx0x0qobvNA9am5Z5wI798WsRwZQwOBgXJdyseu5vBp
         iNCHdk+Ymh0HieSckqCzefax6oYCVoK1kZ4//cEJtIKLePnWjUNugrHQg1IP1Faynp
         RjW9PXdNZMueiFItf54gahjW62gfmowG1bkNwxAKfiEf/QFS++UmldWhkXyFT46c6p
         ND3xRpS28TXl7T+e8SYET/779o7m87mdki0TuKvFSX7S2PmIRbEG1S2XlJXredxFxX
         UsXUWAlV/iQhesizdc+cLEiK6X2zObyh93xHui1zIQ+ynuV/KxD4+gB1dXjdIvOAg+
         U5ECPpEZgIUZQ==
Date:   Thu, 22 Apr 2021 09:43:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Check value of resource alignment before using __ffs
Message-ID: <YIEa/5E45SzKzvuf@unreal>
References: <20210421184747.62391-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421184747.62391-1-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 22, 2021 at 12:17:47AM +0530, Amey Narkhede wrote:
> Return value of __ffs is undefined if no set bit exists in
> its argument. This indicates that the associated BAR has
> invalid alignment.
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/pci/setup-bus.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 2ce636937c6e..44e8449418ae 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1044,6 +1044,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  			 * resources.
>  			 */
>  			align = pci_resource_alignment(dev, r);
> +			if (!align) {
> +				pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
> +					 i, r);
> +				continue;
> +			}

I see that you copied it from pdev_sort_resources(), but it is
incorrect change, see how negative order is handled and later
ARRAY_SIZE() check.

Thanks

>  			order = __ffs(align) - 20;
>  			if (order < 0)
>  				order = 0;
> --
> 2.31.1
