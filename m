Return-Path: <linux-pci+bounces-40463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765DEC3973B
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 08:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8A91A434C1
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 07:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1994C21D00A;
	Thu,  6 Nov 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="L5WyxcgW"
X-Original-To: linux-pci@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125052DF12F;
	Thu,  6 Nov 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415410; cv=none; b=O8wszDamjXDtEBdpSipzVRfLEZBgeCIUu3Mz8AXs0SmeMvDNDnbX96bYhApzANJwF3m0CEzXuPF4iIdlJ4Tw9nQQygDTqQ2ytcXKQv1003Sbaw2WI2ywpq1kev2wfSV0yj9wvCrFFzFkv/zklm08jmO88ucO47tSTFHeVezqHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415410; c=relaxed/simple;
	bh=6krB87tTpg7PnjQCqlyzNLsWgUPFNQzg1RuH0acs9H4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GG0Wq35ZQ4gsalX8CQ0VLpwCgO3vZMwYsGJBsCXuDtydcxmweM1ggYCxctanGakTeHqiL8t0N1QZM2J8RPYuUjNsSvlZ5h7sclLNDWkvO32uAgUt63kxAVgQAXQ6EN+AN/OXfTMETnFuMUdVLCcpSbRYs8FpIDGI+qeu3/SsGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=L5WyxcgW; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=7Daal1mpDnwksHTBXhovLycDkyASp1letXDnqfk8zx0=; t=1762415405;
	x=1763020205; b=L5WyxcgWmEC4z5z9DknCBodljeCa1B6aqVEvHpXUMHR4eBQYBtViQciJlHEj6
	JDax301w5OpOO2mYA2VmR1FtivxNn0sBZNTNceTYymqZkZlLVk2IV0OhIYtjMHlmkb9RzECRxQLGv
	AgZU2ve910D0UUPUOUhtYUmBrnvCywChZHMNvB53loDVLOcq6WxiQVxt6jR+BGzfJFp3pB5Txp3Hy
	zgKuhn2CAflfkqThRgpQuFxXponvN+om4tuUJhPzlVCjrB4V+Bf8NygzQB1WYuYCFipumhOTqPnYG
	XJ+5KoAuUswtWaJUspFxLPe2PLmtvxemFYcqHGW28DRDAmP9aA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vGukh-00000003Msv-3VoG; Thu, 06 Nov 2025 08:49:51 +0100
Received: from dynamic-077-183-232-018.77.183.pool.telefonica.de ([77.183.232.18] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vGukh-00000003VWh-2Pwo; Thu, 06 Nov 2025 08:49:51 +0100
Message-ID: <8fcc0fd4b74f99d5c4d80d3907e7607a7d4c89da.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 02/24] sparc/PCI: Remove pcibios_enable_device() as they
 do nothing extra
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andreas Larsson <andreas@gaisler.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "David S. Miller" <davem@davemloft.net>,  Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, 	linux-pci@vger.kernel.org,
 sparclinux@vger.kernel.org, Thomas Bogendoerfer	
 <tsbogend@alpha.franken.de>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Yinghai Lu <yinghai@kernel.org>, Igor Mammedov	
 <imammedo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>,  Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kw@linux.com>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, 
	linuxppc-dev@lists.ozlabs.org
Date: Thu, 06 Nov 2025 08:49:50 +0100
In-Reply-To: <20250822145605.18172-3-ilpo.jarvinen@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
	 <20250822145605.18172-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Ilpo,

