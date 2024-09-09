Return-Path: <linux-pci+bounces-12945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7646F97138C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C4D284D4E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A21B4C48;
	Mon,  9 Sep 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1P41AHB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6718B1B4C39;
	Mon,  9 Sep 2024 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874094; cv=none; b=Y/zI+YpSg5hFFNPGlKFyZOjypEa+B4ByfwNFvux66QLSaOkS4iNrbPY5QPw5zMErhvrXncFS5ZVZv9RK9ncm0XVwqROO9tBh9Eq5GzhGd7O92Qv3BRrhsPRh9N8s+6dkxjaWc26J+wNThdn5yzaKltGYf3Hzrh6x2kDLeARU9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874094; c=relaxed/simple;
	bh=5/vlMbOv5Gk5+EMX5qaHDfYzM7Cjef4SdKHB+HygAh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hn1iwNX/Q5ngp57L0zVxEvu8VbYQK5tsrJp6ekQ04FmcSD6zLxy1t9KKj7aOu+/4WNi+6Armql6tD9Al4RmPy9YYP1bUaiWsZcUY49Y68486A/l61ANtdQYJPZo61gRKeQVh5Ls5RsIgqsE0JBBjpGA6t8wolWKJI3n2dYsXoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1P41AHB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725874092; x=1757410092;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5/vlMbOv5Gk5+EMX5qaHDfYzM7Cjef4SdKHB+HygAh0=;
  b=R1P41AHByMFUquj/YTg3qfeRv/O3d7p5tmZ02DiNa/Qs4w8KyzJeOQLX
   WhhLxqTSP82dkNcnxXgdS4pjHRCEXyspcaq97RunB5EJt8iILaEOY1fWt
   jOvibDsns525dKCfiYBwYdY5VwvH8YWCCUwDlvDO8YU7x8kkUfR9DIZhc
   r01CROotej7zQd8SexJiPb4Hv+XPkz1gvcQbseS6sxINTmOjnXdvGsR3v
   nv3HN1HBHuG2QVWT9Yo28BaCLtb2swzBlmp8BC7CQu+Q85Jc3nx0WtcP2
   WvrMjmSD43m+WXCh2SzMcj1p64qVDWv2ZlxmT8+hb3OUvYaBbwm4JZr7h
   w==;
X-CSE-ConnectionGUID: bhhSMHL9QXW1Zi4SbtO8VA==
X-CSE-MsgGUID: X6xX6uWuTHutk4nJ1TghUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24109378"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24109378"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:28:11 -0700
X-CSE-ConnectionGUID: H8Opibg1REiUl+ZWODO8GA==
X-CSE-MsgGUID: HTJ8Mum9REisrNW8Gq9d1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="71190334"
Received: from unknown (HELO localhost) ([10.217.182.6])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:28:07 -0700
Date: Mon, 9 Sep 2024 11:28:02 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-leds@vger.kernel.org, Lukas Wunner
 <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>, Ilpo =?ISO-8859-1?Q?J?=
 =?ISO-8859-1?Q?=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Stuart Hayes
 <stuart.w.hayes@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Keith Busch
 <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>, Pavel Machek
 <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 1/3] leds: Init leds class earlier
Message-ID: <20240909112802.00001353@linux.intel.com>
In-Reply-To: <20240909090340.GA6556@google.com>
References: <20240904104848.23480-1-mariusz.tkaczyk@linux.intel.com>
	<20240904104848.23480-2-mariusz.tkaczyk@linux.intel.com>
	<20240909090340.GA6556@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Sep 2024 10:03:40 +0100
Lee Jones <lee@kernel.org> wrote:

> On Wed, 04 Sep 2024, Mariusz Tkaczyk wrote:
>=20
> > NPEM driver will require leds class, there is an init-order conflict.
> > Make sure that LEDs initialization happens first and add comment.
> >=20
> > Suggested-by: Dan Williams <dan.j.williams@intel.com> =20
>=20
> Do you have a link to this discussion?

https://lore.kernel.org/linux-pci/2024061429-handiness-waggle-d87a@gregkh/

I discussed this with Lukas and Dan offline and as a result I updated Makef=
ile
instead initcall change.

>=20
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> > ---
> >  drivers/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index fe9ceb0d2288..45d1c3e630f7 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -17,6 +17,9 @@ obj-$(CONFIG_PINCTRL)		+=3D pinctrl/
> >  obj-$(CONFIG_GPIOLIB)		+=3D gpio/
> >  obj-y				+=3D pwm/
> > =20
> > +# LEDs must come before PCI, it is needed by NPEM driver =20
>=20
> This seems very fragile.
>=20
> Isn't there a better way to describe the dependency in Kconfig etc?

I don't know if it is better. What I know is (according to Greg) that
maintainers are aware of possible ordering issues and not described depende=
ncies
so they are not likely to allow changing it.

Mariusz

