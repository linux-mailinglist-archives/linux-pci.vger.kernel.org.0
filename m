Return-Path: <linux-pci+bounces-29389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DCAAD494C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 05:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE703A5C94
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 03:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977F718DB0E;
	Wed, 11 Jun 2025 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vde01gqY"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E413A3F2;
	Wed, 11 Jun 2025 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612434; cv=none; b=EqFrBp1Mfa/DaHrC6RT+uyJqiRxMJX5WLwslahwNK/dWULvwsm5NDtSe5GfxcPojAs2mpWRTgnYzkEihOFn/HM4yG9wA92JFvFWzCdNgxOL3KUUsL/vIZbe9ICp24nyvObMdz2jAPWP8bobnJeNU0sLYQ/x+c3BkInzvRpLxKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612434; c=relaxed/simple;
	bh=x/5yoshJpK/46vD6GnhsEJDVUCcaG30nZvgNrRAXwyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3p3AfiJKCnqc+wj57jjJAlQS0mR9pkur/ANu8d7eOM/Mw+JoA8gSCV6bDkVLpmlu84+JR+K4xbATvvmvRSsA7TanWTv1Ol3K39L7C1Cq5IRT0rykeiCc7zRxu+puS0/sEctdP05qf5L9aRhHr0Y0VOhuB3/WusDHNBO3h/Hoes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vde01gqY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eT2mDlWcfi4vpC/fXERnSm4bvQLSkLGtiKJc/u+kRZI=; b=vde01gqYoLSiujMIH9TY8DaQXV
	91hOwGVeBw99TB5LYiwlNiDnLqE4cr0r5pG7h47Y5m+bJMv8+d3edWk3mLhRgrS4Y6zTfZ9fJhG76
	H6zxiUH9hJMq111yoirRM6JX5TFFBtzJo3aWJpt6Hm4yHouOIW8JWFOLjknaBW9Tzp/Dr04TvjTC8
	4UG3VyHt4BK3Tx9wmG5DWPaAgRdOH4OXsu/HxLjXNt30zPIFBWV1Jj29pM//TuGip6n8S/OISShQ4
	uBYwM8pgzK4eSGzZbNV11wFwkf8WJ5GNxTDP0NUsk1tftFhZd3GYA8vXy9UQc0FFzIUGkD79JSHNd
	Kp7HNz5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPC7M-00000008jgW-2eKW;
	Wed, 11 Jun 2025 03:27:12 +0000
Date: Tue, 10 Jun 2025 20:27:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: grwhyte@linux.microsoft.com
Cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com,
	code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
Message-ID: <aEj3kAy5bOXPA_1O@infradead.org>
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 12:05:50AM +0000, grwhyte@linux.microsoft.com wrote:
> From: Graham Whyte <grwhyte@linux.microsoft.com>
> 
> Add a new flr_delay member of the pci_dev struct to allow customization of
> the delay after FLR for devices that do not support immediate readiness
> or readiness time reporting. The main scenario this addresses is VF
> removal and rescan during runtime repairs and driver updates, which,
> if fixed to 100ms, introduces significant delays across multiple VFs.
> These delays are unnecessary for devices that complete the FLR well
> within this timeframe.

Please work with the PCIe SIG to have a standard capability for this
instead of piling up hacks like this quirk.


