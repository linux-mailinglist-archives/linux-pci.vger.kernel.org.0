Return-Path: <linux-pci+bounces-8752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB410907BB4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 20:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F0E1C210D3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 18:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2B614B081;
	Thu, 13 Jun 2024 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3XGyyGF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5214AD2C;
	Thu, 13 Jun 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304317; cv=none; b=BWjgA/6Cms/oo41bcGkoUd/Pbl3ws2Ka3Rblpk2mQjPr+raAqlVGwW8Mrgx+i9FP6/kznZOpb2XSqO3SP4h1LVOh8MgTMka8dqsV9LTvMio2xFigVj4C8o7O4XCwwAa0Lw5xEN1dfnFSdcAWk1ktzqArIF4CN9WYG00UAVmREOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304317; c=relaxed/simple;
	bh=SaYK7xDVIVPlSht74HhNqclsX16Ie88uGUDzvreWhC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n396HNQ/gjzH/DyEoJeh4vwn2HirmG8pP0pcvItDX8ah4GPNVsBfgNf0HRyAUcSczkVUN1sBlEDH0BfjQBRFdH0El71B5VB6yOk6RZvOTILlQGHt49gvA8jTfmE2W7PGYBxwJPQEQH+yiMBmmxaWsmp177WHWFdaXfsHnTay+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3XGyyGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CA4C2BBFC;
	Thu, 13 Jun 2024 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718304316;
	bh=SaYK7xDVIVPlSht74HhNqclsX16Ie88uGUDzvreWhC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=R3XGyyGFzwjza+YIqcLz1yLluC+7EBBbxz+bjk3bINlUnfF3fBo0vxvRZJE5rfezX
	 IdtqN5Ji664TSC9q1zDKWqteUv+wYuC1Nj5D/qWFhIxfv8aJHOsOlVa+YlyfZXwTbw
	 q8YhThE/zwkuHoY0Gow1P3nfPb7g0HDwiVmv6lBgHboXDBhEInoNST0x9kr7XAcZST
	 7l5nAMqy+jilTniLJNCAATJ9/PnOsT2mV1J+v0mG6Iq95VwyFrsc8mUvCjaBHL5hu4
	 1iFHa0yZKD8X3mVu1QH6PyWqatlTDDPlcJHDN/wiinR13NnQmlbKLPuT6KqVIHBrt1
	 ehn9BXQozHTbg==
Date: Thu, 13 Jun 2024 13:45:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Philipp Stanner <pstanner@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 03/13] PCI: Reimplement plural devres functions
Message-ID: <20240613184514.GA1071919@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa4e5dd8-2ac4-ae58-2b1b-8d05115ac769@linux.intel.com>

On Thu, Jun 13, 2024 at 07:54:38PM +0300, Ilpo Järvinen wrote:
> On Wed, 5 Jun 2024, Philipp Stanner wrote:
> 
> > When the original PCI devres API was implemented, priority was given to
> > the creation of a set of "plural functions" such as
> > pcim_request_regions(). These functions have bit masks as parameters to
> > specify which BARs shall get mapped. Most users, however, only use those
> > to map 1-3 BARs.

> > +static int __pcim_request_region_range(struct pci_dev *pdev, int bar,
> > +		unsigned long offset, unsigned long maxlen,
> > +		const char *name, int req_flags)
> > +{
> > +	resource_size_t start = pci_resource_start(pdev, bar);
> > +	resource_size_t len = pci_resource_len(pdev, bar);
> > +	unsigned long dev_flags = pci_resource_flags(pdev, bar);
> > +
> > +	if (start == 0 || len == 0) /* That's an unused BAR. */
> > +		return 0;
> > +	if (len <= offset)
> > +		return  -EINVAL;
> 
> Extra space.

Thanks for reviewing this.  I dropped the space locally in the v9
series.

> >  void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
> >  {
> > -	void __iomem * const *iomap;
> > -	int i;
> > -
> > -	iomap = pcim_iomap_table(pdev);
> > -	if (!iomap)
> > -		return;
> > +	short bar;
> 
> The current best practice is to use unsigned for loop vars that will never 
> be negative.
> 
> I don't entirely follow what is reasoning behind making it short instead 
> of unsigned int?

Existing interfaces like pcim_iomap() take "int bar".  I locally
changed all the BAR indices to "int".  We can make everything unsigned
later if worthwhile.

> > -	for (i = 0; i < PCIM_IOMAP_MAX; i++) {
> > -		if (!mask_contains_bar(mask, i))
> > +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> 
> Is this change minimal if it contains variable renames like this?
> Was "i" not "bar" even if it was given as a parameter to 
> mask_contains_bar()?

Replaced locally with "i".

Bjorn

