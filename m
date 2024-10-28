Return-Path: <linux-pci+bounces-15466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56469B372D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 17:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B3DB26030
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218CF1DEFC7;
	Mon, 28 Oct 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h32sXUpa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B5155A52;
	Mon, 28 Oct 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134649; cv=none; b=kyv4APEPOGGnlKqhxbNsJ1s6XYxKfu3ENBWaBfVwd4b8KMqsphbPKy6pay3Dd9q8m3mad85QVkMExF/jp7JPqvG27g8qmwQeeBAhJlFKYcS09ZPRuhX4skOYQZEh3oEqEeXgqaRZRR4a/xq0QRR7jvFQpcVx+XYSoKNFzdARLQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134649; c=relaxed/simple;
	bh=2KecpOx0TISZK4hZM9Euk6MQyQdvrq36DoUE8N/sBa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A0FdLtj2k9c/FujUgWx+cdZ74RgO5IxXvK+DL4Z4X+ehgRSgwA2hmvFHGqRwBniyyrapqofX/t7WMMBgol+Ufh4fNqB4SuwArQ+wvfSK5VwAC1VU5AmjGjLPVVMTbyaIqEJ/gYF+qHVpdDml9nn+Pvu9VluT/KXeUDdQoONKXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h32sXUpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13830C4CEC3;
	Mon, 28 Oct 2024 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730134648;
	bh=2KecpOx0TISZK4hZM9Euk6MQyQdvrq36DoUE8N/sBa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h32sXUpaAnVumDOyku8/9Z8DVogCkQPwAm2biBrs1JAmpJvbPnG+3JG00FuOLC9qf
	 K2+Wb6dI8G5kHI9GLzJCjIWgGXO/rP3y++vElJlzSjwS/awLaBvhmuHYe3ZGl6lZj6
	 3YR0psC9Aih1eFll7R/64Qjq0X23cxSr7/jtdjS3Jq9qddATKWZrWaNA8CzwNRrgB7
	 qv9/PEXHzFs7uRvlOYv7cnbu9OSfwKtyei6r+FQnoYvUhFhzqQU4MpnzTtROZtwBQP
	 xwUjRM89PN2ZlqEJg8LMH3MRy2Zw36WGt8KpXzEx3UoLCtV6Ye4TlfkFoSWZuqJEfO
	 4+3uMVhYdbpTg==
Date: Mon, 28 Oct 2024 11:57:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 05/12] PCI: of_property: Assign PCI instead of CPU bus
 address to dynamic bridge nodes
Message-ID: <20241028165725.GA1106415@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com>

On Mon, Oct 28, 2024 at 03:07:22PM +0100, Andrea della Porta wrote:
> When populating "ranges" property for a PCI bridge, of_pci_prop_ranges()
> incorrectly use the CPU bus address of the resource. Since this is a PCI-PCI
> bridge, the window should instead be in PCI address space. Call
> pci_bus_address() on the resource in order to obtain the PCI bus
> address.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for working through this!

> ---
>  drivers/pci/of_property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 5a0b98e69795..886c236e5de6 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -126,7 +126,7 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>  		if (of_pci_get_addr_flags(&res[j], &flags))
>  			continue;
>  
> -		val64 = res[j].start;
> +		val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
>  		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
>  				   false);
>  		if (pci_is_bridge(pdev)) {
> -- 
> 2.35.3
> 

