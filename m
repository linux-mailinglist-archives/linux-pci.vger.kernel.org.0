Return-Path: <linux-pci+bounces-24421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2CFA6C60A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 23:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E881887C51
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AB1F03D9;
	Fri, 21 Mar 2025 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPIcwriH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3C1C462D
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742596772; cv=none; b=J+J+m0r8XpgW36fo3/qDeIUE6ETwd3Bptu4+VZiwRocsukuiQ9SFRND3WTSRSczBipwsjAJ86Z0SbbfkVC8/sT2kNJwVbiOHGOVjUlx3Xi1dDrpyOwZbrYCSYKzYs7t7bfZ/2suQ0MibOP7MB29FrZdusJIYzDZvA/kc+1LWWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742596772; c=relaxed/simple;
	bh=YIRKMdGQrKxWWXeXFOpYatAHP51OrW/y4YaT0emWFcc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J7GQ2BkwxtzyTdZZOoWLVWAMeoSdowTYKVVcw7z5/E2mn3fsA5tZSXk3CxPez4KSEkBidBznFI6eAI76xo4izQLHCi1yIuUlfs+dCK+svwnBOrRgZXSPxN3YbWGEODGYcQyi9OvcaaWg8aeWCcMFTd5dnBpcLDTthBSl4AtAsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPIcwriH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C13C4CEE3;
	Fri, 21 Mar 2025 22:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742596772;
	bh=YIRKMdGQrKxWWXeXFOpYatAHP51OrW/y4YaT0emWFcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KPIcwriHf+BTLl9gHaG693F36++BByqI91leqUphbZOc83P0tsHxhHkHTtP8HE5hP
	 NNMM86mp8zrPzi7DRCFkzK1Tk426c3EHmHJOqytZfgdHj5wcAzWDcyr3uhjRu3ACNi
	 sO/CVEk/GUlSUg0u1hZI2R2ae3zsvWhd4ba5fWmVe7teezKwOXBfV3DE2LbQQacszU
	 UEmXs6e/N++vdzONCvqzBIZY14ZudtvtNAA4uviD4fWLUYH6LFQ82N5C0jpzBQFYpc
	 Zu+Pmok6AR2s4Oae2mkVSXfFhT4boPUc89rySSNqGOBGVEaJ5xt60Bapl5EoC9ufsf
	 QMRSc3JcoKfaQ==
Date: Fri, 21 Mar 2025 17:39:30 -0500
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
Message-ID: <20250321223930.GA1172062@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c62d088-36b3-4311-9e53-d7cf87cf3393@paulmck-laptop>

On Fri, Mar 21, 2025 at 03:16:48PM -0700, Paul E. McKenney wrote:
> On Fri, Mar 21, 2025 at 05:01:15PM -0500, Bjorn Helgaas wrote:
> > On Thu, Mar 20, 2025 at 06:58:03PM -0700, Jon Pan-Doh wrote:
> > > Update name to reflect the broader definition of structs/variables that
> > > are stored (e.g. ratelimits). This is a preparatory patch for adding rate
> > > limit support.
> > > 
> > > Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> > > Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> > > Reported-by: Sargun Dhillon <sargun@meta.com>
> > 
> > What did Sargun report?  Is there a bug fix in here?  Can we include a
> > URL to whatever Sargun reported?
> 
> He reported RCU CPU stall warnings and CSD-lock warnings internally
> within Meta, so sorry, no useful URL.

Oh, I see now how this happened via your ack email, Paul.  So I think
it would make sense for Jon to add Sargun's reported-by to "[PATCH v5
6/8] PCI/AER: Introduce ratelimit for error logs", along with a line
in the commit log connecting Sargun with the RCU CPU stall warnings,
etc., because that's the patch that actually addresses those warnings.

I wouldn't add it to the other patches because it's just confusing.

Bjorn

