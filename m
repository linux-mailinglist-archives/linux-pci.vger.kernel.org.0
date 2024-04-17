Return-Path: <linux-pci+bounces-6384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A58A8FB4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 01:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E1DB21730
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 23:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BB18624B;
	Wed, 17 Apr 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4WhJ7M9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614672BAE2
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397884; cv=none; b=AmYhl6wC+ALzTMwS7s7lUfiRzduO+4yi/0g2YDhGlvyTJe/iXo7bJffOEJFRsjBhk4eB6dWCI6UXJqrK/8yog4k1QsRnTIp662WHkkisr6JFlLUZJ7OjS/QN8FW2a2IorKOmIdOMLh/em0coxcns70jEpr8sYUSbtg+iFJYITg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397884; c=relaxed/simple;
	bh=i/1H8sNy636Oj5vWztg2luasuynSMGankMbHeU2oc0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMpyNrfuyeZ/TORxjDs7M7hxwaSfbL+tqAtrVXaH0leHK6FQc0AK0d8ckGkQjOw1m1XP+sINZ5PVEXGJ1RkiT1ItNOhzsCjwETccHSdRwJQro6cY7mdOxTxgUcff44mdR6Fv8GSwLquDsoubqXzYKWZTmtIRQxQVbMx5t3DbeCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4WhJ7M9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3027C072AA;
	Wed, 17 Apr 2024 23:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713397883;
	bh=i/1H8sNy636Oj5vWztg2luasuynSMGankMbHeU2oc0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4WhJ7M9Ssy7uaKPQlHyDMGh3b6v6xyUbX9tv9WZ4fxJznz4Fd1IktenT24kUmbJV
	 W/YQ8Kk0syNiq3HoNhQI+PbIiyoJeANF2pum032kb8ig6uPKCN4J2xd4LWON5A6JTZ
	 kdhweI86gN5/uojo/ocqv5GV+1nagvCKP+R2fnNhV7QPThOU1o/U9+QTZwkiz14NGZ
	 yGgS6jvyIfBiXU2fFK21k7uvsgCzAglhEGa9aHyqnMVSbRQ5Sv+IADPIuQKL7wFE2E
	 CdGsnC5Kefdxrrc+P0wqfUuZi6WrlRuXOu0kpNcMxeU1aDoc8WSP64gbAu5kl4VClg
	 QtqOraZ9FUt3w==
Date: Wed, 17 Apr 2024 17:51:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
Message-ID: <ZiBgeYVQRLWPs_ZO@kbusch-mbp>
References: <20240417201542.102-1-paul.m.stillwell.jr@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417201542.102-1-paul.m.stillwell.jr@intel.com>

On Wed, Apr 17, 2024 at 01:15:42PM -0700, Paul M Stillwell Jr wrote:
> +=================================================================
> +Linux Base Driver for the Intel(R) Volume Management Device (VMD)
> +=================================================================
> +
> +Intel vmd Linux driver.
> +
> +Contents
> +========
> +
> +- Overview
> +- Features
> +- Limitations
> +
> +The Intel VMD provides the means to provide volume management across separate
> +PCI Express HBAs and SSDs without requiring operating system support or
> +communication between drivers. It does this by obscuring each storage
> +controller from the OS, but allowing a single driver to be loaded that would
> +control each storage controller. A Volume Management Device (VMD) provides a
> +single device for a single storage driver. The VMD resides in the IIO root
> +complex and it appears to the OS as a root bus integrated endpoint. In the IIO,
> +the VMD is in a central location to manipulate access to storage devices which
> +may be attached directly to the IIO or indirectly through the PCH. Instead of
> +allowing individual storage devices to be detected by the OS and allow it to
> +load a separate driver instance for each, the VMD provides configuration
> +settings to allow specific devices and root ports on the root bus to be
> +invisible to the OS.

This doesn't really capture how the vmd driver works here, though. The
linux driver doesn't control or hide any devices connected to it; it
just creates a host bridge to its PCI domain, then exposes everything to
the rest of the OS for other drivers to bind to individual device
instances that the pci bus driver finds. Everything functions much the
same as if VMD was disabled.

