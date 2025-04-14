Return-Path: <linux-pci+bounces-25833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5841AA88108
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 15:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A011882CBA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458765227;
	Mon, 14 Apr 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJJ9i6Yc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0471482E7;
	Mon, 14 Apr 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635691; cv=none; b=ZGHLtudTxgi+oN0yoIRGxADLsKr2ZppWb04UcXx7+3fPjUlsKw3HRHReCrgL0ase/yOW3LnKp1qUe5JNdSKI2Zc3TazafmljkaLqkzvrJ1fAHYXKsFOC8B32H4zyD/wYrDA6/ZfmD9bHpNlbml5huXfxam99FYrLIvavF1whVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635691; c=relaxed/simple;
	bh=TvT6KZOm7khG7yOX2mT8/OUHx94BznZi+RP/jNeSTik=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UvLHjcLCmAR9VypK+pgfkb1sADKGgz5PkRdjzvVTIY2eZ3e91GKpx2lWJ6dNVheI4ctEYQHCmtbe5rL1nMd5PsHwe6OVMQGQWaqTQkZexcJjhpRcEkwBfqZAeX0oDOz4CWpOWTdOFY7mb0hLJsROVc/b6biCUSzgOFQVPWy74xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJJ9i6Yc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744635690; x=1776171690;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TvT6KZOm7khG7yOX2mT8/OUHx94BznZi+RP/jNeSTik=;
  b=SJJ9i6Yc6TyJNOfF6N7rDLU3gE4sGYuzb2lf9bz7YbGgQW3Nc4SqUlIQ
   aThPkYv4GwFLbQUrq3jEpvM7ohqGo1a2trI9bVUmPVU4RXnyChZOGFi7j
   tkoonynBUvT3nOELXp/Kjj/C2Kyd/6dQeXvGZnYsyBf0iEimo3vkQ79Hl
   AmHkWVC3/D3CUWu9jOEviWga8A0s4OsnUsHAPqnsW8IA0tVShJp2RWvUk
   gc3/IbbTmRiMfiyL593aSFSKtbMyN+6fnI2SV5uIUbV2DLAGgWc9eXE1P
   MXvS/Qz0E0wx1g0cDZjCn43l51zT0ANrrprcWxb8E8BMSaWkhJSRwg98M
   g==;
X-CSE-ConnectionGUID: GJYU/GCxQKeXBaNQyPhHCg==
X-CSE-MsgGUID: sUAApCIISWOKLZAf9u7oBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46192989"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="46192989"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:01:28 -0700
X-CSE-ConnectionGUID: HjakGuZXQIm9xRmzrj6KBg==
X-CSE-MsgGUID: KEpAqU9zTRWnlvq1ckZmIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="166984908"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:01:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 14 Apr 2025 16:01:21 +0300 (EEST)
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
cc: bhelgaas@google.com, Mika Westerberg <mika.westerberg@linux.intel.com>, 
    sathyanarayanan.kuppuswamy@linux.intel.com, Lukas Wunner <lukas@wunner.de>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    alistair.francis@wdc.com, wilfred.mallawa@wdc.com, dlemoal@kernel.org, 
    cassel@kernel.org
Subject: Re: [PATCH v2] PCI: fix the printed delay amount in info print
In-Reply-To: <20250414001505.21243-2-wilfred.opensource@gmail.com>
Message-ID: <01ff78f6-0708-4556-1fce-69250d625b2b@linux.intel.com>
References: <20250414001505.21243-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-482290908-1744635681=:10563"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-482290908-1744635681=:10563
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 14 Apr 2025, Wilfred Mallawa wrote:

> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> Print the delay amount that pcie_wait_for_link_delay() is invoked with
> instead of the hardcoded 1000ms value in the debug info print.
>=20
> Fixes: 7b3ba09febf4 ("PCI/PM: Shorten pci_bridge_wait_for_secondary_bus()=
 wait time for slow links")
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..8139b70cafa9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4935,7 +4935,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_de=
v *dev, char *reset_type)
>  =09=09delay);
>  =09if (!pcie_wait_for_link_delay(dev, true, delay)) {
>  =09=09/* Did not train, no need to wait any further */
> -=09=09pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n"=
);
> +=09=09pci_info(dev, "Data Link Layer Link Active not set in %d msec\n", =
delay);
>  =09=09return -ENOTTY;
>  =09}
> =20
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-482290908-1744635681=:10563--

