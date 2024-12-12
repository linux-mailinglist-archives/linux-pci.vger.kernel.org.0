Return-Path: <linux-pci+bounces-18299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99D9EF0C1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2A11889D98
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B9723EA89;
	Thu, 12 Dec 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Va8SuPJ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D923EA7B;
	Thu, 12 Dec 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019961; cv=none; b=SE8UM/DbHuYHe9RSX6tdNS75YL7YDJHewgLZbvvxe6uVUeCFER9nhZxy0SEXndZv5SQm/1dyPJSIFKLxYejjmr06YWU0WTe1Oiwi/4+OswOVMopcjb6W70Mr/UcWJh9L9QdBEQ/EddISmkSdsuNb3ceI2g1Lg8Bqgv+90dv0ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019961; c=relaxed/simple;
	bh=/zzJK9mnFf6zdHNCyut9nYjKlt83q2BcuRUr2z160zQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e3LGQqtcI+KP0NpwOuUgInrUVgusVKLExUDyLYqslPT4JgMcVzyyDgEEk9QbKUcKbGIhdN3Je7RRDWh3tMdFcnZ69gQx7/KSz4dZv3HFk98KwIpV4WR0gP7tb9GUTsJk6HLmheYrHAj8OIWKx9fdQnsQ2ThDHK+IIkY0E0+HKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Va8SuPJ2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734019960; x=1765555960;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/zzJK9mnFf6zdHNCyut9nYjKlt83q2BcuRUr2z160zQ=;
  b=Va8SuPJ2sBNL7Kz8OmKJJSU1a3ya85NsYGiLg8kqhVtBm3PLy3QSLnjj
   nFRS8CbU2UQnW8oMjMHXurdNs5hWTjRZFBM/PJdgvSAcYppirPIV/oAC4
   BtggEN/U83RsNJ3ykP3M11/W6R1GMmp42bKF6A2SrvrD4LaK1rWRs8F4b
   reVb7TS9tSdgjdUmNlzk7TY+7W/c5i+mZjtiT6KqIm51+owSOF2SwEouy
   Q1JKhTNEw8DK8LgFpNVyOYqOzM92rE5HBxCTZVgXkEnzClnuxOo8B1cYd
   BJBBB1eQPI2rlRHYLPR8VoZLmViE55OmCbv+BwWhCJWGUSU4T0/xFQcZh
   A==;
X-CSE-ConnectionGUID: dgaHEKqFTRy9qghsnzo0QA==
X-CSE-MsgGUID: ySa++XA/TwO1vRaisKLjCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="59840836"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="59840836"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 08:12:24 -0800
X-CSE-ConnectionGUID: 3/zP/YWEToi+5AyQtTtn5Q==
X-CSE-MsgGUID: V4/Dril5RPetIeubuZG3sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96116896"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.137])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 08:12:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Dec 2024 18:12:18 +0200 (EET)
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 6/8] PCI: Add TLP Prefix reading into
 pcie_read_tlp_log()
In-Reply-To: <20241211164904.00007a02@huawei.com>
Message-ID: <e4f907ad-ab87-ac42-7428-93e16f070f74@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com> <20240913143632.5277-7-ilpo.jarvinen@linux.intel.com> <20241211164904.00007a02@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-913753533-1734019938=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-913753533-1734019938=:936
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Dec 2024, Jonathan Cameron wrote:

> On Fri, 13 Sep 2024 17:36:30 +0300
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > pcie_read_tlp_log() handles only 4 Header Log DWORDs but TLP Prefix Log
> > (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.
> >=20
> > Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle also
> > TLP Prefix Log. The relevant registers are formatted identically in AER
> > and DPC Capability, but has these variations:
> >=20
> > a) The offsets of TLP Prefix Log registers vary.
> > b) DPC RP PIO TLP Prefix Log register can be < 4 DWORDs.
> >=20
> > Therefore callers must pass the offset of the TLP Prefix Log register
> > and the entire length to pcie_read_tlp_log() to be able to read the
> > correct number of TLP Prefix DWORDs from the correct offset.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Trivial comments below
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Would have been nice if they'd just made the formats have the
> same sized holes etc!

That's not even the worst problem.

They managed to copy-paste most of the stuff into DPC (copy-paste is=20
really obvious because the text still refers to AER in a DPC section :-))=
=20
but forgot to add a few capability fields into the DPC capability, most=20
importantly, the bit that indicates whether TLP was logged in Flit mode
or not And now we get to keep the pieces how to interpret the Log=20
Registers (relates to the follow up series). :-(

> > diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> > index 65ac7b5d8a87..def9dd7b73e8 100644
> > --- a/drivers/pci/pcie/tlp.c
> > +++ b/drivers/pci/pcie/tlp.c
> > @@ -11,26 +11,65 @@
>=20
> >  /**
> >   * pcie_read_tlp_log - read TLP Header Log
> Maybe update this to read TLP Header and Prefix Logs
> >   * @dev: PCIe device
> >   * @where: PCI Config offset of TLP Header Log
> > + * @where2: PCI Config offset of TLP Prefix Log
>=20
> Is it worth giving it a more specific name than where2?
> Possibly renaming where as well!

Sure, why not.

--=20
 i.

> > + * @tlp_len: TLP Log length (Header Log + TLP Prefix Log in DWORDs)
> >   * @log: TLP Log structure to fill
> >   *
> >   * Fill @log from TLP Header Log registers, e.g., AER or DPC.
> >   *
> >   * Return: 0 on success and filled TLP Log structure, <0 on error.
> >   */
> > -int pcie_read_tlp_log(struct pci_dev *dev, int where,
> > -=09=09      struct pcie_tlp_log *log)
> > +int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> > +=09=09      unsigned int tlp_len, struct pcie_tlp_log *log)
> >  {


--8323328-913753533-1734019938=:936--

