Return-Path: <linux-pci+bounces-10744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7541B93B737
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 21:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2674E281715
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 19:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945615FD16;
	Wed, 24 Jul 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJGeZfef"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8515F403
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848233; cv=none; b=JOxqfZSSjF79JgXWVHnBIx/DqGkTcBvHbcdcIVfv6LRmUh7c9KLpTDIbqPAsDhIgYUdZO1geM0gNl/C/FzkDAgkwu/dlC7l/VdPxpMlrMJ3QCGHztPDvfCX6DTU+SXRFXECIq/7/m93oL/MVd/nxwGrXuIeolwD6J9Zhqg4VMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848233; c=relaxed/simple;
	bh=dFpa70ZJP28VQjYHLsU0meCJmv7S4f8fEaF8elB+tZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nGHvDxyXZmRtJl66K63hMRSxrTHgzspJCBB5m37LUGWLcJnOJJ7pVgiKT9e/M5AEOQjGvBBy/DpeMKoh0AGgtVtX4ai5qWOL/muyf3+ku2iMWg0C6YlRdQ1ZJrHgB7FN/vrtk+Zah3Ru2RXREfDhLPhnEeeb0ncxxd4hD5jy1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJGeZfef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588F8C32781;
	Wed, 24 Jul 2024 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721848232;
	bh=dFpa70ZJP28VQjYHLsU0meCJmv7S4f8fEaF8elB+tZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JJGeZfef/llGuSsFpo5X8RH5AD8SsvVs9O4N3Z8vqFocAGhgDgYIcPfBHBOaM9FC7
	 JbpTydmZzw8h2shjQbM6oDokVtENug6SGJP7mZNdq4dU1XzjgaLC7qgDvKtyJbUNxf
	 l9vN9MWXuB2Nol3Qfq2HXLleX4A2KOL8X9sKJQLuDDAX2uu7u8oakb3erqKKZOEQwo
	 d6aCaU5tGMBD1TR9s4tXPQSyG6FFpN9QKR1WvmSQj3opdJ7XjvqRtDJW5q/eQWLaX9
	 9DcN4mBNEOmlOMVRLK4t9wRecST0Qznz16SoWjsbmdYzMS3ePvwTahboVN2mwj4mZN
	 scXu5re5r8YsA==
Date: Wed, 24 Jul 2024 14:10:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, paul.m.stillwell.jr@intel.com,
	Jim Harris <james.r.harris@intel.com>
Subject: Re: [PATCH] PCI: fixup PCI_INTERRUPT_LINE for VMD downstream devices
Message-ID: <20240724191030.GA806685@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724170040.5193-1-nirmal.patel@linux.intel.com>

On Wed, Jul 24, 2024 at 10:00:40AM -0700, Nirmal Patel wrote:
> VMD does not support legacy interrupts for devices downstream from a
> VMD endpoint. So initialize the PCI_INTERRUPT_LINE to 0 for these
> devices to ensure we don't try to set up a legacy irq for them.

s/legacy interrupts/INTx/
s/legacy irq/INTx/

> Note: This patch was proposed by Jim, I am trying to upstream it.
> 
> Signed-off-by: Jim Harris <james.r.harris@intel.com>
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  arch/x86/pci/fixup.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b33afb240601..a3b34a256e7f 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -653,6 +653,20 @@ static void quirk_no_aersid(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
>  
> +#if IS_ENABLED(CONFIG_VMD)
> +/* 
> + * VMD does not support legacy interrupts for downstream devices.
> + * So PCI_INTERRPUT_LINE needs to be initialized to 0 to ensure OS
> + * doesn't try to configure a legacy irq.

s/legacy interrupts/INTx/
s/PCI_INTERRPUT_LINE/PCI_INTERRUPT_LINE/

> + */
> +static void quirk_vmd_interrupt_line(struct pci_dev *dev)
> +{
> +	if (is_vmd(dev->bus))
> +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 0);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_vmd_interrupt_line);

A quirk for every PCI device, even on systems without VMD, seems like
kind of a clumsy way to deal with this.

Conceptually, I would expect a host bridge driver (VMD acts like a
host bridge in this case) to know whether it supports INTx, and if the
driver knows it doesn't support INTx or it has no _PRT or DT
description of INTx routing to use, an attempt to configure INTx
should just fail naturally.

I don't claim this is how host bridge drivers actually work; I just
think it's the way they *should* work.

> +#endif
> +
>  static void quirk_intel_th_dnv(struct pci_dev *dev)
>  {
>  	struct resource *r = &dev->resource[4];
> -- 
> 2.39.1
> 

