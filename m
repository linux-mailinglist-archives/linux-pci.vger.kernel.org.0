Return-Path: <linux-pci+bounces-28143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3501ABE5FF
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4331B65131
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A925E46E;
	Tue, 20 May 2025 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/zc6R9g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7DB2528FD;
	Tue, 20 May 2025 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776331; cv=none; b=m6h83F8Q0cMv1TU0ahx2PdL0lqpRcsPDqMHtpZja0iRlUn7hbiXE2Vod1QP+nvXr+jIswqSnyFKXkrMGrB4Bv6xlYWfzc0IRT24eyEPl2GjqlJN/a9fMTcDHamUKsFKF3pI0OmeBMAp8ibQL+77rHhdhlHbOer5Ud3V4jAlAsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776331; c=relaxed/simple;
	bh=FCNh0IptjSh80eH+CVfsMlmlvLVALzpv2FwtcV3n7ag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SWfIOhW4GsqtBm5rFk4UySmS7IeU5BLEYdAwiMQ75+7bwWeFbT5m7CY2o3UXu+FfpHOEODsiapDZC89QU0Bq7gCm0oJDd+/LBo6xM3Z8QQi6W3NfCnaS7atyJbUd13HqNg0r2FAO/IFUnFfY/8V0k+eJFnzdYoitGzKlh/WYdiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/zc6R9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87F9C4CEED;
	Tue, 20 May 2025 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747776331;
	bh=FCNh0IptjSh80eH+CVfsMlmlvLVALzpv2FwtcV3n7ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k/zc6R9g4IGcsWMS5g9FRrSbMEwAuPBO6xeTI3aYQvkDIPrw7jEYQf4eBXcLbuKep
	 ApH4aK8G6zlw/+k3RK6TmGTaMvBCaZEPKHiLx9l+2TKrfRtzvgGeOmSTuh+VjH9+mo
	 Yf1fz2Gemqi+t399nvUmwGCdAe2NC0jPcqA8hpOR0qZ+rrYX+3NAJ5urb7UWc9Sls0
	 0syMfuk5Wyp+7qUt7+oYqj+D8kfI8+J0qbii876QDCXqqPrH29Nsk5bvDdc2w9xQDx
	 xEjdFycI8TT8esLLQqMXgJ5WP2DukC52mLK1C+59BEuXXqtgGcfBbbnQFxJ+02MPvk
	 zA5MVGPdjhymQ==
Date: Tue, 20 May 2025 16:25:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 13/16] PCI/AER: Rename struct aer_stats to aer_report
Message-ID: <20250520212529.GA1301402@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8624dd16-83a3-4fd3-a5d9-a79c50236e58@linux.intel.com>

On Mon, May 19, 2025 at 08:30:09PM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> > From: Karolina Stolarek <karolina.stolarek@oracle.com>
> > 
> > Update name to reflect the broader definition of structs/variables that are
> > stored (e.g. ratelimits). This is a preparatory patch for adding rate limit
> > support.
> > 
> > Link: https://lore.kernel.org/r/20250321015806.954866-6-pandoh@google.com
> > Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> >   drivers/pci/pcie/aer.c | 50 +++++++++++++++++++++---------------------
> >   include/linux/pci.h    |  2 +-
> >   2 files changed, 26 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 06a7dda20846..da62032bf024 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -54,11 +54,11 @@ struct aer_rpc {
> >   	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
> >   };
> > -/* AER stats for the device */
> > -struct aer_stats {
> > +/* AER report for the device */
> > +struct aer_report {
> 
> For me aer_report also sounds like stats like struct. I prefer
> aer_info, but it is up to you.

I tend to agree and can imagine a future where we might collect the
stats, ratelimits, and maybe aer_capability_regs into a per-device AER
structure.  "aer_info" seems like a decent generic name, so I did
s/\<aer_stats\>/aer_info/

