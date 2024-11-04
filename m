Return-Path: <linux-pci+bounces-15989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6579BBD5B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 19:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9641C2103F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62B61CB537;
	Mon,  4 Nov 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVgmsW2B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8551CB9E9;
	Mon,  4 Nov 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745407; cv=none; b=nkuV8wEnp0EkY2PMaYGFnT3L4Dpb7DzVwUuv6LwDJ0mm5OqTjUFAmXrfG/tVHIKLV8+tRvKxC7cpDYum6zXWXwGPZn5ndyDSlefFKuyfPuiGjLhAyA9GP1CQHpZYqPSYEGFK4soN42Dl2i2UBTkJkbZnMpOHoHW/57lCEBdc6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745407; c=relaxed/simple;
	bh=vPRT5Ok0iatDoQ8sYX0E41DsuqQx7MZ4e798ogKn4/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaTuR2q0Jq0wK+QeNT2qM7lIHYYy3w1H5zsAn7gDlhVNbk1iMKayexmuPhITHEE/UcwviRLhjFZyJMoq/hay1sLHrs06BQvxESEwFGG5dKlFYuNugp+KSRV7fIB/z4D/rB01oDoEeH4lxFchcDw6t2lya7oEA4l2V29Mh8xHj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVgmsW2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0225EC4CECE;
	Mon,  4 Nov 2024 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730745407;
	bh=vPRT5Ok0iatDoQ8sYX0E41DsuqQx7MZ4e798ogKn4/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVgmsW2Byap2nnAfgufOvQ6Dpy7iyqqiToopnq65zidrTpwXgwtIVPK0ml8Iu6GCx
	 stpnzW9oUHh5kee4Yu9lJVNGX5YTebI4svUGRjAQxjt5lq//OQ8Vpyh3MhwyNizZS5
	 /grbqBTU7Kz2x8xB9NSkwSBxEPh+aup6JP+Zy+3RjhKf4Yk6EPVbFeL4wjkhIsFlKP
	 /6AwfvMevgm15vuacpc6arPHEx2dVpHdOGGyI9fPcxkO8+HgeFJenejfE+vywh/qjS
	 SIeE11M9rNMaYK3ClW0Ymbpl5k+m7f+z6f7kV9jFb/GoOFWLlz4Ut2yOkrQutU0GN5
	 +iHIsuyT4n8mw==
Date: Mon, 4 Nov 2024 19:36:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] ata: ahci: Don't call pci_intx() directly
Message-ID: <ZykUO31aOfnCIkUH@ryzen>
References: <c604a8ac-8025-4078-ab90-834d95872e31@gmail.com>
 <ZyiGNtLMSY1vTQH7@ryzen>
 <8acdd01c-1744-4545-9cc7-0a60e83a5d4d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8acdd01c-1744-4545-9cc7-0a60e83a5d4d@gmail.com>

On Mon, Nov 04, 2024 at 02:23:43PM +0100, Heiner Kallweit wrote:
> On 04.11.2024 09:30, Niklas Cassel wrote:
> > On Fri, Nov 01, 2024 at 11:38:53PM +0100, Heiner Kallweit wrote:
> >> pci_intx() should be called by PCI core and some virtualization code
> >> only. In PCI device drivers use the appropriate pci_alloc_irq_vectors()
> >> call.
> > 
> > Hello Heiner,
> > 
> > as you might or might not know, this patch conflicts with a Philipp's
> > already acked patch:
> > https://lore.kernel.org/linux-ide/20241015185124.64726-10-pstanner@redhat.com/
> > 
> I know, therefore he's on cc. Fully migrating PCI device drivers to the
> pci_alloc_irq_vectors() should be done anyway and is the cleaner
> alternative to changing pci_intx(). However for some drivers this is a rather
> complex task, therefore I understand Philipp's approach to adjust pci_intx()
> first. He's incorporating other review feedback in his series, so with the
> next re-spin he could remove the ahci patch from his series.

Well, if you look at Philipp's patch it:

1) Doesn't only update drivers/ata/ahci.c,
it also updates:
drivers/ata/ata_piix.c
drivers/ata/pata_rdc.c
drivers/ata/sata_sil24.c
drivers/ata/sata_sis.c
drivers/ata/sata_uli.c
drivers/ata/sata_vsc.c

Why don't you update the other drivers in drivers/ata/* ?


2) Doesn't just bother to fix a single subsystem (drivers/ata/),
it is actually part of a series that fixes all affected subsystems.

Why don't you send out this fix as part of a series that fixes all the
affected subsystems?


Kind regards,
Niklas

