Return-Path: <linux-pci+bounces-37934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0901BD51FD
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9116318A5286
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A870B2C21C3;
	Mon, 13 Oct 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6nZ1NT6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F328D83E
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373582; cv=none; b=lo2cdifIlR9URIO4RwWTZz3JYzKstvGLe2ywT8UhtpYK5DBXNVtUCOl44csF/cXt9+/goFVoeAf0SoNBJ1lw4hahFH8j/50uHcAk/Wm7ybyS/lJqErQXHAxqGJ6/4qikUkhpbvTvV9TIWYd3boP9Bk8e09L7Pi2Syjnez+zANb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373582; c=relaxed/simple;
	bh=i/hiNKAuoibeo9OMvwYn5oMnRpXztBEJ1t/LyxW9bQs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tos0pgF+SVLhcdm6+FlU2442TSqVwmFYiR4QSuJsDNYumwHUeWIqB78uQNEgfU70r5No2ZYedKDoywWsvoTWwhY5h9gbGqtbWi4bcTZbZPysxzl5dIT7L252UT8NSQ5atRufgYcN5qqwF6tq2bTi8osfs/XpHQw9thQEK5CMiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6nZ1NT6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760373580; x=1791909580;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i/hiNKAuoibeo9OMvwYn5oMnRpXztBEJ1t/LyxW9bQs=;
  b=C6nZ1NT6YCH4yFeO77J73mF8/hh8hmih35ooWmgNojbvuLmJgdD3JDPS
   7H7LxTj0zqI0bBILgaHX0JdhAs+wNfH2jffVfVcqid5EkJK2B7gDDC6O8
   /qpHggvdwsogNIoM6A0cRvDySU5+fniR9jemfA4uXKTPUw97TGvRNf4fq
   mKyugxD+lFBPCIA+Vt3U39z6AIq8AtH32uLy1+vyDohion2wzfpBsB9Lu
   4oiy99I4ImKHoTHA3e4lbIquBXidOHjLNoppRmSMnMmQl6q5UT4j5/SAM
   DhFXYne5s4elLFgn4ZnjnvrDSGH2jP2yG0/p+giITvEsmDN30qYMGjlaZ
   A==;
X-CSE-ConnectionGUID: 88URaKZmSqeq2FLwet5VRg==
X-CSE-MsgGUID: 6C61po9NTfWhmPLhjbUpCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61725411"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="61725411"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:39:26 -0700
X-CSE-ConnectionGUID: xmKvltDLRAGccCmIur+UMg==
X-CSE-MsgGUID: BCK3jwjhR6iBpEMEjDjHwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="182408186"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.77])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:39:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Oct 2025 19:39:20 +0300 (EEST)
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
cc: mario.limonciello@amd.com, bhelgaas@google.com, tzimmermann@suse.de, 
    Eric Biggers <ebiggers@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/VGA: Select SCREEN_INFO
In-Reply-To: <20251013154441.1000875-1-superm1@kernel.org>
Message-ID: <85690357-f7c2-5be0-d31e-1617aec3e950@linux.intel.com>
References: <20251013154441.1000875-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1785228779-1760373560=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1785228779-1760373560=:933
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 13 Oct 2025, Mario Limonciello (AMD) wrote:

> commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
> a screen info check") introduced an implicit dependency upon SCREEN_INFO
> by removing the open coded implementation.
>=20
> If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
> would now return false.  Add a select for SCREEN_INFO to ensure that the
> VGA arbiter works as intended. Also drop the now dead code.
>=20
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a =
screen info check")
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v2:
>  * drop dead code (Ilpo)
> ---
>  drivers/pci/Kconfig  | 1 +
>  drivers/pci/vgaarb.c | 8 +-------
>  2 files changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 7065a8e5f9b14..c35fed47addd5 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -306,6 +306,7 @@ config VGA_ARB
>  =09bool "VGA Arbitration" if EXPERT
>  =09default y
>  =09depends on (PCI && !S390)
> +=09select SCREEN_INFO
>  =09help
>  =09  Some "legacy" VGA devices implemented on PCI typically have the sam=
e
>  =09  hard-decoded addresses as they did on ISA. When multiple PCI device=
s
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index b58f94ee48916..8c8c420ff5b55 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -556,13 +556,7 @@ EXPORT_SYMBOL(vga_put);
> =20
>  static bool vga_is_firmware_default(struct pci_dev *pdev)
>  {
> -#ifdef CONFIG_SCREEN_INFO
> -=09struct screen_info *si =3D &screen_info;
> -
> -=09return pdev =3D=3D screen_info_pci_dev(si);
> -#else
> -=09return false;
> -#endif
> +=09return pdev =3D=3D screen_info_pci_dev(&screen_info);
>  }
> =20
>  static bool vga_arb_integrated_gpu(struct device *dev)

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1785228779-1760373560=:933--

