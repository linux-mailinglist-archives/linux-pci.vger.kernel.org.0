Return-Path: <linux-pci+bounces-11194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E11945FDB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 17:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87114283C50
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D7F1E2898;
	Fri,  2 Aug 2024 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Feuyqlsz"
X-Original-To: linux-pci@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398DE1F61C;
	Fri,  2 Aug 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611265; cv=none; b=sQgWgGJEbTP+/W2Q9OXScL4BFy6JWdNT/EmfoDZG9dXQP8cD3OCBpc+dBfyFYIu8NyA33ZRZFjqunjYC8JiicbxWBKUnkgWMI7bjVjn/XBoYP7+E96RyhSt3pz4bttCEdWnEzYGcT6KHDMvSwnJLVWfRfEAdSOfMBwM9M0rCPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611265; c=relaxed/simple;
	bh=iLjiimI9QumdAASoSSm5SQ9Q5oP3vBPC+C6gOdC1ahg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIFL4qga1dOYRSFUKgZFfSTxV/1uKxdua9YwR1zEUFuJTm2F0nACoUOiXPgtTqpUw2cenpZmj19XNHb4grQ6KA+PRkDu4hl9xCF1r3yQ9T/4ghQtFaqvMMb1jjzuUnyu8gotnVZjAi/jyMJ5gjZRpG7u3cvDWx1Y9EEgMPYMjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Feuyqlsz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=fIYvKPuNOEMEkDChnU2e4Wtk8YCB6+/z9l+uIWsJNiA=; b=Feuyqlsz+VRV6PvIasBPuyuFLy
	5TQcnlgbH/t1tHUgX17TV5G12D+KD0k0VYWwExdJM+uriVdtnJOHWVUmoomxZXGT1tGUKv/IvsonX
	g4Z/M4k6kyCh1OvteeCHfbb5ycE4041SgMJECHDauoFUqhgwiitG28PF1tXCZfgXweWQAcVHwwQr0
	5u6ZYUhEpA6DJLxxZ9ch3YuK8vJKEgCAJdYzr1OMQ+DVdRRX+fq8SGhAgCBhpN/7st94qQMgKMgNF
	JGCL1ahR+lKuh3hfpnNYiMa2LIwud7gd5Ta+xCrq09HWa2IFWKDiYCx71TDVf/09GM/exGhMt6QSi
	mc5f9UNw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZtsL-00000005jbg-0OJ7;
	Fri, 02 Aug 2024 15:07:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38A2430049D; Fri,  2 Aug 2024 17:07:24 +0200 (CEST)
Date: Fri, 2 Aug 2024 17:07:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, torvalds@linux-foundation.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Jonathan Corbet <corbet@lwn.net>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] cleanup: Add usage and style documentation
Message-ID: <20240802150724.GL39708@noisy.programming.kicks-ass.net>
References: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
 <171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com>
 <20240802145856.00002717@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240802145856.00002717@Huawei.com>

On Fri, Aug 02, 2024 at 02:58:56PM +0100, Jonathan Cameron wrote:
> On Fri, 29 Mar 2024 16:48:48 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > When proposing that PCI grow some new cleanup helpers for pci_dev_put()
> > and pci_dev_{lock,unlock} [1], Bjorn had some fundamental questions
> > about expectations and best practices. Upon reviewing an updated
> > changelog with those details he recommended adding them to documentation
> > in the header file itself.
> > 
> > Add that documentation and link it into the rendering for
> > Documentation/core-api/.
> > 
> > Link: http://lore.kernel.org/r/20240104183218.GA1820872@bhelgaas [1]
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Changes since v2:
> > * remove the unnecessary newlines around code examples further reducing
> >   the visual interruption of RST metadata (Jon)
> > * Fix a missing FILO=>LIFO conversion
> > * Fix a bug in the example
> > * Collect Jonathan's reviewed-by
> > 
> > Review has been quiet on this thread for a few days so I think is the
> > final rev. Let me know if anything else to fix up.
> 
> Would be good to either get more review, or this applied.
> 
> Currently I'm pointing people at the email. Would much rather
> point them at the upstream docs!
> 
> Jon, would you consider picking this up?

I suppose I can stick it in tip/locking/core, I think that's how we all
ended up with this nonsense anyway :-)

