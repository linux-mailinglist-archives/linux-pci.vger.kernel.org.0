Return-Path: <linux-pci+bounces-26113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0C0A9202F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 16:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3671690A3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EA224E4B3;
	Thu, 17 Apr 2025 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Phfou6Qy"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EC374BED;
	Thu, 17 Apr 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901389; cv=pass; b=LbK+tWMtqcgwKNVmOZBhcxNkIjvzp1NvywFoCEhjnjK3bs14XFdi0aQP2TxHeoHaTQ/pstEZZ5nYlte/g5dtBWKFTdQwvWHKuWFIxWxLjp1ZQxOm2Xq/aLNtrcg9oA47pRLnak20Y64B+VBW0iYHYWUQYHHtaxArmlBWqyWYEWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901389; c=relaxed/simple;
	bh=xv3lSHb1zSnXv2HQIBMHf+S/cXx3Av9Pw58pI/Ek+uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3/HfQiy0LZmsK+6O9O50NQZomrEwSFMYYhD2sVH3TG1ZnRAnhNnTbivQfcrVCj4qBaVg0rMv3zu307hN/U79VJrxhvYU6+z2kO0pDCIvxcUIH6Va9FGA98WBByO8pRQDV9+2ZPV5yC6bmesVgue5a003rm3CDB29vMZOWW4JxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Phfou6Qy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744901360; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LSA4XUad9HjJCzKl0wWGtil+yNnca6JHHXClQCjTn53PXnZKCtj487H9AvZE24+44kYzAP8GqLFXR/0w3iLDvy5om6JGZcOsABiNV+EnM8mXCUP/n1o92IBWriIxvIUsT2z9Yumf5/LuRRtzAzoxVoO84kAfsuFhEF4nz4FW/bw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744901360; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=efU53WnCdbsY58dh84Ulpb0jetMQ/EeX3XIf2R02SAM=; 
	b=Ff3cL9ZFXVPbQsV8514XmQa64YEIF3QzEpoL+fmMM73ppwL5hmvwERj0ysNom3GmLSFWd/3qIO5zIOaf1BMNu3WbHj7vnjMqZSejp4sBKXZwupIchJe4ptbOQYnRF8HGDi+yfW6FgiPAc/mStJ+AZDrZBE7SWGjeY3NDevM4Tic=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744901360;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=efU53WnCdbsY58dh84Ulpb0jetMQ/EeX3XIf2R02SAM=;
	b=Phfou6QycRe1GtJOHKoq1P0jx74qH0wBurp0HGdN7h4IPhljdMju7cgBYrcLzv9N
	N9h15YvDxoQgGQizOlfmZDjy+SXL6tM0GDicxriAoGx5RdXox12gfoYE1C0BvCNjNPi
	GNRfz1eu57ryIJ+azTytgbceRolkfkP86+0xQW3U=
Received: by mx.zohomail.com with SMTPS id 1744901358607467.10631715253476;
	Thu, 17 Apr 2025 07:49:18 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 =?UTF-8?B?TWljaGHFgg==?= Winiarski <michal.winiarski@intel.com>,
 linux-rockchip@lists.infradead.org,
 =?UTF-8?B?T25kxZllag==?= Jirman <megi@xff.cz>,
 Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 1/1] PCI: Restore assigned resources fully after release
Date: Thu, 17 Apr 2025 16:49:13 +0200
Message-ID: <3578030.5fSG56mABF@workhorse>
In-Reply-To: <20250403093137.1481-1-ilpo.jarvinen@linux.intel.com>
References: <20250403093137.1481-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 3 April 2025 11:31:37 Central European Summer Time Ilpo J=C3=
=A4rvinen wrote:
> PCI resource fitting code in __assign_resources_sorted() runs in
> multiple steps. A resource that was successfully assigned may have to
> be released before the next step attempts assignment again. The
> assign+release cycle is destructive to a start-aligned struct resource
> (bridge window or IOV resource) because the start field is overwritten
> with the real address when the resource got assigned.
>=20
> Properly restore the resource after releasing it. The start, end, and
> flags fields must be stored into the related struct pci_dev_resource in
> order to be able to restore the resource to its original state.
>=20
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list i=
n sync")
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20

+Cc: linux-rockchip

Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

This fixes a regression on the RK3588 that I ran into with v6.15-rc<=3D2.

Specifically, the PCIe3 controller will fail to map the address space
of a
  Non-Volatile memory controller: KIOXIA Corporation NVMe SSD (rev 01)
  (prog-if 02 [NVM Express])

drive on most, but not all, boots, depending on the order initialisation
happens, it seems. A different drive I tested seems to work fine, so not
only does the regression only rear its head based on boot timing, but
also based on the device attached to the PCIe3 controller. Bisecting was
a bit of a tortured affair, as the bad commit 96336ec70264 doesn't seem
to build for me, so I had to `git bisect skip` it.

The specific problematic behaviour fixed by this patch is that we get:

  pci 0000:00:00.0: bridge window [mem size 0x00100000]: can't assign; bogu=
s alignment

It sounds like Ond=C5=99ej Jirman ran into the same regression, since the
devices he mentioned (Orange Pi 5+ and QuartzPro64) both use the
Rockchip RK3588 SoC.

Kind regards,
Nicolas Frattaroli



