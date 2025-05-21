Return-Path: <linux-pci+bounces-28243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8427AC0059
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 01:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BFD9E1E4C
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 23:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5FE23BCF2;
	Wed, 21 May 2025 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsUde9Z2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E0A220686;
	Wed, 21 May 2025 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868803; cv=none; b=beOp6D7DnDvlGx6Atr7wt37ASSnRNMgQmja7fND0Xv5kvSzvnUtcQGQ/BuO6gNpgx87ziAY4SD2R5DeHeoUPk33JBS15sSdQARi412mHqU2e3yW9F2aL34zuh+d8jU1/g6RIUIq9yv3+25ZOoMAtpOdpmzuFee10j6tyJLfh2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868803; c=relaxed/simple;
	bh=NEfRGNGqd+jQ4ZBng1dfzvjrKmSVR+/dtJx0zlR93Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cw7ItFdOPxGiXkDVH4f9MVmvWAoDus7cd9oW6whVlAJsgd5mvdwEJAipe1jttSsJnWaDaZ4pWo32EzPVyTcRwBETZlGYAOTMdb2CuCkYO3r6TfRRfOtVtOohvKZ885ZIsS4NBaNg+LHxCufXvc+yeqHRcO71A4fNd9IzpbNMgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsUde9Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369B4C4CEEA;
	Wed, 21 May 2025 23:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747868801;
	bh=NEfRGNGqd+jQ4ZBng1dfzvjrKmSVR+/dtJx0zlR93Ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SsUde9Z2FPViWIrd9w4gBW4lxhWaZCxVaNRIUwfdG98emO4Q0nTSUmtVGXUa/K62u
	 4kDvqYBFgk5Vjli1GmKSnXNG4CCjkJGZlKPPLZ0hPDXPQCA7vKajIGUWEHeubI/6IP
	 T3+Xzs0eQp22gYrGHaPWQVYwKpqEuMPINy2sIw5udEBO4KjiUXbfhZ8rXJoJrTrohp
	 aZRTX4UJs/vAqJ5qq0sxK4MBdIZiOapIz0SWEPizirFpYHQrC1plIDGXVtml7qj9x6
	 PCZVBQGvP4tg6eiVTFEXiLhWk7M90tWuK+VjhuxZRZH5dYupM94ZZhZcJjt9KUFzL2
	 TnwGOmuLP9dRw==
Date: Wed, 21 May 2025 18:06:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
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
Subject: Re: [PATCH v7 15/17] PCI/AER: Ratelimit correctable and non-fatal
 error logging
Message-ID: <20250521230639.GA1452526@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac30a88d-7139-40ce-ae3c-34ef12c939a5@linux.intel.com>

On Tue, May 20, 2025 at 03:33:45PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 5/20/25 2:50 PM, Bjorn Helgaas wrote:
> > From: Jon Pan-Doh <pandoh@google.com>
> > 
> > Spammy devices can flood kernel logs with AER errors and slow/stall
> > execution. Add per-device ratelimits for AER correctable and non-fatal
> > uncorrectable errors that use the kernel defaults (10 per 5s).  Logging of
> > fatal errors is not ratelimited.

> > +	/* Ratelimits for errors */
> > +	struct ratelimit_state cor_log_ratelimit;
> > +	struct ratelimit_state uncor_log_ratelimit;
> 
> Nit: Do you think we should name it as nonfatal_log_ratelimit?

Maybe so.  We can always change this internal name, so I guess the
important part is the sysfs filename
("/sys/bus/pci/devices/<dev>/aer/ratelimit_burst_uncor_log").

"ratelimit_burst_nonfatal_log" is not quite parallel with
"ratelimit_burst_cor_log" the way "ratelimit_burst_uncor_log" is.

But it's definitely true that the underlying PCIe Messages are
ERR_COR, ERR_NONFATAL, and ERR_FATAL.

So I think this is more than a nit, and you're right that we should
use "cor" and "nonfatal" somehow.

I'll work on that tomorrow.

