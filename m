Return-Path: <linux-pci+bounces-15155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F09AD71D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 00:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D439FB2137C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 22:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB70195811;
	Wed, 23 Oct 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRE0bIq8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18652146018
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720846; cv=none; b=gKdTxNPxiigsxWyJTjFij9Wfymx4BrmxJ4BloORRF/G8w+zsgxgl02AZjpLI3XzUgfKA6jxW/kvy/DU9U3I6ZpAoZyM7dxvW3lk4oTRwu8l9gthkV9aTZnSq9WzK4cYKE2FCPagUhTscK7sjPR2og5c17fFXs+2GunTWFa14OrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720846; c=relaxed/simple;
	bh=bd2OJLgDac1hMcYyaMDm3y1s/qwrbDKuvfYtanCUsdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q56gEnzTxjDLek4A62/fNTzCnKScAEdygzNnBz5lW1kSzofa70XwYrYZv+J+wXNUBpJbBk2D/8Vt2SwFGNnGzRzwzU5MooPT3bOwI1OZSBC/bie/xMPtKoWxbW1JB6LWqKs4DDyWeWFvfg18yfYdn7ZC2S+rMmSwTgrJpqfsw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRE0bIq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C9BC4CEC6;
	Wed, 23 Oct 2024 22:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729720845;
	bh=bd2OJLgDac1hMcYyaMDm3y1s/qwrbDKuvfYtanCUsdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRE0bIq8ZvE7sTbmQrUVlVls39RWBD1Al+ZJWcFY3MPg0msjnCX0MiJ0s7v8j4kX0
	 jVF3snywJ0Rsf3gqXEqZZ5OEdD7ZBGdgyQPgAJtebk4zpKErawfXmkWe0dLHcKhexO
	 PIexjxyR/SBPVaoSLUz2lBwiVEGykZQQMmSlG03EhG36UHNolTwDOwq6AXP9yM2kYU
	 1mOrhOnDCo8zl+LsHZXZvSxrDVeOfmHoUXHPvFcjXVM6YaBNYpHwYcgDUQIgxYzqan
	 iJevQWXQUtsVEbif98aeITKPDJOwgR86cATzehM5v6ckY9adG3PBDpy6P56fFwB0+Y
	 zooGtYSmX964A==
Date: Wed, 23 Oct 2024 16:00:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, lukas@wunner.de,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCHv3 5/5] pci: unexport pci_walk_bus_locked
Message-ID: <ZxlyCvf1DQS9GYvS@kbusch-mbp>
References: <20241022224851.340648-6-kbusch@meta.com>
 <20241023214320.GA936997@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023214320.GA936997@bhelgaas>

On Wed, Oct 23, 2024 at 04:43:20PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 22, 2024 at 03:48:51PM -0700, Keith Busch wrote:
> > @@ -445,7 +445,6 @@ void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *
> >  
> >  	__pci_walk_bus(top, cb, userdata);
> >  }
> > -EXPORT_SYMBOL_GPL(pci_walk_bus_locked);
> 
> I think we could also move the declaration from include/linux/pci.h to
> drivers/pci/pci.h, right?
> 
> I guess there's some argument for keeping it in include/linux/pci.h
> next to the pci_walk_bus() declaration, but I certainly don't want to
> encourage more use of either one, especially outside the PCI core.

Thanks, that's a good point! Not only are modules not using this,
neither does any kernel code outside drivers/pci/, so no need to
declare this in include/linux/.

