Return-Path: <linux-pci+bounces-18400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3539F1384
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 18:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A57188D7C1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF121E25F6;
	Fri, 13 Dec 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQS3Al3f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16A1E22E6
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110538; cv=none; b=AmTjDV5NQBPlmqWWW3rzN+qMEPfiZn7TbwGCp/vEamDzE4zFN5/EoPJA8EUgNiRIVtaklQlIYNLpAgv45w87m45d8ClbOK6YsAQIjChW8CCFZ3jXBIG+QxWPoLfTUUgofmxc7I/oAovePvAX0MBGEQpvPJWlms89nil1Nt+1WB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110538; c=relaxed/simple;
	bh=xTSTCxeBrwLAQV/iKlS/ejsKp6N+MD8vysw2fquITo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bc06DFJ/m3XZ8eG3YC/kRK9IrfXEgXvofrRcKQz1XZGSUrv3O8vo4l1G6Dszm7ZhZgJdKNtKQigQAE+u7mjxuXCmzKS1a32loHIbNTlj/3vrCbT8X4b9QkS3pLF2Esdp9t055FSQ8G22QVdGy0HQa2hrTuQlQ/0sIItYK/znw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQS3Al3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF5FC4CED1;
	Fri, 13 Dec 2024 17:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734110537;
	bh=xTSTCxeBrwLAQV/iKlS/ejsKp6N+MD8vysw2fquITo0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YQS3Al3f40tu/F5QkAoz+qwTCraUdoNFMpv5/6rXcgg6L3mDqIu6hivx9XJ7T+Dsl
	 FiaTfFccdQhQmHFDDQoTNqiNZ6pZ7ixYUADpT/oNT7TEgmKntgAGTBa2YsWnPrMezy
	 B4+3EYFHEWMk6Atr7Hy37ke0EWqn7p+NQuKRcUfBbh38mTHBh/qiNkjAUWMYs51T4K
	 rW/HYdfDHucna7FGs05PgPdJUhm7ClLBahdQgrWC9kjUacfqSpSdtzDCZET2Dqd50d
	 nk9DY32/kQrfMu6gO6OHQ24pZirdZ8nixWAMVuwGoBERjX2v7EYVYLTeKuJQocGNWT
	 gbwLvwS8VSpww==
Message-ID: <416ba7f0603be18a61a7f9510cf36a7266b0d707.camel@kernel.org>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
From: Niklas Schnelle <niks@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Bjorn Helgaas
 <helgaas@kernel.org>, 	linux-pci@vger.kernel.org, Ilpo Jarvinen
 <ilpo.jarvinen@linux.intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Date: Fri, 13 Dec 2024 18:22:14 +0100
In-Reply-To: <Z1wBshMqWp9Ea8gN@wunner.de>
References: <20241212161103.GA3345227@bhelgaas>
		 <efafe0d864af49d2f496fc6543f619958630869f.camel@linux.ibm.com>
		 <0b01d64fa7f6f62d49f39447c5175b44a1011fd5.camel@kernel.org>
		 <Z1wBshMqWp9Ea8gN@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 10:43 +0100, Lukas Wunner wrote:
> On Thu, Dec 12, 2024 at 08:40:07PM +0100, Niklas Schnelle wrote:
> > > > On Thu, Dec 12, 2024 at 09:56:16AM +0100, Lukas Wunner wrote:
> > > > > The Supported Link Speeds Vector in the Link Capabilities 2 Regis=
ter
> > > > > indicates the *supported* link speeds.  The Max Link Speed field =
in
> > > > > the Link Capabilities Register indicates the *maximum* of those s=
peeds.
> > > > >=20
> > > > > Niklas reports that the Intel JHL7540 "Titan Ridge 2018" Thunderb=
olt
> > > > > controller supports 2.5-8 GT/s speeds, but indicates 2.5 GT/s as =
maximum.
> > > > > Ilpo recalls seeing this inconsistency on more devices.
> > > > >=20
> > > > > pcie_get_supported_speeds() neglects to honor the Max Link Speed =
field
> > > > > and will thus incorrectly deem higher speeds as supported.  Fix i=
t.
> >=20
> > Ok, gave this a test and as somewhat suspected this patch alone doesn't
> > fix my boot hang nor do I get more output (also tried Lukas suggestion
> > with early_printk).
>=20
> Hm, that's kind of a bummer because while we know how to work around
> your boot hang (by disabling bwctrl altogether), we don't really know
> the root cause.
>=20
> The bwctrl IRQ handler runs in hardirq context, so if it ends up in an
> infinite loop for some reason or keeps waiting for a spinlock, that
> might indeed cause a boot hang.  Not that I'm seeing in the code where
> that might occur.  Nevertheless you can try adding "threadirqs" to the
> kernel command line to force all IRQ handlers into threads.
> Alternatively, enable CONFIG_PREEMPT_RT to also turn spinlocks into
> sleeping locks.  Maybe this turns the boot hang into a hung task splat
> and thus helps identify the root cause.
>=20
> Thanks,
>=20
> Lukas

Tried with "threadirqs" but no change. So then I tried additionally
just exiting pcie_bwnotif_irq() without doing anything if the bus
number matches my thunderbolt controller. Still same result. So I don't
think it is anything the irq handler does in software.

Thanks,
Niklas


