Return-Path: <linux-pci+bounces-21565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F3A37742
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 20:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB8E189006E
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBDE13635B;
	Sun, 16 Feb 2025 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="iDVAJlnd"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D992179A3
	for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739735478; cv=none; b=bSVLuP1puA7t8KSa9MUKuDQLsHhOJj6BO924xN5M0DDjajlCEzQ6UGNSGGnB9xLRFPSIChcoaGaB5N0ssEr0rJ5Z1czwts3oFXyhnBbMwuhnPSK3vi9flj8vBr0sUFhJM2vQR7svwkp79FT+helyBE3NNHGPkrYpNQyL65NJ0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739735478; c=relaxed/simple;
	bh=lulXzaE5mQzB7tIgOZ+HcnTs//PgwrJYfD6ZZ9xU8Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5B0k6IrDfr2LNwwpH1JfeN9mistQV3rs0EM7J7TQckBWZugGiPtPjB9TBSXxDikRSRF4auEoAiqesXlCeff7D0N4Df2XzUUYlt6M6LhFfnlQ7+Aqn6/mHBM3Q0JyoESX0muMzZ3Ix04DKoR9oah/X0el+CICxyP2UoOH0XHYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=iDVAJlnd; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Sun, 16 Feb 2025 14:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739735472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7zUF7if+qI0pS0WqK6F5Wlzlg37Ucrvyg1LqmdHhQII=;
	b=iDVAJlndi+SAJ4P39P0F55UBMJJ3QaHDSypuXSmL4IM3ztDWbai30ZyC62omhEki4/tq0w
	sKAHK7EZtBFwK9djKt/HuCdyrSYVh9/ws9CMJWJ+YCRWc++bzP1kZ3SNM9VNnVRWwHISo/
	rMI6kcFpN6BK/dzPkbAflcIrDVmqExtqQMfPhRW5c6FmDxm039bpV/0raAMrq93x5Mbp22
	T46MHMcbg3hjMz8cRJDnuJAEuq3WrpjXESU8RyF659TwyZzsP2XfZ+NsnSwJHwWE8bZy4T
	DQHupO/1iIiMJCWmFR4KnwP+UMuJqHl8irKTnIipXovpcqUgm+OMHEWuQEnHQw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Janne Grunau <j@jannau.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: apple: Add depends on PAGE_SIZE_16KB
Message-ID: <Z7JBrMxHZfWpUhHR@blossom>
References: <20250211-pci-16k-v1-1-7fc7b34327f2@rosenzweig.io>
 <20250211183859.GA51030@bhelgaas>
 <20250211195601.GB810942@robin.jannau.net>
 <20250211220019.GC810942@robin.jannau.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211220019.GC810942@robin.jannau.net>
X-Migadu-Flow: FLOW_OUT

> This is much less sutle than I remember up to the point that I'm not
> sure if this change is still needed.
> 
> Silently disabled CONFIG_* due to missing dependencies aren't nice either.

Very true. Plus, it seems useful to be able to build-test the apple pcie
driver in a 4K situation, to catch build-breaks sooner for cross-driver
changes.

Let's drop this patch from our tree?

Alyssa

