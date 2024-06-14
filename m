Return-Path: <linux-pci+bounces-8848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0B990903A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 18:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6CE1F225A1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9906C16F0D1;
	Fri, 14 Jun 2024 16:28:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA84637;
	Fri, 14 Jun 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382498; cv=none; b=klv1u826hOyzL72uDUY+NbqC3doLpeaQgyVhjkKCv6dYjU5EvOkeUR+aHbdQ9rd2zuXi7anA0zvcQT0Q392I4OG3JzHxJKIfOtYzHCAcTSEfhSesaGIhRVmzavWWEb0h7Ss9/Hj0E6q35xTy1xAazZjTybdKYUzEgoUMsLjKhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382498; c=relaxed/simple;
	bh=vXSQ5+BquuRvhQj/1WKknpvAxJollwsRa0HUggyd0vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAEvBDAFbTFQlXUvXVz31YO/sjlZva4gGyrQDOytdMoRbaTSk7qeVS9mAsP3AMGtq/1Om7PaXP/p9eftn3s1SCsswFlBsbBGfA0d5STBpgXhd7wNz2FiijSnri4hQ1dW+zwmeCFROB+i4QN6VlVJam29vqnkN4OWdQLZXltHPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 921F32800F9A4;
	Fri, 14 Jun 2024 18:28:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7AC6AFF5DD; Fri, 14 Jun 2024 18:28:12 +0200 (CEST)
Date: Fri, 14 Jun 2024 18:28:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com,
	gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
	rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v11 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <ZmxvnLDBhkWPrXGK@wunner.de>
References: <20240614001244.925401-1-alistair.francis@wdc.com>
 <20240614001244.925401-3-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614001244.925401-3-alistair.francis@wdc.com>

On Fri, Jun 14, 2024 at 10:12:43AM +1000, Alistair Francis wrote:
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <linux/stat.h>
>  #include <linux/export.h>
>  #include <linux/topology.h>

I'm not seeing any symbols used here which are defined in pci-doe.h.
Am I missing something?

If not this additional #include can be dropped.


> @@ -1143,6 +1144,9 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
>  {
>  	int i;
>  
> +	if (IS_ENABLED(CONFIG_PCI_DOE))
> +		pci_doe_sysfs_teardown(pdev);
> +

No need to constrain to "if (IS_ENABLED(CONFIG_PCI_DOE))" as you're
defining an empty static inline in the header file.


> @@ -1227,6 +1231,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
>  	int i;
>  	int retval;
>  
> +	if (IS_ENABLED(CONFIG_PCI_DOE)) {
> +		retval = pci_doe_sysfs_init(pdev);
> +		if (retval)
> +			return retval;
> +	}
> +

Same here.

Note that pci_{create,remove}_resource_files() is not the right place
to dynamically add sysfs attributes.  These functions are called very
late to postpone exposure of ROM resources until they're enumerated.
You want to add your sysfs attributes right after device_add() has been
called and you want to remove them right before device_del() is called.

See here for an example how it's done correctly:

https://lore.kernel.org/all/20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com/

(Search for the call to pci_npem_create() in pci_device_add() and
pci_npem_remove() in pci_destroy_dev().)


> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -189,6 +189,7 @@ extern const struct attribute_group *pci_dev_groups[];
>  extern const struct attribute_group *pci_dev_attr_groups[];
>  extern const struct attribute_group *pcibus_groups[];
>  extern const struct attribute_group *pci_bus_groups[];
> +extern const struct attribute_group pci_doe_sysfs_group;
>  #else
>  static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
>  static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
> @@ -196,6 +197,7 @@ static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
>  #define pci_dev_attr_groups NULL
>  #define pcibus_groups NULL
>  #define pci_bus_groups NULL
> +#define pci_doe_sysfs_group NULL
>  #endif

You only need the "extern const struct ..." definition, not the
NULL definition.  The reason we have these NULL definitions is
because we're referencing the attribute groups in files which
are compiled even if CONFIG_SYSFS=n.  But I believe that's not
the case here.

Thanks,

Lukas

