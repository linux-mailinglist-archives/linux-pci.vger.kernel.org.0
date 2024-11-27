Return-Path: <linux-pci+bounces-17391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5939DA2DA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 08:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36059166F06
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD71494AB;
	Wed, 27 Nov 2024 07:10:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA9713CA95
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691456; cv=none; b=dTQHFwRHZrwceyEerg9LeVmK2+VnoWjfoe116TLO/lPWmMARaGG5cwVnHtRTQwX4+otOgzIDh9FipeSlEladYm6fP2U89TGd8ux4sdGlZsTSGKLd49aIa286cD/OMIwZBATEWLFVwLK76t/YWCrbL3wQmoJn6k3Rr8rs9jlrED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691456; c=relaxed/simple;
	bh=6dbUPVQh8Ch+/GT6RkfNVqQ8/HQFQPFohRxjriDnEFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxsPe74YXaekfMNMLVjLLtLf0h7UZAXYudaiiczJYVd1RADrugkIGkI+ILlKPO7r9pwjKALvtu1xthg1jD+zK6D68lPYN84As0jXjfqrYtQK14QMHAspTfDlndywMoRWWIiuawqBV9p0ZxBXkJkPKKeuOwqQZIu5/4akhHGFrek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D2784100E5F3F;
	Wed, 27 Nov 2024 08:10:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AA47656DFE5; Wed, 27 Nov 2024 08:10:43 +0100 (CET)
Date: Wed, 27 Nov 2024 08:10:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: fengnan chang <fengnanchang@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Deadlock during PCIe hot remove and SPDK exit
Message-ID: <Z0bF81fgwwc9wXJj@wunner.de>
References: <D0B37524-9444-423B-9E48-406CF9A29A6A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0B37524-9444-423B-9E48-406CF9A29A6A@gmail.com>

On Wed, Nov 27, 2024 at 02:56:57PM +0800, fengnan chang wrote:
> Dear PCI maintainers:
>    I'm having a deadlock issue, somewhat similar to a previous one https://lore.kernel.org/linux-pci/CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM/#t??? but my kernel (6.6.40) already included the fix f5eff55.

Could you try a contemporary kernel such as v6.12 and test if it
still exhibits the issue?


> irq/148-pciehp stack, cat /proc/513/stack
> [<0>] vfio_unregister_group_dev+0x97/0xe0 [vfio]     //wait for 
> [<0>] vfio_pci_core_unregister_device+0x19/0x80 [vfio_pci_core]
> [<0>] vfio_pci_remove+0x15/0x20 [vfio_pci]
> [<0>] pci_device_remove+0x39/0xb0
> [<0>] device_release_driver_internal+0xad/0x120
> [<0>] pci_stop_bus_device+0x5d/0x80
> [<0>] pci_stop_and_remove_bus_device+0xe/0x20
> [<0>] pciehp_unconfigure_device+0x91/0x160   //hold pci_rescan_remove_lock, release reset_lock of ctrl B 
> [<0>] pciehp_disable_slot+0x6b/0x130
> [<0>] pciehp_handle_presence_or_link_change+0x7d/0x4d0
> [<0>] pciehp_ist+0x236/0x260             //hold reset_lock of ctrl B

It says here "wait for".

Wait for what?  Why is vfio_unregister_group_dev() blocking?

Thanks,

Lukas

