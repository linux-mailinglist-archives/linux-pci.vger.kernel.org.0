Return-Path: <linux-pci+bounces-1286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB581C654
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 09:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B741C2206C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 08:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0462BCA5D;
	Fri, 22 Dec 2023 08:14:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC117C2DE;
	Fri, 22 Dec 2023 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id AB9FE30000D0B;
	Fri, 22 Dec 2023 09:14:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A13C2517AF; Fri, 22 Dec 2023 09:14:27 +0100 (CET)
Date: Fri, 22 Dec 2023 09:14:27 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH v4 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
Message-ID: <20231222081427.GA4134@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02619a5c-842c-4441-85cb-0f7151705a5d@linux.intel.com>
 <589b2dbc-325b-404f-a387-b1c99a064d15@linux.intel.com>
 <cc6f7c1a-13f0-475a-9961-e22e73b13a32@linux.intel.com>
 <8fbd1a86-1ef5-4679-a4d9-b4faee2eda64@linux.intel.com>
 <94b08bab-6488-4c4a-9742-30a69972ba50@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Dec 22, 2023 at 09:56:39AM +0800, Ethan Zhao wrote:
> I don't know if the polling along sleeping for completion of meanningless
> devTLB invalidation request blindly sent to (removed/powered down/link down)
> device makes sense or not.

If you have a way to get to the struct pci_dev * which you're waiting for
in qi_submit_sync() then I guess you could check for its presence and bail
out if it's gone, instead of issuing a cpu_relax().


> > Again, the proposed patch is not a proper solution.  It will paper over
> > the issue most of the time but every once in a while someone will still
> > get a hard lockup splat and it will then be more difficult to reproduce
> > and fix if the proposed patch is accepted.
> 
> Could you point out why is not proper ? Is there any other window
> the hard lockup still could happen with the ATS capable devcie
> supprise_removal case if we checked the connection state first ?
> Please help to elaberate it.

Even though user space may have initiated orderly removal via sysfs,
the device may be yanked from the slot (surprise removed) while the
orderly removal is happening.


> Yes, this is the old kernel stack trace, but customer also tried lasted
> 6.7rc4

If you could provide a stacktrace for a contemporary kernel,
I think that would be preferred.


> (doesn't work) and the patched 6.7rc4 (fixed).

Why is it fixed in v6.7-rc4?  Is the present patch thus unnecessary?


> > Finally, it is common to adhere to terms
> > used in the PCIe Base Spec in commit messages, so "ATC Invalidate Request"
> > might be preferable to "devTLB flush request".
> 
> ATS Invalidate Request ? devTLB flush request has the same meaning,
> 
> I thought all iommu/PCIe guys could understand.

I'm just pointing out the preferred way to write commit messages
in the PCI subsystem (as I've perceived it over the years) so that
you can reduce the number of iterations you have to go through
due to maintainer feedback.  I'm just trying to be helpful.


> How to define the point "some" msec to timeout while software
> break out the waiting loop ? or polling if the target is gone ?

I'd say adhere to the 1 min + 50% number provided in the spec.

If you know the device is gone before that then you can break out
of the loop in qi_submit_sync() of course.

The question is, does the Intel IOMMU have a timeout at all for
Invalidate Requests?  I guess we don't really know that because
in the stack trace you've provided, the watchdog stops the machine
before a timeout occurs.  So it's at least 12 sec.  Or there's
no timeout at all.

If the Intel IOMMU doesn't enforce a timeout, you should probably amend
qi_submit_sync() to break out of the loop once the 1 min + 50% limit
is exceeded.  And you need to amend the function to sleep instead of
polling in interrupt context.

Can you check with hardware engineers whether there's a timeout?

Thanks,

Lukas

