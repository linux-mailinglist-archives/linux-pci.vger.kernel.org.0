Return-Path: <linux-pci+bounces-8836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEBA908C9E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C59289EED
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 13:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E554B19D8AF;
	Fri, 14 Jun 2024 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1qkA7vV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE763B
	for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372459; cv=none; b=KrYQn0eWb6IsGWryvmJ+3n/4eOVqyIvJGV0nSiyWIxeb24A152KLJuxQf743iHbpSi59IqMos0236QBmkCmHutMP6Y7i66rVQx5xIdrqR4dO9HraSbTlyCo2vl+sMd6f1JDcav8nWp23eYbOB8HC/+kDxI5X0lvN8SC2OzkOJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372459; c=relaxed/simple;
	bh=5S6KwbmIV8MAPYKRv/m/9LbAkddhsr5uz1DxQUJ6GJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+RbT9nNcD6CdeWEJINKqDNevG13/qe35VQMSfqfffyHDpNldr59I8n9wRFpPDCArQ8337l1jYt6+CW7zaIETqX/16MQAL7iJl/KOvKd07zu/gWhjfjP//fv0Fd+Umr4T9uDp2Jm1Le03CmsgLpLPzSApLOggZ+qkeDstBcyzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1qkA7vV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718372458; x=1749908458;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5S6KwbmIV8MAPYKRv/m/9LbAkddhsr5uz1DxQUJ6GJE=;
  b=E1qkA7vVjgn3EQhImNJRhd8gff23q+arLDZexPECunRmCgeYxbIBY44f
   J4Pihir2WbOPzajgS8+Q2JX9UBGiK6BJUYYww2WaIRbUqSggNOmSotUxL
   G1/o2fVQms3e3qKdcUCfRLKEnX1T19V1tCoZEg2BXkU/msrFVMFZLbBga
   IDMY4r/cWQV/gDPhdWu/PYpq8ipfebP5eWZC+aDYXhRZpq57rXqSMGvQf
   LexnzVAvUunHPrMKM4ADpu222heeMZj6HBkRPUNlij1BAfEujE3/8wCtR
   T5M/UE6y/SZSXw6C7jh6Bm88HPhx9CFVoU8xgLPHwWlBPZQzmKQGiDOSF
   g==;
X-CSE-ConnectionGUID: 15ukhBFDSaq3aMnp8Jf39w==
X-CSE-MsgGUID: Fh8uFonRQxWoRRxXkQf9vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="26675536"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="26675536"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:40:57 -0700
X-CSE-ConnectionGUID: dhG0qEXjSmSPoOHHsCpxsg==
X-CSE-MsgGUID: h5UVIomUS1uIdtWli191GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="45046226"
Received: from ajaszkux-mobl4.ger.corp.intel.com (HELO localhost) ([10.246.1.223])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:40:54 -0700
Date: Fri, 14 Jun 2024 15:40:49 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>,
 Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>, Pavel
 Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Stuart Hayes
 <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240614154049.000016ec@linux.intel.com>
In-Reply-To: <3e4718ce-8371-93e2-b390-cc3b263f31df@linux.intel.com>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
	<20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
	<3e4718ce-8371-93e2-b390-cc3b263f31df@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 28 May 2024 16:55:16 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> > +#define  PCI_NPEM_IND_SPEC_0		0x00800000
> > +#define  PCI_NPEM_IND_SPEC_1		0x01000000
> > +#define  PCI_NPEM_IND_SPEC_2		0x02000000
> > +#define  PCI_NPEM_IND_SPEC_3		0x04000000
> > +#define  PCI_NPEM_IND_SPEC_4		0x08000000
> > +#define  PCI_NPEM_IND_SPEC_5		0x10000000
> > +#define  PCI_NPEM_IND_SPEC_6		0x20000000
> > +#define  PCI_NPEM_IND_SPEC_7		0x40000000 =20
>=20
> Are these off-by-one, shouldn't that field go all the way to the last bit=
=20
> which is 0x80000000 (the field is 31:24)??

Yes, I made a mistake. Good catch!

Mariusz

