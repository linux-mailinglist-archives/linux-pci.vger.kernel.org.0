Return-Path: <linux-pci+bounces-19269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FDCA01058
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 23:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598C0163373
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 22:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B917C220;
	Fri,  3 Jan 2025 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHps8VU9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518DA146D6A;
	Fri,  3 Jan 2025 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735944798; cv=none; b=XLhnDBTVbOVjalB4ZZmQiq11SGVFiJc4pcmkqcQYLfgje9CF0cn8y2/tAMraRv408ICvnuwpWxjAficDkdrmyl1PeOwSi/DED9SEjTGjNwUOtNgPhZe/FC3+z4d7OS+8hhIXvztGl+Wq6itzkdg07j5Ib++CajDEh4rtGTK6g2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735944798; c=relaxed/simple;
	bh=vYEFxVNFqFi2Jt66mokNT7YWB/EMzIFs5NQ/Rf5hxYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dWI6zg1/fNkgWH86kyFNAUBZkmCBTqH+qYwv4SiTS8sd6SOshknwSV/KEiwFz65mluYS/+VIpIsJfLKJeSG6Wg9KMap6D2qRPQ4aDwugbEWQfsn1O4I6mgUCvwIJzBJXUWUs9D6XwORPxkrRqb7zAeCOuuQSratoNr15ajEd+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHps8VU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C899EC4CEDE;
	Fri,  3 Jan 2025 22:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735944798;
	bh=vYEFxVNFqFi2Jt66mokNT7YWB/EMzIFs5NQ/Rf5hxYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NHps8VU9RiNHgVRe9oXj/1dZwVqujWEFrU5i9YsbZZ5LKufC/91pgubK3ap1AYRRD
	 bk1qwWHG8sIRSh2lL9PbbsjEUo+gAory7FJ12YcI3ors1vX1Ad9w1cxCxolGO2ytYA
	 mF74SNpOay1l5yy1/qg/7S7sYjbTthfA1tQyBPhfYbSobAVY0+Afs7gyqENNs7X2+I
	 uJynNvANGaykDxfQzZD41xnQUJluKty+J0g4TYXZF+dss+hVk+tEdNg2wRZbu7IF6n
	 1kIiSrEANfgWxQGMwTm/78FgG+JlXom0XDTYk+G40XlrhTqPrhNJxxES8ZsQcn4ff5
	 EvXi331LDsaiQ==
Date: Fri, 3 Jan 2025 16:53:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Takashi Iwai <tiwai@suse.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Yet another quirk for PIO log size on Intel
 Raptor Lake-P
Message-ID: <20250103225315.GA12322@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102164315.7562-1-tiwai@suse.de>

On Thu, Jan 02, 2025 at 05:43:13PM +0100, Takashi Iwai wrote:
> There is yet another PCI entry for Intel Raptor Lake-P that shows the
>   error "DPC: RP PIO log size 0 is invalid":
>   0000:00:07.0 PCI bridge [0604]: Intel Corporation Raptor Lake-P Thunderbolt 4 PCI Express Root Port #0 [8086:a76e]
>   0000:00:07.2 PCI bridge [0604]: Intel Corporation Raptor Lake-P Thunderbolt 4 PCI Express Root Port #2 [8086:a72f]
> 
> Add the corresponding quirk entry for 8086:a72f.
> 
> Note that the one for 8086:a76e has been already added by the commit
> 627c6db20703 ("PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root
> Ports").

Intel folks, what's the long-term resolution of this?  I'm kind of
tired of adding quirks like this.  So far we have these (not including
the current patch), dating back to Aug 2022:

  627c6db20703 ("PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports")
  3b8803494a06 ("PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports")
  5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root Ports")

I *thought* this problem was caused by BIOS defects that were supposed
to be fixed, but nothing seems to be happening.

If Linux can't figure out the correct value by itself (and I assume it
can't because we wouldn't need the register if we could), maybe we
can just silently ignore it and live without the RP logs?

> Link: https://bugzilla.suse.com/show_bug.cgi?id=1234623
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 76f4df75b08a..4ed3704ce92e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6253,6 +6253,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa72f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
>  #endif
> -- 
> 2.43.0
> 

