Return-Path: <linux-pci+bounces-24250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB575A6AD38
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 19:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74236882FED
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844E1EC006;
	Thu, 20 Mar 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7S5qMlk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628DE22540F
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496325; cv=none; b=X4GgX3+hUAxqsYxkgOLTJsjGkyuFrV+G5LoGyTu70mlNeRx3dlJOvSZj3qL6UA7KFSFzSRPsXqDyQZWMhYXvV+MCaCCYwBp+23JbqctvL7wS4dnCt1vf57bbW07weTCeGt5A9511XZ5Hz2Hn32sFr7l9O233pqnijFA+2q0Q38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496325; c=relaxed/simple;
	bh=YWMSZn9B7JlNs79o3naI1bmf46y09FSsawFryXmfvxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn1vzxYeLyvez4930tUC29KGSSTBx04iuKcPbRMwVp+9Vw/4iLtBwFDbjZ0pQ/XCrTXOgRXhLUsP8VpihQ4LGz0bPMZ8HPzrf1PbihAwbhVCKWhFE+rH0A3nHB7vA/T1gcTPM2TzAXCUtSvuzPch9KsQDv7/95tIjzzlt7H5/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7S5qMlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C063EC4CEDD;
	Thu, 20 Mar 2025 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742496324;
	bh=YWMSZn9B7JlNs79o3naI1bmf46y09FSsawFryXmfvxk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=J7S5qMlkKrF/uPcTyH6etPSIz/bkaJCID0orx1t9aDnCimh37E02y8r5ihumyAF5V
	 gDW+6FzGsmZi/MIFL3apWMHXr+vpxajEvUzARKLsS8n2pgTGYvv3MEXsJ26+e/OEdu
	 RJQ6XD+2IBMCM7+wx5cDVQIZhSsM7KczVSz0jEbSpyMGoe6SsvGWnqYQox0kdQdJuT
	 mwegMpb1BKsIgDBXeIhjurSjPUV1pszYFjJbdCbve/IF88GOqjqYXNAir4sQZZPj3c
	 XjlVE/sjhmoMif+hBeMUjsxkC8icDDVJp9E/AGiEPnA1oLMQfZufy6SmZQi8Yjnlr2
	 n+oayrJeAKFCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 69692CE0AE0; Thu, 20 Mar 2025 11:45:24 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:45:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
	Terry Bowman <Terry.bowman@amd.com>
Subject: Re: [PATCH v4 0/7] Rate limit AER logs
Message-ID: <75742734-c795-4a10-9a4a-31ff5332e721@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250320082057.622983-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320082057.622983-1-pandoh@google.com>

On Thu, Mar 20, 2025 at 01:20:50AM -0700, Jon Pan-Doh wrote:
> Proposal
> ========
> 
> When using native AER, spammy devices can flood kernel logs with AER errors
> and slow/stall execution. Add per-device per-error-severity ratelimits
> for more robust error logging. Allow userspace to configure ratelimits
> via sysfs knobs.
> 
> Motivation
> ==========
> 
> Several OCP members have issues with inconsistent PCIe error handling,
> exacerbated at datacenter scale (myriad of devices).
> OCP HW/Fault Management subproject set out to solve this by
> standardizing industry:
> 
> - PCIe error handling best practices
> - Fault Management/RAS (incl. PCIe errors)
> 
> Exposing PCIe errors/debug info in-band for a userspace daemon (e.g.
> rasdaemon) to collect/pass on to repairability services is part of the
> roadmap.

For the series:

Reported-by: Sargun Dhillon <sargun@meta.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>

And thank you!  I did throw together a quick hack to get things going
internally on our fleet, but this series is way better.

							Thanx, Paul

> Background
> ==========
> 
> AER error spam has been observed many times, both publicly (e.g. [1], [2],
> [3]) and privately. While it usually occurs with correctable errors, it can
> happen with uncorrectable errors (e.g. during new HW bringup). 
> 
> There have been previous attempts to add ratelimits to AER logs ([4],
> [5]). The most recent attempt[5] has many similarities with the proposed
> approach.
> 
> Patch organization
> ==================
> 1-4 AER logging cleanup
> 5-7 Ratelimits and sysfs knobs
> 
> Outstanding work
> ================
> Cleanup:
> - Consolidate aer_print_error() and pci_print_error() path
> 
> Roadmap:
> - IRQ ratelimiting
> 
> v4:
> - Fix bug where trace not emitted with malformed aer_err_info
> - Extend ratelimit to malformed aer_err_info
> - Update commit messages with patch motivation
> - Squash AER sysfs filename change (Patch 8)
> v3:
> - Ratelimit aer_print_port_info() (drop Patch 1)
> - Add ratelimit enable toggle
> - Move trace outside of ratelimit
> - Split log level (Patch 2) into two
> - More descriptive documentation/sysfs naming
> v2:
> - Rebased on top of pci/aer (6.14.rc-1)
> - Split series into log and IRQ ratelimits (defer patch 5)
> - Dropped patch 8 (Move AER sysfs)
> - Added log level cleanup patch[6] from Karolina's series
> - Fixed bug where dpc errors didn't increment counters
> - "X callbacks suppressed" message on ratelimit release -> immediately
> - Separate documentation into own patch
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215027
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=201517
> [3] https://bugzilla.kernel.org/show_bug.cgi?id=196183
> [4] https://lore.kernel.org/linux-pci/20230606035442.2886343-2-grundler@chromium.org/
> [5] https://lore.kernel.org/linux-pci/cover.1736341506.git.karolina.stolarek@oracle.com/
> [6] https://lore.kernel.org/linux-pci/edd77011aafad4c0654358a26b4e538d0c5a321d.1736341506.git.karolina.stolarek@oracle.com/
> 
> Jon Pan-Doh (5):
>   PCI/AER: Move AER stat collection out of __aer_print_error()
>   PCI/AER: Rename struct aer_stats to aer_report
>   PCI/AER: Introduce ratelimit for error logs
>   PCI/AER: Add ratelimits to PCI AER Documentation
>   PCI/AER: Add sysfs attributes for log ratelimits
> 
> Karolina Stolarek (2):
>   PCI/AER: Check log level once and propagate down
>   PCI/AER: Make all pci_print_aer() log levels depend on error type
> 
>  ...es-aer_stats => sysfs-bus-pci-devices-aer} |  34 +++
>  Documentation/PCI/pcieaer-howto.rst           |  16 +-
>  drivers/pci/pci-sysfs.c                       |   1 +
>  drivers/pci/pci.h                             |   4 +-
>  drivers/pci/pcie/aer.c                        | 271 +++++++++++++-----
>  drivers/pci/pcie/dpc.c                        |   3 +-
>  include/linux/pci.h                           |   2 +-
>  7 files changed, 260 insertions(+), 71 deletions(-)
>  rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (77%)
> 
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 

