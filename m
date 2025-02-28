Return-Path: <linux-pci+bounces-22659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFD8A4A183
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 19:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43573AEBBC
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0377E2755E3;
	Fri, 28 Feb 2025 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqXoUASs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FB327427A
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767252; cv=none; b=EeUyVgwsxMkXjaMsqnBNExfmmuPhptL8VLynDzOoR+dYnyn4xu5JGVyva37QH4LOfljV4Dkei7Pc9AeQunAbSii5Q9Eh12NZBuuws8nQAHl3a0HyCKRfaaK/taXwjSCGPgCldXEdj21F7qBEsnwFBSm26KAR6Qx96I6HqzY01To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767252; c=relaxed/simple;
	bh=XTRg5+c5k+wV7COI9J3Pf7YaXviayGm3kABMYFn1Hms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CJJ6JRoJMbzbJ2Lf6Qrs6bfwK7zJOluEKggfFfDoZybL0ghfICsCsMz40Hk/Ub0d6hEFXwqqvkl9wJeCqC/xoF49s5k5j6avwM6jIfUin6qH4qywYdqtkJ5HEp8Exq5psSpRqINT0EdmMgZuiv7qh68n7FkzDhA9BwzyRS+V158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqXoUASs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DF1C4CED6;
	Fri, 28 Feb 2025 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740767252;
	bh=XTRg5+c5k+wV7COI9J3Pf7YaXviayGm3kABMYFn1Hms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PqXoUASsrEMhJOZiJfo6ouQ399N5UvwOIWyLHez3lcTaI/fJNovsIynYu0XaSInpm
	 eB62Iods417oqcjtYZjB/BPgq/5UpfGte8D/MGgHvkqUhNqCrEi1oTo5V/zor4kMKO
	 kw1xD+Xz5bdXbmJWC5mnLxeJB3333zpt4/Osqch1RpCLJdNqXp8uZtAWwGDswfWfTF
	 4XUks5wqosjYdosc+ggGCrXyR0RtGAjnO3nXVfQY4GF+rKP5fq50IR1nQumzjtjPN9
	 C0Up8fa8rerIzv3lRgHQXT9se8+2JYdu0cZ00sufasHxt6i1EpdCr6cpwAj9LsWkjG
	 FHL6D22XaifSg==
Date: Fri, 28 Feb 2025 12:27:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>
Subject: Re: Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable
Message-ID: <20250228182730.GA59475@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR07MB883875A86213C568BC2E08E2FD5B2@PA4PR07MB8838.eurprd07.prod.outlook.com>

[+cc Vidya and reviewers of fede8526cc48]

On Thu, Nov 14, 2024 at 02:05:08PM +0000, Wannes Bouwen (Nokia) wrote:
> Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB non-prefetchable
> windows.
> 
> According to the PCIe spec, non-prefetchable memory supports only 32-bit
> BAR registers and are hence limited to 4 GiB. In the kernel there is a
> check that prints a warning if a non-prefetchable resource exceeds the
> 32-bit limit.
> 
> This check however prints a warning when a 4 GiB window on the host
> bridge is used. This is perfectly possible according to the PCIe spec,
> so in my opinion the warning is a bit too strict. This changeset
> subtracts 1 from the resource_size to avoid printing a warning in the
> case of a 4 GiB non-prefetchable window.
> 
> Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
> ---
>  drivers/pci/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index dacea3fc5128..ccbb1f1c2212 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -622,7 +622,7 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>             res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> 
>             if (!(res->flags & IORESOURCE_PREFETCH))
> -               if (upper_32_bits(resource_size(res)))
> +               if (upper_32_bits(resource_size(res) - 1))
>                     dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");

I guess this relies on the fact that BARs must be a power of two in
size, right?  So anything where the upper 32 bits of the size are
non-zero is either 0x1_0000_0000 (4GiB window that we shouldn't warn
about), or 0x2_0000_0000 or bigger (where we *do* want to warn about
it).

But it looks like this is used for host bridge resources, which are
windows, not BARs, so they don't have to be a power of two size.  A
window of size 0x1_8000_0000 is perfectly legal and would fit the
criteria for this warning, but this patch would turn off the warning.

I don't really understand this warning in the first place, though.  It
was added by fede8526cc48 ("PCI: of: Warn if non-prefetchable memory
aperture size is > 32-bit").  But I think the real issue would be
related to the highest address, not the size.  For example, an
aperture of 0x0_c000_0000 - 0x1_4000_0000 is only 0x8000_0000 in size,
but the upper half of it it would be invalid for non-prefetchable
32-bit BARs.

Bjorn

