Return-Path: <linux-pci+bounces-37762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 475D4BC9926
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 16:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15BD1A60C32
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9DF2EACF1;
	Thu,  9 Oct 2025 14:41:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859472EA72A;
	Thu,  9 Oct 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020918; cv=none; b=Lw9SNqn27T7eM6KqkdvdBzcazGtsO3ANB5IGJucUY+2k7j6Fzs8infrnsMOeVMaVBKyXDDyqu4eoA8wGqt1MQU5NsrhKfhLsDgMA8WraS+tRph6xPI5dCsVV07eqf6seTTey7aZ3/c9pVA3Sp87/Bq29ltocGEMw3DdhTW2YDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020918; c=relaxed/simple;
	bh=sC/XZAqpJzpobFxBHDZsCZmS63EZEGChI+Ey0HYlrno=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0sQMbfxM3DoNt//MsqpNsMmW0jQCbUNb/Vwqt041MyW5V6VG06R5HNDptjNRgNeJ1G2Vt3oTPT4uJoDg9xAstXJekN7A7aeIcyGBNzSAp2Zfbn3gbC2L19w22r9Vod5LRWnco12W44whTH3rxzA7po1IZ/N3MkyRbE6KYSXFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjCHB2hVFz67Cxd;
	Thu,  9 Oct 2025 22:41:10 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 32C5A1400CA;
	Thu,  9 Oct 2025 22:41:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 15:41:52 +0100
Date: Thu, 9 Oct 2025 15:41:50 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Evangelos Petrongonas <epetron@amazon.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, David
 Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, Chris Li
	<chrisl@kernel.org>, Jason Miu <jasonmiu@google.com>, "Pratyush Yadav"
	<pratyush@kernel.org>, Stanislav Spassov <stanspas@amazon.de>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [RFC PATCH 05/13] pci: pcsc: control the cache via sysfs and
 kernel params
Message-ID: <20251009154150.00001d8c@huawei.com>
In-Reply-To: <2a0e6b85b06fef2d77ddd6879dea4335aeb3021f.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
	<2a0e6b85b06fef2d77ddd6879dea4335aeb3021f.1759312886.git.epetron@amazon.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 3 Oct 2025 09:00:41 +0000
Evangelos Petrongonas <epetron@amazon.de> wrote:

> Add kernel parameters and runtime control mechanisms for the PCSC
> 
> A new kernel parameter 'pcsc_enabled' allows enabling or disabling
> the cache at boot time. The parameter defaults to disabled.
> 
> A sysfs interface at /sys/bus/pci/pcsc/enabled provides:
> - Read access to query current cache status (1=enabled, 0=disabled)
> - Write access to dynamically enable/disable the cache at runtime
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci-pcsc  | 20 ++++
>  .../admin-guide/kernel-parameters.txt         |  3 +
>  drivers/pci/pcsc.c                            | 93 ++++++++++++++++++-
>  3 files changed, 114 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-pcsc
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-pcsc b/Documentation/ABI/testing/sysfs-bus-pci-pcsc
> new file mode 100644
> index 000000000000..ee92bf087816
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-pcsc
> @@ -0,0 +1,20 @@
> +PCI Configuration Space Cache (PCSC)
> +-------------------------------------
> +
> +The PCI Configuration Space Cache (PCSC) is a transparent caching layer
> +that intercepts configuration space operations to reduce hardware access
> +overhead. This subsystem addresses performance bottlenecks in PCI
> +configuration space accesses, particularly in virtualization
> +environments with high-density SR-IOV deployments where repeated
> +enumeration of Virtual Functions creates substantial delays.
> +
> +What:			/sys/bus/pci/pcsc/enabled
> +Date:			September 2025
> +Contact:		Linux PCI developers <linux-pci@vger.kernel.org>
> +Description:
> +				PCI Configuration Space Cache (PCSC) is a subsystem that
> +				caches accesses to the PCI configuration space of PCI
> +				functions. When this file contains the "1", the kernel
> +				is utilizing the cache, while when on "0" the
> +				system bypasses it. This setting can also be controlled
> +parameter.
indent issue on this last line.

Excellent to see someone remembering the ABI docs for once in an RFC!


> diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
> index 343f8b03831a..44d842733230 100644
> --- a/drivers/pci/pcsc.c
> +++ b/drivers/pci/pcsc.c
> +static struct kobj_attribute pcsc_enabled_attribute =
> +	__ATTR(enabled, 0644, pcsc_enabled_show, pcsc_enabled_store);
> +
> +static struct attribute *pcsc_attrs[] = {
> +	&pcsc_enabled_attribute.attr,
> +	NULL,
Trivial but no need for that trailing comma after the NULL terminator.
We don't want it to be easy to accidentally add something after that.

> +};
> +
> +static struct attribute_group pcsc_attr_group = {
> +	.attrs = pcsc_attrs,
> +};
> +
> +static struct kobject *pcsc_kobj;
> +
> +static void pcsc_create_sysfs(void)
> +{
> +	struct kset *pci_bus_kset;
> +	int ret;
> +
> +	if (pcsc_kobj)
> +		return; /* Already created */

Why do we need the kobject? Can't we make this a group on the
pci_bus_kset->kobj with a group name of pcsc?

(I see you have a comment on this next bit later in here)
Event better if we can arrange for not to be added after that is
created but just be a group on it in the first place.
That is make it a group in bus_groups of the pci_bus_type alongside
the one with bus_attr_rescan.attr in it.

That should mean you don't need the two tried to set it up that
you have currently.

> +
> +	pci_bus_kset = bus_get_kset(&pci_bus_type);
> +	if (!pci_bus_kset) {
> +		/* PCI bus kset not ready yet, will be retried later */
> +		return;
> +	}
> +

> +
> +/*
> + * The PCI subsystem is initialised later, therefore we need to add
> + * our sysfs entries later. This is done to avoid modifying the sysfs
> + * creation of the core pci driver.
Vs complexity and races, I think I'd rather you did modify that.

> + */
> +late_initcall(pcsc_sysfs_init);


