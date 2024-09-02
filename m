Return-Path: <linux-pci+bounces-12625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F27968CC4
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C301C220E1
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8EA19F129;
	Mon,  2 Sep 2024 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URHWCMTX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B051A264E;
	Mon,  2 Sep 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297653; cv=none; b=i/OCK3hsPDLaScrsfPm0fQnVWcXOiM1WX1HI4KUOIRyZqO1U1CCyI5oV0bgwdr4NzjAjnqfQsD0M8vzZOTjLDr5qPof+fZPWgWji0dFdxYJFMlbF898JlN//zzi3kCWGFVm24uJYf/SSvmFUyOyCz7sQRWT5mmi1qslbZbt+NPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297653; c=relaxed/simple;
	bh=GkQVm/313yFRiCJitqApvhCnlkgQuXATKxT6CqO6J2s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h9Dzop5W7UqIxgRVK8Qt1QOzzkXDg7nIisUnNY3mFE/FscONhuG8mlGo9/S2TFA0l7hNZvRHBs1K29odoJMMxoD24ObpQrz3D+OZ8Bg+KjJoycsQt6AtwOO/8sjFWOSt8RikqW+s9LwvY+EO1oCDHuvw/8dYzC1F3ngqdGLvaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URHWCMTX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725297652; x=1756833652;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GkQVm/313yFRiCJitqApvhCnlkgQuXATKxT6CqO6J2s=;
  b=URHWCMTXlHHy9mo3b1Ag76wpzYU32fx5VETYJVo27dUjbZBC6B1OhPGy
   lmhmRT52HD5RQDdLZ+2y1oQ7pSMGFpyRKU2Cw/zCHHTG7R/irtJUKa8qL
   r+S2FFbghG1BwSHyvK8tllIeLcn6V9QIZCFm7edScexkL8kCJeQ+gcVoa
   EvYwhqm/xxthOU57Oeu5Ieagq1T40vbAu8kJlOPbhAxAREG20HR4Si4Jq
   88epp5XKN+MkCmGc5LGqEsCF+YG6eFX1Czdm3SO0Y1MQ4gO9TmPVJ5Rku
   OqA22IXvo9mxXSksn3SI4x5F3TZmRITqXqQCiJvJSh5C5udoxou6eQiEu
   A==;
X-CSE-ConnectionGUID: mpomgh3iQSSWTFBRDTU/bg==
X-CSE-MsgGUID: G3UFhax9TwWbeOBygmm+eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35253189"
X-IronPort-AV: E=Sophos;i="6.10,196,1719903600"; 
   d="scan'208";a="35253189"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 10:20:51 -0700
X-CSE-ConnectionGUID: 4Whz1t3+TEOCjPACwmHH9w==
X-CSE-MsgGUID: IJelBsvoT0ahJb71fLn1Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,196,1719903600"; 
   d="scan'208";a="64287900"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 10:20:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Sep 2024 20:20:41 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>, 
    LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 7/7] PCI: Create helper to print TLP Header and Prefix
 Log
In-Reply-To: <20240830191129.GA115840@bhelgaas>
Message-ID: <b0484353-8ba5-02c2-e78c-d51aba55bbb7@linux.intel.com>
References: <20240830191129.GA115840@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1996877222-1725297641=:1156"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1996877222-1725297641=:1156
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 30 Aug 2024, Bjorn Helgaas wrote:

> On Tue, May 14, 2024 at 02:31:09PM +0300, Ilpo J=C3=A4rvinen wrote:
> > Add pcie_print_tlp_log() helper to print TLP Header and Prefix Log.
> > Print End-End Prefixes only if they are non-zero.
> >=20
> > Consolidate the few places which currently print TLP using custom
> > formatting.
> >=20
> > The first attempt used pr_cont() instead of building a string first but
> > it turns out pr_cont() is not compatible with pci_err() and prints on a
> > separate line. When I asked about this, Andy Shevchenko suggested
> > pr_cont() should not be used in the first place (to eventually get rid
> > of it) so pr_cont() is now replaced with building the string first.
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/pci.h      |  2 ++
> >  drivers/pci/pcie/aer.c | 10 ++--------
> >  drivers/pci/pcie/dpc.c |  5 +----
> >  drivers/pci/pcie/tlp.c | 31 +++++++++++++++++++++++++++++++
> >  4 files changed, 36 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 7afdd71f9026..45083e62892c 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -423,6 +423,8 @@ void aer_print_error(struct pci_dev *dev, struct ae=
r_err_info *info);
> >  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> >  =09=09      unsigned int tlp_len, struct pcie_tlp_log *log);
> >  unsigned int aer_tlp_log_len(struct pci_dev *dev);
> > +void pcie_print_tlp_log(const struct pci_dev *dev,
> > +=09=09=09const struct pcie_tlp_log *log, const char *pfx);
> >  #endif=09/* CONFIG_PCIEAER */
> > =20
> >  #ifdef CONFIG_PCIEPORTBUS
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index ecc1dea5a208..efb9e728fe94 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -664,12 +664,6 @@ static void pci_rootport_aer_stats_incr(struct pci=
_dev *pdev,
> >  =09}
> >  }
> > =20
> > -static void __print_tlp_header(struct pci_dev *dev, struct pcie_tlp_lo=
g *t)
> > -{
> > -=09pci_err(dev, "  TLP Header: %08x %08x %08x %08x\n",
> > -=09=09t->dw[0], t->dw[1], t->dw[2], t->dw[3]);
> > -}
> > -
> >  static void __aer_print_error(struct pci_dev *dev,
> >  =09=09=09      struct aer_err_info *info)
> >  {
> > @@ -724,7 +718,7 @@ void aer_print_error(struct pci_dev *dev, struct ae=
r_err_info *info)
> >  =09__aer_print_error(dev, info);
> > =20
> >  =09if (info->tlp_header_valid)
> > -=09=09__print_tlp_header(dev, &info->tlp);
> > +=09=09pcie_print_tlp_log(dev, &info->tlp, "  ");
>=20
> I see you went to some trouble to preserve the previous output, down
> to the number of spaces prefixing it.
>=20
> But more than the leading spaces, I think what people will notice is
> that previously AER and DPC dmesgs contain the "AER: " or "DPC: "
> prefixes implicitly added by the dev_fmt definitions [1], where now
> IIUC they won't.
>=20
> I think adding dev_fmt("") here should take care of that, e.g.,
>=20
>   pcie_print_tlp_log(dev, &info->tlp, dev_fmt(""));
>=20
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1990272

Okay, I'll fix it and resend but looking into that output, it doesn't=20
look very consistent when it comes to prefixes as the lines in between do=
=20
not start with "AER: " either. Perhaps those lines should be changed as=20
well?

--=20
 i.

--8323328-1996877222-1725297641=:1156--

