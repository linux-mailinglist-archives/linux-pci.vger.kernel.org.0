Return-Path: <linux-pci+bounces-37265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA9EBADE61
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 17:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C50F4E181C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66353081B4;
	Tue, 30 Sep 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YnBwf57d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333B3081AA;
	Tue, 30 Sep 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246248; cv=none; b=HCGdaikecOuw4HJbBwMO3RU6OKEcNZaX+Fe21F573l+sO7P+8WNatZLNPS2gEGKwO8FKM3oYrSA30WlbZeA5jgZm5SlG/3Y8AnhOr5I0VP8yRgBeNjXmJd/3zdLTbQHT1/kaTGRgQjlB5Ee7R1fpA/uZqW4qvRvl3eesoHmonEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246248; c=relaxed/simple;
	bh=pdHwn0a7TyAYIR38zmFhOPQydyY2hJcTXaAoNlmI2+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ5WN47g3GiVdWke3eSCYr8JKw1RCRCFAUX/FyUJ1TK3eAzDwrJibG07KMh5DfhOhdcsFKGGy7hDg9l61QQITgq9Ik837H2O621OQMpqQhGoItYtKdrn08JpXrMwgtMkFDgsajy8ynATgkB/IxffV0yWEFUkyK0frxVl4bVAVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YnBwf57d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD3AC113D0;
	Tue, 30 Sep 2025 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759246248;
	bh=pdHwn0a7TyAYIR38zmFhOPQydyY2hJcTXaAoNlmI2+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YnBwf57diahlJNaU9UC1SjIOB4x9SmaIrTEscPaQYz+OeQMWDrLZvXJj/dzeeJEKs
	 jHWzZq4K42o0Hy3qgXq447wEsWEpyeitpDgZ5KtIOd8wtslNxVKhjj4nBj6AmvGZ8m
	 m7ZuQ543HHFgirYOHorVlpQd3znOl2bCgRdWpScE=
Date: Tue, 30 Sep 2025 17:15:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 01/10] PCI/LUO: Register with Liveupdate Orchestrator
Message-ID: <2025093018-snugly-twisty-91b1@gregkh>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-1-c494053c3c08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-1-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:09AM -0700, Chris Li wrote:
> Register PCI subsystem with the Liveupdate Orchestrator
> and provide noop liveupdate callbacks.
> 
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
>  MAINTAINERS              |  2 ++
>  drivers/pci/Makefile     |  1 +
>  drivers/pci/liveupdate.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91cec3288cc81aea199f730924eee1f5fda1fd72..85749a5da69f88544ccc749e9d723b1b54c0e3b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14014,11 +14014,13 @@ F:	tools/testing/selftests/livepatch/
>  
>  LIVE UPDATE
>  M:	Pasha Tatashin <pasha.tatashin@soleen.com>
> +M:	Chris Li <chrisl@kernel.org>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
>  F:	Documentation/admin-guide/liveupdate.rst
>  F:	drivers/misc/liveupdate/
> +F:	drivers/pci/liveupdate/
>  F:	include/linux/liveupdate.h
>  F:	include/uapi/linux/liveupdate.h
>  F:	tools/testing/selftests/liveupdate/
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 67647f1880fb8fb0629d680398f5b88d69aac660..aa1bac7aed7d12c641a6b55e56176fb3cdde4c91 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_PCI_DOE)		+= doe.o
>  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>  obj-$(CONFIG_PCI_NPEM)		+= npem.o
>  obj-$(CONFIG_PCIE_TPH)		+= tph.o
> +obj-$(CONFIG_LIVEUPDATE)	+= liveupdate.o
>  
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..86b4f3a2fb44781c6e323ba029db510450556fa9
> --- /dev/null
> +++ b/drivers/pci/liveupdate.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Chris Li <chrisl@kernel.org>
> + */
> +
> +#define pr_fmt(fmt) "PCI liveupdate: " fmt
> +
> +#include <linux/liveupdate.h>
> +
> +#define PCI_SUBSYSTEM_NAME "pci"
> +
> +static int pci_liveupdate_prepare(void *arg, u64 *data)
> +{
> +	pr_info("prepare data[%llx]\n", *data);

You do know that's a security bug, right?

Please don't do this, even in "debug" code, as it can escape into the
wild...

thanks,

greg k-h

