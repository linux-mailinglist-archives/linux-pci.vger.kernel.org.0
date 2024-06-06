Return-Path: <linux-pci+bounces-8410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF7A8FF581
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 21:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E87288BCD
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D9B6EB7D;
	Thu,  6 Jun 2024 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo9p2ViJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B44C618;
	Thu,  6 Jun 2024 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703770; cv=none; b=vCmNBRUwXNjwDY/xXE9bkGilacP1HXtcvbGIDTPb5ZN3enekSEMRFDgpnC6Bjc6KipAQklXrS5ULMRk6gIbzpi+h+OWz2kWvm4PEOMwpzPDaOdLRZNSTL3Lp86G4volSqeYprvjs80BvRgx2qZxQnCry2y0OIV/ieF8SLcqLc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703770; c=relaxed/simple;
	bh=0IAiGnLisQODtmbVUvM/bZ5fn4fz5tUOHl97p3eYprc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CBiBL+y20H5zPJaC6KjiH8qebNkDOAzJInIToma8zOdWMr0ArTaTk5O2oXZEdQp7U46Jr9HZ8sSMm9DieKUohkoDz90QxL6Gp01C7v5Rs2YNateQz6fK2ZmmyFMFP02SOd0Da5p/KHxRc/V1CoyQAzWMgJiWGqPzxhqjbM+ELEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo9p2ViJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895CEC2BD10;
	Thu,  6 Jun 2024 19:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717703770;
	bh=0IAiGnLisQODtmbVUvM/bZ5fn4fz5tUOHl97p3eYprc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uo9p2ViJBY5udVAA0yPjZUyMc2fgHBhEq7LeErVy/2y7CBpffSjPQlAt1kVnrWTrv
	 SG+oGEluWCCYJP6cw77rued1DgGkozJchAeRVtqvV0/0LjkC7848phDfk2BSv43G5k
	 KVSNJ7rPwzM72dR17Vuqm0j2CLHXRGVrq+6UkAqSNvjKql0f29vfPnRZtcFUpzuNvh
	 a0y2PWhfC3/NdHfF871o2yZ+TsWp+XOuyE63W1qG1/IsUeBm5/xCh4KqLlL9rdF2tC
	 RA9t9sOMATpq6HUw/avxo1imCf5F1EBx+Y8NolBze277rqc6P2QZd+jYYfzYAx98FP
	 Qe2EdoaoKcWPA==
Date: Thu, 6 Jun 2024 14:55:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, bhelgaas@google.com,
	rafael@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: PCI: Remove unused struct 'acpi_handle_node'
Message-ID: <20240606195558.GA816336@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk9cTVvPoyzM4hYm@gallifrey>

On Thu, May 23, 2024 at 03:10:05PM +0000, Dr. David Alan Gilbert wrote:
> * Jonathan Cameron (Jonathan.Cameron@Huawei.com) wrote:
> > On Thu,  9 May 2024 01:08:58 +0100
> > linux@treblig.org wrote:
> > 
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > 'acpi_handle_node' is unused since
> > > Commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
> > > Remove it.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > FWIW, indeed unused.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Thanks; any idea who would pick this up?

Applied with Jonathan's reviewed-by to pci/misc for v6.11, thanks!

Rafael, let me know if you want this instead.  Easy for me to drop if
you do.

> > > ---
> > >  drivers/acpi/pci_root.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > index 58b89b8d950ed..59e6955e24edb 100644
> > > --- a/drivers/acpi/pci_root.c
> > > +++ b/drivers/acpi/pci_root.c
> > > @@ -293,11 +293,6 @@ struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
> > >  }
> > >  EXPORT_SYMBOL_GPL(acpi_pci_find_root);
> > >  
> > > -struct acpi_handle_node {
> > > -	struct list_head node;
> > > -	acpi_handle handle;
> > > -};
> > > -
> > >  /**
> > >   * acpi_get_pci_dev - convert ACPI CA handle to struct pci_dev
> > >   * @handle: the handle in question
> > 
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

