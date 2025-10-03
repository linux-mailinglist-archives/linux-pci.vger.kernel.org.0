Return-Path: <linux-pci+bounces-37542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C54CBB7162
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 15:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C8764EA422
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A501C1ADB;
	Fri,  3 Oct 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcNmmF9p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C079B134BD;
	Fri,  3 Oct 2025 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759499831; cv=none; b=Sqd/CnqWPuOdJnVMaLD7924B4u6e6Df7zLKRuzpIjj9kcsKy4hTbE5b4DmeKiBBSiLrPjZu/0Ek9YUl4Qd48MiaWQj7cCt3G7Q4anOBfxy9dwRWC+ExlJ5AgQS/d6OwX7xu8eXP1hExQ07AQpvbjeBPg6X/btQtTlYhG5n800wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759499831; c=relaxed/simple;
	bh=TIL5B49MQtX8eA4jSS9b9Z1BGlh49nCaSMLJYFrGJIk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SemFYgtiGI8wavZm8J+LPLmHTmCLXnuY5Uy6Gqxe0C9Yzq3IX9XrABISMJ70yMz9hCwG0TkYTKDB8HUrn6mKjrmayJsAav/PM/flW+i+fqrEVMz09IXZLIC6bn/p0u2edoXIcXZRF0zTcCU/eHDNB6gWUEScfNOXs0ZupaMCrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcNmmF9p; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759499830; x=1791035830;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TIL5B49MQtX8eA4jSS9b9Z1BGlh49nCaSMLJYFrGJIk=;
  b=AcNmmF9pAphqsfJK11ZysPzdEWvIRH/5zu98iYUYa3xEjgqg8juYBoG1
   BIY+0W2MwquZCQd5L5pcVwspAnNu8mpxMxyhbXISTtlW5l5c/Sb/Qkis9
   eEBj8soYT96ol5u7ojB4NBEC5ioyrcpCJAGglCeIk0KnJVVQ9rrsm+/Ql
   8eqGtdNnfGwNKkj14oNOLElVl3gBjfi1bzX86wSlPo6KtSddE6qyQMdFO
   3JAR54W6Q6soXmI7OmG998eFoBWnVsnOvkHGKz4aMXsswJja9wEli8jJc
   /ofovbioEhEtlYjB6koJQF2z1XHcO5obbXpDYbMx0y+HVxXBNSI02zmll
   w==;
X-CSE-ConnectionGUID: p8dcd9AUQXKeijPZjs3Hwg==
X-CSE-MsgGUID: QqGYMpV8Rq+AcMXvU8UIQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="73209713"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="73209713"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 06:57:08 -0700
X-CSE-ConnectionGUID: gWrhJNxeS2GEexWejig4TA==
X-CSE-MsgGUID: tMI4O/ZTQfqmtKStwuJdwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="183578846"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.66])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 06:57:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 3 Oct 2025 16:57:01 +0300 (EEST)
To: Geert Uytterhoeven <geert+renesas@glider.be>
cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: Drop ARM dependency from PCI_RCAR_GEN2
In-Reply-To: <00f75d6732eacce93f04ffaeedc415d2db714cd6.1759480426.git.geert+renesas@glider.be>
Message-ID: <f2bbca79-8b96-2fff-48ba-64b4fd4372b3@linux.intel.com>
References: <00f75d6732eacce93f04ffaeedc415d2db714cd6.1759480426.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-921359581-1759499821=:1157"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-921359581-1759499821=:1157
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 3 Oct 2025, Geert Uytterhoeven wrote:

> Since the reliance on ARM-specific struct pci_sys_data was removed, this
> driver can be compile-tested on other architectures.
>=20
> While at it, make the help text a bit more generic, as some members of
> the R-Car Gen2 family have a different number of internal PCI
> controllers.
>=20
> Suggested-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
> Fixes: 4a957563fe0231e0 ("PCI: rcar-gen2: Convert to use modern host brid=
ge probe functions")

I'm not sure if fixes tag is warranted for "fixing" COMPILE_TEST.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pci/controller/Kconfig | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index 9f9d0c93cb461831..4c15caa1f1798ebb 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -259,12 +259,11 @@ config PCIE_RCAR_EP
> =20
>  config PCI_RCAR_GEN2
>  =09bool "Renesas R-Car Gen2 Internal PCI controller"
> -=09depends on ARCH_RENESAS || COMPILE_TEST
> -=09depends on ARM
> +=09depends on (ARCH_RENESAS && ARM) || COMPILE_TEST
>  =09help
>  =09  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
> -=09  There are 3 internal PCI controllers available with a single
> -=09  built-in EHCI/OHCI host controller present on each one.
> +=09  Each internal PCI controller contains a single built-in EHCI/OHCI
> +=09  host controller.
> =20
>  config PCIE_ROCKCHIP
>  =09bool
>=20

--=20
 i.

--8323328-921359581-1759499821=:1157--

