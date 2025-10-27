Return-Path: <linux-pci+bounces-39457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB161C0FCDF
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 18:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1E33BD37F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCBB318131;
	Mon, 27 Oct 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMoqbr6O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488903191A8;
	Mon, 27 Oct 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587713; cv=none; b=i007xuXxPRV18RaIWi0r0w2KPLzxjPEFGYCiS9kyfIWQvfrZMh9yOhTdr8y9xCDrY2AGwq/uAIUVwWhIgZUU/5Fprxb1C5zD2kxWItw56KbpcMbkRUkITBQOUfKhH/TLwvDyQFO24wAuIUBxuFXYPUzXtSHF/DED3gWS+pnHCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587713; c=relaxed/simple;
	bh=ZaItOhZSphnIQu+yUj94PFShpAr5muKFCTY7ve8Z1Xw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pADcHLyZ3Fs4QI7sd17C0GridEHzGXj5mGA9LPYwAP0mUOkXkOGYDRtz97FQiXZGjOAmwPmeunJh3GTUV64AqhLFtfRdX5Adtyh6Iook/+4GbmBnKYBxXW/NA/XILeouX0OPdndZI5OLtzxh2EZLJQpKqZ78LyUoEca+ZXwGpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMoqbr6O; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761587712; x=1793123712;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZaItOhZSphnIQu+yUj94PFShpAr5muKFCTY7ve8Z1Xw=;
  b=LMoqbr6OVBffQQ8EdFfbL6C26OWOWKxiPl2Z+99SxTFI8MLEgXS5lUXi
   smpfJ/UXfu6a3Yq0mmNRbwFKLjgBmuFqSd3USS6CY2W+WqNlXsKyG63ZP
   V60U5ZYTRy+AJrRVJNJ4DqSphHo1ghdsZc06fvEnRXeFDAC8MQ3Ue1+Ez
   zwIZF/CJ1+1NB6LMDSlWdhElG9i9A6xMknAk2poVZyvoVA71+Mpsqumx+
   cxtgMpRxAa0hqwF6kqRcnDQEIYDEIuaZmJ14UQAsYyf5/PP+rwBHh+Eet
   RLB7r4UAE0Q8wHv0CQqmG5Un7C+44eyVtyfTzBgHEd+X7RWYlzmclxWah
   Q==;
X-CSE-ConnectionGUID: 938WK7CdSQSLTZc/F8GaeA==
X-CSE-MsgGUID: 1S+Dlb+zRN+d5d8qQ9Ze1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63378809"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="63378809"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 10:55:11 -0700
X-CSE-ConnectionGUID: 7vZFIvX0SQywQyFzvNHmRA==
X-CSE-MsgGUID: Ld1zGVsRQFK5UMS6LeRRdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="190319204"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.85])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 10:55:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 Oct 2025 19:55:05 +0200 (EET)
To: Klaus Kudielka <klaus.kudielka@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Do not size non-existing prefetchable window
In-Reply-To: <4419385c114b344ba5c1d5b0a817a322b37624cc.camel@gmail.com>
Message-ID: <5b6d7dfb-b2d2-a596-1f41-0428426a791f@linux.intel.com>
References: <20251027132423.8841-1-ilpo.jarvinen@linux.intel.com> <4419385c114b344ba5c1d5b0a817a322b37624cc.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1914371039-1761587705=:982"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1914371039-1761587705=:982
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 27 Oct 2025, Klaus Kudielka wrote:

> On Mon, 2025-10-27 at 15:24 +0200, Ilpo J=C3=A4rvinen wrote:
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
> > pci 0000:00:03.0:=C2=A0=C2=A0 bridge window [io=C2=A0 0x0000-0x0fff]
> > pci 0000:00:03.0:=C2=A0=C2=A0 bridge window [mem 0x00000000-0x000fffff]
> > pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02]=
 add_size 200000 add_align 200000
> > pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02]=
 add_size 200000 add_align 200000
> > pci 0000:00:03.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
> > pci 0000:00:03.0: PCI bridge to [bus 02]
> > pci 0000:00:03.0:=C2=A0=C2=A0 bridge window [mem 0xe0000000-0xe03fffff]
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at drivers/pci/setup-bus.c:2373 pci_assign_unass=
igned_root_bus_resources+0x1bc/0x234
>=20
> With this patch on top of v6.18-rc3, the boot log looks clean again:
>=20
> pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> pci 0000:00:03.0: PCI bridge to [bus 00]
> pci 0000:00:03.0:   bridge window [io  0x0000-0x0fff]
> pci 0000:00:03.0:   bridge window [mem 0x00000000-0x000fffff]
> pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
> pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02] a=
dd_size 200000 add_align 200000
> pci 0000:00:03.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
> pci 0000:00:03.0: PCI bridge to [bus 02]
> pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xe03fffff]
>=20
> (and no WARNING thereafter)
> Thanks a lot!
>=20
> Tested-by: Klaus Kudielka <klaus.kudielka@gmail.com>

Thanks for testing.

--=20
 i.

--8323328-1914371039-1761587705=:982--

