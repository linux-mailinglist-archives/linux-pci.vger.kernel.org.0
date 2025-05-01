Return-Path: <linux-pci+bounces-27079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C721AA65FC
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 00:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3381BC3576
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 22:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F2B1EFF96;
	Thu,  1 May 2025 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bzv0j4Qe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496A14AD2D
	for <linux-pci@vger.kernel.org>; Thu,  1 May 2025 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746136981; cv=none; b=YxGzETeinUBWorHv2YUpZfrWpkXQaYbVolSj1LrLUueNBIhjKNl6RSotsyw+EMBtb50DNUdY4Ezpykl2D6jNHCZGPKgj9TkxWHX1UuEojm+68BGeIzXQQ7yXu9WyV/uNFWnwxyJjQl/aj71c+lcTYdng2RQG6XxB2x1vGKriv7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746136981; c=relaxed/simple;
	bh=w1V25AytGZA6GelSgaUSdHHHS3Bf0Ausd/8eCuMAe4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OTKfa8CLjcNzg2G5HNXd0vIvtefbE2KP0u67Sh/JV5alulQmRRYg/lP+IDOGHEB4uTIlCVMb7CZuu7n84cgcP3H7UpveI4e6WPyhWrfpZx7OEkm9jtodT+ORUriQgcFkZocCc6Th9Pyn+eGZpLhR7zjjZ5XzwyUU1DQS7jb+kXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bzv0j4Qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30440C4CEE3;
	Thu,  1 May 2025 22:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746136981;
	bh=w1V25AytGZA6GelSgaUSdHHHS3Bf0Ausd/8eCuMAe4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Bzv0j4QeES00IA0jV/3CLZu2BAP/S6OPvsaQjHas0i8MB6A4v5goXxR43he7tkJyO
	 J68tW5aoZoaXvFo8j//0OjC/6fiRRyexOXxksES2rx3W8jCNAZMWnP3l1opIm+2GvV
	 dwGk2MVYnMoGhyZWqGvEvMYAb1fR+xpX49q0BXDbRBdvI+dfE8zwr77RFTvekXbReY
	 IEf0BTGoDVsl6kkQK+IOEdbcmrg4G5jV+hO7vyJKnzT91wfj9HTqykSnGar+Vbn2OE
	 9QH3/Ix+12UptcgqrR3iI2+WtBFW/jThAu0VbX922AWIDJ6jeoCs7YaSGySLVI09Xl
	 Ap3FnJibDQErQ==
Date: Thu, 1 May 2025 17:02:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>
Subject: Re: [PATCH v5 5/8] PCI/AER: Rename struct aer_stats to aer_report
Message-ID: <20250501220259.GA787711@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321223930.GA1172062@bhelgaas>

On Fri, Mar 21, 2025 at 05:39:30PM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 21, 2025 at 03:16:48PM -0700, Paul E. McKenney wrote:
> > On Fri, Mar 21, 2025 at 05:01:15PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Mar 20, 2025 at 06:58:03PM -0700, Jon Pan-Doh wrote:
> > > > Update name to reflect the broader definition of structs/variables that
> > > > are stored (e.g. ratelimits). This is a preparatory patch for adding rate
> > > > limit support.
> > > > 
> > > > Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> > > > Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> > > > Reported-by: Sargun Dhillon <sargun@meta.com>
> > > 
> > > What did Sargun report?  Is there a bug fix in here?  Can we include a
> > > URL to whatever Sargun reported?
> > 
> > He reported RCU CPU stall warnings and CSD-lock warnings internally
> > within Meta, so sorry, no useful URL.

CSD?  I guess knowing what CSD is isn't completely essential here, but
I haven't a clue what it means.  Something to do with IPI and getting
another CPU to run a function?  Is CSD an acronym for something?

Bjorn

