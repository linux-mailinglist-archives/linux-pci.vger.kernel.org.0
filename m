Return-Path: <linux-pci+bounces-34472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9D1B2FEAE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD715C23C7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536532F6199;
	Thu, 21 Aug 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCLeEp0b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866D292910;
	Thu, 21 Aug 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789862; cv=none; b=HbGcKkMlMnH3OwyRNZHilPIyMFpPxo3gj4v+2eKr2gEehmiIAk78SKSm4pJzFCICUHwh/95u/Vx/cBSZKp971heFRz1t7ok1ONhfuBp2gHoR8jejFlWYi1GdqT96qrQOkxANIrqB+TvunxZsTq0V2gLoh5rh0tDxg/Sdrb4LW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789862; c=relaxed/simple;
	bh=TbPhT0fJ9UVY2GpBFgSYAMdfwE7Jlo8AQrRMPKTTskE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hsuHV/xStsmpsS9U3hbgKOLAOswYdN8o07MOFFJ013hUTV63+EgiwJOVcOq6GfX7DVKlqeVfluBiGKqV3oq/7YbyyjyEGlEITbkwzt++5xvV7j1LuKYLNLB1y8E7OPyiqsFMf7tQS3iG/5jl7QdjU1FMYUzrsYy9ZT3gg/KDWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCLeEp0b; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755789861; x=1787325861;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TbPhT0fJ9UVY2GpBFgSYAMdfwE7Jlo8AQrRMPKTTskE=;
  b=bCLeEp0b6IPKGYhx1ubdmDRlnp4Z49njn0Z/LZofhmuoosz5X9IUdpbL
   NOt5GMdlH/ZYOhKD8snDvDppOCnLY6RDLbPCxJdzgxkMPmsG01vEP4YNK
   JXLsLFARnhyvnYstAh26K6e4IK23y3+OQYtISDY7wL2NaPF6hPdbtugQV
   RwvsJPGROlB5RpylSUC5edquCVCWBIADK6NFq82dPn0tnQ8b0fIm4QYlX
   v8ICdE3n1OPg7EYIm8JMGpoCH5QNZNG6Ah9ioH3j/398hW5pa/z2lg6lU
   cDlSJe+Y9ryzlzCvmOiy7ypnCLRrK8ydy40g0XrzN3BWVsmK8HmM+2cVl
   g==;
X-CSE-ConnectionGUID: P+nR0csaQw66tb1whkidBQ==
X-CSE-MsgGUID: 175Y5JuHQM+/RdYGFJUftw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61914411"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61914411"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:24:21 -0700
X-CSE-ConnectionGUID: vpOrtkQEQoOVTERqkbMzcA==
X-CSE-MsgGUID: 7tf6eHjQQ7KIXWNVlkyxMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168803584"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:24:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 21 Aug 2025 18:24:12 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Tudor Ambarus <tudor.ambarus@linaro.org>, Rio <rio@r26.me>, 
    D Scott Phillips <scott@os.amperecomputing.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Relaxed tail alignment should never increase
 min_align
In-Reply-To: <3ded51ff-6265-da0a-d8a1-ecf788e99d31@linux.intel.com>
Message-ID: <b3018c24-7626-d406-2487-67ea32bd2712@linux.intel.com>
References: <20250821151035.GA674429@bhelgaas> <3ded51ff-6265-da0a-d8a1-ecf788e99d31@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1727549204-1755789852=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1727549204-1755789852=:933
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Aug 2025, Ilpo J=C3=A4rvinen wrote:

> On Thu, 21 Aug 2025, Bjorn Helgaas wrote:
>=20
> > On Mon, Jun 30, 2025 at 05:26:39PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > When using relaxed tail alignment for the bridge window,
> > > pbus_size_mem() also tries to minimize min_align, which can under
> > > certain scenarios end up increasing min_align from that found by
> > > calculate_mem_align().
> > >=20
> > > Ensure min_align is not increased by the relaxed tail alignment.
> > >=20
> > > Eventually, it would be better to add calculate_relaxed_head_align()
> > > similar to calculate_mem_align() which finds out what alignment can b=
e
> > > used for the head without introducing any gaps into the bridge window
> > > to give flexibility on head address too. But that looks relatively
> > > complex algorithm so it requires much more testing than fixing the
> > > immediate problem causing a regression.
> > >=20
> > > Fixes: 67f9085596ee ("PCI: Allow relaxed bridge window tail sizing fo=
r optional resources")
> > > Reported-by: Rio <rio@r26.me>
> >=20
> > Was there a regression report URL we could include here?
>=20
> There's the Lore thread only:
>=20
> https://lore.kernel.org/all/o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NO=
zOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=3D@r26.me/
>=20
> (It's so far back that if there was something else, I've forgotten them=
=20
> by now but looking at the exchanges in the thread, it doesn't look like=
=20
> bugzilla entry or so made out of it.)

Making it "official" tag in case that's easier for you to handle=20
automatically...

Link: https://lore.kernel.org/all/o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8R=
Q3NOzOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=3D@r26.m=
e/


--=20
 i.

--8323328-1727549204-1755789852=:933--

