Return-Path: <linux-pci+bounces-855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 867EE810DF1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 11:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8771F21199
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC08224C1;
	Wed, 13 Dec 2023 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="u8HkgpHu";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="JUUMUmi0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00367A7
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 02:10:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 2A8EAC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702462239; bh=1HO4KgChVWwyhvIE6hh+PkZPVElHbSYA9mybNOQfVBk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=u8HkgpHuwFj+9fwV7GuBlUURXRg4OLbHfjke/D0NkVNYZeD2JwFNtOx1/oKUY42Ad
	 gc/Ogr0gRcLPNWzOHneB5xijRhVpD1eGE/5TDjIlOPvEbXSC+AS3+vkgGyK2mnYwZJ
	 KWJnArjpqpHEEg8yuHtd3eunZ678a6/4ONLvt34wec8uF6+PUx2sQC3t8QPwWk7BaE
	 qwPL8kvo/27y8FHxJ2bkIodRQLMWm23sE+JdxnJdmX9sGoz+1VWs+4L1AzUNOHKx57
	 9tysGCo3wg52T22UYTI1acmkvdgfWTKXibmkbt6rhRNLedf5WX3qT7/GgMdcvAcnk0
	 2RMsLhHkfbdog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702462239; bh=1HO4KgChVWwyhvIE6hh+PkZPVElHbSYA9mybNOQfVBk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=JUUMUmi08pnaKXnk8KfIrNIaCo7PX0LvpNVuH3wQ7ECa+Nsmi+oHfN3TzRZT+MdGU
	 +EGA7j/7h9cvdVrc33CTv/woiMAHqQ0Flmdb7Rgv09nCcHziMKdKS4x/J7otTt3s8u
	 WSM+DkTIDiq+t6SdYZ+MQCsKORpelXnbMkr8FLcf/bdfDA21y6xtvjSZsB3QC3A8zG
	 KsmuSml7LqrI63y8LezxwEXq3EIjH5tuiT9JqBSx+uMxwQMjGjveyx2GD4z1rXciP5
	 4IIQFgkNl5zdodHe5Zjb96zK3zoVJPHTIuV1NQ4AEjHtlkW+Dr3SajzQoh3kB8zSn2
	 Np8GMyBSgCFHw==
Date: Wed, 13 Dec 2023 13:10:36 +0300
From: Nikita Proshkin <n.proshkin@yadro.com>
To: Martin =?UTF-8?B?TWFyZcWh?= <mj@ucw.cz>
CC: <linux-pci@vger.kernel.org>, <linux@yadro.com>, Sergei Miroshnichenko
	<s.miroshnichenko@yadro.com>
Subject: Re: [PATCH 04/15] pciutils-pcilmr: Add functions for device
 checking and preparations before main margining processes
Message-ID: <20231213131036.18840bb9.n.proshkin@yadro.com>
In-Reply-To: <mj+md-20231208.172608.28110.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
	<20231208091734.12225-5-n.proshkin@yadro.com>
	<mj+md-20231208.172608.28110.nikam@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

Hello Martin,
Thanks for the review!

On Fri, 8 Dec 2023 18:30:01 +0100
Martin Mare=C5=A1 <mj@ucw.cz> wrote:
=20
> > -all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) =
lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS)
> > +all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) =
lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS=
) lmr_lib/liblmr.a
>=20
> Is there any advantage with building LMR as a library instead of linking =
all
> the object files with the margining utility?

Actually, there are no advantages, I just thought that the Makefiles would
look more neat with this approach. I will redo the linking to make it=20
consistent with the lspci building.

> > +bool margin_prep_dev(struct margin_dev *dev)
> > +{
> > +  struct pci_cap *pcie =3D pci_find_cap(dev->dev, PCI_CAP_ID_EXP, PCI_=
CAP_NORMAL);
>=20
> What if it doesn't exist?

Nothing good at all. I will add more checks.

> > --- /dev/null
> > +++ b/lmr_lib/margin_hw.c
> > @@ -0,0 +1,85 @@
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <stdlib.h>
>=20
> Generally: Please add a comment to every source file, which explains the
> purpose of the file and contains a copyright notice. See existing files
> for the recommeneded format.
>=20
> > +  uint8_t down_type =3D pci_read_byte(down_port, PCI_HEADER_TYPE) & 0x=
7F;
> > +  uint8_t down_sec =3D pci_read_byte(down_port, PCI_SECONDARY_BUS);
> > +  uint8_t down_dir =3D (pci_read_word(down_port, cap->addr + PCI_EXP_F=
LAGS) & PCI_EXP_FLAGS_TYPE) >> 4;
>=20
> I would prefer using libpci types (u8, u32 etc.).
>=20
> > +  if (!(down_sec =3D=3D up_port->bus && down_type =3D=3D 1
>=20
> Please avoid whitespace at the end of line.
>=20
> > diff --git a/lmr_lib/margin_hw.h b/lmr_lib/margin_hw.h
> > new file mode 100644
> > index 0000000..a436d4b
> > --- /dev/null
> > +++ b/lmr_lib/margin_hw.h
> > @@ -0,0 +1,39 @@
> > +#ifndef _MARGIN_HW_H
> > +#define _MARGIN_HW_H
> > +
> > +#include <stdbool.h>
> > +#include <stdint.h>
> > +
> > +#include "../lib/pci.h"
>=20
> Please do not use relative paths to libpci header files.
> Instead, supply proper include path to CC in the Makefile.
>=20
> > +/*PCI Device wrapper for margining functions*/
>=20
> Please surround "/*" and "*/" by spaces as in existing source files.

Got it, I'll rework the code.

Best regards,
Nikita Proshkin

