Return-Path: <linux-pci+bounces-40322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B248C3488C
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 09:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B96A4F03CA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 08:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2602D9EE6;
	Wed,  5 Nov 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8yCRZJW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E652D94AC;
	Wed,  5 Nov 2025 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332312; cv=none; b=bauEzMwzXlBC5RsgwGVpnw8+KEIU0QebIOkGfAmarvTc8PiS/+pXd35a9IOR2ff0UooL91FRoRwrZwT+1ToSTeCN65t7eVEmi+poyHPa5SmjVhy/8EV/IqvOAPeUbe5WXps8EmAeK589xDdWMUYqlGO7SBgSnsZ7wfLMEU9XClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332312; c=relaxed/simple;
	bh=ONo3lQJBSG60YzvL0zPvRv2Ax2mJQO6EQfj7ir29EzU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dovbGD8wFMfqZCWCFc6GrgKf1pmKuDjrVI+9EbAmOnMy4ohj564KvlHlgVQRHxlEShbO9yDWpD9bp9MGcWFgraila2BL5KhYjVesTAMoWF3LQFv+Gio3mLbDG9NihkYKAMgVEqD67OJCaVvNpfUt6PyX0MCbg74D64N1/Eo0X50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8yCRZJW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762332310; x=1793868310;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ONo3lQJBSG60YzvL0zPvRv2Ax2mJQO6EQfj7ir29EzU=;
  b=X8yCRZJWiax7I/HiP4/p9fNJGjI5+PIPrPPkkKjg2/zWcbWI+XPwnQiZ
   zTYUMD3Wo3NvwRJTKQnUI1APDbqWlJ2xdd3v4hVEFTIQ7z7YdI8BdvgbQ
   UukktHLUh9rB6zUkWbP7jHzbWzkkvm9Lq7ABHGW6F10TaMUQZFkiXDIMu
   2eAk/cfIGv6sx/pUWDbnr409XtdiCvQKXP00M9P08SoyhIrdPqMeRHeHB
   iSG+sphQu2MhdNqADclwtTbn9070thU/rMwEKth1zw/dgalhejHkA1ZDd
   gxyr9urXhvBnWI9gKZI1tnfBQSzlh2yYpUYvAiO7rKa8+JuYDOkVFTtb0
   Q==;
X-CSE-ConnectionGUID: hwuDvibGQQa2GTp/0Yh4PA==
X-CSE-MsgGUID: NyeJIO/fS72sYBrsCFcQkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="74733631"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="74733631"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 00:45:10 -0800
X-CSE-ConnectionGUID: ncPN683IQSye5yDVr+RjIw==
X-CSE-MsgGUID: xh+mfx/bSs2+IRun1f1wig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187086212"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 00:45:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 5 Nov 2025 10:45:04 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v3 1/1] PCI: of: Relax max-link-speed check to support
 PCIe Gen5/Gen6
In-Reply-To: <6fdc4f2c-16fa-9aed-6580-759e229e5606@linux.intel.com>
Message-ID: <eba1f55e-3396-052c-0d77-09bf8b8c8216@linux.intel.com>
References: <20251101164132.14145-1-18255117159@163.com> <6fdc4f2c-16fa-9aed-6580-759e229e5606@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2034070910-1762332304=:33477"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2034070910-1762332304=:33477
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 5 Nov 2025, Ilpo J=E4rvinen wrote:

> On Sun, 2 Nov 2025, Hans Zhang wrote:
>=20
> > The existing code restricted `max-link-speed` to values 1~4 (Gen1~Gen4)=
,
> > but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 suppor=
t.
> >=20
> > While DT binding validation already checks this property, the code-leve=
l
> > validation in `of_pci_get_max_link_speed` also needs to be updated to a=
llow
> > values up to 6, ensuring compatibility with newer PCIe generations.
> >=20
> > Signed-off-by: Hans Zhang <18255117159@163.com>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> > Changes for v3:
> > - Modify the commit message.
> > - Add Reviewed-by tag.
> >=20
> > Changes for v2:
> > https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475=
861-1-18255117159@163.com/
> > - The following files have been deleted:
> >   Documentation/devicetree/bindings/pci/pci.txt
> >=20
> >   Update to this file again:
> >   dtschema/schemas/pci/pci-bus-common.yaml
> > ---
> >  drivers/pci/of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 3579265f1198..53928e4b3780 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -890,7 +890,7 @@ int of_pci_get_max_link_speed(struct device_node *n=
ode)
> >  =09u32 max_link_speed;
> > =20
> >  =09if (of_property_read_u32(node, "max-link-speed", &max_link_speed) |=
|
> > -=09    max_link_speed =3D=3D 0 || max_link_speed > 4)
> > +=09    max_link_speed =3D=3D 0 || max_link_speed > 6)
> >  =09=09return -EINVAL;
> > =20
> >  =09return max_link_speed;
> >=20
>=20
> Hi,
>=20
> IMO, using a literal here is somewhat annoying as it's hard to find this=
=20
> spot when adding support to the next PCIe Link Speed. It would be nice if=
=20
> it could get updated at the same while the generic support for a new Link=
=20
> Speed is added.
>=20
> Perhaps include/linux/pci.h should have something along the lines of:
>
> static inline int pcie_max_supported_link_speed()
> {
> =09return PCI_EXP_LNKCAP_SLS_64_0GB - PCI_EXP_LNKCAP_SLS_2_5GB + 1;
> }

=2E..Or maybe put it just to drivers/pci/pci.h instead.

> Then replace that 6 with pcie_max_supported_link_speed().
>=20
> So when the next speed get's added, somebody grepping for=20
> PCI_EXP_LNKCAP_SLS_64_0GB will find pcie_max_supported_link_speed() has=
=20
> to be changed and the change will propagate also to of.c.
>=20
>=20

--=20
 i.

--8323328-2034070910-1762332304=:33477--

