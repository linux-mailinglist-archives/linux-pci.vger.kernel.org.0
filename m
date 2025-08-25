Return-Path: <linux-pci+bounces-34659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4B6B33C52
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 12:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9613B701C
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282B2DA776;
	Mon, 25 Aug 2025 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mk1zAubp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01282DA77B;
	Mon, 25 Aug 2025 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116794; cv=none; b=FlA8DcwiYwgVNZqzJtwx+7CB5eGdlfzWBOJs4+1vdPgukszFM53YmUV+6h6pFHUPFgHsiUhD9cBQ3JB2o1jwr/o0E9BWxLF0RYH5qWQGciHFHiIPLJTWxjR3bTnHoKMK3ISUwVkV79Y6tz7KiPCAOviEwNCPRhXD1b5+HASksz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116794; c=relaxed/simple;
	bh=Tu1uu36c/e3+UcVG/3ecM7T8H0UQUtPbiTnqVH646a8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EgdeCfnjkFhJOQCkiygvek6lcfwA7FgahE03epQ7X2eK5CDjsvmEIOTGcJIfNxBdHl61OUXeCZ5fLImUIuGw0JGP+PqxNhLOPN/nanpPj1v4eUjnRk28I/ZMafgEs1klWwzt9RLZky+v1U52LYvja9N5BVSOf/xiPSZvmzesbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mk1zAubp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756116792; x=1787652792;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Tu1uu36c/e3+UcVG/3ecM7T8H0UQUtPbiTnqVH646a8=;
  b=mk1zAubpEWO5EWyUbve7QWMlYzD+7/UM9aSJ4vSqKSMf9hO0bftTg8x7
   FvY9ZHmPy7VR932lRSPXMlFcXhGrdZRyKSQMpJ60dSh13v2nRrVws7UBG
   q92eJ5vKRNfSqOnCACfuxiEhMuuVLKLjDGqe3Zh2Gpo+wqN3r435LC2bQ
   K3MbIs0Sr+JbQm3vBv4cNNEIuHqCSac5hSrjqB/Y8Q4CzLL/jez4zTrah
   16/GANGyVGMdwBvxKHeCvknKiIbJqtyEBz0+ihDMghwjuw1+Dsihsvcai
   7bMOdkYTC9nYfnPxpAUH+nT0eEJzB7cJ9I9EWTsRIZ24bdywuAcxzW4/x
   w==;
X-CSE-ConnectionGUID: o5soedtfSYqZUCITjttdpg==
X-CSE-MsgGUID: MlQUwrUpTqGIeL60ipuHdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="58425765"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58425765"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 03:13:12 -0700
X-CSE-ConnectionGUID: HDaId02FT0mPKk0hQdVJYA==
X-CSE-MsgGUID: ng4ZDQ2ERCaZt6xwLhsFsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169452136"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.85])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 03:13:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 25 Aug 2025 13:13:06 +0300 (EEST)
To: Markus Elfring <Markus.Elfring@web.de>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Reduce the scope for a variable in
 pci_bridge_release_resources()
In-Reply-To: <599e9acf-886b-4394-86bb-099e062c5b2c@web.de>
Message-ID: <f848ff97-9118-3e4a-d07c-c5009a4c310c@linux.intel.com>
References: <599e9acf-886b-4394-86bb-099e062c5b2c@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1219464466-1756113915=:966"
Content-ID: <2cd9c9ed-60b8-e458-00e3-f091fb2edbcb@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1219464466-1756113915=:966
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <aba0cc45-ecfd-5109-a163-4df15bef1487@linux.intel.com>

On Sat, 23 Aug 2025, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 23 Aug 2025 09:40:13 +0200
>=20
> * Move the definition for the local variable =E2=80=9Cold_flags=E2=80=9D
>   into an if branch.
> * Put the assignment for the local variable =E2=80=9Ctype=E2=80=9D on a s=
eparate line.
>=20
> The source code was transformed by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pci/setup-bus.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 119f97b96480..38bf4e673bd7 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1714,7 +1714,6 @@ static void pci_bridge_release_resources(struct pci=
_bus *bus,
>  {
>  =09struct pci_dev *dev =3D bus->self;
>  =09struct resource *r;
> -=09unsigned int old_flags;
>  =09struct resource *b_res;
>  =09int idx =3D 1;
> =20
> @@ -1751,7 +1750,9 @@ static void pci_bridge_release_resources(struct pci=
_bus *bus,
>  =09/* If there are children, release them all */
>  =09release_child_resources(r);
>  =09if (!release_resource(r)) {
> -=09=09type =3D old_flags =3D r->flags & PCI_RES_TYPE_MASK;
> +=09=09unsigned int old_flags =3D r->flags & PCI_RES_TYPE_MASK;
> +
> +=09=09type =3D old_flags;
>  =09=09pci_info(dev, "resource %d %pR released\n",
>  =09=09=09 PCI_BRIDGE_RESOURCES + idx, r);
>  =09=09/* Keep the old size */

My series is going to remove these variable altogether. A) One shouldn't=20
be messing with type (flags) at all which this code the tried to work=20
around by carrying the type information over the code that cleared it, and=
=20
B) there's a gross hack in how type is being handled. Both are solved by=20
my series.

Although, now that you posted this patch, I ended up realizing there's a=20
transient problem in my series, the assignment to type got removed too=20
early (should only be removed along with the type related hack, will be=20
fixed by v2 of my series).

--=20
 i.
--8323328-1219464466-1756113915=:966--

