Return-Path: <linux-pci+bounces-23049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669E9A549B8
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 12:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F113B36DC
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2E120E338;
	Thu,  6 Mar 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBNNqyMr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D620E021;
	Thu,  6 Mar 2025 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260866; cv=none; b=dH8D6C03ivWV8wmiYCHlrPz4jQa/MzdNUFfP6a0ughA8+2we/h+JP6NEfa+h4tDdq00/CqL/VwR5np8awT22HBWocwU8YWzywE7bul1NZTgbG3yu8GpvY0vsh8fpO40ti68S7cH1GZVREN6Ir8YsCvr9tUGQwLeZ1pAGmKoxUtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260866; c=relaxed/simple;
	bh=sG9UqVSN67qctiywEj88yXs3h5wabdhNRlgIG3e9WeI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lx5qiY6ikNfkutkB2x2h7VMdAYld7U+Kw9UDMfaTjpvahj6J+MDvh73ElLkEU92waSjaaTigGs3cx+D9l0P/Kdq3WE/1Xr4iC0y7Py44MsKN98qr4ZJV/Uv7AmzhqqfvMBqdynYGPSvmJqu8fdq0/t4eS6U3mjfT2kE7jLfLHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBNNqyMr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741260865; x=1772796865;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=sG9UqVSN67qctiywEj88yXs3h5wabdhNRlgIG3e9WeI=;
  b=JBNNqyMr4Li9IFAmmLbU2znl3jkTWLLGTejx6ygDQ677MSHnNgECSWnW
   SwP9iWwx78cDc0cAOCkgEa/0Cov3M0jcAq33qF7LylPCkYM8eTGRyGuTz
   7dDFeQchTWxXKFcFhCJ97FY4fNUN/vWovOxCz4zEpG7g8JCvxbUqjzrbJ
   1JbmTX1oMNRmQuRBI0DvhK0Ts7iWXa5FvAXgkW7xVNWbylrLrY0rd16fL
   lw7x+BqV3U/x+9qcfwkSzNpJbDQPYZBRKlcUoFOHgqLckuH1Gg22IjXeb
   1maquPLlnP02DF7yyg6jnCzaBzlVYVsN4j2IWKr1AhAkK82AuFX4Cm835
   w==;
X-CSE-ConnectionGUID: 53oe671iT3ysn2BZ6evXTA==
X-CSE-MsgGUID: LwOt74MjRrOMj1f7GF8bAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42289303"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42289303"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:34:25 -0800
X-CSE-ConnectionGUID: WmSX0OoPQ2uhP7cxqsbrvQ==
X-CSE-MsgGUID: fzj9xWb8R5yPAObiGKbHqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118909936"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.218])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:34:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 6 Mar 2025 13:34:19 +0200 (EET)
To: Zhiyuan Dai <daizhiyuan@phytium.com.cn>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    bhelgaas@google.com
cc: cassel@kernel.org, christian.koenig@amd.com, helgaas@kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Update Resizable BAR Capability Register
 fields
In-Reply-To: <20250221010951.361570-1-daizhiyuan@phytium.com.cn>
Message-ID: <3a6952a9-c80b-bbff-fb38-18c61722bdda@linux.intel.com>
References: <Z7cjS7iuX655O7b3@ryzen> <20250221010951.361570-1-daizhiyuan@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-187422919-1741260772=:937"
Content-ID: <b5e14376-2b7d-df7e-27a7-89e2a6851abe@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-187422919-1741260772=:937
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <4b31e008-0bf0-6ed3-4bae-be34a76b8f5c@linux.intel.com>

On Fri, 21 Feb 2025, Zhiyuan Dai wrote:

> PCI Express Base Spec r6.0 defines BAR size up to 8 EB (2^63 bytes),
> but supporting anything bigger than 128TB requires changes to=20
> pci_rebar_get_possible_sizes() to read the additional Capability bits=20
> from the Control register.
>=20
> If 8EB support is required, callers will need to be updated to handle u64=
=20
> instead of u32. For now, support is limited to 128TB, and support for=20
> sizes greater than 128TB can be deferred to a later time.
>=20
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/pci.c             | 4 ++--
>  include/uapi/linux/pci_regs.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 661f98c6c63a..77b9ceefb4e1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3752,7 +3752,7 @@ static int pci_rebar_find_pos(struct pci_dev *pdev,=
 int bar)
>   * @bar: BAR to query
>   *
>   * Get the possible sizes of a resizable BAR as bitmask defined in the s=
pec
> - * (bit 0=3D1MB, bit 19=3D512GB). Returns 0 if BAR isn't resizable.
> + * (bit 0=3D1MB, bit 31=3D128TB). Returns 0 if BAR isn't resizable.
>   */
>  u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>  {
> @@ -3800,7 +3800,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev=
, int bar)
>   * pci_rebar_set_size - set a new size for a BAR
>   * @pdev: PCI device
>   * @bar: BAR to set size to
> - * @size: new size as defined in the spec (0=3D1MB, 19=3D512GB)
> + * @size: new size as defined in the spec (0=3D1MB, 31=3D128TB)
>   *
>   * Set the new size of a BAR as defined in the spec.
>   * Returns zero if resizing was successful, error code otherwise.
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index 1601c7ed5fab..ce99d4f34ce5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1013,7 +1013,7 @@
> =20
>  /* Resizable BARs */
>  #define PCI_REBAR_CAP=09=094=09/* capability register */
> -#define  PCI_REBAR_CAP_SIZES=09=090x00FFFFF0  /* supported BAR sizes */
> +#define  PCI_REBAR_CAP_SIZES=09=090xFFFFFFF0  /* supported BAR sizes */
>  #define PCI_REBAR_CTRL=09=098=09/* control register */
>  #define  PCI_REBAR_CTRL_BAR_IDX=09=090x00000007  /* BAR index */
>  #define  PCI_REBAR_CTRL_NBAR_MASK=090x000000E0  /* # of resizable BARs *=
/

pbus_size_mem() can only handle up to 8TB so its aligns array should be=20
enlarged as well to support sizes up to 128TB.

--=20
 i.
--8323328-187422919-1741260772=:937--

