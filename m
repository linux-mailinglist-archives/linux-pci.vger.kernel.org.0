Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614B940B77D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 21:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhINTKl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 15:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhINTKk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 15:10:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C268A60FED;
        Tue, 14 Sep 2021 19:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631646563;
        bh=cfhCymTR+NW29/iSC+hTY93GTILfL5f/hAJx/9UgVVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tr+fY58jSFJxzkQD3+ZeNTH6ot3AQjr9hI5N+KRk/pUe10bWgj9E2fWblopTfx8zu
         uJIocMIZvsIk+OM/+eDPkmlt2wgJc3vcky+ov0S1t77UOIhOkN+YUuXHs3qPv2DVpo
         2qm+h9xVEff8lNQTlneJLjJmC0HIQ/OZd4yy7SwFe5zIklTeX1iOOX755GC3akda+9
         odhXDgZgd/PesEkHSwIMLPXCbdgRPN4yoFLR200yMTObkB8Om7roHaF7z9jTYQyd+G
         SUc7CgSOtcb+YIT+U5cYP/1TwcVCJeIevhLQuGn5GtusuoNCPhsL9C03y0vFhgYnQQ
         kKCNi+Gr7wPrg==
Date:   Tue, 14 Sep 2021 14:09:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v3 03/10] PCI: of: Allow matching of an interrupt-map
 local to a pci device
Message-ID: <20210914190921.GA1445505@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913182550.264165-4-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 07:25:43PM +0100, Marc Zyngier wrote:
> Just as we now allow an interrupt map to be parsed when part
> of an interrupt controller, there is no reason to ignore an
> interrupt map that would be part of a pci device node such as
> a root port since we already allow interrupt specifiers.
> 
> This allows the device itself to use the interrupt map for
> for its own purpose.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume Lorenzo would merge this along with the rest of the series.

If I were applying I would silently wrap to 75 characters, s/pci/PCI/
in subject and above, and maybe incorporate a version of the subject
line in the commit log so it says what the patch does.

> ---
>  drivers/pci/of.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index d84381ce82b5..443cebb0622e 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -423,7 +423,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>   */
>  static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
>  {
> -	struct device_node *dn, *ppnode;
> +	struct device_node *dn, *ppnode = NULL;
>  	struct pci_dev *ppdev;
>  	__be32 laddr[3];
>  	u8 pin;
> @@ -452,8 +452,14 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>  	if (pin == 0)
>  		return -ENODEV;
>  
> +	/* Local interrupt-map in the device node? Use it! */
> +	if (dn && of_get_property(dn, "interrupt-map", NULL)) {
> +		pin = pci_swizzle_interrupt_pin(pdev, pin);
> +		ppnode = dn;
> +	}
> +
>  	/* Now we walk up the PCI tree */
> -	for (;;) {
> +	while (!ppnode) {
>  		/* Get the pci_dev of our parent */
>  		ppdev = pdev->bus->self;
>  
> -- 
> 2.30.2
> 
