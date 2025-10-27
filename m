Return-Path: <linux-pci+bounces-39477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9EFC11EFE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 00:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53633A92A6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3473128B6;
	Mon, 27 Oct 2025 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6q/dgWc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915262BF013;
	Mon, 27 Oct 2025 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606744; cv=none; b=jmyuUKhX+IN05w0H3Drccd9TxJV7xfaRwMVB+tZeGAbUeeAEMSlvvUpPoorneEZRp+Sz44Whw0qFZtPdzIhpigrtzhLYCZGGD9x6jUk+ZP2wL5e+XY8pwdLieD6+Um3j0kjBpj4qzDoULLaGrZzeVrndq8LALgfKlbQ5oGdVkHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606744; c=relaxed/simple;
	bh=u+AhKk5PGv7Xhu4wWr/8KsE4Pfmj8O1Av45RSz3UmGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IGHnmw2PV3cOc8n8CHQZvLijBqQTj0LxTymtMRVI4nRMQLzkIdQ92CFX5O1t+4Qd7u3t3xrmTWj1+WIZV9zZgTyKII4mTCQh7b5PA6OoU1PSe+ZgpHDIjBu9NcnSZTFIJcHnbgIrTffZRiyghsDROj71JbsP+wMMUSSpJoRrhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6q/dgWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E128FC4CEF1;
	Mon, 27 Oct 2025 23:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761606744;
	bh=u+AhKk5PGv7Xhu4wWr/8KsE4Pfmj8O1Av45RSz3UmGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C6q/dgWcp2nbUwo63zcdEJOinqpVMhDG8JlpAdJLo6h5jQjMWVhZnKby3KawUr4Ht
	 e4i44dKXgsoX2Q7rQR/KKjquIC4k2+GUSecIOsbebMkyEfZQbt6wbEcxnmbRSACAdC
	 63PwjeW0v9cKThpu5CVtXgDj2qAxHqT1Fgv0doyiqprZ99iO38hgy4cJRK/h8LnnSA
	 mCh0nLSThqbsoPQEszIOIXvc+uPvnRjlaif2LMHkveweB/cMeQyWmgsEETeuw4U6CI
	 fKfiVgQ6wHViTBBs+mRpnhK7NOVTsKrKaeAuy/yl/0fsynIItU5CNWCcFwAvf/EMf8
	 isxIdGZGPtEvQ==
Date: Mon, 27 Oct 2025 18:12:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Do not size non-existing prefetchable window
Message-ID: <20251027231222.GA1487591@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027132423.8841-1-ilpo.jarvinen@linux.intel.com>

On Mon, Oct 27, 2025 at 03:24:23PM +0200, Ilpo Järvinen wrote:
> pbus_size_mem() should only be called for bridge windows that exist but
> __pci_bus_size_bridges() may point 'pref' to a resource that does not
> exist (has zero flags) in case of non-root buses.
> 
> When prefetchable bridge window does not exist, the same
> non-prefetchable bridge window is sized more than once which may result
> in duplicating entries into the realloc_head list. Duplicated entries
> are shown in this log and trigger a WARN_ON() because realloc_head had
> residual entries after the resource assignment algorithm:
> 
> pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> pci 0000:00:03.0: PCI bridge to [bus 00]
> pci 0000:00:03.0:   bridge window [io  0x0000-0x0fff]
> pci 0000:00:03.0:   bridge window [mem 0x00000000-0x000fffff]
> pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02] add_size 200000 add_align 200000
> pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02] add_size 200000 add_align 200000
> pci 0000:00:03.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
> pci 0000:00:03.0: PCI bridge to [bus 02]
> pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xe03fffff]
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at drivers/pci/setup-bus.c:2373 pci_assign_unassigned_root_bus_resources+0x1bc/0x234
> 
> Check resource flags of 'pref' and only size the prefetchable window if
> the resource has the IORESOURCE_PREFETCH flag.
> 
> Fixes: ae88d0b9c57f ("PCI: Use pbus_select_window_for_type() during mem window sizing")
> Link: https://lore.kernel.org/linux-pci/51e8cf1c62b8318882257d6b5a9de7fdaaecc343.camel@gmail.com/
> Reported-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Since ae88d0b9c57f appeared in v6.18-rc1, this looks like v6.18
material, right?

Applied to pci/for-linus for v6.18 on that assumption, thanks!

> ---
>  drivers/pci/setup-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 362ad108794d..7cb6071cff7a 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1604,7 +1604,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
>  			     additional_io_size, realloc_head);
>  
> -		if (pref) {
> +		if (pref && (pref->flags & IORESOURCE_PREFETCH)) {
>  			pbus_size_mem(bus,
>  				      IORESOURCE_MEM | IORESOURCE_PREFETCH |
>  				      (pref->flags & IORESOURCE_MEM_64),
> 
> base-commit: 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
> -- 
> 2.39.5
> 

