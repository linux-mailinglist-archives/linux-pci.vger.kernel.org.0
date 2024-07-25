Return-Path: <linux-pci+bounces-10792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F2593C412
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 16:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459481C210AA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A219D06B;
	Thu, 25 Jul 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IMzIrHn7"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BB21993A3;
	Thu, 25 Jul 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917588; cv=none; b=bWLXPoZadLyGY63hz9hNLFbTVP0EKkNVUKn/N0K82LjdOxO7so6fGYoQZGzG9oxnv1/J9Q5vA9ZBm7vKHbBOQQ4pclKZ5J9fgVjCkSomQ5hV+SuGjV8tO2vr4lHQ96/gSwfcy/WHSFY6escDIlj6ri4kJH8qewZje9MQSzaD+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917588; c=relaxed/simple;
	bh=wJNe1r0ees+R3uFBTUmhrQpWGLekdD/gHRWmwZ0KnKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/L/1ugIoYAsR4x+2qlHStZ7jrGwUZzmBhYHH6KlyLwI1v7pqFenc7+BudSfKVccEawhA0ROahKcJRS+JJxJn4rSZ/FCgS1bkGsh0y6rGpWt7lhGkqoYkmIhMMnyYQQ0+yAAnWV6CRHF5LMRYkqYXNivmRDIYzjoSX7hAZxvYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IMzIrHn7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jRL6tU3zpV7/caq8r71fqaGYcFN6r6n0uIOJF1NOOlA=; b=IMzIrHn7B5R1lzEr66dpZmJA+I
	n633TM2kMmTRWH67Ys6SsXs3MOo+Hw6DnU7QyNMLF2Zx+76L+87vuLKI7UxhxJDfX1HYsn3anqgYg
	lWm6nBXmZZVczMDli05+hFdI6UVsgk9PtPENUxacv5XOifqH5PifqZRU0mLtf3JYqh+QVEkmRX8aX
	UNB0vHPPUEloMuhgLER1+WwzHVc18Ml9HZJPaxXN7WlBmfdqiq6PXrOJz2BbA5pMvfioQ5dROxXx/
	IbmjHyObJFwn4tPTZ36TOFDAMtE6yyQCPn3AVGJo5kxUFohdX8sxMZby3fuq0grXp7e9AEJLM4Lm/
	P9PEXHjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWzQG-00000001FfK-1mBc;
	Thu, 25 Jul 2024 14:26:24 +0000
Date: Thu, 25 Jul 2024 07:26:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <ZqJgkLxJjJS7xpp1@infradead.org>
References: <20240725120729.59788-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725120729.59788-2-pstanner@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Can we please fix this to never silently redirect to a manager version
and add a proper pcim_intx instead and use that where people actually
want to use the crazy devres voodoo instead?  Doing this silently
underneath will always create problems.


