Return-Path: <linux-pci+bounces-24245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C80DA6AC7D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 18:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68247AC6ED
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E15F226CF9;
	Thu, 20 Mar 2025 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G50IUNNw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB38226D02
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493076; cv=none; b=SyU7AVxYzaetqTqDvz21srFl7hE9BCr6PlKy+HpIWhRwCdEffObYvsZXDqOrc69EbTrr24tnQlCSLy3UzYnYkSBWLxduZOtvlRKA/6QfC7qoVpXDCWzdc/m8Z19X0Wlaw77BGrryERjLvxx2mZ7RdWgE1j7vAghNMJsb1e6NHBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493076; c=relaxed/simple;
	bh=ayhB41P/EMNT89Y8iG8vAXEYTGJ941LK5pl5ZmTct18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r67pDurwb0ZATn3OCSz27vSFIWB6KoFotxgtfI1/QWfA5Oj+gwxaTC+w7NfnvLiRjeIFJcguIXRcoDID0gGWsM47VeW13tbExwu3vXKjFihGlb5x+yFrDR2umcF4X9sRRj7Kcd+fHnQ4E9ey0eO8dwgaJwA6/9c2Uba2zwu/cfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G50IUNNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371DDC4CEE7;
	Thu, 20 Mar 2025 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742493075;
	bh=ayhB41P/EMNT89Y8iG8vAXEYTGJ941LK5pl5ZmTct18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G50IUNNwJIxj/6bF9nIh0o+JlG2ECTDz5JeXL3kgEhaBkgxjpgJrYk/qeippUXMS+
	 SJ+OlljUkPkSxB5awciFZKi4skNCyiY/IbbRxHsa3LjAxhe0xZEYbgX1oFBbf7ZzWb
	 FVrzI7H/c4EATuDDReBhb+Q86NAF+1LrSr6GoB3ryDuzR6qvAQVGL469oZTopiErEM
	 YK2gCLEfCE1UMFr8edDCXsLQRYmwVhv4rQUvPjxTMPt10ljARaTh+VrLcALOCveGe6
	 9lM1e+OHf4G0WXqYcaRr6hVdDweIefuibWTVMMijgH4zEfdWRDh0tGS9zrXJmwPowI
	 +HRRb3/im1pNA==
Date: Thu, 20 Mar 2025 12:51:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Jon Pan-Doh <pandoh@google.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20250320175113.GA1089681@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebafe3cc-2d0f-4000-863d-20365977e27c@oracle.com>

On Thu, Mar 20, 2025 at 03:56:53PM +0100, Karolina Stolarek wrote:
> On 20/03/2025 09:20, Jon Pan-Doh wrote:
> > Spammy devices can flood kernel logs with AER errors and slow/stall
> > execution. Add per-device ratelimits for AER correctable and
> > uncorrectable errors that use the kernel defaults (10 per 5s).

> > +	/*
> > +	 * Ratelimits are doubled as a given error produces 2 logs (root port
> > +	 * and endpoint) that should be under same ratelimit.
> > +	 */
> 
> It took me a bit to understand what this comment is about.
> 
> When we handle an error message, we first use the source's ratelimit to
> decide if we want to print the port info, and then the actual error. In
> theory, there could be more errors of the same class coming from other
> devices within one message.

I think this refers to the fact that when we get an AER interrupt from
a Root Port, the RP has a single Requester ID logged in the Source
Identification, but if Multiple ERR_* is set, find_device_iter() may
collect error info from several devices?

> For these devices, we would call the ratelimit
> just once. I don't have a nice an clean solution for this problem, I just
> wanted to highlight that 1) we don't use the Root Port's ratelimit in
> aer_print_port_info(), 2) we may use the bursts to either print port_info +
> error message or just the message, in different combinations. I think we
> should reword this comment to highlight the fact that we don't check the
> ratelimit once per error, we could do it twice.

Very good point.  aer_print_rp_info() is always ratelimited based on
the ERR_* Source Identification, but if Multiple ERR_* is set,
aer_print_error() ratelimits based on whatever downstream device we
found that had any error of the same class logged.

E.g., if we had something like this topology:

  00:1c.0 Root Port to [bus 01-04]
  01:00.0 Switch Upstream Port to [bus 02-04]
  02:00.0 Switch Downstream Port to [bus 03]
  02:00.1 Switch Downstream Port to [bus 04]
  03:00.0 NIC
  04:00.0 NVMe

where 03:00.0 and 04:00.0 both logged ERR_FATAL, and the Root Port
received the 03:00.0 message first, 03:00.0 would be logged as the
Source Identification, and Multiple ERR_FATAL Received should be set.
The messages related to 00:1c.0 and 03:00.0 would be ratelimited based
on 03:00.0, but aer_print_error() messages related to 04:00.0 would be
ratelimited based on 04:00.0.

That does seem like a problem.  I would propose that we always
ratelimit using the device from Source Identification. I think that's
available in aer_print_error(); we would just use info->id instead of
"dev".

That does mean we'd have to figure out the pci_dev corresponding to
the Requester ID in info->id.  Maybe we could add an
aer_err_info.src_dev pointer, and fill it in when find_device_iter()
finds the right device?

> Also, I wonder -- do only Endpoints generate error messages? From what I
> understand, that some errors can be detected by intermediary devices.

Yes, I think any device, including switches between a Root Port and
Endpoint, can detect errors and generate error messages.

I guess this means the "endpoint" variable in aer_print_port_info() is
probably too specific.  IIUC the aer_print_port_info() "dev" parameter
is always a Root Port since it came from aer_rpc.rpd.  Naming it "rp"
would make this more obvious and free up "dev" for the source device.
And "aer_print_port_info" itself could be more descriptive, e.g.,
"aer_print_rp_info()", since *every* PCIe device has a Port.

> I'm also thinking -- we are ratelimiting the aer_print_port_info() and
> aer_print_error(). What about the messages in dpc_process_error()? Should we
> check early if DPC was triggered because of an uncorrectable error, and if
> so, ratelimit that?

Good question.  It does seem like the dpc_process_error() messages
should be similarly ratelimited.  I think we currently only enable DPC
for fatal errors, and the Downstream Port takes the link down, which
resets the hierarchy below.  So (1) we probably won't see storms of
fatal error messages, and (2) it looks like we might not print any
error info from downstream devices, since they're not reachable while
the link is down.

It does seem like we *should* try to print that info after the link
comes back up, since the log registers are sticky and should survive
the reset.  Maybe we do that already and I just missed it.

This seems like something we could put off a little bit while we deal
with the AER correctable error issue.

Bjorn

