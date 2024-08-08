Return-Path: <linux-pci+bounces-11503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12694C283
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 18:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB4E1C22B27
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F389618B47A;
	Thu,  8 Aug 2024 16:20:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3701A269;
	Thu,  8 Aug 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134037; cv=none; b=Qc/+UIQWgkiImKKNaY1Ovpy4F4elzZdyOjkn+TxUq2W4KHbxW92EfkihSAo+n+wKZESGkA52BoWSGWTefzeyX3xd7mIH6YAtLbhOSjXVXOqdQvaatI4we2UyCd+qQ1kxt9DrB8f5OjxCuTom82LHkDwZAS6xHJc3m1cQRKTqGU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134037; c=relaxed/simple;
	bh=uUFZmNG7KZC90pIUDOI51+FHQt5jYILjr8zsdF5VOlw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7g8/6C8rrsJMqgfpMQL1wIsp0agTin+QptWuiCepWojLroSXAwgVGNrv0YTRTmAslFhQDRWuLF5FyyngkzrAZMvIS/6jpuJYsQL/gPuW8HR3iL6KlPBFUYih+iP8DNcK0pow3OaaUb6DX2S1Ne19851yyzvfXT1ciaFWiIir9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WfsdV2dZ1z6K6Kb;
	Fri,  9 Aug 2024 00:17:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E3BA5140A70;
	Fri,  9 Aug 2024 00:20:31 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 8 Aug
 2024 17:20:31 +0100
Date: Thu, 8 Aug 2024 17:20:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <412574090@163.com>
CC: <helgaas@kernel.org>, <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<xiongxin@kylinos.cn>
Subject: Re: [PATCH] PCI: Add PCI_EXT_CAP_ID_PL_64GT define
Message-ID: <20240808172030.00006950@Huawei.com>
In-Reply-To: <20240808021239.24428-1-412574090@163.com>
References: <20240806175905.GA70868@bhelgaas>
	<20240808021239.24428-1-412574090@163.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  8 Aug 2024 10:12:39 +0800
412574090@163.com wrote:

> > On Tue, Aug 06, 2024 at 10:27:46AM +0800, 412574090@163.com wrote: =20
> > > From: weiyufeng <weiyufeng@kylinos.cn>
> > >=20
> > > PCIe r6.0, sec 7.7.7.1, defines a new 64.0 GT/s PCIe Extended Capabil=
ity
> > > ID,Add the define for PCI_EXT_CAP_ID_PL_64GT for drivers that will wa=
nt
> > > this whilst doing Gen6 accesses.
> > >=20
> > > Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
> > > ---
> > >  include/uapi/linux/pci_regs.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_r=
egs.h
> > > index 94c00996e633..cc875534dae1 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -741,6 +741,7 @@
> > >  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
> > >  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> > >  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s =
*/
> > > +#define PCI_EXT_CAP_ID_PL_64GT  0x31    /* Physical Layer 64.0 GT/s =
*/ =20
> >
> > It probably makes sense to add this (with the corrections noted by
> > Ilpo), but I *would* like to see where it's used.
> >
> > I asked a similar question at
> > https://lore.kernel.org/all/20230531095713.293229-1-ben.dooks@codethink=
.co.uk/
> > when we added PCI_EXT_CAP_ID_PL_32GT, but never got a specific
> > response.  I don't really want to end up with drivers doing their own
> > thing if it's something that could be done in the PCI core and shared.
> > =20
> PCI_EXT_CAP_ID_PL_32GT and PCI_EXT_CAP_ID_PL_64GT have not used now,but=20
> PCI_EXT_CAP_ID_PL_16GT have usage example,in drivers/pci/controller/dwc/p=
cie-tegra194.c
> function config_gen3_gen4_eq_presets():
>=20
> offset =3D dw_pcie_find_ext_capability(pci,
> 				     PCI_EXT_CAP_ID_PL_16GT) +
> 		PCI_PL_16GT_LE_CTRL;
>=20
> PCI_EXT_CAP_ID_PL_32GT and PCI_EXT_CAP_ID_PL_64GT could be used while nee=
d to
> get this similar attribute=E3=80=82

I'll bite.  In PCI_EXTE_CAP_ID_PL_32GT PCIe 6.1 which I happen to have
open has some writeable fields in the control register.  So
kind of fair enough a driver might write them.  In my view we should
probably have waited for such a use to turn up.

The Physical Layer 64.0 GT/s Extended Capability control register is
entirely reserved. So as of now, I don't see a use for this capability
until the PCIe spec adds something.

>=20
> > >  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> > >  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> > > =20
> > > --=20
> > > 2.25.1
> > >  =20
> --
> Thanks,
>=20
> weiyufeng
>=20
>=20


