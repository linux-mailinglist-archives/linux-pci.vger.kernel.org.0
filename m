Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0BA390BE1
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 00:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhEYWCr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 18:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbhEYWCr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 18:02:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67FA9613C1;
        Tue, 25 May 2021 22:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621980076;
        bh=OKbt8VTDqH9/fUZ2IX91hNORMUmKC9bItngyqEBECPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=przfyApJFqk2Nno6nAevclc/7gjQHKPgEhs5XeokeM0hCRLhzfxrsNMPdLdOiRS5H
         8h/FMNMzE/tEPlr7rZvczvOIDSFnIVC3dK9PbhA3BJO5v0m4IZG1gh6AJdiZ4rreyK
         vNFTz1I22YVVWoLbvgj4ArpCcoCNtz0Vpxbxaw9ZUK77QVK0zP9Z5knDZLXvT4eMIL
         NsvgTmJgwTOV2VPOgmjxhtjpWSzNjVoxs6K6al61Z8l1SDOMqrCqlhDJJOjAeZvRAr
         PZGABByzp4GdLwEmjNaCd1Lxz53zH92/b0JMnHNFAbcpwPxzpKyNXYcO7+Zhvso5NA
         1j66Zcyh+cbNQ==
Date:   Tue, 25 May 2021 17:01:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2] PCI: Check value of resource alignment before using
 __ffs
Message-ID: <20210525220115.GA1233963@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422105538.76057-1-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 22, 2021 at 04:25:38PM +0530, Amey Narkhede wrote:
> Return value of __ffs is undefined if no set bit exists in
> its argument. This indicates that the associated BAR has
> invalid alignment.
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/pci/setup-bus.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 2ce636937c6e..ce5380bdd2fd 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1044,10 +1044,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  			 * resources.
>  			 */
>  			align = pci_resource_alignment(dev, r);
> -			order = __ffs(align) - 20;
> -			if (order < 0)
> -				order = 0;
> -			if (order >= ARRAY_SIZE(aligns)) {
> +			if (align) {
> +				order = __ffs(align) - 20;
> +				order = (order < 0) ? 0 : order;
> +			}
> +			if (!align || order >= ARRAY_SIZE(aligns)) {
>  				pci_warn(dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
>  					 i, r, (unsigned long long) align);
>  				r->flags = 0;

I know this is solving a theoretical problem.  Is it also solving a
*real* problem?

I dislike the way it complicates the code and the usage of "align" and
"order".  I know that when "!align", we don't evaluate the
"order >= ARRAY_SIZE()" (which would involve an uninitialized value),
but it just seems ugly, and I'm not sure how much we benefit.

And the "disabling BAR" part is gross.  I know you're not changing
that part, but it's just wrong.  Setting r->flags = 0 certainly does
not disable the BAR.  It might make Linux ignore it, but that doesn't
mean the hardware ignores it.  When we turn on PCI_COMMAND_MEMORY, the
BAR is enabled along with all the other memory BARs.

Bjorn
