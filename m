Return-Path: <linux-pci+bounces-24424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD320A6C611
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 23:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51465482DF2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D361BD9C6;
	Fri, 21 Mar 2025 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRNzCgYV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140228E7
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597276; cv=none; b=FaM2Gb5BzsTaM0fXSk2PyuJlmXn1LD6WYgkv98i+PmFQhylBTDL8gVobAVIFTSIbh9DBXOPL4Q7VVZ80YAKhFXLPuUVMz9SDengy7JlJOnQuKMsXROe3DtNNqXNyGookB5c/fJBZyFoHA1IE4VFJgOZu0PIut9rg/OG45njI+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597276; c=relaxed/simple;
	bh=Xcf4gH0CSbYs7kTv7qacEPUMVyH4G+UGVg0onWIA0hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdOz0VwQFBlJB9r3HH4rFBf2uGZDOO9bo+N7NSFnSmjSougPRWtd4fjKYPp7Iors3T+koFi2gbYqxGkdc8zvD3acVgGEWcEiD9jrezG9t9TGWL7aMhAyqpDirBv+G5TL56j84SNEuo1/5k9lXubaCzj+zoafShmmDLoFJf447w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRNzCgYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C07C4CEE3;
	Fri, 21 Mar 2025 22:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742597275;
	bh=Xcf4gH0CSbYs7kTv7qacEPUMVyH4G+UGVg0onWIA0hY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KRNzCgYVu+kL+ktpF/Qk6gSobTEp5vH3+edhFo7ELkpOc8vRLUlzO4N+NOmvyiFa+
	 pbNfm7hIcEulZGYDYaqAY9geJ5O9XZC4+hP3kHm9sLgajtELTxp83swKAe4AI49EXd
	 DdDYGvnBNs31m5RT/SxV11/dnGY26s8Yh6ztABxbGma1uuoaHkBRmg7R9rBWuJbmfA
	 xjxZQeFpYpYMzAKRdMsxRyJxbLDssbUDcGn87/HEubBqTchXf6NREanfm048TBSM03
	 0sTwQyMnHJ6M6qiEOGqoclLMBELM5y9tYgtR83LgHWzmd6F2nlaNKX2Qv2WP69RiKL
	 /RlFv79CRCFXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 46601CE0D1D; Fri, 21 Mar 2025 15:47:54 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:47:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>
Subject: Re: [PATCH v5 5/8] PCI/AER: Rename struct aer_stats to aer_report
Message-ID: <6037bebe-0490-470e-9220-42ca63feb4a5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9c62d088-36b3-4311-9e53-d7cf87cf3393@paulmck-laptop>
 <20250321223930.GA1172062@bhelgaas>
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
> 
> Oh, I see now how this happened via your ack email, Paul.  So I think
> it would make sense for Jon to add Sargun's reported-by to "[PATCH v5
> 6/8] PCI/AER: Introduce ratelimit for error logs", along with a line
> in the commit log connecting Sargun with the RCU CPU stall warnings,
> etc., because that's the patch that actually addresses those warnings.
> 
> I wouldn't add it to the other patches because it's just confusing.

Works for me!

							Thanx, Paul

