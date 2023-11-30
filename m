Return-Path: <linux-pci+bounces-278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C491E7FED8A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 12:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D71B20BA1
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8198250F8;
	Thu, 30 Nov 2023 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C9dzChac"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD5918E01
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 11:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A491AC433C8;
	Thu, 30 Nov 2023 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701342622;
	bh=SjhlINoIwso49e7CMCFoGN/qtMdMriRoe6RxeuRtQik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9dzChacAES531HEvRBhF4PlksKboYYXj6iZr4/Nfv68Pc1zacj1a5A7bUbDv7D09
	 +4cM70at56yxNfqA2dIc5vLkInq04CdjMY5mcEP6pWIljlyVT0jS4vTmgj9hHHBskv
	 IcdO0u8KfSarVg3hgSLQNZR5bQgetbIuegpAEURQ=
Date: Thu, 30 Nov 2023 11:10:19 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Wasim Khan <wasim.khan@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Message-ID: <2023113014-preflight-roundish-d796@gregkh>
References: <20231122154241.1371647-1-vladimir.oltean@nxp.com>
 <20231129233827.GA444332@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129233827.GA444332@bhelgaas>

On Wed, Nov 29, 2023 at 05:38:27PM -0600, Bjorn Helgaas wrote:
> [+cc Greg because these mergers & spinoffs happen all the time, and
> pci_ids.h doesn't necessarily need to keep up, so maybe there's
> precedent for what to do here]

Yes, the precedent is to leave it alone.

> On Wed, Nov 22, 2023 at 05:42:41PM +0200, Vladimir Oltean wrote:
> > What is today NXP is the result of some mergers (with Freescale) and
> > spin-offs (from Philips).
> > 
> > New NXP hardware (for example NETC version 4.1 of the NXP i.MX95
> > SoC) uses PCI_VENDOR_ID_PHILIPS. And some older hardware uses
> > PCI_VENDOR_ID_FREESCALE.
> > 
> > If we have PCI_VENDOR_ID_NXP as an alias for PCI_VENDOR_ID_FREESCALE,
> > we end up needing something like a PCI_VENDOR_ID_NXP2 alias for
> > PCI_VENDOR_ID_PHILIPS. I think this is more confusing than just spelling
> > out the vendor ID of the original company that claimed it.
> > 
> > FWIW, the pci.ids repository as of today has:
> > 1131  Philips Semiconductors
> > 1957  Freescale Semiconductor Inc
> > 
> > so this makes the kernel code consistent with that, and with what
> > "lspci" prints.
> 
> Hmm.  I can't find the 0x1957 Vendor ID here:
> https://pcisig.com/membership/member-companies, which is supposed to
> be the authoritative source AFAICS.
> 
> Also, that page lists 0x1131 as "NXP Semiconductors".
> 
> There's a contact email on that page if it needs updates.
> 
> I don't quite understand the goal here.  The company is now called
> "NXP", and this patch removes PCI_VENDOR_ID_NXP (the only instance of
> "NXP" in pci_ids.h) and uses PCI_VENDOR_ID_FREESCALE (which apparently
> does not exist any more)?
> 
> Why would we remove name of the current company and use the name of a
> company that doesn't exist any more?

Yes, this seems very odd.  What is the reason for any of this other than
marketing?  Kernel code doesn't do marketing :)

thanks,

greg k-h

