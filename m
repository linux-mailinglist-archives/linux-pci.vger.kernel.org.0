Return-Path: <linux-pci+bounces-41238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2671C5D2D2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 13:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8303F4209D7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824ED22172C;
	Fri, 14 Nov 2025 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="az1xF04J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8791C3BE0
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763124544; cv=none; b=d2nJVSiKZvE6dxDA6Z547NYMUF/lCWgaI1drO1htPHINYf/mYg+yGiFncqm8QbB+TvIxi6lDQz5oTIJqZUe68iQr5uAJob4pjFtfjkAVzRW1hfJtuVeas59ulit4RQ7pxsEgJzfdWY6yBwFRMq73zaS68h4l5uHwZy4kxHbH404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763124544; c=relaxed/simple;
	bh=Vs1j3k+egiqigYTw8Bu/0q6YTfCwbX01X7FAVLFuegQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EX6jra/tgR0VQG9S7ByKFJJA0pquY1fOxEXpBhXopdUU1hCH+xhBnYJQySNGhaoU2GSwXfPs1/wYqIjDxG/NDj4iwDdVO3L5M0tBHcwe1eIJO526bF5JpbGEWUB2SY9JZd82ZWUDSqk6ekvco0yx66FyTJbCuGo1RweCNLUsrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=az1xF04J; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763124542; x=1794660542;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Vs1j3k+egiqigYTw8Bu/0q6YTfCwbX01X7FAVLFuegQ=;
  b=az1xF04JkPFUQN9wzHn0L40lBXzwLzwlvSTrglLM5DYUqMUpURrpegS1
   h1xug+Sdq71gA6MPbj+bt9JEbBzrRwwPJpNGTdYZQOy7XOw+5MsBJhEZ/
   6/Ifuq6rJ7lNnIJFMM4t6EGGtbZYJIZ3A5bqAWhMmGy2nj/DaGVvvoXKD
   vdCPfwVEuW6H+kpkk+TNLDNKUSHuBVPaV2+MGIAts0FjuhREVD0AHHA5Q
   lGaxr14Ivok5WAOwkHMwnLts+KzKI1qWORlNLLmNZKK1RotuUG7e0P3Ph
   l7Z9L1iH9Q6A1TzR7Qn1P82pBn/kgrubKAdDLqdUTWtVNTJ4qVmIzBfAQ
   A==;
X-CSE-ConnectionGUID: 0TZOoCWrS5ufE05jbd5uFQ==
X-CSE-MsgGUID: qsFi2w0iRL6yvvYNb9wSZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65120319"
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="65120319"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 04:48:55 -0800
X-CSE-ConnectionGUID: U6d+MCYmTIq1xaNsEtxY+Q==
X-CSE-MsgGUID: KpimQk4BTG+luBVtzfZkPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="189616838"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.31])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 04:48:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Nov 2025 14:48:46 +0200 (EET)
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: Simon Richter <Simon.Richter@hogyros.de>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
    Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@gmail.com>, 
    dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
    intel-xe@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, 
    Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
    linux-pci@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
    Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>
Subject: Re: [PATCH v2 00/11] PCI: BAR resizing fix/rework
In-Reply-To: <87jyzsq0nr.fsf@draig.linaro.org>
Message-ID: <7321c165-e38b-6016-54b0-48fcdfdaa199@linux.intel.com>
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com> <87jyzsq0nr.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-860166094-1763122538=:1008"
Content-ID: <8d7e8208-1885-0d8b-a6cf-f1895a519fae@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-860166094-1763122538=:1008
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <01e8aae0-c24c-7924-0748-50421fa6d7ac@linux.intel.com>

On Fri, 14 Nov 2025, Alex Benn=E9e wrote:

> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> writes:
>=20
> > Hi all,
> >
> > Thanks to issue reports from Simon Richter and Alex Benn=E9e, I
> > discovered BAR resize rollback can corrupt the resource tree. As fixing
> > corruption requires avoiding overlapping resource assignments, the
> > correct fix can unfortunately results in worse user experience, what
> > appeared to be "working" previously might no longer do so. Thus, I had
> > to do a larger rework to pci_resize_resource() in order to properly
> > restore resource states as it was prior to BAR resize.
> <snip>
> >
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
>=20
> Ahh I have applied to 6.18-rc5 with minor conflicts and can verify that
> on my AVA the AMD GPU shows up again and I can run inference jobs
> against it. So for that case:
>=20
> Tested-by: Alex Benn=E9e <alex.bennee@linaro.org>

Thanks for testing! (And saving me the effort of backporting to 6.17 :-))

I'd be interested to see the dmesg with this series applied just to check=
=20
there isn't anything else I should still look at (even if it now appears=20
to work).

You seemed to have only a few io resource assignment failures to occur=20
during BAR resize which might be the reason the kernel thought rollback=20
is necessary (so AFAICT, the rollback likely was entirely unnecessary as=20
the mem resources did assign successfully).

I made the resize to ignore unrelated (reoccuring) io resource failures in=
=20
the commit 31af09b3eaf3 ("PCI: Fix failure detection during resource=20
resize"), but that might not have been backported to 6.15 you took the log=
=20
from (in the initial report). So kernel might not even do rollback at all=
=20
with 6.18-rc5.

--=20
 i.
--8323328-860166094-1763122538=:1008--

