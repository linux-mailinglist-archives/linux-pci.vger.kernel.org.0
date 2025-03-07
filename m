Return-Path: <linux-pci+bounces-23118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7441EA56892
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 14:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844FB16F577
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E59A219E86;
	Fri,  7 Mar 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIVoFEaC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C92192B77;
	Fri,  7 Mar 2025 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353207; cv=none; b=IHSrbsVDsTSkJPK3Ey9p1EsnsGJH9CYfOPX2+ekFs3yjrD6yZyY+FUbSODB9Yg3aFBC/tLFVd+yLY85tb5M/uJYuq/tfoPfVHNQ5l/n0xZCZB0nEjJKhxiaLaRU15vk0blbrOeVvICkjrz3QkFcpM/kNBta2ankJzYbQ1KZu6j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353207; c=relaxed/simple;
	bh=RPQMkL/j7UK28Z/9RAmWA5qfPlPR6W8B8k+/akQmqmE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nPiPEz+eRjWvHov1mYDiRYgMG1FAlraE6PIP/Y6sKESDBc4gy1JHXT8v+Lr9PziBStdpS6BMyEtGsrxBWfqVGeB8M1LRXg8ZBfD2B+srSmdgWIgqqIvCmoiwB8aWGWDv4aWP/2R5+Qr7Dm4vpoOBFZZWdCPPCzDMB0spggYPpog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIVoFEaC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741353205; x=1772889205;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RPQMkL/j7UK28Z/9RAmWA5qfPlPR6W8B8k+/akQmqmE=;
  b=eIVoFEaCWQT40PTDovmbHuEjE3rhb2H9X9GgK+R6IkB/k4jyc4QbpX3c
   0iBgtQxB117h4P0LldmHeGTaZx9yWUk4qtuERXRZyMgVhDqsrxFiv1ixM
   aGxIp1KtObfjaV2InTC5sqGTB09wgrfXMCJZJkqlqbIqD5Q5uHVYkZGx/
   iIXciI2aML22gPuAXEsDyCoeQXPKy2ZTo1FMQ8cfuodkItchzl+choWyR
   M1c6v1SKtURDabhAuBd1Nd8Q0jFKN2QLrz97/G9g07cvQLHcUj2O8rygZ
   BfJGLOrxzKraHFLyrKTlzz4elTpmk3UQNn/pihfNQ5SabHh21ApejoMXd
   g==;
X-CSE-ConnectionGUID: nQuuTYdgS/StS8o9w03b5w==
X-CSE-MsgGUID: R6uvbvozSXyzVcyZVMAV8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53788739"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53788739"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 05:13:24 -0800
X-CSE-ConnectionGUID: nIhPzr/oTcS+usKtZFoamw==
X-CSE-MsgGUID: Xi40Or4KRxWxyQv7SvNNBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119148446"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 05:13:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Mar 2025 15:13:19 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
In-Reply-To: <Z8qvo0_tuSbwwyIY@wunner.de>
Message-ID: <adfcd6ad-5672-f941-5a0f-076ecb1dbb0e@linux.intel.com>
References: <20250304135108.2599-1-ilpo.jarvinen@linux.intel.com> <Z8qvo0_tuSbwwyIY@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2007978352-1741353199=:984"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2007978352-1741353199=:984
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 7 Mar 2025, Lukas Wunner wrote:

> On Tue, Mar 04, 2025 at 03:51:08PM +0200, Ilpo J=E4rvinen wrote:
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5564,6 +5564,33 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORK=
S, 0x0144, quirk_no_ext_tags);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ex=
t_tags);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ex=
t_tags);
> > =20
> > +static void quirk_pcie2x_no_tags_no_mrrs(struct pci_dev *pdev)
> > +{
> > +=09struct pci_host_bridge *bridge =3D pci_find_host_bridge(pdev->bus);
> > +=09u32 linkcap;
> > +
> > +=09if (!bridge)
> > +=09=09return;
>=20
> I note that in a lot of places where pci_find_host_bridge() is called,
> no NULL pointer check is performed.  So omitting it would appear
> to be safe.
>=20
> The quirk is x86-specific, so compiling it into the kernel on other
> arches creates unnecessary bloat.  Avoid by moving to arch/x86/pci/fixup.=
c.
>=20
> There should definitely be a multi-line code comment above the function
> explaining what defect this works around (slower performance apparently),
> and also link to the PDF document.

I'll do those in v2. Thanks for the comments.

> BTW the PDF document says "Intel Confidential", I'm wondering why this
> has been made public without stripping the confidentiality marker...

We're apparently also not supposed to "finalize a design with this=20
information". :-)

--=20
 i.

--8323328-2007978352-1741353199=:984--

