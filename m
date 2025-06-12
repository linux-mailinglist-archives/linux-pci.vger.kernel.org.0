Return-Path: <linux-pci+bounces-29522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3AAD6809
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB23117E4D0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 06:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2C61F8EFF;
	Thu, 12 Jun 2025 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oqo9AlTX"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F91F0E39;
	Thu, 12 Jun 2025 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709884; cv=none; b=FeRWMokbhBexgJurWW00aH9iVKzRMvBxJWFIWCHjDOGOD5txB/DUtkyd0WUDvAbAg1JaBBv/gytmPAwXfkVYLj5QvqrmQMzxZQh2Tm1mbobOQvfTKedsgnoSYQXhmJingCsSqT3MFFvkT114XwbmW8fmuNQ84PDsLf1k20Kmkkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709884; c=relaxed/simple;
	bh=hwEQMmj5NpD7TYTUrpSQl8P8YX/4owSuhsy987Ydyf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9Ny167rBOskNp52MRtaodGyWKZZOAmpjmy2kVUihujcVjmFxwHElbQJfV3yBV2C6/O6SqKHy94e/KEhgRbrBle3MCprtliOvZNqXoWB1K5YC/x3e9Rdzrzpcyp/Yw2UqqZgrkSLbJNzoVN8C+o1mc+4HsqO4iSAWjl82ylKzOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oqo9AlTX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/LIT+PyE2jX0PpxZeFpDNynbM6tFJlZCwyr6C5tUQIc=; b=Oqo9AlTXShU0/3RSbMuyuzzPD7
	KJwmmT3Tvzw6DIHfQGPs3jw08HtW8+682FZon6Tk8DZ+q1nIMRUUC9k/VApO7Jy/jqu+zDTGhLDAP
	nb4sRP+AOzPh9nxiBgQdlGnvzQZuaFQSqCL0wX/f/8JmhyRh+jtDETmfm74u0E0Zcv6lOGEvu3Xak
	WytEOEbWKfHN3Zpm84cz3UD60ENFXYJtB7QzCT9bIB6SRdM6cfrXde+KafFei1vJCaq5OWwPaiFmr
	WcGi4aLPRTqttb5VsJq3/xr1UuOkjxy26MA8Yi1igTyCcs5Kk+EGyP1T2gPlCEq28fbLycjUkeu4c
	61zJN8vA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPbT5-0000000CK0N-2Anj;
	Thu, 12 Jun 2025 06:31:19 +0000
Date: Wed, 11 Jun 2025 23:31:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Graham Whyte <grwhyte@linux.microsoft.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
	shyamsaini@linux.microsoft.com, code@tyhicks.com, Okaya@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
Message-ID: <aEp0N2RNh1szW1Xy@infradead.org>
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
 <aEj3kAy5bOXPA_1O@infradead.org>
 <aEku4RTXT-uitUSi@ryzen>
 <1ccbaac5-7866-42f6-b324-cb9e851579e6@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ccbaac5-7866-42f6-b324-cb9e851579e6@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 01:08:21PM -0700, Graham Whyte wrote:
> We can ask our HW engineers to implement function readiness but we need
> to be able to support exiting products, hence why posting it as a quirk.

Your report sounds like it works perfectly fine, it's just that you
want to reduce the delay.  For that you'll need to stick to the standard
methods instead of adding quirks, which are for buggy hardware that does
not otherwise work.


