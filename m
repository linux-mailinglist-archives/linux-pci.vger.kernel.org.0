Return-Path: <linux-pci+bounces-9922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8088192A001
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 12:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69CAB2B1C1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 10:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597B313ACC;
	Mon,  8 Jul 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B5gPE/aS"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10EC6A022
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433689; cv=none; b=ZQNaJL4mTYpsCj31CIHAdjDj1a3lwR1RBpfTSZrZlZqJvyl0erSoH9j+q/q8SOKatZAReefYglKtjJQWQVXmTPjLA5n2VpLD9hbhI8M7ElYsqCnnxgTDaCtK0FepeJtPmNZztOrlKnk4JmelQtiIiTSwG0PTsX1/LB9/h645/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433689; c=relaxed/simple;
	bh=QeLRnze+FOvuy3NL83/3Z/skQXmg1uH40KAxHheU4Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRMZxyNfs4XnEw4RL0+KVXDYzmZUVrAfqdHRcXvvudJrk6BZC/UQgvTgyXQqUtKK9zMzOOwk2Gmhohkm8EXiiJJTAbpVhB3ef7oPv0AZiWvMf0C9KAkqFgDVNIXU3uxA1IMiyN0Rvo1Yr5G1KoW/wuUy9ruioT/MBzUxnla0Biw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B5gPE/aS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bJk0CJJMGqhc7FGJgXNbOb0zn5yf/CCUUfbN0Er0hOk=; b=B5gPE/aSVMsesE1Yhux06rrxbN
	r0cOwRjtVhP0hxUYbuQcpgIKD/MxvmSUgyZdCMl9iW3Z9sZ2x3v15Ud4Ke1aJ9oCF+cuJ4AfWxYbp
	X1ENUdbPWXxRkdYNsIH40Vixb4Ib0jBQJxMeDLOUhW4loZ8EUU1cM2ByzSeFqH5C5zmiAsJZ0lUj5
	3iNEgNg0unHG2VF4P1zj8B7tKlD4p5emSTjValdmikBaZg0VcfAEG1/2zs2GClMwC9zcRespNRfts
	ZvTilLZwkgWobZlduYKjpTjWPAeNPHe56GVKo1h8hd+7CsdSLt/4zrdnSsQtiVYYLWzjbiq5suT2p
	2NZWVlIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQlOO-00000003QRm-13Gi;
	Mon, 08 Jul 2024 10:14:44 +0000
Date: Mon, 8 Jul 2024 03:14:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v3 3/3] PCI/NPEM: Add _DSM PCIe SSD status LED management
Message-ID: <Zou8FJLJ-3H7CInO@infradead.org>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
 <20240705125436.26057-4-mariusz.tkaczyk@linux.intel.com>
 <ZofvZyzIe_7tH6zZ@infradead.org>
 <Zof-P7jNmoLvJTF-@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zof-P7jNmoLvJTF-@wunner.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 05, 2024 at 04:07:59PM +0200, Lukas Wunner wrote:
> On Fri, Jul 05, 2024 at 06:04:39AM -0700, Christoph Hellwig wrote:
> > > +struct dsm_output {
> > > +	u16 status;
> > > +	u8 function_specific_err;
> > > +	u8 vendor_specific_err;
> > > +	u32 state;
> > > +} __packed;
> > 
> > This structure is naturally aligned, so no need for the __packed.
> 
> Isn't the compiler free to insert padding wherever it sees fit?

In terms of the standard: yes.  It could even reorder members.  In
terms of not breaking the Linux kernel (or other low-level software)
left, right and center: no.

> structs passed to ACPI firmware would no longer comply with the
> spec-prescribed layout then and declaring them __packed seems to be
> the only way to ensure that doesn't happen.

Take a look at just about any driver, file system or network protocol.


