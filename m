Return-Path: <linux-pci+bounces-19353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25872A02F65
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 19:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44491885678
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5511DF981;
	Mon,  6 Jan 2025 18:01:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637641DF97D;
	Mon,  6 Jan 2025 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186513; cv=none; b=oma8DrfK3i7P8+oq2caTjJrW1lwCFEa7AdC4mqEnkGqU9BgNlnC5HxLhM5x4YchvAl2/cbo03+pgO8ADsk91+gN9MC5SDoqLS0iF6WxEXGRgpggC8arxmI8ZN2FXEbn0VTRoxPJRNP3nyLnVs3Z9XPUttILWlUgb8bArtWrNhHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186513; c=relaxed/simple;
	bh=bBys0F/7N0RBkrQ1f7e0vGrpJamGHK669h9LdW7XWlU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FglsqywiwKQapN/qWh9hg2b+5agefwti+ZSypUib4+2Htig6mbQ8u2l9EsWJV4dbEYzLXQASKPzl9mo8h7PtBblABIVSEeQ0F2OxZG5EE2b9DnOiFBFrpJKKrqDsNPJRPXFqUDFSLjMIFz+IkUmbAUMRO99GKm8fYoPSTHM+o1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YRhmB3Y2Qz6M4dK;
	Tue,  7 Jan 2025 02:00:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A4498140736;
	Tue,  7 Jan 2025 02:01:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 6 Jan
 2025 19:01:41 +0100
Date: Mon, 6 Jan 2025 18:01:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<lenb@kernel.org>, <robert.moore@intel.com>, <bhelgaas@google.com>,
	<wei.huang2@amd.com>, <honnappa.nagarahalli@arm.com>,
	<dhruv.tripathi@arm.com>, <rob.herring@arm.com>, <jeremy.linton@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 0/2] GENL interface for ACPI _DSM methods
Message-ID: <20250106180140.00005132@huawei.com>
In-Reply-To: <20250106163045.508959-1-wathsala.vithanage@arm.com>
References: <20250106163045.508959-1-wathsala.vithanage@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 6 Jan 2025 16:30:43 +0000
Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:

> Linux v6.13-rc1 added support for PCIe TPH and direct cache injection.
> As already described in the patch set[1] that introduced this feature,
> the cache injection in supported hardware allows optimal utilization of
> platform resources for specific requests on the PCIe bus. However, the
> patch set [1] implements the functionality for usage within the kernel.
> But certain user space applications, especially those whose performance
> is sensitive to the latency of inbound writes as seen by a CPU core, may
> benefit from using this information (E.g., the DPDK cache stashing
> feature discussed in RFC [2]). This RFC is an attempt to obtain the PCIe
> steering tag information from the kernel to be used by user mode
> applications. We understand that there is more than one way to provide
> this information. Please review and suggest alternatives if necessary.
> 
> The first of the two patches introduced in this RFC attempts to overcome
> the kernel-only limitation by providing an API to kernel subsystems to
> hook up relevant _DSM methods to a GENL interface. User space
> applications can invoke a _DSM hooked up to this interface via the
> "acpi-event" GENL family socket, granted they have the minimum
> capabilities and message formats demanded by the kernel subsystem that
> hooked up the _DSM method. This feature is added by extending the
> "acpi-event" GENL family that multicasts ACPI events to the user-space
> applications such as acpid.
> 
> The second patch of this RFC hooks up the PCIe root-port TLP Processing
> Hints (TPH) _DSM to the ACPI GENL interface. User space applications
> like [2] can now request the kernel to execute the _DSM on their behalf
> and return steering-tag information.
> 
> [1] lore.kernel.org/linux-pci/20241002165954.128085-1-wei.huang2@amd.com
> [2] inbox.dpdk.org/dev/20241021015246.304431-2-wathsala.vithanage@arm.com

Hi Wathsala,

Superficially this feels like another potential interface that could be wrapped
up under appropriate fwctl. Jason, what do you think?

Mind you I'm not personally convinced that an interface that focuses on
exposing _DSM calls to userspace makes sense as opposed to subsystem specific
stuff.

Maybe consider associating the actual interface with the individual PCI functions
(which provides the first chunk of the message directly).

Also, _DSM is just one form of firmware interface used for PCI supporting
system. Tying the userspace interface to that feels unwise.  I can certainly
foresee a PSCI/SCMI or similar interface for this on ARM platforms
wrapped up in _DSM where ACPI is present but directly accessed when DT
is in use.

I'd also request that you break out what goes in ARG0,1,2 as that is all
stuff that the kernel is aware of and not all reviewers have access to the
ECN (I do though).  In particular the fact there are ACPI UIDs may
need a more generic solution.

Jonathan

> Wathsala Vithanage (2):
>   ACPI: Add support for invoking select _DSM methods from user space
>   PCI: Add generic netlink interface to TPH _DSM
> 
>  drivers/acpi/Makefile                 |   3 +-
>  drivers/acpi/{event.c => acpi_genl.c} | 110 ++++++++++++++++++++++-
>  drivers/acpi/acpi_genl_dsm.c          |  76 ++++++++++++++++
>  drivers/pci/tph.c                     | 121 ++++++++++++++++++++++++++
>  include/acpi/acpi_genl.h              |  54 ++++++++++++
>  include/linux/acpi.h                  |   1 +
>  6 files changed, 360 insertions(+), 5 deletions(-)
>  rename drivers/acpi/{event.c => acpi_genl.c} (63%)
>  create mode 100644 drivers/acpi/acpi_genl_dsm.c
>  create mode 100644 include/acpi/acpi_genl.h
> 


