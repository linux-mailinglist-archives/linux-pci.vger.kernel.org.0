Return-Path: <linux-pci+bounces-18394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3B29F1177
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9381648E1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7963015383D;
	Fri, 13 Dec 2024 15:55:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCD84039;
	Fri, 13 Dec 2024 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105304; cv=none; b=MGu3jSpb7FE4SuSf4w30Z4AV+uRXOqd7WM1/A7WdcmsFiKFgbYYSrDbn6n44Ler5LegzOTVoCs0rqa3iqotO4WK0+PGTB6q/uiedYht7Rih08KJ2WVE+HE/vngJqeE4fyFRdmxfPpMyFjqeLKOfqulOdKKp4vuzTG4yXMAT7m5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105304; c=relaxed/simple;
	bh=kbqbabwvc/VPjjuaLPaXRQlSZw4ZEpBN0gxC/LtQcvk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=earkhs5Wrge9hFybMgv6MkeUqfMQdd2sXUmYhdUc9xQ54HXL2J6jwELRnYeHMZ2zszK4Yb9tJPageGibh3Th7GrbmniQL1/yvxkNdImqwdbstURFeCwBje7RLErq90kWPPJOzBkZt0y+vGFktddakCVJl6jjUDHuQTWRxiTf2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y8v1D51bTz6J6HQ;
	Fri, 13 Dec 2024 23:50:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D290A140134;
	Fri, 13 Dec 2024 23:54:52 +0800 (CST)
Received: from localhost (10.47.76.147) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Dec
 2024 16:54:52 +0100
Date: Fri, 13 Dec 2024 15:54:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Mahesh
 J Salgaonkar" <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, LKML <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 6/8] PCI: Add TLP Prefix reading into
 pcie_read_tlp_log()
Message-ID: <20241213155450.00005b70@huawei.com>
In-Reply-To: <827acda7-26d8-f4f5-2251-befb932ebb8b@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
	<20240913143632.5277-7-ilpo.jarvinen@linux.intel.com>
	<20241211164904.00007a02@huawei.com>
	<e4f907ad-ab87-ac42-7428-93e16f070f74@linux.intel.com>
	<827acda7-26d8-f4f5-2251-befb932ebb8b@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 12 Dec 2024 20:48:38 +0200 (EET)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 12 Dec 2024, Ilpo J=E4rvinen wrote:
>=20
> > On Wed, 11 Dec 2024, Jonathan Cameron wrote:
> >  =20
> > > On Fri, 13 Sep 2024 17:36:30 +0300
> > > Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > >  =20
> > > > pcie_read_tlp_log() handles only 4 Header Log DWORDs but TLP Prefix=
 Log
> > > > (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.
> > > >=20
> > > > Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle al=
so
> > > > TLP Prefix Log. The relevant registers are formatted identically in=
 AER
> > > > and DPC Capability, but has these variations:
> > > >=20
> > > > a) The offsets of TLP Prefix Log registers vary.
> > > > b) DPC RP PIO TLP Prefix Log register can be < 4 DWORDs.
> > > >=20
> > > > Therefore callers must pass the offset of the TLP Prefix Log regist=
er
> > > > and the entire length to pcie_read_tlp_log() to be able to read the
> > > > correct number of TLP Prefix DWORDs from the correct offset.
> > > >=20
> > > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> =20
> > >=20
> > > Trivial comments below
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > > Would have been nice if they'd just made the formats have the
> > > same sized holes etc! =20
> >=20
> > That's not even the worst problem.
> >=20
> > They managed to copy-paste most of the stuff into DPC (copy-paste is=20
> > really obvious because the text still refers to AER in a DPC section :-=
))=20
> > but forgot to add a few capability fields into the DPC capability, most=
=20
> > importantly, the bit that indicates whether TLP was logged in Flit mode
> > or not And now we get to keep the pieces how to interpret the Log=20
> > Registers (relates to the follow up series). :-(
> >  =20
> > > > diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> > > > index 65ac7b5d8a87..def9dd7b73e8 100644
> > > > --- a/drivers/pci/pcie/tlp.c
> > > > +++ b/drivers/pci/pcie/tlp.c
> > > > @@ -11,26 +11,65 @@ =20
> > >  =20
> > > >  /**
> > > >   * pcie_read_tlp_log - read TLP Header Log =20
> > > Maybe update this to read TLP Header and Prefix Logs =20
> > > >   * @dev: PCIe device
> > > >   * @where: PCI Config offset of TLP Header Log
> > > > + * @where2: PCI Config offset of TLP Prefix Log =20
> > >=20
> > > Is it worth giving it a more specific name than where2?
> > > Possibly renaming where as well! =20
> >=20
> > Sure, why not. =20
>=20
> Hi again,
>=20
> After doing this rename, I rebased the Flit mode series on top of it and
> realized there's one small problem with naming where2. It will be=20
> overloaded between TLP Prefix Log (Non-Flit mode) and extended TLP Header=
=20
> Log (DW5+) (Flit mode) so I'm not sure if there's really going to be a=20
> good name for it.
>=20
Ah. I should read that series ;)

Absolutely fine - sometime generic naming is the best we can do!

Jonathan



