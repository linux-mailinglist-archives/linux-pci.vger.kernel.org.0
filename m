Return-Path: <linux-pci+bounces-37266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE12BADE6A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 17:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF523807FD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790DF308F2E;
	Tue, 30 Sep 2025 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P1AWzQlf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5B308F16;
	Tue, 30 Sep 2025 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246251; cv=none; b=LDad9l4/O09rQxekijVXJxDM/MDVeYxQpYDTFh+w/BjuUhK4lf4iZLKiWneyjoe0F70eITb4rpPC/ItY5Lsrm1ZOhOGd3OcEAE25tnPg/ezRe+XKZQmzRbfsWmEWG0OaAp13YLKCguA3U5PH1DHvbvUSqaVqH+MWbRsq13YwmTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246251; c=relaxed/simple;
	bh=ooCBmh9/CIFksOUqUMHAhlpwhUo/LkdrKCdrIJqspQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+Yx4F7FWZUmOZWVoNxjUNSk+yW2T9X34ba2BhEXafo1wcTxMMgSY8R9XLMtTePF2SElcoBVkRNXY7LyVmlUVtBtUmeYq/aku/wpjfF4V/Iqxotq5EUTUlxaoWw1oLNE1AgDfvaVMA14uqannBHPphgRiXQX61h9h11XNSty7k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P1AWzQlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E4CC116B1;
	Tue, 30 Sep 2025 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759246251;
	bh=ooCBmh9/CIFksOUqUMHAhlpwhUo/LkdrKCdrIJqspQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1AWzQlf/lNFmWR+oBolQ1gpkB7lj3kSS+2c2XsKANZ4fe0hKeMEOzggQX8Iubj+/
	 Ys5tZkqKhkAlfn/OGjFzHu49RZLryle+q3Bd7XdOrrj0JTXQLfVb46MPKp/0LFsTSm
	 j8K2Z0Ic6yreOfAgQ7o0vASDaSF8Tx9rCk+gDL1M=
Date: Tue, 30 Sep 2025 17:17:10 +0200
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
Message-ID: <2025093014-qualify-scoop-c406@gregkh>
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
> +	return 0;
> +}
> +
> +static int pci_liveupdate_freeze(void *arg, u64 *data)
> +{
> +	pr_info("freeze data[%llx]\n", *data);
> +	return 0;
> +}
> +
> +static void pci_liveupdate_cancel(void *arg, u64 data)
> +{
> +	pr_info("cancel data[%llx]\n", data);
> +}
> +
> +static void pci_liveupdate_finish(void *arg, u64 data)
> +{
> +	pr_info("finish data[%llx]\n", data);
> +}
> +
> +struct liveupdate_subsystem pci_liveupdate_ops = {
> +	.prepare = pci_liveupdate_prepare,
> +	.freeze = pci_liveupdate_freeze,
> +	.cancel = pci_liveupdate_cancel,
> +	.finish = pci_liveupdate_finish,
> +	.name = PCI_SUBSYSTEM_NAME,
> +};
> +
> +static int __init pci_liveupdate_init(void)
> +{
> +	int ret;
> +
> +	ret = liveupdate_register_subsystem(&pci_liveupdate_ops);
> +	if (ret && liveupdate_state_updated())
> +		panic("PCI liveupdate: Register subsystem failed: %d", ret);
> +	WARN(ret, "PCI liveupdate: Register subsystem failed %d", ret);

But this didn't fail.

And you just crashed the box if panic-on-warn is enabled, so if some
test infrastructure builds this first patch, boom.

{sigh}

If you are going to do a "dummy" driver, please make it at least work
and not do anything bad.

thanks,

greg k-h

