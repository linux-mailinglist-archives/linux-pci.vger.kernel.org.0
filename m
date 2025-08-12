Return-Path: <linux-pci+bounces-33836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE38B21E00
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 08:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FECB3B8C44
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 06:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC9A2DEA60;
	Tue, 12 Aug 2025 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ZhGlxdY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zdFEHqye"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D929BDB7;
	Tue, 12 Aug 2025 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979045; cv=none; b=L9WvRg57PRE3vlKEit9n/Dz4oOf/vC+D6lHqty3Wwm4R/rNUNcBTUkjQ68Fan6sy+OIhRWGzNwbdWns1N2qzW9wwtOzpTMw3Ky5YP0ke0WeiO8MxRqNefeEwfhwSfMSveyLVejyx5skOZKtpQTtxcXOHDL/vUGHJfVqSow6q4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979045; c=relaxed/simple;
	bh=QeZKjx8xR+XhQUAXBzt6ZVwajAMptLPOoyxJRsp59B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULncdn/KJ3qXVqZ3eM8LiTKOpm8armj5bmgtqtILshpNT0QYpx1XsfP9Gn++9dGmmlpIqFG7SYI4vaEQj/MVv8IBlXA6q2KnHEC3/cTeOEbFMXo22E4d1WPy6srAJAW4znAm5j7NZQ+Y208Z48WDO7dACbAkOoxocgEvoFbBzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ZhGlxdY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zdFEHqye; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Aug 2025 08:10:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754979042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uI4CgwvUXCbUc5uPC5+X8729M4tDF2pOP2xKvb9cDI=;
	b=3ZhGlxdYlv3VJPSpkgTTfl8TU5GIYzCUx7KkQbaNk1LnurpNfZZyhnAJw2Hn0ZRStYkWV2
	PSaQvChg1wFVRbIr/FS+pDoIRvze9scRiaQ32JFbg/3lJzQIn3GOU2x06FGxczNTwDtLxE
	NYM74BFTJmzkum2EZLyZX/tq7WNTbYxb7t5JHqAem58ZMjWVvip7aML8EHj/1318Gx5VPV
	Yfh4ogLkflI307vKSNxC/JLZwThl23nj/u54XAuCyX/oMRXd2Fq7YbZNALSdZCStfnjkMW
	9Waf8SIoShdZyWKQIQ5zOhg/xI48qqsa9Gv+hdVTWVvPcz4gYJS7aY86CS8UYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754979042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uI4CgwvUXCbUc5uPC5+X8729M4tDF2pOP2xKvb9cDI=;
	b=zdFEHqye4kn8F6Tl5mhCvWy99jUnVPlfXZfrW/w0cudhlLt3EaUr4qtNe+cT3qoSWdHqCh
	Fumfr9ux4Skta8AA==
From: Nam Cao <namcao@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx: Fix NULL pointer dereference
Message-ID: <20250812061028.O01CaCXa@linutronix.de>
References: <20250811054144.4049448-1-namcao@linutronix.de>
 <20250811222937.GA167215@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811222937.GA167215@bhelgaas>

On Mon, Aug 11, 2025 at 05:29:37PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 11, 2025 at 07:41:44AM +0200, Nam Cao wrote:
> > Commit f29861aa301c5 ("PCI: xilinx: Switch to
> > msi_create_parent_irq_domain()") changed xilinx_pcie::msi_domain from child
> > devices' interrupt domain into Xilinx AXI bridge's interrupt domain.
> > 
> > However, xilinx_pcie_intr_handler() wasn't changed and still reads Xilinx
> > AXI bridge's interrupt domain from xilinx_pcie::msi_domain->parent. This
> > pointer is NULL now.
> > 
> > Update xilinx_pcie_intr_handler() to read the correct interrupt domain
> > pointer.
> > 
> > Fixes: f29861aa301c5 ("PCI: xilinx: Switch to msi_create_parent_irq_domain()")
> 
> Since this appeared in v6.17-rc1, I suppose this should be merged for
> v6.17, right?  I provisionally put this on pci/for-linus for now.

Yes please.

> What does this look like to a user?  I assume a NULL pointer
> dereference in xilinx_pcie_intr_handler()?  Do you have a dmesg
> snippet from hitting it?  It would be nice to include a couple lines
> of that in the commit log to help users find this fix.

Sorry I didn't clarify this, but this has not been tested with hardware.

Claudiu pointed out this problem with another driver [1], so I audited all
the other drivers that I touched and noticed that this one has the same
problem.

Nam

https://lore.kernel.org/linux-pci/20250809144447.3939284-1-claudiu.beznea.uj@bp.renesas.com/ [1]

