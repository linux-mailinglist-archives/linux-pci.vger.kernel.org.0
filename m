Return-Path: <linux-pci+bounces-28088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B06EABD550
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6A11641BD
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2CE2571A7;
	Tue, 20 May 2025 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/YdffTD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D726C382;
	Tue, 20 May 2025 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737558; cv=none; b=oiff6OMxLe7SggGmKlxa6YvFZJQwJ9J2Ike4cb8XtCwQo4wwKyYRJIJ1+BC0M72M1ZbK+edCWfbpWQSxTZEP0LLU6gy6pzzPlHh6qYQ0oeZZ4tssp795pmwSOt3Yi7K6vRYipITetAtEH2GoT2Nco5Bux9UTGFho8vfUa9vLqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737558; c=relaxed/simple;
	bh=mYMylA2w4ZhvLJgkA2XzwHktV/OQfBpbjS+UEenJWx8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qq+FC2bTWErzS3/4C2Oalhsqd7fwrEa7uGMBc/SmXvNiFb5hC1GVNZPZ3rpClra+V3JhizI+Mw6usuTQUbuWqNi467qYuhs/FttJmZKLTUlM/Ye1UYlURW2FY8x7AnyS9xCQme/XaDscN0v5/n/Ir9GU7S77ppJqnKgJ+i/h2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/YdffTD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747737557; x=1779273557;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mYMylA2w4ZhvLJgkA2XzwHktV/OQfBpbjS+UEenJWx8=;
  b=i/YdffTD1+EIqdqBwOuTx2bx8AqUdX2n2o3F9i4R7GAt80ckrCmG2wVb
   6VZ2mxGR7NTW2ziPxxjuEHN4cz5jlmu8wDmTq7YDdKO4+sU39nfEeMCvc
   zkWle35lVKlwtV7LfNN9c9S/xI+3fBfnYNZa8EoJYS1SpYCHbGE/4lMvR
   UxGIduGvgoO5RDqdWm/kqhkz0eGNNvR171Wf1CV3pEM+Yp4Vu/kL/iK23
   WxHXyp8MCVuZ/5JCsf+7KbAUwxsrIlPBfU4FSvOXr6puqfL9Kjlev8xYD
   gJ4++w5CS9BLesb4/8sBZRNedmqrmUPYe+lwOGhR5ojYroH9+X1R5ADBX
   A==;
X-CSE-ConnectionGUID: TmNMDVlRS9CsEzqgMTcF7w==
X-CSE-MsgGUID: Zk8Opqj0TZaYJ0TCOe/rMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49819620"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49819620"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:39:16 -0700
X-CSE-ConnectionGUID: hll6pHgZRW2X/dz6jsfCFw==
X-CSE-MsgGUID: LFjoowSZTkSd1cwn0aN9tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140659956"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:39:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 13:39:06 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
    Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 07/16] PCI/AER: Initialize aer_err_info before using
 it
In-Reply-To: <20250519213603.1257897-8-helgaas@kernel.org>
Message-ID: <0d429918-b42c-5714-ef40-ce2a9e129a6b@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-8-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-824981395-1747737546=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-824981395-1747737546=:936
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Previously the struct aer_err_info "e_info" was allocated on the stack
> without being initialized, so it contained junk except for the fields we
> explicitly set later.
>=20
> Initialize "e_info" at declaration with a designated initializer list,
> which initializes the other members to zero.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 95a4cab1d517..40f003eca1c5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1281,7 +1281,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  =09=09struct aer_err_source *e_src)

Unrelated to this change, these would fit on a single line.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

>  {
>  =09struct pci_dev *pdev =3D rpc->rpd;
> -=09struct aer_err_info e_info;
> +=09u32 status =3D e_src->status;
> =20
>  =09pci_rootport_aer_stats_incr(pdev, e_src);
> =20
> @@ -1289,14 +1289,13 @@ static void aer_isr_one_error(struct aer_rpc *rpc=
,
>  =09 * There is a possibility that both correctable error and
>  =09 * uncorrectable error being logged. Report correctable error first.
>  =09 */
> -=09if (e_src->status & PCI_ERR_ROOT_COR_RCV) {
> -=09=09e_info.id =3D ERR_COR_ID(e_src->id);
> -=09=09e_info.severity =3D AER_CORRECTABLE;
> -
> -=09=09if (e_src->status & PCI_ERR_ROOT_MULTI_COR_RCV)
> -=09=09=09e_info.multi_error_valid =3D 1;
> -=09=09else
> -=09=09=09e_info.multi_error_valid =3D 0;
> +=09if (status & PCI_ERR_ROOT_COR_RCV) {
> +=09=09int multi =3D status & PCI_ERR_ROOT_MULTI_COR_RCV;
> +=09=09struct aer_err_info e_info =3D {
> +=09=09=09.id =3D ERR_COR_ID(e_src->id),
> +=09=09=09.severity =3D AER_CORRECTABLE,
> +=09=09=09.multi_error_valid =3D multi ? 1 : 0,
> +=09=09};
> =20
>  =09=09if (find_source_device(pdev, &e_info)) {
>  =09=09=09aer_print_source(pdev, &e_info, "");
> @@ -1304,18 +1303,14 @@ static void aer_isr_one_error(struct aer_rpc *rpc=
,
>  =09=09}
>  =09}
> =20
> -=09if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> -=09=09e_info.id =3D ERR_UNCOR_ID(e_src->id);
> -
> -=09=09if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
> -=09=09=09e_info.severity =3D AER_FATAL;
> -=09=09else
> -=09=09=09e_info.severity =3D AER_NONFATAL;
> -
> -=09=09if (e_src->status & PCI_ERR_ROOT_MULTI_UNCOR_RCV)
> -=09=09=09e_info.multi_error_valid =3D 1;
> -=09=09else
> -=09=09=09e_info.multi_error_valid =3D 0;
> +=09if (status & PCI_ERR_ROOT_UNCOR_RCV) {
> +=09=09int fatal =3D status & PCI_ERR_ROOT_FATAL_RCV;
> +=09=09int multi =3D status & PCI_ERR_ROOT_MULTI_UNCOR_RCV;
> +=09=09struct aer_err_info e_info =3D {
> +=09=09=09.id =3D ERR_UNCOR_ID(e_src->id),
> +=09=09=09.severity =3D fatal ? AER_FATAL : AER_NONFATAL,
> +=09=09=09.multi_error_valid =3D multi ? 1 : 0,
> +=09=09};
> =20
>  =09=09if (find_source_device(pdev, &e_info)) {
>  =09=09=09aer_print_source(pdev, &e_info, "");
>=20

--=20
 i.

--8323328-824981395-1747737546=:936--

