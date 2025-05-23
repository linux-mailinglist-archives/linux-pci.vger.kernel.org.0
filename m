Return-Path: <linux-pci+bounces-28334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 787C6AC2725
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 18:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817663B4C80
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADD7223DCD;
	Fri, 23 May 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ4BTRSD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5A2DCC07;
	Fri, 23 May 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016421; cv=none; b=CdcxjopGP9gD3QhY8Kbz5M7fcUaBk7YEIPjVgvuwH+N/Bm0YbmqmJ9L9kYib2+HIdsp+g/l7nC7QdOWH80isbmItWzPSddTKM2iZUb51tYjLMHoIWe6faLGWjkTI6xWyqArUVx7VpjuROcu9e13DbFcJZ9eubm7XX7htbNMKI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016421; c=relaxed/simple;
	bh=U5OXlf+RyqrwgHycF2mts31Fb7vitn7wTynxz3ykuCU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y1BWurFjD4qHmghYkQH8E63eZ6TE8xx2Xfrd+aXFOSf7IS9uiu57Zjc36F/vMrsil1oULaVkrAgLq+MqZdmQJ5M25NAPYYIyAMiA836AI1x917a2dxvF7UgUyQKzXM2B6FPnId9DoCMQhc6YpdqLykvfDpPVZspkbsgRXu/tf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ4BTRSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD81C4CEEB;
	Fri, 23 May 2025 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748016420;
	bh=U5OXlf+RyqrwgHycF2mts31Fb7vitn7wTynxz3ykuCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HJ4BTRSD/0E+TS5UteGvWOxf6R8OzJOt1+4nzoXPvNCXRD/8S/RNGcPwi58jotavi
	 +4tTV8FqgSGUtL4GoCwxkaJlgejTdf4aMBX+IvZvWOvMGbFhSXdQDkVOjBmkXvR+S0
	 A9qINpvL88R5Q+bWhPSmHHFrdVJ+9gSC/jPZH+EcX4uP/DMIfwsHCfFm9iq1abQET6
	 gC/+8VnoGgTxoCZucgiciaTMBy20nqlu9TLHLQhvg72dAthv2ZWiMbew4qxHxAyn8+
	 SzSxhptlarY55XjN3O70l0VVUIkvlIvZApk9gVoyDSbZldmkqtr6C0gwS5Jw4QzCt1
	 chp6pa8W4pWGQ==
Date: Fri, 23 May 2025 11:06:58 -0500
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
Subject: Re: [PATCH v8 18/20] PCI/AER: Ratelimit correctable and non-fatal
 error logging
Message-ID: <20250523160658.GA1559366@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb9bca3e-cb0a-41e9-bf7f-0889eb3f3c47@linux.intel.com>

On Thu, May 22, 2025 at 04:56:56PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 5/22/25 4:21 PM, Bjorn Helgaas wrote:
> > From: Jon Pan-Doh <pandoh@google.com>
> > 
> > Spammy devices can flood kernel logs with AER errors and slow/stall
> > execution. Add per-device ratelimits for AER correctable and non-fatal
> > uncorrectable errors that use the kernel defaults (10 per 5s).  Logging of
> > fatal errors is not ratelimited.

> > +static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
> > +{
> > +	struct ratelimit_state *ratelimit;
> > +
> > +	if (severity == AER_FATAL)
> > +		return 1;	/* AER_FATAL not ratelimited */
> > +
> > +	if (severity == AER_CORRECTABLE)
> > +		ratelimit = &dev->aer_info->correctable_ratelimit;
> > +	else
> > +		ratelimit = &dev->aer_info->nonfatal_ratelimit;
> > +
> > +	return __ratelimit(ratelimit);
> > +}
> > +
> 
> Why not combine severity checks? May be something like below:
> 
>     switch (severity) {
>     case AER_NONFATAL:
>         return __ratelimit(&dev->aer_info->nonfatal_ratelimit);
>     case AER_CORRECTABLE:
>         return __ratelimit(&dev->aer_info->correctable_ratelimit);
>     default:
>         return 1; /* Don't rate-limit fatal errors */
>     }

Beautiful, adopted, thank you!

