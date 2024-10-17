Return-Path: <linux-pci+bounces-14774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B021C9A22EC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7519328178C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140B21DD525;
	Thu, 17 Oct 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+jgzSOy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B41DCB3A;
	Thu, 17 Oct 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170169; cv=none; b=IZTntpuhsU/k3XnvT6pgt8Vc5jwe5PnkeiySC1wLKM9eG7EFN+gzaLJ7VfGAx2utsvb00e1yLYaXhewpMiFOSuy9FHSFIV0r01mlC42M8auna9GDcajA1BV582dMCONyB6ZLS7ngr7eCUdfwXieyxY8QUpVfBz39NLm60Pd8HEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170169; c=relaxed/simple;
	bh=C0gNaOyOF8UH12hLY+xHLdbZtQnGw/UPdbQsUgQmbwc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A0PQ56rjJIpjhF395r9BItNV0ZUWcW2j5smWpROtLzXlXjLyi9VHp0AhF3LPdeBHb4kl3/cFTBLLdunHKYogRLTDZ/yoG/pYEHlYFKHjuVS/jrom/Jrp9aiQbnT0ThJZadzwpXrawMOraia7DmpZD/5oI71QaKZFyqYnytYP3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+jgzSOy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729170166; x=1760706166;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=C0gNaOyOF8UH12hLY+xHLdbZtQnGw/UPdbQsUgQmbwc=;
  b=X+jgzSOymVFMp66/mfyMJY61ecnHzrfh7UQC38xHByXlgTzW1T82vFae
   bLuqgi6FNit0xwLMPCJvyq77AwtrIixq02Lq9XnE4cs2BLWGhRGASyxUg
   b1NJZiSNSo2PHcVyuejw1AsHSkxGTCcRp9/B6uor/O0e04Mwfh04fwmEX
   tOaKpmyba8daJQRth+27EDZmkZn6PmDMjCN5RU0jJ1AavUAqPDSni/OWb
   KB1bIvIj+tFQlNRXgbTW1c7+VtO8YzjkxvLGUp2Jlkjkjx0rH6L5k1NaP
   xfL58Wg6Z5TWG99nsJiugGFou+9m2t0ZsoN8yShu33JsZ31YYqaRYdLcU
   g==;
X-CSE-ConnectionGUID: J0C7rGXkQ5CwPbSpb24yoA==
X-CSE-MsgGUID: usf6s4JDStGe761rim9JQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46119029"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46119029"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:02:44 -0700
X-CSE-ConnectionGUID: HtSWxkTLRy6wteI19IbULA==
X-CSE-MsgGUID: lf2CSdF+SeyZsR6uy5ZDnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83370471"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:02:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 17 Oct 2024 16:02:34 +0300 (EEST)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, Lukas Wunner <lukas@wunner.de>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    linux-pm@vger.kernel.org, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    LKML <linux-kernel@vger.kernel.org>, Amit Kucheria <amitk@kernel.org>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 7/8] thermal: Add PCIe cooling driver
In-Reply-To: <CAJZ5v0g+4ZorOVrC_Pr8BvhDUXckqg5WqREw2Wz+8_WzL_d52g@mail.gmail.com>
Message-ID: <47da33ac-4959-b30e-5ca6-52d30650b353@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com> <20241009095223.7093-8-ilpo.jarvinen@linux.intel.com> <20241017120456.00006023@Huawei.com> <70507175-dc7d-d334-4a2a-988239f380a6@linux.intel.com>
 <CAJZ5v0g+4ZorOVrC_Pr8BvhDUXckqg5WqREw2Wz+8_WzL_d52g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-484917308-1729170154=:929"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-484917308-1729170154=:929
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 Oct 2024, Rafael J. Wysocki wrote:

> On Thu, Oct 17, 2024 at 2:16=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Thu, 17 Oct 2024, Jonathan Cameron wrote:
> >
> > > On Wed,  9 Oct 2024 12:52:22 +0300
> > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > > Add a thermal cooling driver to provide path to access PCIe bandwid=
th
> > > > controller using the usual thermal interfaces.
> > > >
> > > > A cooling device is instantiated for controllable PCIe Ports from t=
he
> > > > bwctrl service driver.
> > > >
> > > > If registering the cooling device fails, allow bwctrl's probe to
> > > > succeed regardless. As cdev in that case contains IS_ERR() pseudo
> > > > "pointer", clean that up inside the probe function so the remove si=
de
> > > > doesn't need to suddenly make an odd looking IS_ERR() check.
> > > >
> > > > The thermal side state 0 means no throttling, i.e., maximum support=
ed
> > > > PCIe Link Speed.
> > > >
> > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Acked-by: Rafael J. Wysocki <rafael@kernel.org> # From the cooling =
device interface perspective
> > >
> > > Trivial thing noticed on a reread.
> > >
> > >
> > > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > > index 61e7ae524b1f..d3f9686e26e7 100644
> > > > --- a/drivers/thermal/Kconfig
> > > > +++ b/drivers/thermal/Kconfig
> > > > @@ -220,6 +220,15 @@ config DEVFREQ_THERMAL
> > > >
> > > >       If you want this support, you should say Y here.
> > > >
> > > > +config PCIE_THERMAL
> > > > +   bool "PCIe cooling support"
> > > > +   depends on PCIEPORTBUS
> > > > +   help
> > > > +     This implements PCIe cooling mechanism through bandwidth redu=
ction
> > > > +     for PCIe devices.
> > >
> > > Technically links not devices, but don't think that matters much
> >
> > That distinction would be splitting hairs beyond what seems useful from
> > ordinary user's point of view. If there's no device attached, BW
> > controller cannot do anything since the link is not going to train.
> > The link speed reduction is going to impact the speed the device
> > can communicate with even if it technically occurs on the link.
>=20
> From the Kconfig description perspective I think it's better to say
> "devices" even though technically it is about links, because device
> performance is what users will measure and notice any changes of.

Yes, that's what I tried to explain above. I intend to keep it as=20
"devices" for this very reason.

--=20
 i.

--8323328-484917308-1729170154=:929--

