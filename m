Return-Path: <linux-pci+bounces-35359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9C4B41653
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 09:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7DC6800DC
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 07:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466D22D9ED9;
	Wed,  3 Sep 2025 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJBJ0wnC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC92D97BE;
	Wed,  3 Sep 2025 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884083; cv=none; b=kO7r6FcVC73HbZzLbQi2lsPiaxVj0DWFdQqeVpTxnkGXWcBNDBLv11sRL9B0t056amZH2sazkUHGhKVprp2wX60FUweI8I3KG/ipX8AKrBcTFN+3Y7hlkkNxuDCYc6/X2O5POitN3TJwpVGgC6q+PKRZNLYNOwZ4vvI4JO7mcPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884083; c=relaxed/simple;
	bh=aE2wSHWhtqpiMKHN7D3PfY7xel2VdPYw5MsWLRepx7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA27WSXRIZakLiUUNktmn0Ap7f4slFeYpE9PSTbbgOuYf78IkWOXZfjFgJ/UIVdRZueETXgkbGjiV4vC3Iojy7tgCjnVfnfr4F9/wc2QAzDzjv12wppvV/PqFyFXY0QaXUWumdl4Q1xfMEdZIAvjjdCyhVqm/dbtks4n048vAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJBJ0wnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB26EC4CEF1;
	Wed,  3 Sep 2025 07:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756884082;
	bh=aE2wSHWhtqpiMKHN7D3PfY7xel2VdPYw5MsWLRepx7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJBJ0wnCkJ1bai4763J4Y9QBfj8wXwSGJY+gHPqNW3l/BcjWmpT/KdbNwOVh2P+uY
	 8Wsw+b/URVuxPr4VH6ak4gHXuYNmZwgy2c5lHjASKjt4OiUSUykSbIo1i/JaE1LC3p
	 HDV1L/b2Wgw+BPwU4RqakGu5lNpkmfSOsJCAY7AL/jh8I1qN6rSZMBqIUdfJtEt/gC
	 MVP4jCj9RMgo0XWs0DjJZSCPWO8ZEhHRyyaQ+pHqmyICGm9/LFGKmbIHTbHAybqKzU
	 5YaZm9MYrtURfao8cI2299LvtUG34wLHV+u0VmKVoo2DqEXAgj43KiJnCZWKrvQjAl
	 xIOCjRs6V/APg==
Date: Wed, 3 Sep 2025 08:21:17 +0100
From: Lee Jones <lee@kernel.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mfd: vortex: implement new driver for Vortex
 southbridges
Message-ID: <20250903072117.GY2163762@google.com>
References: <20250822135816.739582-1-marcos@orca.pet>
 <20250822135816.739582-4-marcos@orca.pet>
 <20250902151828.GU2163762@google.com>
 <45b84c38-4046-4fb0-89af-6a2cc4de99cf@orca.pet>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45b84c38-4046-4fb0-89af-6a2cc4de99cf@orca.pet>

On Tue, 02 Sep 2025, Marcos Del Sol Vives wrote:

> El 02/09/2025 a las 17:18, Lee Jones escribió:
> >> +
> >> +struct vortex_southbridge {
> >> +	const struct mfd_cell *cells;
> >> +	int n_cells;
> >> +};
> > 
> > Why is this needed?
> > 
> 
> To have a variable amount of cells. Currently I am only implementing the
> GPIO device because it's the most critical (required for device shutdown),
> but I plan on implementing once this gets merged at least also the watchdog,
> which is provided by the same southbridge.
> 
> Adding support for this is should make adding that simpler.

You don't need it.  Please find another way to achieve your goal.

> >> +static const struct mfd_cell vortex_dx_sb_cells[] = {
> >> +	{
> >> +		.name		= "vortex-gpio",
> >> +		.resources	= vortex_dx_gpio_resources,
> >> +		.num_resources	= ARRAY_SIZE(vortex_dx_gpio_resources),
> >> +	},
> >> +};
> > 
> > It's not an MFD until you have more than one device.
> 
> Same as above.

It will not be accepted with only a single device (SFD?).

> >> +static const struct pci_device_id vortex_sb_table[] = {
> >> +	/* Vortex86DX */
> >> +	{ PCI_DEVICE_DATA(RDC, R6031, &vortex_dx_sb) },
> > 
> > We're not passing one initialisation API's data (MFD) through another (PCI).
> 
> Unless I understood you incorrectly, you mean I should not pass MFD cells/
> data as private data?

Right.

> vortex_dx_sb are "struct vortex_southbridge" type, not raw MFD API data.

I like your style, but nope!

vortex_southbridge contains MFD data and shouldn't exist anyway.

-- 
Lee Jones [李琼斯]

