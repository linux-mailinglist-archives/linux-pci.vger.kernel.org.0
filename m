Return-Path: <linux-pci+bounces-4999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CEB886DB9
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 14:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59641C22AD9
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C849F2F844;
	Fri, 22 Mar 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GhlT6sUi"
X-Original-To: linux-pci@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658746426;
	Fri, 22 Mar 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115168; cv=none; b=YcM/6x6GEIIKlFcvqUmILXMz/abwOjnIU0w4RLHgYfjO3vZ6SJ7AGLATLuuA5M9qrb+vL+dSMbrR3mb8m6n/XGg3yZm2B9FWthEJeNLKpl82PEIX5O13Ou4sEB0XwfsgXHDlIIvsEoOi6PKbRPKWflBUyhdfIninG7+dtY4jkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115168; c=relaxed/simple;
	bh=wWL7Qd9zf9P35RRTiH66YgwnjnydwRR7zrbffpADuTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiJT8BMTL3VIYyFaaT+g2dbrn+tONKOIe4AwLcPaAMDGdvv6J1V9vF5aDe8YzCD/RRqlEOTWojZzJoghg0mtjIwltgAsvRShl68+2JAcDOyc27UL4Vqo0HZeyfrCL83arux1mX9FI+ZzQAnPH+xjaqn1ZAfGc34lHpxb5vwAOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GhlT6sUi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Xl/48A4HPpWnt1iClvth3eKw6IUYrmTPNL4qKKxVwg=; b=GhlT6sUi6KIkvAtazRCczUEo6H
	JH5Ukt9dpq3wMsczgXQKJ3uaLAHHnkrhY0DNaOdNpxtgn+LVCULIkPPg/ykwBHBA/9k5hKvDc8ymB
	QbhWOP18eDTcuYvxJuA/t9mrhV9fpoDAFIxkmD9a36ZqFAsuc4VbFVkhIxjEqvOd6F3cczNZ0jT42
	w3etq9ULUMjy9kLRjHjjjvX1IcaAgYIBsQNUMR9Qn2b4u9P+mgvS8mCLGyV8aU4DNr25hnrN67TOV
	AWr/Fo5QOB1Wt/QlISWpFcJwxJbqe5zbEW3U3TrngLALwRlPG9YKNqP/6BjRgu5sWaJo7za5LQonn
	Ofs3y76g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnfDX-00000009QjS-2U0L;
	Fri, 22 Mar 2024 13:45:55 +0000
Date: Fri, 22 Mar 2024 13:45:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: peterz@infradead.org, torvalds@linux-foundation.org,
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
Message-ID: <Zf2LkyLAKuSZAG16@casper.infradead.org>
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
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index 7a3a08d81f11..845fbd54948f 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -36,6 +36,7 @@ Library functionality that is used throughout the kernel.
>     kobject
>     kref
>     assoc_array
> +   cleanup
>     xarray
>     maple_tree
>     idr

Maybe move that up by a line?  assoc_array, xarray, maple_tree, idr are
all data structures and it looks weird to have cleanup go in the middle
of them.


