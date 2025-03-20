Return-Path: <linux-pci+bounces-24258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC91A6AF2D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 21:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6BB481EE6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 20:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74DB1E8337;
	Thu, 20 Mar 2025 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh1BuHHU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7F2A1A4
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502555; cv=none; b=ugx3KQTwErpJFt88hcTcbRKN0ywxfbrVDQkSKaN4ycCR5VczMuyPBtz60OKoyAbhx9Q75Lm2b3QxlpTocbMZA2IrmvbFF+XpuJ76TStc37/J5PoLp3vDZlRrGPII0pvpikxPz3ZIW9AXbS+x3T9clH1VXaxymhZEjjxBew7grgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502555; c=relaxed/simple;
	bh=GY+uOMdexOuW15NVjDL1ks7HetEkmcWHEvFS6jNxmyY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F82Swz0vR05rJhHTseZxMCRZqu0DoTi1JzmpK2bBVbJUoUXDZhV7u4hu4rLRNKYudr6e88mcNEOwRTppeiIdfn4S/Sjrw4ePGObvwHFG+qXp5HYfrpq1ssNt/Dr/0dePSwEMa5Lvlx7aRCAQzOdQRwZQx1/4xmyWpSjIyLIE614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh1BuHHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E197C4CEEC;
	Thu, 20 Mar 2025 20:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742502555;
	bh=GY+uOMdexOuW15NVjDL1ks7HetEkmcWHEvFS6jNxmyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Dh1BuHHUzF40NtKDwwtXFDyPMCGepJ0eOv1LKNvx7l/RZ2AqWrAafa2rszNkTcZUB
	 bhUPJIe+e0HBKyDt489grBGi5m8fUk3E7fN0fTUugV6TLb4/oFJzlqJxL+aTWWJNqN
	 6Hvk+Pxc/FsaG9eCja7+VK8Z4EuhzUm7o3KK+A/Cq//+1XqsCC0/5xGwB2k1OE6cwf
	 CQTrYbqd7AmZdVPTHvcCRlnsZyR5fUoyc7NHBXUs0Vvw7FPAMQeFoyZYChn13iV3Qv
	 BsGtSsgrJ799SaeDUCjDDkl4wopFqVWQ78LDssr74xmOyYRv/EbwbvnMSbHG4QX82Y
	 F+h7egdRoPk0w==
Date: Thu, 20 Mar 2025 15:29:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <Terry.bowman@amd.com>
Subject: Re: [PATCH v4 5/7] PCI/AER: Introduce ratelimit for error logs
Message-ID: <20250320202913.GA1097165@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMC_AXVi7cFOnSa25SEkZsYf27eoX1NwFmc8VnRgFQS44PpKRQ@mail.gmail.com>

On Thu, Mar 20, 2025 at 12:53:53PM -0700, Jon Pan-Doh wrote:
> On Thu, Mar 20, 2025 at 10:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Mar 20, 2025 at 03:56:53PM +0100, Karolina Stolarek wrote:
> > > On 20/03/2025 09:20, Jon Pan-Doh wrote:
> > > > +   /*
> > > > +    * Ratelimits are doubled as a given error produces 2 logs (root port
> > > > +    * and endpoint) that should be under same ratelimit.
> > > > +    */
> > > For these devices, we would call the ratelimit just once. I
> > > don't have a nice an clean solution for this problem, I just
> > > wanted to highlight that 1) we don't use the Root Port's
> > > ratelimit in aer_print_port_info(), 2) we may use the bursts to
> > > either print port_info + error message or just the message, in
> > > different combinations. I think we should reword this comment to
> > > highlight the fact that we don't check the ratelimit once per
> > > error, we could do it twice.
> 
> You're right. I was thinking of amending it to something like:
> 
> Ratelimits are doubled as a given error notification produces up to
> 2 logs (1 at root port and 1 at source device) that should be under
> the same ratelimit.
> 
> > Very good point.  aer_print_rp_info() is always ratelimited based
> > on the ERR_* Source Identification, but if Multiple ERR_* is set,
> > aer_print_error() ratelimits based on whatever downstream device
> > we found that had any error of the same class logged.
> >
> > That does seem like a problem.  I would propose that we always
> > ratelimit using the device from Source Identification. I think
> > that's available in aer_print_error(); we would just use info->id
> > instead of "dev".
> 
> Wouldn't you be incorrectly counting the non-source ID devices then?
> I think this is another reason where removing
> aer_print_port_info()[1] (only printing port info when failing to
> get device error info) simplifies things. Of course, we then have to
> weigh whether the loss of info is less than the ratelimit
> complexity.

Yes, I guess so.  Maybe the ratelimit should be in the source of the
interrupt (Root Port for AER, Root Port or Downstream Port for DPC) so
it's more directly related to the interrupt that got us here in the
first place.

I think the struct aer_err_info is basically a per-interrupt thing, so
maybe we could evaluate __ratelimit() once at the initial entry, save
the result in aer_err_info, and use that saved value everywhere we
print messages?

  - native AER: aer_isr_one_error() has RP pointer in rpc->rpd and
    could save it (or pointer to the RP's ratelimit struct, or just
    the result of __ratelimit()) in aer_err_info.

  - GHES AER: I'm not sure struct cper_sec_pcie contains the RP, might
    have to search upwards from the device we know about?

  - native DPC: dpc_process_error() has DP pointer and could save it
    in aer_err_info.

  - EDR DPC: passes DP pointer to dpc_process_error().

> > > I'm also thinking -- we are ratelimiting the
> > > aer_print_port_info() and aer_print_error(). What about the
> > > messages in dpc_process_error()? Should we check early if DPC
> > > was triggered because of an uncorrectable error, and if so,
> > > ratelimit that?
> >
> > Good question.  It does seem like the dpc_process_error() messages
> > should be similarly ratelimited.  I think we currently only enable
> > DPC for fatal errors, and the Downstream Port takes the link down,
> > which resets the hierarchy below.  So (1) we probably won't see
> > storms of fatal error messages, and (2) it looks like we might not
> > print any error info from downstream devices, since they're not
> > reachable while the link is down.
> 
> I did not expect error storms from DPC so I thought it best to focus
> on AER.

Completely agreed.

> [1] https://lore.kernel.org/linux-pci/CAMC_AXWVOtKh2r4kX6c7jtJwQaEE4KEQsH=uoB1OhczJ=8K2VA@mail.gmail.com/

[BTW, email quoting style error here; shouldn't have the entire
message you're replying to repeated below.  Gmail tries hard to screw
this up for you ;)]

> On Thu, Mar 20, 2025 at 10:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> ... (snipped)

