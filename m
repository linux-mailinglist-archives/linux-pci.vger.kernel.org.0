Return-Path: <linux-pci+bounces-19357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C8FA031A3
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 21:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A963916544A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 20:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441E2188A0D;
	Mon,  6 Jan 2025 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRb3+ps0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749B165F1F;
	Mon,  6 Jan 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736196810; cv=none; b=qpOWttTqdsS7TnABq9xGC0+ikIz3GJItQ6ThjaVEGP2aJ+Gw4A9D6J4wB0UBZXTusaWMvU39UkeiMVEmCGkapH89ji4RF+QP16fXajIEwrvYvwgmVlrS8P9EtEW/JRyOxOw4s2KAT86LEC2K5kimiiXDCsVQkkDMIJpU/3aLe+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736196810; c=relaxed/simple;
	bh=r/lfglIrDThqxuly3fukfGmtqm6TbeIeyw+2/SeAMEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WQ0tqeR/goPrMKdikRWDhjL0/7j0VmNN6S12vxxNcTYbqcVBXKfkR36F/bLHJhQpr9bOqcegStT0uNNf37adBmEd2vRBWFpJZN1nkZB/L4v6v2Bv+DMpaR2s+Md2agK+3Y6RYb2TbkiLlohfxIJh2wrV9FWJMJ16Ks6r2/kgFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRb3+ps0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8FFC4CED2;
	Mon,  6 Jan 2025 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736196809;
	bh=r/lfglIrDThqxuly3fukfGmtqm6TbeIeyw+2/SeAMEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gRb3+ps0pnMrZ6D5v/J1BQRljAb6opb+hwRBgw1EDK7rw2ytvzbFGEREbGoIHbmY7
	 YDbdKV526BOAb0gLedVPgHLLlu/1aiNvkKlssO+eHQuCoGS9KxAijJsNFajSy8qvg+
	 +8SK76ROhkclcg7+477D1FM8Q+pBK6YwsMI+wFep6jItDPGW7RUfkJpy1DgiPpHxrf
	 GrAN58Ms5xY4Taw16AE/ZUXXCONKDb4sZDqaNRCC8WBBit2vBKM7pbGKXkupmrUEkK
	 6rh/Edr7+/KNr5ruymwjcC7o980ZHTJ2kJZnkMfZeHfMZ/RMQTzEj3h6hY7CC9M4uf
	 2a/26reAdpz4w==
Date: Mon, 6 Jan 2025 14:53:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tushar Dave <tdave@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, corbet@lwn.net, bhelgaas@google.com,
	paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
	rostedt@goodmis.org, xiongwei.song@windriver.com, vidyas@nvidia.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	sdonthineni@nvidia.com
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
Message-ID: <20250106205326.GA132024@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>

On Mon, Jan 06, 2025 at 12:34:00PM -0800, Tushar Dave wrote:
> On 1/2/25 10:40, Jason Gunthorpe wrote:
> > On Fri, Dec 13, 2024 at 12:29:42PM -0800, Tushar Dave wrote:
> > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index dc663c0ca670..fc1c37910d1c 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -4654,11 +4654,10 @@
> > >   				Format:
> > >   				<ACS flags>@<pci_dev>[; ...]
> > >   				Specify one or more PCI devices (in the format
> > > -				specified above) optionally prepended with flags
> > > -				and separated by semicolons. The respective
> > > -				capabilities will be enabled, disabled or
> > > -				unchanged based on what is specified in
> > > -				flags.
> > > +				specified above) prepended with flags and separated
> > > +				by semicolons. The respective capabilities will be
> > > +				enabled, disabled or unchanged based on what is
> > > +				specified in flags.
> > >   				ACS Flags is defined as follows:
> > >   				  bit-0 : ACS Source Validation
> > > @@ -4673,7 +4672,7 @@
> > >   				  '1' – force enabled
> > >   				  'x' – unchanged
> > >   				For example,
> > > -				  pci=config_acs=10x
> > > +				  pci=config_acs=10x@pci:0:0
> > >   				would configure all devices that support
> > >   				ACS to enable P2P Request Redirect, disable
> > >   				Translation Blocking, and leave Source
> > 
> > Is this an unrelated change? The format of the command line shouldn't
> > be changed to fix the described bug, why is the documentation changed?
> 
> The documentation as it is (i.e. without my patch), is not correct.
> 
> IOW, config_acs parameter does require flags and it is not optional. Without
> flags it results into "ACS Flags missing". Therefore I remove word
> "optionally" from the documentation text.
> 
> Secondly, the syntax in the example 'pci=config_acs=10x' is incorrect. The
> correct syntax should be 'pci=config_acs=10x@pci:0:0' that would configure
> all devices that support ACS to enable P2P Request Redirect, disable
> Translation Blocking, and leave Source Validation unchanged from whatever
> power-up or firmware set it to.

I'd suggest a separate patch to fix the documentation so we don't try
to relate the doc changes with the code changes.

