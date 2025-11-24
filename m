Return-Path: <linux-pci+bounces-41983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C94EFC82781
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EA1D4E163C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 21:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ACB261B8D;
	Mon, 24 Nov 2025 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCX15Lgd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4552586C8;
	Mon, 24 Nov 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018252; cv=none; b=qQxCIxUHT7xeUcRUgu1t8KuuBcEiuEBB9I22dsOx1nkPKemkQ5fTa1WyHcORh5xyWPWKob75xfdsWd9IlmljgjieBUuKa9hMWDdBjlbEmmcvJ3bD9QXDIOion8/+iR3EPy63LZv4uqD2gykQLwNGllDmHX5/i/NkcZgwhatTtpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018252; c=relaxed/simple;
	bh=iajDv7seBZUI/QDdLzMrsq8XDeJ+YvZpuBn2iSbIUDE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QBX81NnBB6UQw0vr/EvLGOaF0iQ235ILGsnXU3YBxXXORIaF6XMYMLRmmTJleSvrr8IzhGmNsRTLFCgNz2P9DKq69M7qUipf9+OwlKaasTr6ykxsQao7MRgG7yMriCtLbhn4tjzInxO7nLRkHfbDmYmOhfg+OTEAHGoDSb0QFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCX15Lgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0A8C4CEF1;
	Mon, 24 Nov 2025 21:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764018251;
	bh=iajDv7seBZUI/QDdLzMrsq8XDeJ+YvZpuBn2iSbIUDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZCX15LgdoourDMIjzZC9esIRoKDXH0dJZBzuZ5qF/VeMQ8e3GzX9i9IDgCslK8l1W
	 Y7O1QB4YzTWNwTHX7VxZzLPtsdeL03GNDljyGtYeX13yt0kXV7W/OhzRbnhDDqlrTV
	 F4DFkA0ivhXgvyRtWTIOlM/9mOSYrEfN8LvVyZxqq5yQsrx96tFIUfPjpKb4DVjNlO
	 x3wf0hQy9aWl/TZkdY1sjuYricNRwCJHd1pnozheoMfHOB32O8K4UQqi0djM7C2NEI
	 dc0uhHZnhzeQjxxvuHAlLWA4AX0UjFO+khHrDP/5E/BD2STJargaCG3fyT4ocstiBj
	 Z70WR0kBmCX9Q==
Date: Mon, 24 Nov 2025 15:04:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 25/44] drivers/pci: use min() instead of min_t()
Message-ID: <20251124210410.GA2708124@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119224140.8616-26-david.laight.linux@gmail.com>

On Wed, Nov 19, 2025 at 10:41:21PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> and so cannot discard significant bits.
> 
> In this case although pci_hotplug_bus_size is 'long' it is constrained
> to be <= 255.
> 
> Detected by an extra check added to min_t().

I don't mind applying this, but it sure would be nice to have a hint
at the max() and max_t() definitions about when and why to prefer one
over the other.

Applied to pci/misc for v6.19 with the following commit log:

  PCI: Use max() instead of max_t() to ease static analysis

  In this code:

    used_buses = max_t(unsigned int, available_buses,
                       pci_hotplug_bus_size - 1);

  max_t() casts the 'unsigned long' pci_hotplug_bus_size (either 32 or 64
  bits) to 'unsigned int' (32 bits) result type, so there's a potential of
  discarding significant bits.

  Instead, use max(a, b), which casts 'unsigned int' to 'unsigned long' and
  cannot discard significant bits.

  In this case, pci_hotplug_bus_size is constrained to <= 0xff by pci_setup()
  so this doesn't fix a bug, but it makes static analysis easier.

> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  drivers/pci/probe.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a8..0f0d1b44d8c2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3163,8 +3163,7 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  	 * bus number if there is room.
>  	 */
>  	if (bus->self && bus->self->is_hotplug_bridge) {
> -		used_buses = max_t(unsigned int, available_buses,
> -				   pci_hotplug_bus_size - 1);
> +		used_buses = max(available_buses, pci_hotplug_bus_size - 1);
>  		if (max - start < used_buses) {
>  			max = start + used_buses;
>  
> -- 
> 2.39.5
> 

