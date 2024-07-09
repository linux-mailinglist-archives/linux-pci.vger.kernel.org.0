Return-Path: <linux-pci+bounces-10008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458AB92BF8E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 18:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BFD1F25862
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CAB82494;
	Tue,  9 Jul 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmtYy8OS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1FA34;
	Tue,  9 Jul 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541979; cv=none; b=ZipbGClmb+zJHCxq9qzr5EmRCa9xoQwYA5fncmNV6AIULepnzdVi1QZrYLkzasWODKD9wwiSITUCQlxc34tCa9V8mgH33k3JaBAiTKt1kcmI5uEadhOUIOr80pSWPU5FneLmWq3pEXhCjeEO/8lJumDfH7ndpnLFoW6ot8oc2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541979; c=relaxed/simple;
	bh=E2gODmvDj/noFSq0Ij194HBL9MaQfm0x0CDWqpYQLc4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=diW8NDylNHYCiv7Pip/oLWxVtQ0sc+Hv7uO/+BMluGZTIxBhXzmkiMciDrZ0hvERgDX/36kUWp/RedllISFwPk79op+hTPrq/p8DiyNG4QkwrU3+vsfW2Fh6qog9s9KSOK/xPJ2Aj0XDJeo+PFtl3J7v/lgXpcUDL9zn+T05Y24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmtYy8OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0887C3277B;
	Tue,  9 Jul 2024 16:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541978;
	bh=E2gODmvDj/noFSq0Ij194HBL9MaQfm0x0CDWqpYQLc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GmtYy8OS3GPfUH6SjjcYrrTd2lYraSUOEC7ox0EuX2EP4K7JwXSsxdronJnaX8Tht
	 ugziB5fDn6HtjuY45znqV2M7Dv0eYPxpMQyZWA3+rfMirdneeXumH7Wlm4MC/S9iYL
	 g8zbpROvK++FSib7NbhgHaiUT1e5kPdxFBoE92Vr/VN6i/HBXTacC8cI5IcxpR50gE
	 nw31O8ilLdHwT1Oe3K+Qhp+zVTnDncjJvOtxHGwtNH4HUky/uUhwCEkcXouimwmCJ9
	 M56Zzmt5vA+7I0oPsRbINIhAdcMsoUGX2U3FIfKp6Y7H+6e/+YqAMlVM7UJUaJjNOB
	 nBB36TIA0qscw==
Date: Tue, 9 Jul 2024 11:19:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/6] x86: PCI: preserve IORESOURCE_STARTALIGN
 alignment
Message-ID: <20240709161936.GA175713@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709133610.1089420-5-stewart.hildebrand@amd.com>

On Tue, Jul 09, 2024 at 09:36:01AM -0400, Stewart Hildebrand wrote:
> Currently, it's not possible to use the IORESOURCE_STARTALIGN flag on
> x86 due to the alignment being overwritten in
> pcibios_allocate_dev_resources(). Make one small change in arch/x86 to
> make it work on x86.

Is this a regression?  I didn't look up when IORESOURCE_STARTALIGN was
added, but likely it was for some situation on x86, so presumably it
worked at one time.  If something broke it in the meantime, it would
be nice to identify the commit that broke it.

Nit: follow the subject line conventions for this and the other
patches.  Learn them with "git log --oneline".  For this patch,
"x86/PCI: <Capitalized text>" is appropriate.

> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
> ---
> RFC: We don't have enough info in this function to re-calculate the
>      alignment value in case of IORESOURCE_STARTALIGN. Luckily our
>      alignment value seems to be intact, so just don't touch it...
>      Alternatively, we could call pci_reassigndev_resource_alignment()
>      after the loop. Would that be preferable?
> ---
>  arch/x86/pci/i386.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> index f2f4a5d50b27..ff6e61389ec7 100644
> --- a/arch/x86/pci/i386.c
> +++ b/arch/x86/pci/i386.c
> @@ -283,8 +283,11 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
>  						/* We'll assign a new address later */
>  						pcibios_save_fw_addr(dev,
>  								idx, r->start);
> -						r->end -= r->start;
> -						r->start = 0;
> +						if (!(r->flags &
> +						      IORESOURCE_STARTALIGN)) {
> +							r->end -= r->start;
> +							r->start = 0;
> +						}
>  					}
>  				}
>  			}
> -- 
> 2.45.2
> 

