Return-Path: <linux-pci+bounces-10432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52EE933D78
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 15:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7916A281E17
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E9B1802C9;
	Wed, 17 Jul 2024 13:16:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7E1802C5
	for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222180; cv=none; b=RBYWrQaapWqgVjm/rCbdy+jKfKZ68CiE559dTnowbmbNoFzq1JzUUcF3PHTs2yrLwoxlKMIjKcgTk4ip/vT52pekDut3ulwdXJvQtVkLg1uFUjD1pPD7L4H3SESsUMw06oztOlSseHeNGbUspVlyX7AdnlvZTG1nI2JRYjsRGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222180; c=relaxed/simple;
	bh=J6MQ4R1W5wk+Dq9MUh5Wu2mQQMu+Rfq0uhrSl0za+vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=KPBWdEnSvReoh4dVAWmQAL12zN8pIlK17zfd7eraCKcjuNnalOZCA4XFcibZxOYGdMm98Se9BnqT949HmpK2cxqISTERacSJAfOxEMDRgW82xkJfr8ZXAGfUjB3+zqzohebyf27qOgdefJ2SM5HrLd9cGTspNM544VTql6xK+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-286-suj3PZiePpKJoA_vVWHUeA-1; Wed, 17 Jul 2024 14:16:09 +0100
X-MC-Unique: suj3PZiePpKJoA_vVWHUeA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jul
 2024 14:15:29 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 17 Jul 2024 14:15:29 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Stewart Hildebrand' <stewart.hildebrand@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Thomas Zimmermann <tzimmermann@suse.de>, "Arnd
 Bergmann" <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>, Yongji Xie
	<elohimes@gmail.com>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 0/8] PCI: Align small (<4k) BARs
Thread-Topic: [PATCH v2 0/8] PCI: Align small (<4k) BARs
Thread-Index: AQHa17cKP+9xH7dU/kmzREQ0omlV2bH64QzQ
Date: Wed, 17 Jul 2024 13:15:29 +0000
Message-ID: <0da056616de54589bc1d4b95dcdf5d3d@AcuMS.aculab.com>
References: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
In-Reply-To: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Stewart Hildebrand
> Sent: 16 July 2024 20:33
>=20
> This series sets the default minimum resource alignment to 4k for memory
> BARs. In preparation, it makes an optimization and addresses some corner
> cases observed when reallocating BARs. I consider the prepapatory
> patches to be prerequisites to changing the default BAR alignment.

Should the BARs be page aligned on systems with large pages?
At least as an option for hypervisor pass-through and any than can be mmap(=
)ed
into userspace.

Does any hardware actually have 'silly numbers' of small memory BARs?

I have a vague memory of some ethernet controllers having lots of (?)
virtual devices that might have separate registers than can be mapped
out to a hypervisor.
Expanding those to a large page might be problematic - but needed for secur=
ity.

For more normal hardware just ensuring that two separate targets don't shar=
e
a page while allowing (eg) two 1k BAR to reside in the same 64k page would
give some security.

Aligning a small MSIX BAR is unlikely to have any effect on the address
space utilisation (for PCIe) since the bridge will assign a power of two
sized block - with a big pad (useful for generating pcie errors!)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


