Return-Path: <linux-pci+bounces-15153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11599AD6D7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 23:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6933E1F23765
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC270146A79;
	Wed, 23 Oct 2024 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjGQG6rZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE981E56A
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719802; cv=none; b=h395ZugA1vdK4sNonNp+hP0nLdIoN8e2Buogfvj3KPAwzKk8NBElgNkXA86aGCu0TtotAGX4IUGsiQsz9EqwVR79cvTpqZhXrMwACxVe7H8QUqZ7f3N9KKIj5Se+PdmOlkbZ+9/e+OQtdmRMttoWWoNdxvkEdWoC4M17zWTAKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719802; c=relaxed/simple;
	bh=UiJNJ6WHwTJw+vssvOOnywVYzyNu57tBD+4zlLkayaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KxiVnzVJyTmv5qTDsa9RHt7JiN6g1Xzgd7P4qyEncmj33P5F+rxpfBCeKySk1qbg5+KqJw13tR9+9L89jwXCwWe7MU6tHIegqC5QHtXLXqIVoustMRWlIRJc1EPZRr411LTB8TCGomgw7nAu17SbGEB6cbG+43yzE0Giy2qISz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjGQG6rZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5466BC4CEC6;
	Wed, 23 Oct 2024 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729719802;
	bh=UiJNJ6WHwTJw+vssvOOnywVYzyNu57tBD+4zlLkayaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PjGQG6rZ5dbC1XXQc5egCQ+VGyACLg2KBeALNNPtOCnHtXhLXb27r8R0oX42Wzxuz
	 6byZtlWIT8zwf2w5GskoRUDwMX3DTtRpadXwl+xxy7xQv1hZjyVMNVMFbik79AIV7X
	 vgzaJk/LGVIDPyZVoa+Tv8ksBb6i9XfxdLitvukZLkr4tittG3TrOeI4+DD98qj7LD
	 loC8bZas4bzZzgls68b6yWy7myIrEbUuJ/E9d4HiMbmZ0d2Yde389GAlWylrTad4Le
	 l9LOZlVnqbWmxdhyfrCKD5M/gqVMiCe966Iaf8hl9Celk3lbVx2j46eSOjSFMY/+jJ
	 E26Y3ES5bvefA==
Date: Wed, 23 Oct 2024 16:43:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, lukas@wunner.de,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCHv3 5/5] pci: unexport pci_walk_bus_locked
Message-ID: <20241023214320.GA936997@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022224851.340648-6-kbusch@meta.com>

On Tue, Oct 22, 2024 at 03:48:51PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> There's only one user of this, and it's internal, so no need to export
> it.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/bus.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 9c552396241e0..d015d5821cefc 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -445,7 +445,6 @@ void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *
>  
>  	__pci_walk_bus(top, cb, userdata);
>  }
> -EXPORT_SYMBOL_GPL(pci_walk_bus_locked);

I think we could also move the declaration from include/linux/pci.h to
drivers/pci/pci.h, right?

I guess there's some argument for keeping it in include/linux/pci.h
next to the pci_walk_bus() declaration, but I certainly don't want to
encourage more use of either one, especially outside the PCI core.

