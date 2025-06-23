Return-Path: <linux-pci+bounces-30395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D638AE4448
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D941B60C03
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E431253F30;
	Mon, 23 Jun 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7ZSo+8c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A74250C06
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685710; cv=none; b=eIQjbEkj4A+mB8s4aAnTCfG+I2FHOtgoBaqjTw05RrCi01PiHIlcfRmMEh7f3nTdeCyGPetGQWtQxfGj+twfas5FmFV51pr4U524C6aetpf/uaC+Zgl0GZMmu9BhTI3l1walIglF/ItGAxUCw5LMGPEC5Jea/lq/0J1JEfbMTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685710; c=relaxed/simple;
	bh=aKv3s1gSP7mjjA9zejL2CpZhUz+utB/JGvSt+uv3Mks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCsZ+LnLJnhX9/tEEe7QHZ4qdut0ZR16SCjTzaNmBKKzor1oMUClxuCrGmvRlJUrDlf9dtWMdMJxcaAnZlWBdis67YvYTTOmte7wMZETsvANaLXqYNyPlLkq7pdqR9g6U8iD7kxnQnWrGFdcfxj9P4rWRXf+WXpyMgFswYXM4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7ZSo+8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFF5C4CEF2;
	Mon, 23 Jun 2025 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750685710;
	bh=aKv3s1gSP7mjjA9zejL2CpZhUz+utB/JGvSt+uv3Mks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7ZSo+8cWgmfe8MplB/2NUs39HUevakRFmewDReiLL4OuKoz9pW4BsLi1o4m4PXIi
	 aJr98rLhU0Zs1tLEEwMV9f+urhNJ/ix/HyFXzFK4+laSFEID7/ysdDqd5ORhfN50v/
	 ZanV4uW8TAfu5VmIFZ/XlS7aIxu/BM6Pi789WaK1aZUOH1Qozmu8BadYnxIc02TvsF
	 oD2Eyu4g1acX2RLHnOGY+drSs/o99gDZUq0j8hQ4hBTPOp/8YxiYspEGYWq5in1Qgg
	 XAljGpm3g3kO4iNI1Tfu1H/QzFzDelGP7mVBIvMwxZoDt3YGOLvVS6DSS4LWA45pMQ
	 NnOM6CJiICwcA==
Date: Mon, 23 Jun 2025 15:35:05 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: endpoint: Fix configfs group removal on driver
 teardown
Message-ID: <aFlYCRtF40Y2i7dX@ryzen>
References: <20250617010737.560029-1-dlemoal@kernel.org>
 <aFklrtQTwqKhOl39@ryzen>
 <011c4c6d-ebff-46e4-b32f-f93eb88dd82d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011c4c6d-ebff-46e4-b32f-f93eb88dd82d@kernel.org>

On Mon, Jun 23, 2025 at 09:01:53PM +0900, Damien Le Moal wrote:
> On 6/23/25 19:00, Niklas Cassel wrote:
> > 
> > I think it is a litte bit confusing that you attach a KASAN
> > splat to a patch that fixes two different bugs.
> > 
> > Surely this KASAN bug can be fixes with only:
> > 
> > -     list_del(&driver->epf_group);
> > +     WARN_ON(!list_empty(&driver->epf_group));
> 
> Yes, with that, you will not get the KASAN warning, but you will get the
> WARN_ON() to trigger unless bug #1 is applied first. But if you apply #1 first,
> then any testing done with that bug fix only will trigger a NULL pointer
> de-reference on the list_del().

Ok, let me rephrase :)

Surely this KASAN bug can be fixed with only:

-     list_del(&driver->epf_group);

As the bug is that the code is trying to delete a list head, which is just
wrong.


A patch 2/2 could add a list_del() to pci_ep_cfs_remove_epf_group() and the
WARN_ON() to pci_epf_remove_cfs().

Considering that pci_ep_cfs_remove_epf_group() also frees the memory for
the group, I think it is more correct to use list_del() rather than
list_del_init(), as no one will be able to re-use this group after calling
pci_ep_cfs_remove_epf_group() on it.


Kind regards,
Niklas

