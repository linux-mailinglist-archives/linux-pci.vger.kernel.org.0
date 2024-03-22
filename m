Return-Path: <linux-pci+bounces-4983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7298868D1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 10:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF389285901
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B091199AD;
	Fri, 22 Mar 2024 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tWMGIn7z"
X-Original-To: linux-pci@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3673A1B943;
	Fri, 22 Mar 2024 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098406; cv=none; b=uScE2+gb1KotsbD+BhMs8Solxqd7xbf6n7Ft9W5pvZCrrUNlNuNvmq4COjp6suxTQJxzlnVzJoNO2WVjwJO/9MPdN2Ozl543TEAKI4Xn1vbS4kDdWs0QvzUKbuFNf6m2YGQWMI+7UUxLpn3JUr/5OJolk8MRgzLTNU2TOPkWt0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098406; c=relaxed/simple;
	bh=XxnnccNT1g9hjZXtIndNZirOkjP5hXPdgEGQvxPPqbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgtGmp9qUfl/x3n5Pqej6Pkygy4k6ut31C5Sy/ZBl+9N/2ZqR6NCN8h6haxMxY4w0vPxH1YXeGWJ+oZm7oEDZJsDADt5oOEKo+g4bH1f5DM7JzkPWHsrYJUgHeyHd8VqPoGOnAJZY0LUlUKHlwPbnbMfuwGxlq1/2GBGXSYy2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tWMGIn7z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pvjxLpRYZMp85nRI3hYI4aDOBGUY172EE0CsMfMFET4=; b=tWMGIn7z9kaGYqXN3J4+0LDTns
	FE85wYkVSfu8zuirijxDTZvE1H5i8rbwJ4RA5QR7oGPke3PA0VwIQm4qDSL6Vb6qtiVeJ96jOqjAu
	Sal+b3Kh5Ks3XHnwB7opBsa/uvL7Q9bIp545Q6/YPLIwfcUMjlXC041NCqnW8TT9xn1s4JSkCHCzQ
	U9fEQePfMQYtZzAqhx0EmnFR8HIL4xeFq5TclcjExCKPCvT1TUYG1MbGvVTNkkdunboL6RHBWpcxi
	qZe/FIFxS6dRPeB3jGLK+o5AEFxGVMjkvX9GAhDCM8V9U/YyQ6m7mu+qk52yZ/mVgUD1UG1L95uch
	QEkDsVCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnar8-00000008tIs-3XT7;
	Fri, 22 Mar 2024 09:06:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7CFBD300399; Fri, 22 Mar 2024 10:06:30 +0100 (CET)
Date: Fri, 22 Mar 2024 10:06:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: torvalds@linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas.wunner@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] cleanup: Add usage and style documentation
Message-ID: <20240322090630.GA40102@noisy.programming.kicks-ass.net>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>

On Wed, Mar 20, 2024 at 03:04:41PM -0700, Dan Williams wrote:

> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..4620a475faee 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -4,6 +4,118 @@
>  
>  #include <linux/compiler.h>
>  
> +/**
> + * DOC: scope-based cleanup helpers
> + *
> + * The "goto error" pattern is notorious for introducing subtle resource
> + * leaks. It is tedious and error prone to add new resource acquisition
> + * constraints into code paths that already have several unwind
> + * conditions. The "cleanup" helpers enable the compiler to help with
> + * this tedium and can aid in maintaining FILO (first in last out)
> + * unwind ordering to avoid unintentional leaks.
> + *
> + * As drivers make up the majority of the kernel code base lets describe
> + * the Theory of Operation, Coding Style implications, and motivation
> + * for using these helpers through the example of cleaning up PCI
> + * drivers with DEFINE_FREE() and DEFINE_GUARD(), e.g.:
> + *
> + * .. code-block:: c
> + *

So I despise all that RST stuff. It makes what should be trivially
readable text into a trainwreck. We're coders, we use text editors to
read comments.



