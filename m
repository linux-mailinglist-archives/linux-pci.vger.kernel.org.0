Return-Path: <linux-pci+bounces-14875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4BF9A4310
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 17:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203BB288C8A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 15:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312F2022D7;
	Fri, 18 Oct 2024 15:58:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523518E762;
	Fri, 18 Oct 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267131; cv=none; b=dasi6YDeifEjun4nj8l7nJ+X64TEhSvVT+JuY8/ZYT+JvR3HL0XFDzCFGsf0jMkjkVyZQarkQn91xDsde3i4XmFO/xyEz2zsS+ihHKtK1UNUAXTmky4S5orNLsoF2QUhqig+HnDOSevo8FVhYiSljx1fdoYUE4ohDJAIyBPLMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267131; c=relaxed/simple;
	bh=rrSYISK7aykn8T3i4YHXOIfpwUvKUp40GGJG19ipCCg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdzM13geDO6zTU6WiIn8yeEt/9fJGxBiQIvdqiLCAIDFIsH3qwPVBT4BB2xS3gT9v13zjQzkLO29QFytxfTZES7636Q1+KgMu6vMBcQM2QlMuUKNGd8L0foYfhXCh6mcAOHTNuonzkXNFDYslVJeBxuzPjocHbnT7PbJZkzisNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVTln2W19z6J7d5;
	Fri, 18 Oct 2024 23:54:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 77B14140B73;
	Fri, 18 Oct 2024 23:58:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 17:58:44 +0200
Date: Fri, 18 Oct 2024 16:58:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Niklas Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, <linux-s390@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: Remove unused PCI_SUBTRACTIVE_DECODE
Message-ID: <20241018165842.0000597d@Huawei.com>
In-Reply-To: <20241017141111.44612-1-ilpo.jarvinen@linux.intel.com>
References: <20241017141111.44612-1-ilpo.jarvinen@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 17:11:08 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> The commit 2fe2abf896c1 ("PCI: augment bus resource table with a list")
> added PCI_SUBTRACTIVE_DECODE which is put into the struct
> pci_bus_resource flags field but is never read. There seems to never
> have been users for it. Remove both PCI_SUBTRACTIVE_DECODE and the
> flags field from the struct pci_bus_resource.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
Nice cleanup.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  arch/s390/pci/pci_bus.c |  2 +-
>  arch/x86/pci/fixup.c    |  2 +-
>  drivers/pci/bus.c       |  4 +---
>  drivers/pci/probe.c     |  5 ++---
>  include/linux/pci.h     | 12 +-----------
>  5 files changed, 6 insertions(+), 19 deletions(-)

