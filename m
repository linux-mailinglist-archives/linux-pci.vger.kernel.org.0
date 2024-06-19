Return-Path: <linux-pci+bounces-8953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79E90E408
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 09:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A64C1C23F4A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 07:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30074BE0;
	Wed, 19 Jun 2024 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g1X5ujbE"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41B6139;
	Wed, 19 Jun 2024 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780970; cv=none; b=WR5PI79y7xJEu8dcm/7jHwKQ36r1yIqBBLIdS2fiX5I7TmY9oh8KxDWPH5xu8odeq39Q8h/AJZa9kKmVZsNDEF1Kq6JNPLEyIAvf34fXEz48OSJY0kRxjCwj7xPHaaXx7BbNX3oO+4xLe2LYArBcREr91IZFv9fo4yKWoP+3UDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780970; c=relaxed/simple;
	bh=9Hi2MN0LHR2BsieKkb/s4ZNHlzXVjUMfLEi1PGQCRJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coCe8DIoiXpWGM5CfC1QpGA1QzbHR1+BYb61PiJEOLGfrC9sJ7Oax6+TMpE+XDkg3MptDk0Ucm6mGBmf9TZ1dLEstVi/tR+6qfpuLK2rh5E9oXIqF4GK3gmxrkwZbYhRE/8DQsEUcxUO5yR/FCeecHy3V2xjwRmPegH/2WnfGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g1X5ujbE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Uicb13uQbVx+qFV6jtZ9WDTbAMdHnx2Ja3RWRg58IJw=; b=g1X5ujbEju4tIR9DcEcnM2sPc6
	as6V32vyl0ZUWoyeSlh5NrN3qsL3nn3HTv+QF71blQkM9p+sWDud/A/reY8tn3AEZRFcqeWAaRhhl
	e5009BXq8c6DgfJyBh46j4TC7Uml1CjPFKNoFfvIxQ8ZKc4hOqmfDSPAUjaSnAhZdl9/7GYE8BytG
	PJGrA5xb/HvVS7CS3vHy8pt/4u6WwZadrr14/LerDHhvGi7DDNqkzF4X9jP5K0gvSGnwfrWZhJesF
	WwTSx2BMT48Gmu3imUD8mpzsZMDh3cmuddXFveaXknGnBOOJVqpBUJ1uQuM+6tVJp4sEWCMy5/qaT
	U88TbtOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJpRd-000000008oz-2TMM;
	Wed, 19 Jun 2024 07:09:25 +0000
Date: Wed, 19 Jun 2024 00:09:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	ming4.li@intel.com, vishal.l.verma@intel.com,
	jim.harris@samsung.com, ilpo.jarvinen@linux.intel.com,
	ardb@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 8/9] PCI/AER: Export pci_aer_unmask_internal_errors()
Message-ID: <ZnKEJd44ItoL67_s@infradead.org>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-9-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617200411.1426554-9-terry.bowman@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 17, 2024 at 03:04:10PM -0500, Terry Bowman wrote:
> AER correctable internal errors (CIE) and AER uncorrectable internal
> errors (UIE) are disabled through the AER mask register by default.[1]
> 
> CXL PCIe ports use the CIE/UIE to report RAS errors and as a result
> need CIE/UIE enabled.[2]
> 
> Change pci_aer_unmask_internal_errors() function to be exported for
> the CXL driver and other drivers to use.

I can't actually find a user for this.  Maybe that's because you did
weird partial CCs for your series, or maybe it's because you don't
want to tell us.  Either way it's a no-go.

