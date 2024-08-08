Return-Path: <linux-pci+bounces-11477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A506994B962
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 10:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0F72829EB
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 08:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95DB189B9A;
	Thu,  8 Aug 2024 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afIirFEc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE414658D;
	Thu,  8 Aug 2024 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107312; cv=none; b=omUrUSlW14NI2yZG+oKYW/LuOUglHRmdYnnbwUtwZVWgxzHYvd0tfSLUi3gAzmqEIa3kTaq3zNtQ9dxaKoIC8PGl0/ZXNkKZ+xL4sDT/g3myGvg+r91g0Rm/kOAeTm333h87YH+Fjn8ZK7gmi0AvCxKBRu2uAEP/rsa5eBFqaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107312; c=relaxed/simple;
	bh=g6FtHJgHkAm3PxT6vF/il9Y2fSwq6sL3vWGAaharZLA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eYJxCc9WcylmEiT+7j6F5LoKEnU6B3ydArDwupssqTSVwKGqOhdxjgUpT0mUklPGMRQVJ9FiHzz8t1w2eXdU7Pdivy5bYP5CrZ1j1XUrfVsGRB0kCVPEySveGL0QVt73S7B9gW8UYNlWL2mN98Y2aHZmM+PS4LfbsrUnWstkFmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afIirFEc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723107311; x=1754643311;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=g6FtHJgHkAm3PxT6vF/il9Y2fSwq6sL3vWGAaharZLA=;
  b=afIirFEctYFC4crLdb/5iAT8KFuNN23Qao4oI86Z4vkMtFZpLjkaWfD6
   6x2vo0cemwiH9JGdyb0nzYMzor/Yo/ufbqdE9rzymm/ttVge6ya+3PTW3
   YzTrZTpmZgaAQk5Dt+72KsVWQvZAw9D4mcrG67e4Trlhm9CryNnf67Im6
   2cZV6x4+EZzp1RRHzmw/meawPN2Zh72k//Sa5ieLsJiOv11y0VGyAIrwh
   Z+HncHQnQaqO6l/ksXbxqrcXXD0DzFousLtTjqy22wgdlFnNehaI55kqo
   2I9iEQt7m2aPBnvAsoFwT7i1H4PgEBB+TQJpbandLrnZ2yUiQjEsg+FUL
   A==;
X-CSE-ConnectionGUID: OGLC+Bh0TJCjAxSih/IPMw==
X-CSE-MsgGUID: nHmeRqrjRC2/WZ2SqumcDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21078460"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21078460"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:55:10 -0700
X-CSE-ConnectionGUID: uTQBL5jHSVq5H/8JAJO4aA==
X-CSE-MsgGUID: 8Q8gZlhLTkyKA0PL/xJMmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="88058615"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.108.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:55:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Aug 2024 11:55:02 +0300 (EEST)
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Philipp Stanner <pstanner@redhat.com>, 
    x86@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] x86/PCI: Improve code readability
In-Reply-To: <20240807151723.613742-2-stewart.hildebrand@amd.com>
Message-ID: <971d8fda-5317-7481-d435-35bf1faae115@linux.intel.com>
References: <20240807151723.613742-1-stewart.hildebrand@amd.com> <20240807151723.613742-2-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1864664292-1723107302=:1044"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1864664292-1723107302=:1044
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 7 Aug 2024, Stewart Hildebrand wrote:

> The indentation in pcibios_allocate_dev_resources() is unusually deep.
> Improve that by moving some of its code to a new function,
> alloc_resource().
>=20
> Take the opportunity to remove redundant information from dev_dbg().
>=20
> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
> ---
> v2->v3:
> * new subject (was: "x86/PCI: Move some logic to new function")
> * reword commit message (thanks Philipp)
>=20
> v1->v2:
> * new patch
> ---
>  arch/x86/pci/i386.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> index f2f4a5d50b27..3abd55902dbc 100644
> --- a/arch/x86/pci/i386.c
> +++ b/arch/x86/pci/i386.c
> @@ -246,6 +246,25 @@ struct pci_check_idx_range {
>  =09int end;
>  };
> =20
> +static void alloc_resource(struct pci_dev *dev, int idx, int pass)
> +{
> +=09struct resource *r =3D &dev->resource[idx];
> +
> +=09dev_dbg(&dev->dev, "BAR %d: reserving %pr (p=3D%d)\n", idx, r, pass);
> +
> +=09if (pci_claim_resource(dev, idx) < 0) {
> +=09=09if (r->flags & IORESOURCE_PCI_FIXED) {
> +=09=09=09dev_info(&dev->dev, "BAR %d %pR is immovable\n",
> +=09=09=09=09 idx, r);
> +=09=09} else {
> +=09=09=09/* We'll assign a new address later */
> +=09=09=09pcibios_save_fw_addr(dev, idx, r->start);
> +=09=09=09r->end -=3D r->start;
> +=09=09=09r->start =3D 0;
> +=09=09}
> +=09}
> +}
> +
>  static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass=
)
>  {
>  =09int idx, disabled, i;
> @@ -271,23 +290,8 @@ static void pcibios_allocate_dev_resources(struct pc=
i_dev *dev, int pass)
>  =09=09=09=09disabled =3D !(command & PCI_COMMAND_IO);
>  =09=09=09else
>  =09=09=09=09disabled =3D !(command & PCI_COMMAND_MEMORY);
> -=09=09=09if (pass =3D=3D disabled) {
> -=09=09=09=09dev_dbg(&dev->dev,
> -=09=09=09=09=09"BAR %d: reserving %pr (d=3D%d, p=3D%d)\n",
> -=09=09=09=09=09idx, r, disabled, pass);
> -=09=09=09=09if (pci_claim_resource(dev, idx) < 0) {
> -=09=09=09=09=09if (r->flags & IORESOURCE_PCI_FIXED) {
> -=09=09=09=09=09=09dev_info(&dev->dev, "BAR %d %pR is immovable\n",
> -=09=09=09=09=09=09=09 idx, r);
> -=09=09=09=09=09} else {
> -=09=09=09=09=09=09/* We'll assign a new address later */
> -=09=09=09=09=09=09pcibios_save_fw_addr(dev,
> -=09=09=09=09=09=09=09=09idx, r->start);
> -=09=09=09=09=09=09r->end -=3D r->start;
> -=09=09=09=09=09=09r->start =3D 0;
> -=09=09=09=09=09}
> -=09=09=09=09}
> -=09=09=09}
> +=09=09=09if (pass =3D=3D disabled)
> +=09=09=09=09alloc_resource(dev, idx, pass);
>  =09=09}
>  =09if (!pass) {
>  =09=09r =3D &dev->resource[PCI_ROM_RESOURCE];
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1864664292-1723107302=:1044--

