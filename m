Return-Path: <linux-pci+bounces-145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B147F5C10
	for <lists+linux-pci@lfdr.de>; Thu, 23 Nov 2023 11:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D2F1C20D1A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Nov 2023 10:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA02224C2;
	Thu, 23 Nov 2023 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="DDPSK0lG"
X-Original-To: linux-pci@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE79F;
	Thu, 23 Nov 2023 02:16:13 -0800 (PST)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4ED651A1F9E;
	Thu, 23 Nov 2023 11:16:10 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1700734570; bh=IdlZbZ9FL5iny9zKRN7ZMCUL5Jenf+2OfYnJsvJqcig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DDPSK0lGkfZJHOQZNuLlkLCLbHz1wjzqVXLySg3Q8z8v7t5gijyPAbAiww7BW4rQr
	 X2EHNtMdFNvELQGkgNrK29IfFgUDgjQUmz9dd+wWZuWnxYFT9HUPPY/tIjAr/4Z7Al
	 LCbuCRwmyx01ek0FkLAGYG8vqjsa3KscngzQWmOLXmSMp5woK+anXKMYENadtfWAxO
	 4mvc7VDKq40/5hTwubz8kifMxUhkDWkl8oEpJYxKuIkSGXypzDhcoE9I4CU5hYWWQ1
	 4JPUyw025ZJ6Qux1IpbkqUH/wC+OyAm2Y3txJyL3Mm0XJYDyM6WznR/dLWgi1+vEqY
	 AdxDvgM/iHMNg==
Date: Thu, 23 Nov 2023 11:16:08 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Halil Pasic <pasic@linux.ibm.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>, Ross Lagerwall
 <ross.lagerwall@citrix.com>, linux-pci <linux-pci@vger.kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Matthew Rosato
 <mjrosato@linux.ibm.com>, Jianxiong Gao <jxgao@google.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231123111608.17727968@meshulam.tesarici.cz>
In-Reply-To: <20231108101347.77cab795@meshulam.tesarici.cz>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
	<20231103171447.02759771.pasic@linux.ibm.com>
	<20231103214831.26d29f4d@meshulam.tesarici.cz>
	<20231107182420.0bd8c211.pasic@linux.ibm.com>
	<20231108101347.77cab795@meshulam.tesarici.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello everybody,

I don't think I have ever seen an answer to my question regarding
alignment constraints on swiotlb bounce buffers:

On Wed, 8 Nov 2023 10:13:47 +0100
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

>[...]
> To sum it up, there are two types of alignment:
>=20
> 1. specified by a device's min_align_mask; this says how many low
>    bits of a buffer's physical address must be preserved,
>=20
> 2. specified by allocation size and/or the alignment parameter;
>    this says how many low bits in the first IO TLB slot's physical
>    address must be zero.
>=20
> I hope somebody can confirm or correct this summary before I go
> and break something. You know, it's not like cleanups in SWIOTLB
> have never broken anything.  ;-)

If no answer means that nobody knows, then based on my understanding the
existing code (both implementation and users), I can assume that this
is the correct interpretation.

I'm giving it a few more days. If there's still no reaction, expect a
beautiful documentation patch and a less beautiful cleanup patch in the
next week.

Petr T

