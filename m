Return-Path: <linux-pci+bounces-8468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4C900A44
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 18:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C4DB24B20
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3906019AA40;
	Fri,  7 Jun 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2ifAwwQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D866D1B9;
	Fri,  7 Jun 2024 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777655; cv=none; b=b5H+8S6M97063M2L7eqqd6He6557R4MI5QUqSr8p4goAHCxgViqP2xTsdRJWnye1ic7ZGgrchlMPfCNZdLRv+PEl+Q2g78CoqM7FiF78SW0QX+jBdOZY44a6LnMkCD2K0Yu502vTRl1WIiXjh4syuQcwsZ6KtwzEgAp3TRQGY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777655; c=relaxed/simple;
	bh=70WFcr3YZHLwEEqWuEFYuf3IHamdP8ojcxlq9+pNkuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f1u9EiKijiv2nKpNWnZfvKM07Of/TW9CY6XTTeR3CEfLS5qHQNIdQiTB1A17OJnmxD8M4LIZQhRCZm2ZWTM+/RlWLWqtBnD/lrvssFernnM9bIaZj5O259e0F+s3NgZKiwO79mxFVv6Nj7OYuVs2Y3XVFk7+DvPOYUnPj7euzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2ifAwwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40999C2BBFC;
	Fri,  7 Jun 2024 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717777654;
	bh=70WFcr3YZHLwEEqWuEFYuf3IHamdP8ojcxlq9+pNkuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A2ifAwwQNjMrd1AqtONpXCSyvOdknl6boYk4Pw9p4ikc4NKZ8YGKRR1L0md2nPcPi
	 m6kH8y2itDxknAKp65Y98T2MRAIXGe2/34JEAEdL5sFSTBzUPtiYUr7tSmPtR5JXNN
	 9sKDMK7noCTja6zKbf+bDCHf8vENZsjUP9oSyMC3W99xGCTaHJpqsa4ds/kpaHe/8L
	 euw+xkGrdiSo7cnFx5Dub7MvAlK9gSW4Q+dIrr0kHiKBAOO8TDZn3XnKebWatyMqg3
	 D0fzdIn8t5StVG25HjdlKm5sgKYCK3KGAAKbDeuskRm3D1EL2GoXXnT0Wn5zhlsLSX
	 VgvM7A9ZGM8Lw==
Date: Fri, 7 Jun 2024 11:27:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH V2 1/9] PCI: Introduce PCIe TPH support framework
Message-ID: <20240607162732.GA848790@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531213841.3246055-2-wei.huang2@amd.com>

On Fri, May 31, 2024 at 04:38:33PM -0500, Wei Huang wrote:
> This patch implements the framework for PCIe TPH support. It introduces
> tph.c source file, along with CONFIG_PCIE_TPH, to Linux PCIe subsystem.
> A new member, named tph_cap, is also introduced in pci_dev to cache TPH
> capability offset.

s/This patch implements/Implement/
s/It introduces/Introduce/
s/is also introduced/Add tph_cap .../

https://chris.beams.io/posts/git-commit/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.9#n94

> +	  This option adds support for PCIE TLP Processing Hints (TPH).
> +	  TPH allows endpoint devices to provide optimization hints, such as
> +	  desired caching behavior, for requests that target memory space.
> +	  These hints, called steering tags, can empower the system hardware
> +	  to optimize the utilization of platform resources.

s/PCIE TLP/PCIe TLP/ to match context.

> +++ b/drivers/pci/pcie/tph.c

> +#define pr_fmt(fmt) "TPH: " fmt
> +#define dev_fmt pr_fmt

Add when used.

> +void pcie_tph_init(struct pci_dev *dev)
> +{
> +	dev->tph_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
> +}
> +

  $ git am m/v2_20240531_wei_huang2_pcie_tph_and_cache_direct_injection_support.mbx
  Applying: PCI: Introduce PCIe TPH support framework
  .git/rebase-apply/patch:88: new blank line at EOF.
  +
  warning: 1 line adds whitespace errors.

