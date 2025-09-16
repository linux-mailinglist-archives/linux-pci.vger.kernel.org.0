Return-Path: <linux-pci+bounces-36236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EAAB59020
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 10:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CC61B223CC
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 08:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE072BE03B;
	Tue, 16 Sep 2025 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lx8hGWJS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1628313A;
	Tue, 16 Sep 2025 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010353; cv=none; b=jvy8biui42RZ4thENgorT4cRxOypL8jMkL7Jqmz734os40yjNV07TuZpvqEPjKvuVEBJ2TJ7tflLTH/3AHdygaCiZPHys9gBcsJsVmbwNVU6wa2Mo++hPDlJKSDp3EYtjECh4Mp2G1ZK4SXQH9mI3W1dXZp8+FTbQr6UDOUcL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010353; c=relaxed/simple;
	bh=/fOTPnIYRzNwyZiVhCec2Qefpdd4a+D5flBWydA6AZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQ7ZLBbxlhoW+Q9F6Ukf3mVkBazF3lhKT4X4QgDJ/vVnj0IgIufY/cE1xv3UM9o9mcScq1cA6shnFhoYmefy+24yyCna+DdHv7JEvxXjESEoY0SDj3Y22uUE7u06b2ASQuJd9Ux4B6aBWo/ZL+I4J8biuN4ftib1LGXEM5pQjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lx8hGWJS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758010352; x=1789546352;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/fOTPnIYRzNwyZiVhCec2Qefpdd4a+D5flBWydA6AZE=;
  b=lx8hGWJSEdQTR9BNvogza54a3y3txZ2UBqpPVzTLCmq1vktDeK8klsDa
   XnL/Nmnf5CtoPTb6kylv4xLKzxqG3vC7k9oFcKL6h3WOQAJ6L8lEAb8wg
   d4dhE3zDV+kBdwPGcRcA1sJdTI4G+maEIwKMj1L6QLRwsMj6A/XEUbSyW
   D9AeFUjQWdCk4ATQtp1Wvzb+HSPlQVaHTzQoFxLOKw3aLq4MHvooTRp6g
   kPoEdv+IvloOD1ow2bvfY7t7WRIrg6B+D+n8lBYTPrhsF7MUV6mSt2e1G
   mkawVuYIO7YhP3kBaCwMINkm1LHcoguNxPkjEi011ARWQ3OTh+hExclWH
   Q==;
X-CSE-ConnectionGUID: IFrKrXtLQQuSM15l02Q+ew==
X-CSE-MsgGUID: mYCQ9+uwSh2AgO95WMzhEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60211639"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="60211639"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 01:12:31 -0700
X-CSE-ConnectionGUID: ZT4Lqgl3Qg2yWk79GVLDRA==
X-CSE-MsgGUID: j/vJU0B9RmavdKiDJ4Kqsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="175658518"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.81])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 01:12:24 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn
 Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Christian
 =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, =?utf-8?Q?Micha=C5=82?=
 Winiarski <michal.winiarski@intel.com>, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, David Airlie
 <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Simona Vetter <simona@ffwll.ch>, Tvrtko
 Ursulin <tursulin@ursulin.net>, ?UTF-8?q?Thomas=20Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Michael J . Ruhl" <mjruhl@habana.ai>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 06/11] drm/i915/gt: Use pci_rebar_size_supported()
In-Reply-To: <aMhzougLzpfw2wWw@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
 <20250915091358.9203-7-ilpo.jarvinen@linux.intel.com>
 <b918053f6ac7b4a27148a1cbf10eb8402572c6c9@intel.com>
 <ewypjj64siaswcfvfzgxihwrflb6k6pz2mrfuu4ursdldwnqlm@ignlhd73keck>
 <aMhzougLzpfw2wWw@intel.com>
Date: Tue, 16 Sep 2025 11:12:21 +0300
Message-ID: <58fb988207c4d5c5ba25338c1281189e12c009c3@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sep 2025, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
> On Mon, Sep 15, 2025 at 07:24:10PM +0200, Andi Shyti wrote:
>> Hi,
>>=20
>> On Mon, Sep 15, 2025 at 03:42:23PM +0300, Jani Nikula wrote:
>> > On Mon, 15 Sep 2025, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com=
> wrote:
>> > > PCI core provides pci_rebar_size_supported() that helps in checking =
if
>> > > a BAR Size is supported for the BAR or not. Use it in
>> > > i915_resize_lmem_bar() to simplify code.
>> > >
>> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>> > > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>> >=20
>> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>> >=20
>> > and
>> >=20
>> > Acked-by: Jani Nikula <jani.nikula@intel.com>
>>=20
>> Just for some random noise on commit log's bureaucracy: why do we
>> need both Ack and R-b? I think R-b covers Ack making it
>> redundant. Right?
>
> reviewed-by is a more formal attestation of the entries in the
> submitting-patches doc, saying that he carefully reviewed the work.
>
> acked by is to state that from the maintainer perspective of that file
> the file can be merged through any tree.
>
> in the drm trees nowdays our tooling is enforcing acked-by tag if
> the patch is touching domains outside that drm branch itself.
>
> if a committer tries to push a patch without ack from the maintainer
> of that domain it will be blocked.
>
> So I believe it is a good idea to keep a separation of the meaning.
> Carrying a technical review of the patch in question doesn't necessarily
> mean that you, as maintainer, is okay of getting that patch merged
> through other trees.

Yes, all of the above. I just wanted to be explicit to avoid the
follow-up questions "thanks for the review, but is it okay to merge via
pci" or "thanks for the ack, but does this need review also", and move
on from this whole thread. (Which is a nice cleanup, btw, thanks.)

BR,
Jani.

--=20
Jani Nikula, Intel

