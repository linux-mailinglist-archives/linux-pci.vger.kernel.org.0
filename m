Return-Path: <linux-pci+bounces-9842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E789289B3
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 15:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AD51C217B6
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D836C14A09A;
	Fri,  5 Jul 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u9G+/H3m"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A4155749
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186189; cv=none; b=NlzcnVazRXZG490gQgRwph5LdFm1+QSTrudyTuXTjM/6NE9+A84LhHmd/T34grA9+jPMiO2Wn0EUPL1+fcflYfCdeHKDS4nazf747v2wDlT8WNjqAzyxELJGLKW+RuNHS1+l5188Rg+QZA+qhN7GfQ93OHwuf9i7M/QRz6LfrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186189; c=relaxed/simple;
	bh=yFgGCHW2MzF1nhn6YrNLJzbIckVlmb2cfeLuFC9spTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqtaEi9BquBAMJgyrQyKX9w2dW/lFHFA5XsJcQ1DddwPus2zmU3M5y8qd0wcdrE5Dk8V4mC9CDG8mJh9S8Xpo4GQlU0BjmdYzGUHB2MEyu+Xx+d5cb5LlPOgEpzD5wmMGXsVW8UDkqdO/qQjz2MJ2IUuHLKTlEOSEiKuroKCnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u9G+/H3m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yFgGCHW2MzF1nhn6YrNLJzbIckVlmb2cfeLuFC9spTs=; b=u9G+/H3mefVMGxgif3R/xRQZxk
	wEm1ERK1cETua7ZuXendD7gSzJjz3E06BQt30CZRB9IL1UBKO+E1Ip4X0cSmID/yEUKxjDznbY3/9
	mWwp1NmtgzcYZce9jlVsPiQ8R0useMm08Car71GBDG4oEaKouozCDQaWs2IjdY0gZ1k+Q4SBq1OoR
	bj5bW1uj9JLSBGUdup/3xN9tXCNhVuuTIKTb6aRhLzliVJHCr5LiBJx8bFd+RxaNRhvn1PMaqdRVc
	t6oOVfX12EvPk55pcWMYC6ERj8FHrmPwUW5PhY8iAPWyIFjxm0sVY5/ZCy9CDSS4huNhoV80tKim2
	q8gWgD4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPj0U-0000000G39H-2Pks;
	Fri, 05 Jul 2024 13:29:46 +0000
Date: Fri, 5 Jul 2024 06:29:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v3 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <Zof1SkQrkR5gPcpB@infradead.org>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
 <20240705125436.26057-3-mariusz.tkaczyk@linux.intel.com>
 <Zofu_b-vnBDkWsnJ@infradead.org>
 <20240705152257.0000527c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705152257.0000527c@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 05, 2024 at 03:22:57PM +0200, Mariusz Tkaczyk wrote:
> I did it way because in next patch I'm adding DSM. With that I have less changes
> in second patch.

Ok, never mind then.


