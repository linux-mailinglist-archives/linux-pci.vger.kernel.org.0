Return-Path: <linux-pci+bounces-8872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0C390B304
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 16:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD11C21E2B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7311F945;
	Mon, 17 Jun 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="31aNCmxy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O1Uv28M2"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EC12E6A;
	Mon, 17 Jun 2024 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632949; cv=none; b=ISR6ZQYcq+khowo6uOEvI4mIVrdhcXTYSa+XLiXVyT/BRuQTfEhfxnY7hLFapGR5WeUoeDxPvGL8/TCYzOSNdBaUqjXYtMz7epuwmJbzPyaMeFAnjmwwDzALw27uTmBHnrk+AQbVYbsAgvcUEtYncKQJubOBchkrIRVg5NNWBsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632949; c=relaxed/simple;
	bh=vg+RfbQuP7Ba2mCXmuv4YQNEagG2f55+JVDZpc66crI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CYnTG6PjiEiqjKSIe3Hs5/V0oqJ9KvW4s+kOOWrtmYR5HBdW1oPdjshxIuWgDa0AyzURWWvq8Q1hh5C7uCRU2ecBgqgjGx34gcXbaUPs2iyLAmQY9Y4F51omxYw1gagV5pucy2+XXDlDAQt5Y/9VEthnTdfgbx1CGRFVuEtl2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=31aNCmxy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O1Uv28M2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEgP6nrjaN40xXEwrTWVtd3w2ZCVG6Zro3ipay84baA=;
	b=31aNCmxyI/jOsyTTXBeM6zLOjjQJmBDkyUdhsoWDBTLxXzOlVyN0tY4+kT8ZuV6vJBoFuW
	afESyFWstnehE+WAucaWFJ3+jTNdVWtn9IjTJdIMoLveJNeq7npCDjw9fKDSX0yTUwgk6T
	5jcix4c5z2Dw7S5s6wQ1bvQUniKK77gU+L8bkoebow9BKZ0UJmj3tWh43KZdxxzjqew12/
	4Y4By4mGrPqzg9nkCTWq/wdSwrEiktuefqkEcuRcjITjqP/bMC0b7DrDfnE6nspWq7l7rs
	OVN8Lk89Z87Y0CdS7WKghBvIxHCw9IcKCGmk8FRvPvqTNbMJZf+a9xYMCcw0zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEgP6nrjaN40xXEwrTWVtd3w2ZCVG6Zro3ipay84baA=;
	b=O1Uv28M2yo4rAmZ4lCRhT1xRU04yv0o/VdQz1V1zAT3CwbTAbIaDWD/Jizs55LvqBgsVTp
	HfpoRuEmjxZhj7Aw==
To: Marc Zyngier <maz@kernel.org>
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
 rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com,
 den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
 lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
 vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
 andersson@kernel.org, mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com
Subject: Re: [PATCH v3 14/24] genirq/gic-v3-mbi: Remove unused wired MSI
 mechanics
In-Reply-To: <86h6drk9h1.wl-maz@kernel.org>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
 <20240614102403.13610-15-shivamurthy.shastri@linutronix.de>
 <86le36jf0q.wl-maz@kernel.org> <87plsfu3sz.ffs@tglx>
 <86h6drk9h1.wl-maz@kernel.org>
Date: Mon, 17 Jun 2024 16:02:24 +0200
Message-ID: <87h6dru0pb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 17 2024 at 14:03, Marc Zyngier wrote:
> On Mon, 17 Jun 2024 13:55:24 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> 
>> On Sat, Jun 15 2024 at 18:24, Marc Zyngier wrote:
>> > On Fri, 14 Jun 2024 11:23:53 +0100,
>> > Shivamurthy Shastri <shivamurthy.shastri@linutronix.de> wrote:
>> >>  static struct msi_domain_info mbi_pmsi_domain_info = {
>> >> -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>> >> -		   MSI_FLAG_LEVEL_CAPABLE),
>> >> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
>> >>  	.ops	= &mbi_pmsi_ops,
>> >>  	.chip	= &mbi_pmsi_irq_chip,
>> >>  };
>> >
>> > This patch doesn't do what it says. It simply kills any form of level
>> > MSI support for *endpoints*, and has nothing to do with any sort of
>> > "wire to MSI".
>> >
>> > What replaces it?
>> 
>> Patch 9/24 switches the wire to MSI with level support over. This just
>> removes the leftovers.
>
> That's not what I read.
>
> Patch 9/24 rewrites the mbigen driver. Which has nothing to do with
> what the gic-v3-mbi code does. They are different blocks, and the sole
> machine that has the mbigen IP doesn't have any gic-v3-mbi support.
> All they have in common are 3 random letters.
>
> What you are doing here is to kill any support for *devices* that need
> to signal level-triggered MSIs in that driver, and nothing to do with
> wire-MSI translation.
>
> So what replaces it?

Hrm. I must have misread this mess. Let me stare some more.

