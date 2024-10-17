Return-Path: <linux-pci+bounces-14781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B489A23CC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D3D6B21199
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83091DDC25;
	Thu, 17 Oct 2024 13:29:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E2364D6;
	Thu, 17 Oct 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171755; cv=none; b=IooX+MQdh15jVDoIw43R+xg8u9vhrPOb//bcblY5PKtqdKEH6xhsFt5ENKGEFbMGKdJXsIdM04iCQEHEN8PA/WOyrUpIJNTuUDcCrxkqxwW7DdBV0cItsvlSP07YdqoiecTLEWC7lAkxDN0GHAAYBLT3Ie438olHwG6cwz/q0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171755; c=relaxed/simple;
	bh=4FjWyAaZfxGJ9S/bLZfEZRXua6ju/h0MsR/tVYXzonk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6fa1wsbm7c6QhLobVG0GLi4yJeIwYIK7OjpiTDxJH13wEv10KYrVpHkcRJVIeG4fHd4lifFqizQuHye4QxtMMd54XAAOX4JnQ1qi9vvHO9xVMLz6No7n9a+TlzlU7xo/qamXtqWSDnpn9QyrUgJcF/4i89rHzaNKAvJ/tJcaVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTpXs6Zmrz6FH2t;
	Thu, 17 Oct 2024 21:27:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C1D01400DB;
	Thu, 17 Oct 2024 21:29:10 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 15:29:09 +0200
Date: Thu, 17 Oct 2024 14:29:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: Improve printout in pdev_sort_resources()
Message-ID: <20241017142908.00001220@Huawei.com>
In-Reply-To: <8b9f3fab-bfeb-5aa7-fc6a-26b9faa89417@linux.intel.com>
References: <20241017095545.1424-1-ilpo.jarvinen@linux.intel.com>
	<20241017121203.000003d8@Huawei.com>
	<8b9f3fab-bfeb-5aa7-fc6a-26b9faa89417@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 14:35:55 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 17 Oct 2024, Jonathan Cameron wrote:
>=20
> > On Thu, 17 Oct 2024 12:55:45 +0300
> > Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> >  =20
> > > Use pci_resource_name() helper in pdev_sort_resources() to print
> > > resources in user-friendly format. Also replace the vague "bogus
> > > alignment" with a more precise explanation of the problem.
> > >=20
> > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >=20
> > > v2:
> > > - Place colon after %s %pR to be consistent with other printouts
> > > - Replace vague "bogus alignment" with the exact cause
> > >=20
> > >  drivers/pci/setup-bus.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 23082bc0ca37..0fd286f79674 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct pci_dev *d=
ev, struct list_head *head)
> > >  	int i;
> > > =20
> > >  	pci_dev_for_each_resource(dev, r, i) {
> > > +		const char *r_name =3D pci_resource_name(dev, i);
> > >  		struct pci_dev_resource *dev_res, *tmp;
> > >  		resource_size_t r_align;
> > >  		struct list_head *n;
> > > @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct pci_dev *d=
ev, struct list_head *head)
> > > =20
> > >  		r_align =3D pci_resource_alignment(dev, r);
> > >  		if (!r_align) {
> > > -			pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
> > > -				 i, r);
> > > +			pci_warn(dev, "%s %pR: alignment must not be zero\n",
> > > +				 r_name, r); =20
> >
> > Why bother with local variable if only used here? =20
>=20
> No other reason than it seems to always be a local variable in the other=
=20
> places too regardless the number of uses.
Fair enough. local style is perfectly valid reasoning.

Jonathan

>=20
> > Absolutely fine if you have more code coming that uses it again though!
> >=20
> > Otherwise seems sensible change. =20
>=20


