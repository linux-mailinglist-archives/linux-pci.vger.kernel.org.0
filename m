Return-Path: <linux-pci+bounces-15328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4FA9B0756
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 17:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFDD0B269D7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEFC21A4B2;
	Fri, 25 Oct 2024 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgQicLib"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285F21A4BA;
	Fri, 25 Oct 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868773; cv=none; b=JM3YTbYa+Igu0ndbFoqImcb9Hp/v+GW7xp1XdKcV/ljZ5NC1IZ9SJZlndEBSQw1k92NzAGMa6DnguM4tMG/Z7oAFirReLtrL46WLFrePX3WEkPGR91X4EI/C6S9GJz7ho/ZJQm7cIqq1o/FxLFS/StPbroKMDiaaU30eddB6dng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868773; c=relaxed/simple;
	bh=HYcim8H2ynwOPOAP7PsjJGiBx5A4govUlPOK1DhGMgM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tcKP7Asub+74m+FdGgt0ZpN+KtPunBSarMPj48x2f91bjPv6obj/ZX9bbxDZ/B6H9+gCD+s8LlrAiQD6LeZBozMYv0HZvHAiXdEzaAVuAXrM34lIUVnVRyV1tnkNtgyBRPM0hHKIaK7+ebUllnFcysvf0EmgaGscjZlzyV2Ij00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgQicLib; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729868771; x=1761404771;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HYcim8H2ynwOPOAP7PsjJGiBx5A4govUlPOK1DhGMgM=;
  b=CgQicLib50hAlsfKzeozjp0WBgYFZdlFV+Th8kCs7fsvu94PTRBKyeWn
   edDWNCNFkxiDMDi19BxUJ3Uv0FhGjKzdoWRGrsjXU0GNWYp37M/8Zt3BS
   IntMj/p1NvpyMEtkVXkIBPEHymuypSkU9jiWLTqlNtGboxQAJBRD61VhS
   Ab113DI7+9RsNPN/mjNhQYHISOIPRuTuAeFyAzBpAoLqQX3YrXr7dAXNq
   mcZ2uE+wabI1RMdlsxPgUb+AXRlN4MZktmSVjcGHcPCMbTc/Kt5UANUEJ
   6aSny0aH4QD9btSqdGcwnWp8UwE6y0c7yom2G1Gcbh93WdYGXggD0sjs1
   w==;
X-CSE-ConnectionGUID: Z2zaYzUFSxmmcY+bRemLlQ==
X-CSE-MsgGUID: ZRsmzDbSSgiepg+eVNwPOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29436550"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="29436550"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:06:10 -0700
X-CSE-ConnectionGUID: /OXIP+vcT06p1iEzBOi/7w==
X-CSE-MsgGUID: 38UJhyRCRO2U0gUnNnfMgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80962169"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:05:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 18:05:53 +0300 (EEST)
To: Philipp Stanner <pstanner@redhat.com>
cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
    Niklas Cassel <cassel@kernel.org>, 
    Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
    Herbert Xu <herbert@gondor.apana.org.au>, 
    "David S. Miller" <davem@davemloft.net>, 
    Boris Brezillon <bbrezillon@kernel.org>, 
    Arnaud Ebalard <arno@natisbad.org>, Srujana Challa <schalla@marvell.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
    Kalle Valo <kvalo@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, 
    Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
    Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    Kevin Cernekee <cernekee@gmail.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
    Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, 
    David Lechner <dlechner@baylibre.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    Jie Wang <jie.wang@intel.com>, Tero Kristo <tero.kristo@linux.intel.com>, 
    Adam Guerin <adam.guerin@intel.com>, 
    Shashank Gupta <shashank.gupta@intel.com>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    Bharat Bhushan <bbhushan2@marvell.com>, 
    Nithin Dabilpuram <ndabilpuram@marvell.com>, 
    Johannes Berg <johannes.berg@intel.com>, 
    Emmanuel Grumbach <emmanuel.grumbach@intel.com>, 
    Gregory Greenman <gregory.greenman@intel.com>, 
    Benjamin Berg <benjamin.berg@intel.com>, 
    Yedidya Benshimol <yedidya.ben.shimol@intel.com>, 
    Breno Leitao <leitao@debian.org>, 
    Florian Fainelli <florian.fainelli@broadcom.com>, 
    linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-ide@vger.kernel.org, qat-linux@intel.com, 
    linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org, 
    ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>, linux-sound@vger.kernel.org
Subject: Re: [PATCH 01/10] PCI: Make pcim_request_all_regions() a public
 function
In-Reply-To: <20241025145959.185373-2-pstanner@redhat.com>
Message-ID: <0eb50380-c5f9-b770-65d0-8dba14711b5a@linux.intel.com>
References: <20241025145959.185373-1-pstanner@redhat.com> <20241025145959.185373-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-698933625-1729868753=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-698933625-1729868753=:946
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 25 Oct 2024, Philipp Stanner wrote:

> In order to remove the deprecated function
> pcim_iomap_regions_request_all(), a few drivers need an interface to
> request all BARs a PCI-Device offers.

Hi Philipp,

I don't know why you put that dash there, it looks a bit odd. Other than=20
that,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> Make pcim_request_all_regions() a public interface.
>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/devres.c | 3 ++-
>  include/linux/pci.h  | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index b133967faef8..2a64da5c91fb 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -939,7 +939,7 @@ static void pcim_release_all_regions(struct pci_dev *=
pdev)
>   * desired, release individual regions with pcim_release_region() or all=
 of
>   * them at once with pcim_release_all_regions().
>   */
> -static int pcim_request_all_regions(struct pci_dev *pdev, const char *na=
me)
> +int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
>  {
>  =09int ret;
>  =09int bar;
> @@ -957,6 +957,7 @@ static int pcim_request_all_regions(struct pci_dev *p=
dev, const char *name)
> =20
>  =09return ret;
>  }
> +EXPORT_SYMBOL(pcim_request_all_regions);
> =20
>  /**
>   * pcim_iomap_regions_request_all - Request all BARs and iomap specified=
 ones
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be6..3b151c8331e5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2293,6 +2293,7 @@ static inline void pci_fixup_device(enum pci_fixup_=
pass pass,
>  =09=09=09=09    struct pci_dev *dev) { }
>  #endif
> =20
> +int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
>  void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long ma=
xlen);
>  void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
>  =09=09=09=09const char *name);
>=20
--8323328-698933625-1729868753=:946--

