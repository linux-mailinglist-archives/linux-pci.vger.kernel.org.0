Return-Path: <linux-pci+bounces-11241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE405946CBB
	for <lists+linux-pci@lfdr.de>; Sun,  4 Aug 2024 08:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABDBB20C0B
	for <lists+linux-pci@lfdr.de>; Sun,  4 Aug 2024 06:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F171187F;
	Sun,  4 Aug 2024 06:32:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10E17C64;
	Sun,  4 Aug 2024 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722753151; cv=none; b=SGQaapl/8Zii0lWKNbt5aSbsQR8OS4zgQFEkp+Fzqos0mwBuOhGDm0um4jqEW2q9blkoltt+fCwG6XI6xJDsDaKIb3XbhtpBEzRsxBF88JPheIEWUFhZ+S4D4j1uhdKHa3Psx9uwdangDcIH7POxa9uHlqr3Tr/lPpQYCnx4U30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722753151; c=relaxed/simple;
	bh=apnte0YLRp9ITKzQNsbkX3OBwSADjQ8BSHYEeJJVcY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRuwcTDKLehoAK1jsnk3d+4RvLOAqs36IdbxGWw6p1FwyN1TqDNoiBvF0rr8UxAgiDmymkwvZjHBpDT7DetEiTrpdgd1N1xqTDYwifFHoFxp35BVIqoP7XZXEwzlRS2fN0cCc1rnAlutru6Ixl80drzuh7nfonSpPwODMToweFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 3C539100B04C5;
	Sun,  4 Aug 2024 08:32:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 138A839041D; Sun,  4 Aug 2024 08:32:18 +0200 (CEST)
Date: Sun, 4 Aug 2024 08:32:18 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com,
	gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
	rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v14 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <Zq8gciQnRjDZwSTK@wunner.de>
References: <20240710023310.480713-1-alistair.francis@wdc.com>
 <20240710023310.480713-3-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710023310.480713-3-alistair.francis@wdc.com>

On Wed, Jul 10, 2024 at 12:33:09PM +1000, Alistair Francis wrote:
> v14:
>  - Revert back to v12 with extra pci_remove_resource_files() call
> v13:
>  - Drop pci_doe_sysfs_init() and use pci_doe_sysfs_group
>      - As discussed in https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
>        we can just modify pci_doe_sysfs_group at the DOE init and let
>        device_add() handle the sysfs attributes.
> v12:
>  - Drop pci_doe_features_sysfs_attr_visible()
> v11:
>  - Gracefully handle multiple entried of same feature
>  - Minor fixes and code cleanups

Hm, it looks like the review comments I left for v11 were never addressed :(

https://lore.kernel.org/all/ZmxvnLDBhkWPrXGK@wunner.de/
https://lore.kernel.org/all/Zm2RmWnSWEEX8WtV@wunner.de/

In particular, pci_{create,remove}_resource_files() is not the right place
to dynamically add attributes.  Move the calls of pci_doe_sysfs_init()
and pci_doe_sysfs_teardown() to pci_device_add() and pci_destroy_dev(),
respectively.  This is also what I'm doing for dynamic CMA attributes
and what Mariusz is doing for LEDs added on enumeration:

https://lore.kernel.org/all/77f549685f994981c010aebb1e9057aa3555b18a.1719771133.git.lukas@wunner.de/
(search for pci_cma_publish)

https://lore.kernel.org/all/20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com/
(search for pci_npem_create and pci_npem_remove)

Thanks,

Lukas

