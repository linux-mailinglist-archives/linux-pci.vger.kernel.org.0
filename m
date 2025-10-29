Return-Path: <linux-pci+bounces-39675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D242EC1C3D2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 255964E86A1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200142D027E;
	Wed, 29 Oct 2025 16:31:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1F2236F7
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755475; cv=none; b=ry3AmxAyo6g3WThsHO5Pfrk2L2it3kMbeasBzT0cD3EyEZJrQd/flm5PZcQ+2RTcdN9tUaeyxCJrn51NM0lT4falm3t+zoZWRonk6HVt+qzsxbI7sIlbSouDEi4iNFGRT9m70beB7lsV9hY3GhIf2e2LQBs1YD03dzeMWVywemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755475; c=relaxed/simple;
	bh=GxlAG7pxgonSTqzQqs8W/DcFKII6LcS7gpmlXKgt/Zk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1Kvpa/v/2btsf/0fJA659Bd7ntydHmIlsBgBN3TroZzCiE61Uk4hRBL2ZCppTibTzRqjWlTbjcqWNjt7g+cLcvuyws5Ix38nJ21BmYsE6aO5SeltnNCLOpUJ2dIa+HIS1/bvEZnt+kafKfWLpGxzf4Q3Y5Jt1UQlji8madGCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cxXmj1HGhzJ46BS;
	Thu, 30 Oct 2025 00:31:01 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 39393140278;
	Thu, 30 Oct 2025 00:31:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 16:31:10 +0000
Date: Wed, 29 Oct 2025 16:31:09 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>
Subject: Re: [PATCH v7 8/9] PCI/IDE: Report available IDE streams
Message-ID: <20251029163109.000030ae@huawei.com>
In-Reply-To: <20251024020418.1366664-9-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
	<20251024020418.1366664-9-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 23 Oct 2025 19:04:17 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The limited number of link-encryption (IDE) streams that a given set of
> host bridges supports is a platform specific detail. Provide
> pci_ide_init_nr_streams() as a generic facility for either platform TSM
> drivers, or PCI core native IDE, to report the number available streams.
> After invoking pci_ide_init_nr_streams() an "available_secure_streams"
> attribute appears in PCI host bridge sysfs to convey that count.
> 
> Introduce a device-type, @pci_host_bridge_type, now that both a release
> method and sysfs attribute groups are being specified for all 'struct
> pci_host_bridge' instances.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

New day, new comments.  Nothing huge, but I would avoid the defining
an attr group to NULL as that feels like storing up bugs for the future.

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d3f16be40102..8b356dd09105 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -616,9 +616,12 @@ static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
>  #ifdef CONFIG_PCI_IDE
>  void pci_ide_init(struct pci_dev *dev);
>  void pci_ide_init_host_bridge(struct pci_host_bridge *hb);
> +extern const struct attribute_group pci_ide_attr_group;
> +#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
>  #else
>  static inline void pci_ide_init(struct pci_dev *dev) { }
>  static inline void pci_ide_init_host_bridge(struct pci_host_bridge *hb) { }
> +#define PCI_IDE_ATTR_GROUP NULL

This only works if we assume nothing else ever ends up in pci_host_bridge_groups.
i.e. it's fragile - think of someone adding something after this.
Whilst I don't like ifdefs inline, there isn't a better option for this case that
I can think of.

>  #endif
>  
>  #ifdef CONFIG_PCI_TSM
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index e638f9429bf9..85645b0a8620 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -63,6 +63,7 @@ struct pci_ide {
>  	const char *name;
>  };
>  
> +void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr);
>  struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev,
>  					    struct pci_ide *ide);
>  struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 302f7bae6c96..44f62da5e191 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c

> +/**
> + * pci_ide_set_nr_streams() - sets size of the pool of IDE Stream resources
> + * @hb: host bridge boundary for the stream pool
> + * @nr: number of streams
> + *
> + * Platform PCI init and/or expert test module use only. Limit IDE
> + * Stream establishment by setting the number of stream resources
> + * available at the host bridge. Platform init code must set this before
> + * the first pci_ide_stream_alloc() call if the platform has less than the
> + * default of 256 streams per host-bridge.
> + *
> + * The "PCI_IDE" symbol namespace is required because this is typically
> + * a detail that is settled in early PCI init. I.e. this export is not
> + * for endpoint drivers.
> + */
> +void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr)
> +{
> +	if (nr > 256)
> +		nr = 256;


hb->nr_ide_streams = min(nr, 256);
maybe

> +	hb->nr_ide_streams = nr;
> +	WARN_ON_ONCE(!ida_is_empty(&hb->ide_stream_ida));
> +	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_ide_set_nr_streams, "PCI_IDE");



