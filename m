Return-Path: <linux-pci+bounces-29400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A72AD4C79
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 09:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA143A8231
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E804B2253B5;
	Wed, 11 Jun 2025 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOaFM3ai"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1D21B8EC;
	Wed, 11 Jun 2025 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749626564; cv=none; b=BZrOVcOGXgB86G5sxz4zWnhDdsVCZkAlw/UU6hm2QJ/2i7RUbdFPQdFnSKAVCssAZ6a9/5vY/CUschToHUCHkS+NcDnRhxqF1BJqsDJR3fd7GHigzlAucDwbHXijnec/lsShz7jTr0MjJVxQXm4yvWf5srEpHm9qiIoaJaEB9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749626564; c=relaxed/simple;
	bh=ECQdEF/hlN++AB53DFuBDy9A9Lr5rxVtAjzxgJo3pqY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IlLUUUP80n7FqNG2/o6p5VqWxt077dN6Ft/mEPZL5oGVV24CQy+Pc/W0SH4CJbKsTiJNPVEAKuiKAYMEDvT6nkCougSyaLpFXonpxyQa0NxF2qnsCCcc7xUQKiL3MKUuhmrbxcxKQMO3IXOpHDQNPgaSGIfsJ7sApxS9IHpctQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOaFM3ai; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749626564; x=1781162564;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ECQdEF/hlN++AB53DFuBDy9A9Lr5rxVtAjzxgJo3pqY=;
  b=DOaFM3aiEtPZI2XHY90PRuZtiAYCdR0kLIpaudBE/qt3UCkoksUQ+fKa
   NqzI5c8c78KfcN/GpVYUdt5SGk8/g7ESH1yeYTr8UWvzXAWyv+F8wDNvh
   Ysl4lmu0M2UqRDohcslXFZJymUdMCoNtkCw6wiPHK9xvvJy7xWbNHRzGp
   9aEngQQmHnGu/pmAvujZRUa4h3JaC5ohXlOtTCNri8ZNvKhqNlIQdDYm0
   2K2qxPII3DjlgOxnssgyJKGmpYvgDMWfQP1GH/P8dc69cN03+9T0AOzmm
   DSwDnc7Dr9kkIvSpy/p1O3PqdndDswaswDv2TJIlWjTbwRjL4t+F2yYOo
   w==;
X-CSE-ConnectionGUID: LgbjJypLSOmb8GTK6HxJmA==
X-CSE-MsgGUID: EcXgswJWQdKboWuiqH6WKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="55562558"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="55562558"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 00:22:43 -0700
X-CSE-ConnectionGUID: WiPnG0SZQ8e/Im6ttCX92A==
X-CSE-MsgGUID: 6jKYhHsVQyq29ffUu4J4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147652666"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 00:22:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 10:22:35 +0300 (EEST)
To: Jakub Kicinski <kuba@kernel.org>
cc: linux-pci@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxgb3: Replace PCI related literals with defines &
 correct variable
In-Reply-To: <20250610135338.580aa25b@kernel.org>
Message-ID: <a24d9048-d296-9bd5-aa65-4e630dc34d51@linux.intel.com>
References: <20250610103205.6750-1-ilpo.jarvinen@linux.intel.com> <20250610135338.580aa25b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1062828760-1749626555=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1062828760-1749626555=:957
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 10 Jun 2025, Jakub Kicinski wrote:
> On Tue, 10 Jun 2025 13:32:03 +0300 Ilpo J=C3=A4rvinen wrote:
> > Replace literals 0, 2, 0x1425 with PCI_VENDOR_ID, PCI_DEVICE_ID,
> > PCI_VENDOR_ID_CHELSIO, respectively. Rename devid variable to vendor_id
> > to remove confusion.
>=20
> This series is missing a cover letter. An explanation of why you're
> touching this very very old driver is in order, and please comment
> on whether you can test this on real HW, because we don't like

No, I don't have the HW available.

> refactoring of very old code:
>=20
> Quoting documentation:
>=20
>   Clean-up patches
>   ~~~~~~~~~~~~~~~~
>  =20
>   Netdev discourages patches which perform simple clean-ups, which are no=
t in
>   the context of other work. For example:
>  =20
>   * Addressing ``checkpatch.pl`` warnings
>   * Addressing :ref:`Local variable ordering<rcs>` issues
>   * Conversions to device-managed APIs (``devm_`` helpers)
>  =20
>   This is because it is felt that the churn that such changes produce com=
es
>   at a greater cost than the value of such clean-ups.
>  =20
>   Conversely, spelling and grammar fixes are not discouraged.
>  =20
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#=
clean-up-patches

Fine, I don't _need_ to get these accepted. I'll keep this in mind in
future.

It probably came up during some other work when I had to look through use=
=20
of all PCI accessor functions and understand what the callers are trying=20
to do. When I took a look at the C file, I ended up noticing other things=
=20
too.

As these are/were not direct requirement for the actual accessor work, I=20
tend to send such series separately to avoid complicating review of one or=
=20
the other, feature series tend to be complicated enough even without the=20
cleanup patches.

It seems that in the unsent state, these patches predated adding that=20
guidance.

--=20
 i.

--8323328-1062828760-1749626555=:957--

