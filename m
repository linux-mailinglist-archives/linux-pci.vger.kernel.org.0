Return-Path: <linux-pci+bounces-28133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36979ABE2B6
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 20:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2813B7B4554
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 18:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E425C805;
	Tue, 20 May 2025 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hddkKu0m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824582116FE;
	Tue, 20 May 2025 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765915; cv=none; b=mJfl3wlD90t8e5Q6abXBTLv9af9qXmxa7+unXH4X5wTdsdftipYYk8+Z1UmlS+RYSp15FSnYcVQriZVyVVUMl3d2LTg7ZewzE82ailmJpmt5LsYu88/lAMK39PIkywuW5DZDFt4gp0Edf+jBedDL73idLo3T6gEE7eSOPGzkPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765915; c=relaxed/simple;
	bh=jwee9jRHKC9i3IB6hd0Exj0Pc2dnDouthrKRY1Giwiw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A58chekjbLxkIbd2lYZ69X2SImpKrkrTTh9TlTytK1y+eivID4UuBZAxOLvqs2wLvR0+zRFxeokOhBKEfnTLxH5f2OgfzBK0kj5gVWFCumFNe1W5nRz6DuuxHjW0Ep1iV8rAF9LqpTmz2LTq4XzlJe91NKkzc6dq0CF67n93Z4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hddkKu0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A596FC4CEE9;
	Tue, 20 May 2025 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747765914;
	bh=jwee9jRHKC9i3IB6hd0Exj0Pc2dnDouthrKRY1Giwiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hddkKu0mDChvBNXjmgLXbi56ACoBmD+CiBVK+DuLbZbm0ooahVgLKKbbVFt+bm3Gj
	 ds7VCAhwsNKpDFVHR+pZDqeUeC8pAYjz+A/lZEdzJICnvU9ceiLRIJq96tkIgOp+no
	 Dq7HcJeYijENpOEsRApyEcxf22JVb1NAYoMye7ClehwZ4godbkhHh1r9/gqiKyJ3hi
	 w7BZXh8iCo6QLspaEWrkoPgrsJda8ViQrnv8In0hQEYhN/A+FXEnaXEA3N3yYUpeAI
	 uz28tTNzk1ZrkL9Y1XXeDZaqwuqbPSun21G5eHxCM0i9hu8MVVNKigUMu4GUbz+Xev
	 FK8LNbMGdjb5w==
Date: Tue, 20 May 2025 13:31:53 -0500
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
Subject: Re: [PATCH v6 14/16] PCI/AER: Introduce ratelimit for error logs
Message-ID: <20250520183153.GA1316070@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e056eb23-e38a-4a0e-83d7-c17c62c0f9f7@linux.intel.com>

On Mon, May 19, 2025 at 09:59:29PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> > From: Jon Pan-Doh <pandoh@google.com>
> > 
> > Spammy devices can flood kernel logs with AER errors and slow/stall
> > execution. Add per-device ratelimits for AER correctable and uncorrectable
> > errors that use the kernel defaults (10 per 5s).
> > 
> > There are two AER logging entry points:
> > 
> >    - aer_print_error() is used by DPC and native AER
> > 
> >    - pci_print_aer() is used by GHES and CXL
> > 
> > The native AER aer_print_error() case includes a loop that may log details
> > from multiple devices.  This is ratelimited by the union of ratelimits for
> > these devices, set by add_error_device(), which collects the devices.  If
> > no such device is found, the Error Source message is ratelimited by the
> > Root Port or RCEC that received the ERR_* message.
> > 
> > The DPC aer_print_error() case is currently not ratelimited.
> 
> Can we also not rate limit fatal errors in AER driver?

In other words, only rate limit AER_CORRECTABLE and AER_NONFATAL for
AER?  Seems plausible to me.