On Fri, 2025-08-22 at 17:55 +0300, Ilpo J=C3=A4rvinen wrote:
> Under arch/sparc/ there are multiple copies of pcibios_enable_device()
> but none of those seem to do anything extra beyond what
> pci_enable_resources() is supposed to do. These functions could lead to
> inconsistencies in behavior, especially now as pci_enable_resources()
> and the bridge window resource flags behavior are going to be altered
> by upcoming changes.
>=20
> Remove all pcibios_enable_device() from arch/sparc/ so that PCI core
> can simply call into pci_enable_resources() instead using it's __weak
> version of pcibios_enable_device().
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/sparc/kernel/leon_pci.c | 27 ---------------------------
>  arch/sparc/kernel/pci.c      | 27 ---------------------------
>  arch/sparc/kernel/pcic.c     | 27 ---------------------------
>  3 files changed, 81 deletions(-)
>=20
> diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
> index 8de6646e9ce8..10934dfa987a 100644
> --- a/arch/sparc/kernel/leon_pci.c
> +++ b/arch/sparc/kernel/leon_pci.c
> @@ -60,30 +60,3 @@ void leon_pci_init(struct platform_device *ofdev, stru=
ct leon_pci_info *info)
>  	pci_assign_unassigned_resources();
>  	pci_bus_add_devices(root_bus);
>  }
> -
> -int pcibios_enable_device(struct pci_dev *dev, int mask)
> -{
> -	struct resource *res;
> -	u16 cmd, oldcmd;
> -	int i;
> -
> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -	oldcmd =3D cmd;
> -
> -	pci_dev_for_each_resource(dev, res, i) {
> -		/* Only set up the requested stuff */
> -		if (!(mask & (1<<i)))
> -			continue;
> -
> -		if (res->flags & IORESOURCE_IO)
> -			cmd |=3D PCI_COMMAND_IO;
> -		if (res->flags & IORESOURCE_MEM)
> -			cmd |=3D PCI_COMMAND_MEMORY;
> -	}
> -
> -	if (cmd !=3D oldcmd) {
> -		pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
> -		pci_write_config_word(dev, PCI_COMMAND, cmd);
> -	}
> -	return 0;
> -}
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index ddac216a2aff..a9448088e762 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -722,33 +722,6 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info=
 *pbm,
>  	return bus;
>  }
> =20
> -int pcibios_enable_device(struct pci_dev *dev, int mask)
> -{
> -	struct resource *res;
> -	u16 cmd, oldcmd;
> -	int i;
> -
> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -	oldcmd =3D cmd;
> -
> -	pci_dev_for_each_resource(dev, res, i) {
> -		/* Only set up the requested stuff */
> -		if (!(mask & (1<<i)))
> -			continue;
> -
> -		if (res->flags & IORESOURCE_IO)
> -			cmd |=3D PCI_COMMAND_IO;
> -		if (res->flags & IORESOURCE_MEM)
> -			cmd |=3D PCI_COMMAND_MEMORY;
> -	}
> -
> -	if (cmd !=3D oldcmd) {
> -		pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
> -		pci_write_config_word(dev, PCI_COMMAND, cmd);
> -	}
> -	return 0;
> -}
> -
>  /* Platform support for /proc/bus/pci/X/Y mmap()s. */
>  int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *=
vma)
>  {
> diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
> index 25fe0a061732..3d54ad5656a4 100644
> --- a/arch/sparc/kernel/pcic.c
> +++ b/arch/sparc/kernel/pcic.c
> @@ -641,33 +641,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  	}
>  }
> =20
> -int pcibios_enable_device(struct pci_dev *dev, int mask)
> -{
> -	struct resource *res;
> -	u16 cmd, oldcmd;
> -	int i;
> -
> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -	oldcmd =3D cmd;
> -
> -	pci_dev_for_each_resource(dev, res, i) {
> -		/* Only set up the requested stuff */
> -		if (!(mask & (1<<i)))
> -			continue;
> -
> -		if (res->flags & IORESOURCE_IO)
> -			cmd |=3D PCI_COMMAND_IO;
> -		if (res->flags & IORESOURCE_MEM)
> -			cmd |=3D PCI_COMMAND_MEMORY;
> -	}
> -
> -	if (cmd !=3D oldcmd) {
> -		pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
> -		pci_write_config_word(dev, PCI_COMMAND, cmd);
> -	}
> -	return 0;
> -}
> -
>  /* Makes compiler happy */
>  static volatile int pcic_timer_dummy;

This change actually broke driver initialization on SPARC, see:

https://github.com/sparclinux/issues/issues/22

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

