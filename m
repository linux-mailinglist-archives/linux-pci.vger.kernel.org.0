Return-Path: <linux-pci+bounces-15496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 340B69B3CA2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 22:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1B31C221A4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 21:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C391E1041;
	Mon, 28 Oct 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7udAymQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C71D2796
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150848; cv=none; b=C19b6wZmdIsKdO8rJeXrIhBJJk1MdGeu6mOH7Ux6LSNF2mhcQ6vbKfvx+9RI4YYqw79FmFFVeTCVzLCFAXOcaFf8ozQvPLtwnWGUNbDw8Rvb2C9OFIeOxFGVkXmfIghKWB0uinzU7cjTScMrAXeTM0m/hi6hXJn9nvutnbWTm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150848; c=relaxed/simple;
	bh=1w4zhaC6Nix0pEDGiclIODAJfrcEfkB2G6atZGAwqgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IGIaAZspYz7h+OjTlidT2dWgzD5MQGnxX1tHouHmsj6ERWd673iAZRrUxAB2TFjgOAxFTX4fss8aA5KS6iP48mnF3fbenmQFJU3uouu9P6fexp2I8p2npzzc/2tE9usY446qLZ24J+3vfDhkW28mjki6Dg+1QyvjWdSO+nF++yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7udAymQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FD5C4CEC3;
	Mon, 28 Oct 2024 21:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730150847;
	bh=1w4zhaC6Nix0pEDGiclIODAJfrcEfkB2G6atZGAwqgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=s7udAymQ0feVfuHyIyLBZCAQOqTAwq0dXMiqsW1lA8kI8NqDfU89q0LBxlw6GQvks
	 Pkb27Fpcv4f0VqqnotKHHnUU+xVZAu3c4s/DGzzC1mYrOOC3g5YaqXqon9YIYjbDYL
	 11tfFhnYZBEg5ksMr5CCrU+CjJgV5/H6Hrsbaa6GucetH+uJuf91UombpmtutS2fXh
	 Z/cRyobQ8So8aoyUEOtv5SBhYl9NL381Es4Rl3we33P/TtzoDAhuMkivWYJeiDa4VG
	 iFqFAVBLM5SqbOPjpbevOqN1MjA5j3TtTwQL0LTnHwopZ8TW7fvqpHLWsA3Kw0FrXM
	 YgQ28gAJtZleQ==
Date: Mon, 28 Oct 2024 16:27:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: Re: [RFC PATCH v1 1/3] PCI: vmd: Clean up vmd_enable_domain function
Message-ID: <20241028212725.GA1118694@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025150153.983306-2-szymon.durawa@linux.intel.com>

On Fri, Oct 25, 2024 at 05:01:51PM +0200, Szymon Durawa wrote:
> This function is too long and needs to be shortened to make it more readable.

Use the actual function name here instead of "This function".

Include "()" after function names, including in the subject line.

> +enum vmd_resource {
> +	VMD_RES_CFGBAR = 0,
> +	VMD_RES_MBAR_1, /*VMD Resource MemBAR 1 */
> +	VMD_RES_MBAR_2, /*VMD Resource MemBAR 2 */

Add space after "/*".

> @@ -132,10 +144,10 @@ struct vmd_dev {
>  	struct vmd_irq_list	*irqs;
>  
>  	struct pci_sysdata	sysdata;
> -	struct resource		resources[3];
> +	struct resource		resources[VMD_RES_COUNT];
>  	struct irq_domain	*irq_domain;
> -	struct pci_bus		*bus;
> -	u8			busn_start;
> +	struct pci_bus		*bus[VMD_BUS_COUNT];
> +	u8			busn_start[VMD_BUS_COUNT];

This looks like a combination of things that don't logically need to
be in the same patch, e.g., adding VMD_RES_COUNT (basically cosmetic),
converting "bus" from a scalar to an array (possibly new
functionality?)

> -static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> +static void vmd_configure_cfgbar(struct vmd_dev *vmd)
>  {
> -	struct pci_sysdata *sd = &vmd->sysdata;
> -	struct resource *res;
> +	struct resource *res = &vmd->dev->resource[VMD_CFGBAR];
> +
> +	vmd->resources[VMD_RES_CFGBAR] = (struct resource){
> +		.name = "VMD CFGBAR",
> +		.start = vmd->busn_start[VMD_BUS_0],
> +		.end = vmd->busn_start[VMD_BUS_0] +
> +		       (resource_size(res) >> 20) - 1,
> +		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
> +	};
> +}

This might need to be split into several patches, each of which moves
some code from vmd_enable_domain() into a helper function, to make
this easily reviewable.  I think generally these are simple, obvious
changes, but when they're all collected together in a single patch,
it's hard to tell that.

Bjorn

