Return-Path: <linux-pci+bounces-24747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B239DA7125D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAE016F523
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3291A2C27;
	Wed, 26 Mar 2025 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="miqIZvAd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z74KjXxa"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B61A23A9;
	Wed, 26 Mar 2025 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976874; cv=none; b=poJLkFqy6geHxoFmLGgsD1jwTRo3/VqZUc9XSVTQ5l7ZlrboUEcWr+0U9ftxiHm2ofrdnDRNzIRm2f4GmJ7VK02E3Y+0LW/DiFFhPAkgLg9QvH+W3LOF9O6Zbeg0IWhfTl0o69IjyGLdvF4uzASti/EptOLKKhbSUtlX6ZfvyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976874; c=relaxed/simple;
	bh=97GGlFoIUVFMwr67oOosvZJZX3ZQCsIweKvgIVSQmec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GzuhH2hDe1ERF+LMcDC+yJd0FQPv76xhka+EUd7OMJuoCPb1LcrWjIfKjNFs/K6CrdpCCQ50ecn/79H4jzMHNx137DTmbDvHOBeQTFjGdvgjU8Ghb6UdCZ4YC8zdfaTiiLxrlpfpWbrpUvS8SQc4XtBYZwyq1Rr5Puz1Bf0XAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=miqIZvAd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z74KjXxa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742976871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKcMiwg131TmW5oikumSj99JLfzIDAkNS32OxdtAXEk=;
	b=miqIZvAdfz9A0oXzn4AFAoacHJhs3i5TmQQYeqKcGNg3b3PYTpMfZpCLhq3rcNLtbpFykb
	//mge/g1ERF/HEnyZSx8GFU8S8itHQgOWMiqijBBJm0v5Xb6xN71F5fbH90t+REvgw27nk
	yV0pjXd3ON/XsOI5bAkoJYIUQS0bELPb6rbrIcGOx6eP0ebWCQczSZ7H2v406DUJtSjsqT
	7wpYmQuXBJFtdMjrFzR3w07Kp4KKgHK0JJLh2SHQ9FCKzQjpT6K7/vJZAoRayWt0wNbUpw
	beaaSQiVCkCGljV6iH/MUqAdfCi7CRVpVjtzo2J+SOCaIWKFV7b556ebFiVmww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742976871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKcMiwg131TmW5oikumSj99JLfzIDAkNS32OxdtAXEk=;
	b=Z74KjXxaq9z8YvoCfDYk+wS2LQPfyuRxNWP5wyKollJxrr/dAX/8yLGcNhPHwsclteOzcJ
	8+DUDm2TmMgPcjBQ==
To: Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>, Bjorn
 Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
In-Reply-To: <Z-KLhBHoNBB_lr7y@macbook.local>
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
 <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
 <Z-GbuiIYEdqVRsHj@macbook.local>
 <kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
 <Z-Gv6TG9dwKI-fvz@macbook.local> <87y0wtzg0z.ffs@tglx>
 <87v7rxzct0.ffs@tglx> <Z-KDyCzeovpFGiVu@macbook.local>
 <87sen1z9p4.ffs@tglx> <Z-KLhBHoNBB_lr7y@macbook.local>
Date: Wed, 26 Mar 2025 09:14:30 +0100
Message-ID: <87msd8yzrt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25 2025 at 11:55, Roger Pau Monn=C3=A9 wrote:
> On Tue, Mar 25, 2025 at 11:27:51AM +0100, Thomas Gleixner wrote:
>> On Tue, Mar 25 2025 at 11:22, Roger Pau Monn=C3=A9 wrote:
>> > On Tue, Mar 25, 2025 at 10:20:43AM +0100, Thomas Gleixner wrote:
>> > I'm a bit confused by what msi_create_device_irq_domain() does, as it
>> > does allocate an irq_domain with an associated msi_domain_info
>> > structure, however that irq_domain is set in
>> > dev->msi.data->__domains[domid].domain rather than dev->msi.domain,
>> > and doesn't override the default irq_domain set by
>> > pcibios_device_add().
>>=20
>> The default irq domain is a parent domain in that case on top of which
>> the per device domains are built. And those are private to the device.
>
> Sorry to ask, but shouldn't dev_get_msi_domain() return the specific
> device domain rather than the parent one?  Otherwise I feel the
> function should rather be named dev_get_parent_msi_domain().

The function returns the MSI domain pointer which is associated to the
device. That can be either a global MSI domain or a parent MSI domain.

The few places which actually care about it have the proper checks in
place and until we consolidate the MSI handling to per device domains,
this will unfortunately remain slightly confusing.

>> The XEN variant uses the original global PCI/MSI domain concept with
>> this outrageous domain wrapper hack. A crime committed by some tglx
>> dude.
>
> I see.  So the proper way would be for Xen to not override the default
> x86 irq_domain in dev->msi.domain (so don't have a Xen PV specific
> version of x86_init.irqs.create_pci_msi_domain) and instead do
> something similar to what VMD does?

No. Xen should override it as it provides the default domain for the
system. VMD is a special case as it provides it's own magic on top.

If XEN would not override it as the global default, then you'd need a
lot of extra hackery to do the override at the end.

Thanks,

        tglx

