Return-Path: <linux-pci+bounces-5037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8194887A5E
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 21:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C5E2821E4
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 20:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF539AFF;
	Sat, 23 Mar 2024 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j3jyiCkY"
X-Original-To: linux-pci@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA243B193;
	Sat, 23 Mar 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711226704; cv=none; b=ZdtjH6pTLex0wwViFEvNBBF6gzMYuZV3sv8j+OCv25kV6wUVQWsS6u63hNIRaTNrQFmyn90Ey0Mwtv9XNDuWO/aDepGX5PhKwomUdkLbahl3u+ooQJ3YUDbVz6yE4+SY6pRWukTsuBZkbQ1/rpvCylE780cvEcGMJVyesOdJjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711226704; c=relaxed/simple;
	bh=e0it6zWyRhUl6CsgJZa+SyAT+lNOfGgzSfE1aPkratA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJ13mYhpNf//Uki1y0EyrkjnW+zU5CJDy4PvGlBrJAs1BmT5K3LMYn9itMlN24zFDaGSAezq0BEiiAMN2GzfbYFqIQVYh/b7bkrfCMdIVxMyu3vbJEfQS/+gNuqpy8IstvdNUBLNdO9ckjjRCKVfUcJaCKHyf7WykrgvoQaKQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j3jyiCkY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YFrRirU/iGoOz+WkYBm22sZJCyVBMxy3NWhi3BHjlxI=; b=j3jyiCkYeVm21Mh9hQY0bv7GqD
	jEgGvIQHy2fWJLA6ZluG4W/weDDBi9B8V5N7CZxs2BYM8uzl4uyj8l2YijTzlnOPttgzGJRziKJOs
	ipMr1xCEtMu0UZ1AquCdnWFHS7S+UceILDAcL/JxV9+z8u+z7dqsaZ8pOjwVElU0Liu96LtcCaIqk
	SrNkzAIrNAO9tv9qIHfq2tR7VYSdpmBvkt8DPSRqzPE7XUsa6Wi9d8Kx8DbboD/9TUa/3vZr1EWAO
	HAoNVWxM3O8Le3JUdYknjEjVjFDWVMPv4mcboIpUjX8tAitrEU5rmDj+13YJMz/VLNAMGpqT04UZu
	+MSWst4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro8EY-0000000CWEi-0837;
	Sat, 23 Mar 2024 20:44:54 +0000
Date: Sat, 23 Mar 2024 20:44:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas.wunner@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] cleanup: Add usage and style documentation
Message-ID: <Zf8_RYHW7QmCzl2-@casper.infradead.org>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <20240322090630.GA40102@noisy.programming.kicks-ass.net>
 <65fdd7ae82934_4a98a29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65fdd7ae82934_4a98a29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Mar 22, 2024 at 12:10:38PM -0700, Dan Williams wrote:
> Peter Zijlstra wrote:
> > So I despise all that RST stuff. It makes what should be trivially
> > readable text into a trainwreck. We're coders, we use text editors to
> > read comments.
> 
> Ok, I will rip out the RST stuff and just make this a standalone comment.

I would rather you ignored Peter's persistent whining about RST and
kept the formatting.

