Return-Path: <linux-pci+bounces-15473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A169B389F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34621F22EDB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 18:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4B71E766F;
	Mon, 28 Oct 2024 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCeteye/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C01E22EF;
	Mon, 28 Oct 2024 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138406; cv=none; b=bNh79OsjA/BaKnWoOByuOp6fFGQPlRzpGpLwH6ImY/mFEE/tdNaFS/6djw/ylF7udtCx8mvaA9yBctwVq0lLIcH4HACIs9RjzyTDX6Nls1DHvax/Pa6hk/UMGq3iwz4DgzjXeI9cdmXVvP/j35rTN4iOiSExDcBew0TBK7/Syuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138406; c=relaxed/simple;
	bh=+mrd7zgi7m7coIAfM4paFT/Ggz1fukaNTlSAj3Ha9OA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i4kdHowOFfB0ZAOXmkSiiE5MKhMQ549tJITN1rvMBml8hE6ZLZ0oAFE87tGWWaSQlI+zXbKvMVt3JipKT1vYc7ewJuCa5tUmeBAUGP7HSqutCBagXQUTptukKYO2Y7mDIj9NkfGFuj6svCwcACfdd204RPrYhXHo9Mjx7dvylCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCeteye/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730138405; x=1761674405;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+mrd7zgi7m7coIAfM4paFT/Ggz1fukaNTlSAj3Ha9OA=;
  b=MCeteye/V2qJnCjSBgpS4X5ER6SAbyg+AHPgo+SdlrUxsmR03DWRaPFn
   lYmtfG47vXwhHklC0lC6OWCd6o9Tucs7jNl6Z/0gKsjOlmiBfWjsRwX2e
   o7SeL5z7J199BbyZ6ZA9FqB2bWxkCxE7+dKZ1OlruqFAnSRJQ7cuECO7x
   nCfnHRxcx/MAAVzMspqZqCf5shmaJDXQ77nD/GhIWzwPgwPzDtYZmKzrx
   KSuvGF9JVmb0IxpVsmSUkQ31OSBRS0TeWid8B39//fP32U5WSq7UO7wLZ
   O+IGP5KI1sL5Wvp6fR90SFWFWfNNk6Vkxsm24kqAzlV/ld75ykFBeJLB4
   w==;
X-CSE-ConnectionGUID: wmrrC0kPToG4LzafQbUxuA==
X-CSE-MsgGUID: npAhcUAvQAK8qoB7DsiQiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29714727"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29714727"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:00:04 -0700
X-CSE-ConnectionGUID: LixNoEwERY+XuFlmRZis0g==
X-CSE-MsgGUID: gCW4ZiKMR5C+/geFuJIuhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="85642500"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.203])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:00:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 28 Oct 2024 19:59:58 +0200 (EET)
To: Keith Busch <kbusch@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI/sysfs: Use __free() in reset_method_store()
In-Reply-To: <Zx_Pt2ObNKIS8cu2@kbusch-mbp>
Message-ID: <8862b34b-26b3-af75-5d23-d765fb41b5d4@linux.intel.com>
References: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com> <20241028174046.1736-3-ilpo.jarvinen@linux.intel.com> <Zx_Pt2ObNKIS8cu2@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1973112510-1730138398=:947"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1973112510-1730138398=:947
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 28 Oct 2024, Keith Busch wrote:

> On Mon, Oct 28, 2024 at 07:40:45PM +0200, Ilpo J=E4rvinen wrote:
> > @@ -1430,7 +1431,7 @@ static ssize_t reset_method_store(struct device *=
dev,
> >  =09=09=09=09  const char *buf, size_t count)
> >  {
> >  =09struct pci_dev *pdev =3D to_pci_dev(dev);
> > -=09char *options, *tmp_options, *name;
> > +=09char *tmp_options, *name;
> >  =09int m, n;
> >  =09u8 reset_methods[PCI_NUM_RESET_METHODS] =3D { 0 };
> > =20
> > @@ -1445,7 +1446,7 @@ static ssize_t reset_method_store(struct device *=
dev,
> >  =09=09return count;
> >  =09}
> > =20
> > -=09options =3D kstrndup(buf, count, GFP_KERNEL);
> > +=09char *options __free(kfree) =3D kstrndup(buf, count, GFP_KERNEL);
>=20
> We should avoid mixing declarations with code. Please declare it with
> the cleanup attribute at the top like before, and just initialize it to
> NULL.

Hi,

I don't exactly disagree with you myself and would prefer to keep=20
declarations at top, but I think as done now is exactly what Bjorn wants=20
for the specific case where __free() is used. This was discussed earlier=20
on the list.

If I misunderstood the conclusion of the earlier cleanup related=20
discussion, can you please correct me Bjorn?

--=20
 i.

--8323328-1973112510-1730138398=:947--

