Return-Path: <linux-pci+bounces-22057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5220A403F0
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 01:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB833BA328
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBE13FFD;
	Sat, 22 Feb 2025 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIYYrwHF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F522331;
	Sat, 22 Feb 2025 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183204; cv=none; b=KNGwVpidFxxOELznJ5r2/iJcqXXF0I/49ThrMMzBENoI0LpI8CJ/c44wPGdW5iSpXa73OsnRZG16+dVfLsrOW72uu5fg4ctb2GE6d/pusW6qO62ojuiynwOy+JPPhvAQKNI9EPXNF9UZb01qBCmkK57gzvbW51YJdzI5mD9lwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183204; c=relaxed/simple;
	bh=nL9RnZdkwRcrZ9TpCc8avTIW5WSFEKEUirJUWZ/sn/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r8jwMhJMNHgjaK48Z0w/zaQM5XYzoXthjJpItVIuVkfyy/QLZ7DUyb2bCNjVAegWa4DX1fxuE+3BeEKYQX6fVAGfFihJ1fGNSV3DheB52QXW7SICKp1aLE1eWfLbErqmb++XEKthFVXcvXTGRYfOVuZrUL6AskDElbUrpsybXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIYYrwHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F63AC4CED6;
	Sat, 22 Feb 2025 00:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740183203;
	bh=nL9RnZdkwRcrZ9TpCc8avTIW5WSFEKEUirJUWZ/sn/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bIYYrwHF1XFTRYhXBU2AuuR9A7DHvoiWPTIZxI0OjDZNeJUSu5+x1JPII8B/S0Zwr
	 j5gcRr5dyyLi5P1w9g08Whe+sfg09Qv8HMa/zy+jVFRk2zifH2OYhNMmwgjyFeRZum
	 GvzgDUZwo20B9k5fm7NH0sOxQmsJ7TYAcaduwE6FKP7t1iIFiA8EkBSABk9JdBb/xt
	 o3Ts/rxEyXvz6flUuDVMHjcXxBm5W4QlgN2f7QewYCdEoLLozlp0RneAAf/BMelQyK
	 vUqoRezdVV60sCko1mhLHCv9VGf2LhK4315XAQH+yUgd+LfCSIqCGp4zL7h1sVWvhg
	 Q9IZ4cIzJs1xA==
Date: Fri, 21 Feb 2025 18:13:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Srirangan Madhavan <smadhavan@nvidia.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Zhi Wang <zhiw@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-cxl@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cxl: add support for cxl reset
Message-ID: <20250222001321.GA374090@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7hZZNT5NHYncZ3c@wunner.de>

On Fri, Feb 21, 2025 at 11:45:56AM +0100, Lukas Wunner wrote:
> On Thu, Feb 20, 2025 at 08:39:06PM -0800, Srirangan Madhavan wrote:
> > Type 2 devices are being introduced and will require finer-grained
> > reset mechanisms beyond bus-wide reset methods.
> > 
> > Add support for CXL reset per CXL v3.2 Section 9.6/9.7
> > 
> > Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> > ---
> >  drivers/pci/pci.c   | 146 ++++++++++++++++++++++++++++++++++++++++++++
> 
> drivers/pci/pci.c is basically a catch-all for anything that doesn't fit
> in one of the other .c files in drivers/pci.  I'm slightly worried that
> this (otherwise legitimate) patch increases the clutter in pci.c further,
> rendering it unmaintainable in the long term.

+1  The reset-related content in drivers/pci/pci.c has been growing
recently.  Maybe we should consider moving it all to a reset.c file.

> At the very least, I'm wondering if this can be #ifdef'ed to
> CONFIG_CXL_PCI?
> 
> One idea would be to move this newly added reset method, as well as the
> existing cxl_reset_bus_function(), to a new drivers/pci/cxl.c file.
> 
> I guess moving it to drivers/cxl/ isn't an option because cxl can be
> modular.
> 
> Another idea would be to move all the reset handling (which makes up
> a significant portion of pci.c) to a separate drivers/pci/reset.c.
> This might be beyond the scope of your patch, but in the interim,
> maybe at least an #ifdef can be added because the PCI core is also
> used e.g. on memory-constrained wifi routers which don't care about
> CXL at all.

Agree, we'll need some way to make this optional.

Bjorn

