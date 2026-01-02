Return-Path: <linux-pci+bounces-43950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B74CEF3BB
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 20:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38B3B3001198
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B990313E2F;
	Fri,  2 Jan 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBjTkB1f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF3E22424C;
	Fri,  2 Jan 2026 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767382173; cv=none; b=u8cX9fykBZGW+pxUrTCn+meB1F3IWMEpiqs2SF4TaUy9TKeAMj7A4FarztF3Mz625fP+fVXo45yF9tixb9H7sRzvkq5H8TuD3E7C2TmxuSHun52Hr0dDV3xQsr0y3wfdKnMB1wwOvR2DR8rf3H27T9yhtczJp0zExo3XsE/O344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767382173; c=relaxed/simple;
	bh=S6PvGgs4PUhcouFEgmqOVeKqW8pY/PDrsEj4d7RLy5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YFmyPNCkt4NhpQdme3GpaDVfdo7Y0b/r5DlsxggSTCTDatD0pj8uL2JpmIYZXPHMwIFcc7mXKCa2wNmNY2wYT8R2A1lKvvol0UYBO41HrRZhbOVmpuMH/rPrZb4ETcDbYUn86mU4bF+v5BUEmdGHxkxrXF7eZpLNYGv+lQ/+tDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBjTkB1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425E2C116B1;
	Fri,  2 Jan 2026 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767382172;
	bh=S6PvGgs4PUhcouFEgmqOVeKqW8pY/PDrsEj4d7RLy5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dBjTkB1fjOc0gA69IPqoIico352B4el8OPuRg5puHrIbogTiAEra/Ufm48MbtWqK/
	 iPI8zlIw/S0sJ9hJi0sVRoMRwc7Ub2lZOe9knslCua6jwiI57at1TXE3STXKdpaH3k
	 13sObqWNVmMEn2OeRo0Sl5pG+Qaej7Ncn/ec1TTf4i0XdxN2y+CbUnH43BkxB+G6Cx
	 uI+nzUGrNHEi8fGwH2XhxpyXwcei6+A5DnHyCY0SsOySnb0Q/h4UQFqAIYSQvV/HE7
	 KjM9eq2Si65J2Wse0kmqDGHFQhTo+142Yd3MgFd8XmDh+ZEZCqvS5ne6NvqLvVVUw6
	 2tIIndxN/XpNA==
Date: Fri, 2 Jan 2026 13:29:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: PCI: IRQ: Handle INTx GSIs as u32 values not int
Message-ID: <20260102192930.GA226444@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVerBwCsuoHadX9K@lpieralisi>

On Fri, Jan 02, 2026 at 12:24:55PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Dec 31, 2025 at 11:01:50AM -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 31, 2025 at 10:26:15AM +0100, Lorenzo Pieralisi wrote:
> > > In ACPI Global System Interrupts (GSIs) are described using a 32-bit
> > > value.
> > > 
> > > ACPI/PCI legacy interrupts (INTx) parsing code treats GSIs as 'int', which
> > > poses issues if the GSI interrupt value is a 32-bit value with the MSB set
> > > (as required in some interrupt configurations - eg ARM64 GICv5 systems).
> > > 
> > > Fix ACPI/PCI legacy INTx parsing by converting variables representing
> > > GSIs from 'int' to 'u32' bringing the code in line with the ACPI
> > > specification.
> > 
> > Looks good to me.  Is there any symptom of what the issue looks like
> > that could be mentioned here?  Might also be useful in the subject,
> > which currently describes the C code without really saying why we want
> > to do this.
> 
> Thanks ! Happy New Year !

Happy New Year!

> acpi_pci_link_allocate_irq() would return a GSI with MSB set, that the
> logic in acpi_pci_irq_enable() would treat as a failure because that's
> a negative value.
> 
> After fixing that - passing a 32-bit value with MSB set to
> acpi_irq_get_penalty() causes an array acpi_isa_irq_penalty dereference
> with an an index that is way beyond the array size.

Ouch, out-of-bounds reference.  Best case, maybe a data page fault or
a "No IRQ available" message or just a suboptimal IRQ choice.

