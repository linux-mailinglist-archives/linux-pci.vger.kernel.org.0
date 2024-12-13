Return-Path: <linux-pci+bounces-18371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E731A9F0D6D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FCA28310B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCBA1E049C;
	Fri, 13 Dec 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsT8N/k/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A391E048F;
	Fri, 13 Dec 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097083; cv=none; b=IrxpS5yiisdMV2UfXl3vOrMgE3U+ZbcRwYZXk8hZa9wLPBzNexnzZtBT69QEpvTV3Lo8msQYiw5REVgiHJAyOo0bViAIA8pCShQCfK4+pFw081uDlGK+wPrtpjiZLt7TjCRZY3i/ISg3ajsiY1aePUn55LOyjMcj45fx8YJzoBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097083; c=relaxed/simple;
	bh=9U5JZFUnNCZkRXoe6sZZUHnrfn3CHmkPIWmKGAHDiX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfsC5bBxJT9M+nuxpA6wj9Ng287UqJOIfKp1Fz8lp9rEgdFYzv8GwOuS+MJepD/jKRP1HlXfoIP03rVmwWrclvm8Pbkzo+CK8nNtWtP/q/jKilIadY++UYC+jmudkiekIReMxTsd/oiFZ4xJL23kY6HP390gjnDLvD8DMRTTrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsT8N/k/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBAEC4CED0;
	Fri, 13 Dec 2024 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734097083;
	bh=9U5JZFUnNCZkRXoe6sZZUHnrfn3CHmkPIWmKGAHDiX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsT8N/k/I/acFdIUUPc0ZF1/5z0TECbZ+/jTqbOvVfmWpBHyjB7dKQZJpCXd8fSWY
	 I/qc4ATlEflLEjWttGx7Rb3AIFNOoyr4Y+aZxvG8o39P21hceyTWVJQuHUum0LU1aB
	 Y2EORxgxt91q5p3M8tW3g/q1xuGHtxf8WJvDh2yRRp1aPQxte2EsiMhUMBpm1+JGcQ
	 FIVlbErMxGr+wi2rR/Bc0/c246H0IY1SCLytxi2vrQ/lheP0sJ4EDAcdxo3g/9PGAa
	 +dy1MKIFE/0tgHuRmV9VTgTo32/kRH2HVjijKUvjoH0wOtLWD1ryJvng/fW/stjXgA
	 NP9Qo+5PtpS3Q==
Date: Fri, 13 Dec 2024 14:37:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v5 2/6] PCI: dwc: ep: Add missing checks when dynamically
 changing a BAR
Message-ID: <Z1w4tToNC0JEcZqP@ryzen>
References: <20241127103016.3481128-10-cassel@kernel.org>
 <20241204171716.GA2691918@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204171716.GA2691918@bhelgaas>

On Wed, Dec 04, 2024 at 11:17:16AM -0600, Bjorn Helgaas wrote:
> [+cc NTB list, since NTB seems to be the main user of .set_bar()]
> 
> Can we say something specific in the subject line, like "prevent
> changing size/flags" or whatever?

Ok. Will fix in v6.


> 
> On Wed, Nov 27, 2024 at 11:30:18AM +0100, Niklas Cassel wrote:
> > In commit 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update
> > inbound map address") set_bar() was modified to support dynamically
> > changing the physical address of a BAR.
> > 
> > This means that set_bar() can be called twice, without ever calling
> > clear_bar(), as calling clear_bar() would clear the BAR's PCI address
> > assigned by the host).
> 
> Unpaired parenthesis at end.

Ok. Will fix in v6.


> 
> Apparently calling .set_bar() twice without calling .clear_bar() is a
> problem?  What problem does it cause?  Sorry about my poor
> understanding of the endpoint and NTB code; I'm sure this would be
> obvious if I understood more.

Calling .set_bar() without calling .clear_bar() is not a problem.
In fact, that is how the NTB EPF dynamically switches the inbound address
translation for a BAR on the fly, after the host has assigned a PCI address
for the BAR.

It is just that for most EPF drivers, you would normally call .clear_bar()
before calling .set_bar() again.


> 
> Maybe a hint about the reason why we need to call .set_bar() twice
> would help me understand.

The NTB EPF does this to change the inbound address translation from one
address to another on the fly. For details about why the NTB EPF driver does
this, you would need to ask Frank who implemented this.


> 
> > This can only be done if the new BAR configuration doesn't fundamentally
> > differ from the existing BAR configuration. Add these missing checks.
> 
> Can you elaborate a bit on what "fundamentally differ" means?  Based
> on the patch, I guess it has to do with changing the size or type?

Correct, BAR size and BAR type has to be the same.
I don't know why the NTB EPF does this, but it is obvious that very bad
things could happen if you would dynamically change from one BAR size to
another. (This is not a resizable BAR...)


> 
> And the problem this would cause is ...?  I guess it's a problem for
> some other entity that knows about the BAR and is doing MMIO or DMA to
> it?

If we allowed the BAR sizes of the old area and the new area to differ,
that could mean that we could leak kernel memory, since if e.g. the new area
is smaller than the old area, a read past the new area size would potentially
read memory that wasn't allocated by the EPF.

To me, is seems like quite a big oversight that these safe guards wasn't
added as part of commit 4284c88fff0e ("PCI: designware-ep: Allow
pci_epc_set_bar() update inbound map address"), but then as you might have
seen, that patch was also merged via the NTB tree without any Ack from the
PCI endpoint maintainers. This patch has a Fixes-tag against that commit,
so stable should pick this up. I will also add an explict Cc: stable in v6.


Kind regards,
Niklas

