Return-Path: <linux-pci+bounces-39480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D18DC11F34
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 00:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100F33AA073
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8522DE6F9;
	Mon, 27 Oct 2025 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlwTH5R5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE1326CE3A;
	Mon, 27 Oct 2025 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606952; cv=none; b=uxdmJfw7Q9xz4gDyrAIFZCgoLKSTBvvGNK0oC3HQqQEJkCYh//zrkQRuAgn5cC2TamRkRUvwKApahhIFnS6ikijbdhPSnwM0JTG8W2IdfYQw1RsVOiYnwpewkldh/Fr27/CwYDEbSemdS7qZFE7WM60LSrmBg8yEUZyJD+ffj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606952; c=relaxed/simple;
	bh=/j7DHDKpN0QX4vOUNDCfZHeNcGCANMg6sfqJnKXSq4Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jhUsQQbp+p18gUZAbD7iF2eEVokI4TP8qnGJ/+MAQ54hAoDVo2e56cXxozCAJczCBg1Wl2DBhvLbJM95pxJzMH7GwhzDQdY6t5YolgroPDq174YM+HCrh5cJs+tKyDFlJQ8Cb0zP6G0wBVZr2/gsEktjh4+ALThQsajIJdYcdvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlwTH5R5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761606950; x=1793142950;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/j7DHDKpN0QX4vOUNDCfZHeNcGCANMg6sfqJnKXSq4Q=;
  b=UlwTH5R5HZj6ChXGd+ax1rIrMXNK6O/mwEcG3LZlGEMJXGPheqFzcdja
   bw4Ntk2VRpip7AHF2fk/x0IfVOalsoXrt31fZibmcrj7Vqz5Zkx2Dk3mh
   nvG7CP878dSZMWyfRt589Lbwp0/PdWjVBtAIefj8PrbPLm5NS0ZA9v5GW
   XFx2tkPQjUdQtbrlYdmFl6Ewj2ckk+T55zh8DZJ7XBNumIKQgqp3SXPAh
   pf0+iQiUQsh4TAdRba4RLUGSR5nZMolS7Zcwnv0bADNdxa/NORzuAR1g8
   RoQNDjcG7gIrW1Ma7KBOPBfTqkHT8p+uiOWOIF5nkBxKeMyuF9p3N+VtO
   A==;
X-CSE-ConnectionGUID: t50zm6drQQmacMrj6IlCjQ==
X-CSE-MsgGUID: l4rzHaHpSAeoS75B9qXpTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67563738"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="67563738"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 16:15:49 -0700
X-CSE-ConnectionGUID: 5uVDLYkVRxWzGSlc8SEoMA==
X-CSE-MsgGUID: Yeo9UPLbTPSbR7oTvH/Nnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="185086939"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.85])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 16:15:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 Oct 2025 01:15:43 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Klaus Kudielka <klaus.kudielka@gmail.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Do not size non-existing prefetchable window
In-Reply-To: <20251027231222.GA1487591@bhelgaas>
Message-ID: <f397a048-e0a8-2bb1-f18b-64ad98bf83a3@linux.intel.com>
References: <20251027231222.GA1487591@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-798074588-1761606943=:982"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-798074588-1761606943=:982
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 27 Oct 2025, Bjorn Helgaas wrote:

> On Mon, Oct 27, 2025 at 03:24:23PM +0200, Ilpo J=C3=A4rvinen wrote:
> > pbus_size_mem() should only be called for bridge windows that exist but
> > __pci_bus_size_bridges() may point 'pref' to a resource that does not
> > exist (has zero flags) in case of non-root buses.
> >=20
> > When prefetchable bridge window does not exist, the same
> > non-prefetchable bridge window is sized more than once which may result
> > in duplicating entries into the realloc_head list. Duplicated entries
> > are shown in this log and trigger a WARN_ON() because realloc_head had
> > residual entries after the resource assignment algorithm:
> >=20
> > pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> > pci 0000:00:03.0: PCI bridge to [bus 00]
> > pci 0000:00:03.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:03.0:   bridge window [mem 0x00000000-0x000fffff]
> > pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02]=
 add_size 200000 add_align 200000
> > pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02]=
 add_size 200000 add_align 200000
> > pci 0000:00:03.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
> > pci 0000:00:03.0: PCI bridge to [bus 02]
> > pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xe03fffff]
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at drivers/pci/setup-bus.c:2373 pci_assign_unass=
igned_root_bus_resources+0x1bc/0x234
> >=20
> > Check resource flags of 'pref' and only size the prefetchable window if
> > the resource has the IORESOURCE_PREFETCH flag.
> >=20
> > Fixes: ae88d0b9c57f ("PCI: Use pbus_select_window_for_type() during mem=
 window sizing")
> > Link: https://lore.kernel.org/linux-pci/51e8cf1c62b8318882257d6b5a9de7f=
daaecc343.camel@gmail.com/
> > Reported-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Since ae88d0b9c57f appeared in v6.18-rc1, this looks like v6.18
> material, right?
>
> Applied to pci/for-linus for v6.18 on that assumption, thanks!

Yes, it's for-linus material.

--=20
 i.

> >  drivers/pci/setup-bus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 362ad108794d..7cb6071cff7a 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1604,7 +1604,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, =
struct list_head *realloc_head)
> >  =09=09pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
> >  =09=09=09     additional_io_size, realloc_head);
> > =20
> > -=09=09if (pref) {
> > +=09=09if (pref && (pref->flags & IORESOURCE_PREFETCH)) {
> >  =09=09=09pbus_size_mem(bus,
> >  =09=09=09=09      IORESOURCE_MEM | IORESOURCE_PREFETCH |
> >  =09=09=09=09      (pref->flags & IORESOURCE_MEM_64),
> >=20
> > base-commit: 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
> > --=20
> > 2.39.5
> >=20
>=20
--8323328-798074588-1761606943=:982--

