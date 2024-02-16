Return-Path: <linux-pci+bounces-3605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F9E857FEF
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 16:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C5E1C21489
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F230412F377;
	Fri, 16 Feb 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdTXJgrS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE7D12F37E
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095607; cv=none; b=QIYyD4TlrO+YL2tNfUFum8c8fWLQcdFa9JMNKBY24weG0HuPP1QZsJkbPWcKtOklHwJBsLh4OMp45nhcpE22j/2c2iM02SWBy1BsC8pCEfE1DBHJhj4k2Eg6kVkKhoNoJNeQv+421j1xP5iROPvSv37Kxp9j2Wvg21PAOS5BsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095607; c=relaxed/simple;
	bh=tKwL2vsOsZCXd2lZrOcTvfC4GWkDdbr3n8+pIzzNUhw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SDeSZR4Lw1wJNCpskuGgo3xzFdJxqfwFu95HdqJwJs4/C5EfrHgkFdoB5OoWjgwOyf9bclCDtoroxnqyC87hj80Kri4AB0sp3PPjkW15hWFVRo3v/zZBTgjKWNsr6gBId0D6WtnNkVJCKxBWkHtdi36Wloq41Jr2mH55xY9Bq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdTXJgrS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708095606; x=1739631606;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tKwL2vsOsZCXd2lZrOcTvfC4GWkDdbr3n8+pIzzNUhw=;
  b=HdTXJgrS9QVKOg/eSPWNEalZw0jEqzJ8j+CaLOv7/c29KBdxM3WltzaB
   7TnJt7Rb7stjDknISuLxAHg8p9H4T0JXekZyi5TZtF9GFRW11u3i6yGFx
   ZNC5MRE9mN5KbbFTHyoR+iZ9uZhqDcyGncBYYDWybqGaX+/EXxf8rKVsI
   IIlLidVpCecS2xl1pQ+H9/562gJKwTQWS1buvCqlVcK73436W5teyRmvx
   hG9Nox39pSrLEpyDGCJ+gTXxfNNuLnHhy8javFjlImG+CAZfbGQDKXN+i
   oTqgMcYzUcjUMEAZUF6F77knK4bRw96YVTLTEKdPksFSf3mhH5FJxe5f9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="19747423"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="19747423"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 07:00:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="8460422"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.234])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 07:00:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Feb 2024 16:59:57 +0200 (EET)
To: =?ISO-8859-15?Q?J=F6rg_Wedekind?= <joerg@wedekind.de>
cc: linux-pci@vger.kernel.org, aradford@gmail.com, linux@3ware.com
Subject: Re: [PATCH] drivers/pci: disable extension-tags on 3w-9xxx
 controller
In-Reply-To: <20240216105141.9607-1-joerg@wedekind.de>
Message-ID: <a22210a6-f9ea-d495-907d-1729dabc17fd@linux.intel.com>
References: <20240216105141.9607-1-joerg@wedekind.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-785550813-1708095597=:1097"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-785550813-1708095597=:1097
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Feb 2024, J=C3=B6rg Wedekind wrote:

Hi,

You need to provide a description here too, the shortlog in subject is not=
=20
enough.

--=20
 i.

> Signed-off-by: J=C3=B6rg Wedekind <joerg@wedekind.de>
> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d797df6e5f3e..2ebbe51a7efe 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5527,6 +5527,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
> =20
>  =09pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
>  }
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_=
tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_=
tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_=
tags);
>=20

--8323328-785550813-1708095597=:1097--

