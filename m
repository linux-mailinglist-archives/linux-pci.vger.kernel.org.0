Return-Path: <linux-pci+bounces-16564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D78029C5CCE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5D2283D03
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794DF204011;
	Tue, 12 Nov 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZuJTRYS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4553204000;
	Tue, 12 Nov 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427321; cv=none; b=LCJw0NX2csrGwZroY2FthDuCh2bERwHXDj4BCLbaGIlj8/KlXpek/UperEnoHxvLoc/rS5iW447vIqeb5WyYQKgdMxzmztLCc5/3oZZM5wXj+XfelQkPux6mS4ZIfWT+wRhJgnE6kZzUw9UIyhfTaS0D7pqAdkwd1h6P3rBMRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427321; c=relaxed/simple;
	bh=iaYaUStprZ8SceeIhaWWBwFLmxeVYeoQCC7M5tVJmxo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CeBIjAkT0Q0E9nhxRylBhcxQ2C3OKS40ZrMZuyiU57zowEgiFKw8vonSE9vYMWl/ehIT8bVgUaMfbQw/teGhcOb2azcNaLjUzNQKPrU5MOcerAS1kwoiNQ/hb6Dump+5XVFHKNcsqW9uxlAx+GKDnarWSZiKM8ZW+EbXwQjWmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZuJTRYS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731427320; x=1762963320;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iaYaUStprZ8SceeIhaWWBwFLmxeVYeoQCC7M5tVJmxo=;
  b=kZuJTRYSbdt4Dqm2BSkywySafk5A17AbojvKpvTbKjE22QWXF+OYHbRa
   XV04rnxxMkC5zTwXIYlUmpyZz5g4kDyJwAwDjZ1euJp/pBFaAIQytS14M
   G/fyQDirnAk+u6MMhEEG39/M1x7+fN7JIzf9eVQFbMtWIPQxxGeMyRdc/
   HR1PaBiZ5S0GJF3/T4+dxiLNy59jQvggDOhuSFg6btMbY4QHMdCn/Uc+v
   D6ZksUT9LAwb5ZLpd9ZpbxNc2oXp1hlJOWWRBNj4toHANn6hjLv6wA+8D
   +fCL9sDx0kqBFYVBI32k80HJYV2g7LahTraxjIE52BpG9BQu7Mtmaczp1
   A==;
X-CSE-ConnectionGUID: hzfe6WZOTB2i8QU7k8axag==
X-CSE-MsgGUID: jayRqt+KSOK63CAlG97FEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41831582"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41831582"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 08:01:59 -0800
X-CSE-ConnectionGUID: MweyGtHOTjm8Wi5P6z1maw==
X-CSE-MsgGUID: 5dCRf5GdQ6GAPRIdDJIe+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87489721"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 08:01:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Nov 2024 18:01:50 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 7/9] PCI/bwctrl: Add API to set PCIe Link Speed
In-Reply-To: <ZzN4pO0lJDTSySaz@wunner.de>
Message-ID: <4f4ee107-1b25-f866-832e-6a35c8c7c35a@linux.intel.com>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com> <20241018144755.7875-8-ilpo.jarvinen@linux.intel.com> <ZzN4pO0lJDTSySaz@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1027285098-1731427310=:13135"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1027285098-1731427310=:13135
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 Nov 2024, Lukas Wunner wrote:

> On Fri, Oct 18, 2024 at 05:47:53PM +0300, Ilpo J=E4rvinen wrote:
> > +EXPORT_SYMBOL_GPL(pcie_set_target_speed);
>=20
> My apologies for another belated comment on this series.
> This patch is now a688ab21eb72 on pci/bwctrl:
>=20
> I note that pcie_set_target_speed() is not called my a modular user
> (CONFIG_PCIE_THERMAL is bool, not tristate), so the above-quoted export
> isn't really necessary right now.  I don't know if it was added
> intentionally because some modular user is expected to show up
> in the near future.

Its probably a thinko to add it at all but then there have been talk about=
=20
other users interested in the API too so it's not far fetched we could see=
=20
a user. No idea about timelines though.

There are some AMD GPU drivers tweaking the TLS field on their own but=20
they also touch some HW specific registers (although, IIRC, they only=20
touch Endpoint'sTLS). I was thinking of converting them but I'm unsure if=
=20
that yields something very straightforward and ends up producing a working=
=20
conversion or not (without ability to test with the HW). But TBH, not on=20
my highest priority item.

> > @@ -135,6 +296,7 @@ static int pcie_bwnotif_probe(struct pcie_device *s=
rv)
> >  =09if (!data)
> >  =09=09return -ENOMEM;
> > =20
> > +=09devm_mutex_init(&srv->device, &data->set_speed_mutex);
> >  =09ret =3D devm_request_threaded_irq(&srv->device, srv->irq, NULL,
> >  =09=09=09=09=09pcie_bwnotif_irq_thread,
> >  =09=09=09=09=09IRQF_SHARED | IRQF_ONESHOT,
>=20
> We generally try to avoid devm_*() functions in port service drivers
> because if we later on move them into the PCI core (which is the plan),
> we'll have to unroll them.  Not the end of the world that they're used
> here, just not ideal.

I think Jonathan disagrees with you on that:

https://lore.kernel.org/linux-pci/20241017114812.00005e67@Huawei.com/

:-)

--=20
 i.

--8323328-1027285098-1731427310=:13135--

