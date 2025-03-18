Return-Path: <linux-pci+bounces-24040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A22CA672EB
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 12:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5FE3BBBF8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF96520AF7E;
	Tue, 18 Mar 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EILedG9Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43809202C2B;
	Tue, 18 Mar 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298228; cv=none; b=MEvzK8Yo3e3VyQCapieAy8TEVfKjRQJzSHn/jzEWwPhhwpK5QKod7i/JQRrrkMHG25NcSD9MWnfzVau5KRGzHSYlyj8n642b7rObU7AW75d0H4tOaxAoOyi29ysbW3v5tHwYS3Hjhb+nbR4Rc7hJa+D3zceMoH9RynaIQkzj3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298228; c=relaxed/simple;
	bh=9pgO6Nq9FufpoLVG0jaa9Kh3C8hqzKLmapfMYEG0PWk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q6gYdIzJCR27dK8OVRGJ33CwxS1gRRZlmxW510d4TU/gsgQt0hOifcpIb5olyLA77eivemUwVqjlXgfUvSP7fIecJYaVCaHsUFidk+Waqi2NKgEQdvkrbnk3YTqreFLJJ2IcX61Z6/BNeZ0mIOIdyDvYp/Ib6hkSueocVJb3YQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EILedG9Q; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742298223; x=1773834223;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9pgO6Nq9FufpoLVG0jaa9Kh3C8hqzKLmapfMYEG0PWk=;
  b=EILedG9Qw7AL4VGmSUXH7gJz4ymNcF/gIYr4rrYjjMYdGJfLy8QCweOq
   jupb+JH8qTHr3G/HjYTfmVEx0tGhIwVGay/1OOPNlnQ/FDaWvU36IENoS
   wSHya/4g9JPG0QHpO+gKJ7jqhy6K3b60/irbksz8VgJbGJqDHQqW49YjQ
   QI9zJMv/EbJ3YDzlS/FqDUQi7ESWwGJex+wKOtal2jjoX2/lfzPfJGLC+
   nGE9Akadn/8RP/8EPJToMsSS4nCsHznrFngCv2X36ckiBqbbKVyar1WpH
   fQBhMtHwZAhj/cMKnGFlLep80SwFGG08NhalHgo/WmWfbdPdjm4411C0H
   g==;
X-CSE-ConnectionGUID: 0I2jg6teR2akw/62ZWQp/g==
X-CSE-MsgGUID: ym44pVlTTe6RVGj9z/fKOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43605631"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43605631"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 04:43:02 -0700
X-CSE-ConnectionGUID: xcxCkDWxQO6apgu0MWTcRg==
X-CSE-MsgGUID: 5irvdhhLQ8mFxi7vH/dqZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="126443523"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.171])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 04:43:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 18 Mar 2025 13:42:57 +0200 (EET)
To: Alex Williamson <alex.williamson@redhat.com>, 
    Jakub Kicinski <kuba@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>
cc: =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
In-Reply-To: <20250317163859.671a618f.alex.williamson@redhat.com>
Message-ID: <ea24cc36-36c7-1b28-f9ba-78f7161430ca@linux.intel.com>
References: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com> <20250314085649.4aefc1b5.alex.williamson@redhat.com> <kgoycgt2rmf3cdlqdotkhuov7fkqfk2zf7dbysgwvuipsezxb4@dokqn7xrsdvz> <20250317163859.671a618f.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1442975368-1742297604=:964"
Content-ID: <89e45673-8795-5956-7f7d-22b5b4ead0dc@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1442975368-1742297604=:964
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e38a54da-a068-0a6a-b77c-f2699afd2024@linux.intel.com>

+ Jakub
+ Alexander

On Mon, 17 Mar 2025, Alex Williamson wrote:
> On Mon, 17 Mar 2025 19:18:03 +0100
> Micha=B3 Winiarski <michal.winiarski@intel.com> wrote:
> > On Fri, Mar 14, 2025 at 08:56:49AM -0600, Alex Williamson wrote:
> > > On Fri,  7 Mar 2025 16:03:49 +0200
> > > Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > >  =20
> > > > __resource_resize_store() attempts to release all resources of the
> > > > device before attempting the resize. The loop, however, only covers
> > > > standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that ar=
e
> > > > assigned, pci_reassign_bridge_resources() finds the bridge window s=
till
> > > > has some assigned child resources and returns -NOENT which makes
> > > > pci_resize_resource() to detect an error and abort the resize.
> > > >=20
> > > > Change the release loop to cover all resources up to VF BARs which
> > > > allows the resize operation to release the bridge windows and attem=
pt
> > > > to assigned them again with the different size.
> > > >=20
> > > > As __resource_resize_store() checks first that no driver is bound t=
o
> > > > the PCI device before resizing is allowed, SR-IOV cannot be enabled
> > > > during resize so it is safe to release also the IOV resources. =20
> > >=20
> > > Is this true?  pci-pf-stub doesn't teardown SR-IOV on release, which =
I
> > > understand is done intentionally.  Thanks, =20

Thanks for reviewing. I'm sorry I just took Micha=B3's word on this for=20
granted so I didn't check it myself.

I could amend __resource_resize_store() to return -EBUSY if SR-IOV is=20
there despite no driver being present, but lets hear if Alexander or Jakub=
=20
has some input on this.

> > Is that really intentional?
> > PCI warns when that scenario occurs:
> > https://elixir.bootlin.com/linux/v6.13.7/source/drivers/pci/iov.c#L936
>=20
> Yep, it warns.  It doesn't prevent it from happening though.
>=20
> > I thought that the usecase is binding pci-pf-stub, creating VFs, and
> > letting the driver be.
> > But unbinding after creating VFs? What's the goal of that?
> > Perhaps we're just missing .remove() in pci-pf-stub?
>=20
> I guess I don't actually know that leaving SR-IOV enabled was
> intentional, maybe it was an oversight.  The original commit only
> mentions the case of a device that requires nothing but this shim as
> the PF driver.  A pci_warn() isn't much disincentive, the system might
> already have taints.  If it's something that we really want to show as
> broken, it'd probably need to be a WARN_ON.=20

Added Alexander and Jakub, perhaps they remember something or if there are=
=20
caveats going either way.

--=20
 i.
--8323328-1442975368-1742297604=:964--

