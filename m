Return-Path: <linux-pci+bounces-7199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B450C8BEE1A
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 22:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0F91C2439E
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FE8187354;
	Tue,  7 May 2024 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLtd2/ls"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C318732B;
	Tue,  7 May 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113708; cv=none; b=FWSOqnmh5Q6pcXEhBSTTLt3Ynm/a7Q/1Gvp03XGSP9uA3B/OLGCeHuxDYBwhk+A2WTPm7RoioCpgasoWBKTU2UVGSGIUqc/08308byejgmQ6ehuBr7hrsP24i1TaE861Fky09o/mW0cKGZwOWP7HtvPahHckGAmmnW1hQ7vi+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113708; c=relaxed/simple;
	bh=LfmeZUvusvEypHJY/DxXRviyNr7UBcxM6dNBwCdT3AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTXGSbhdZRiXQhL52b/4GPSTVW4R8Nd8Lho6B6LJnYkSxJScs1emgqN4vkIBDYAucMyeicb5thleojdbIn1jbcXeLg/B8YT3bGWrh9/BvmYCgoQcBJBZROAeuhC1pcPS+UAh/+8drcMRGV/wPo/0wU9ol8bxo85evapjNKq5Kms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLtd2/ls; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso1455361fa.0;
        Tue, 07 May 2024 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715113702; x=1715718502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPy8ompmPldCNZipueALFh52GpJRRGRwg2FLSF4D2Bs=;
        b=BLtd2/lsq5z1J6RQdLqKMGMpgg6O6jLiurc/asEf4KWkB6+m47F4J0FC12y/3BrZnP
         gXnTnddUR9Le3+3rQrJ7tJoEakhqBXGxbEzIctkmBSe9Q/t8K/v02wrSA/vqOXSkH0g9
         XT3lspgHncv6pI588944o56jOTA+jcO4SMYXvk6d/yt5F1vCMsIm1Xtgr7h92EjS99kp
         RNjHkqExjSxlmCeCBN+l3Mxj8T5IjRhD4vCJS2MWMOQjtrqphxCv/CGmrBFnntOt+FfA
         oKWHPHuDXkKOfVXIlHtz9d1WrBGRTFgp5Zud9m+FPioLMGq6Nj5o1+2Zcw8bS05kLHuu
         x0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715113702; x=1715718502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPy8ompmPldCNZipueALFh52GpJRRGRwg2FLSF4D2Bs=;
        b=k7SoPIOQBFPuN0P9o3NxWJ6MwEOUUFR/wn2GwCnyxavBWR/d0uvN57vEuYCuTsQos7
         XQi5SMfU7I+1Y+9dgy71xpUDCEH06fEPS/ZeVMamDdiYAukXGRm/YWfjMuplx8HU42/S
         knk2I46i/hwBCOxbNB/PdZQh2mZj+lgvJlqJNtNLTCYv1sSXkHxO287woi3bvUUDrwWo
         8apBgEvlUkjQNIHKQNNtR/1Jw30VFmxcSgJvkC4mx2f9jlYHCWQ657So5PhEzAsluFyN
         iJiOejzObxQ8x4EMPY9diDOLXIunTvzPgD5Fyp5UxOoe8cL95a2CiozOfiFf2sl7YDOI
         3Ggw==
X-Forwarded-Encrypted: i=1; AJvYcCWydyVSWd8DR0Hx9eUGrd/j43P5NpDQLtQunY9GGrx0RkINls+Gl9PjzS5YMZdxN3uCdWRrAdjpCtCQz7Uzp/pnowqHt4KMjVYmVgYRNDNDDSnO28LkGsXXdrs44JZVU8wFvBFEzQKhPsnl
X-Gm-Message-State: AOJu0YxxXadi7Tjv75UpDpigGr++ZRjbAiV3/mSYlKqxLU9GknmwnD1m
	C7izcyOFVldAS8lYrtpOiFFwn5rRKbhlpn683iUrBsgfdjMPEqRKOJbRj8aZZ+KkhSP6Ire06xX
	zkDm4kAxEbnB0sA6aACkhrzKuz49oQA==
X-Google-Smtp-Source: AGHT+IF6cBtdRDx8VBCdMSTQP3botVT52qFdDBeXlCnojiOMSPAJhQ+B3s4ra8mbu40+b2pE5qfdgGLm9TD43wkmk8Q=
X-Received: by 2002:a2e:7215:0:b0:2e1:ff62:d92 with SMTP id
 38308e7fff4ca-2e3d9b88cfamr11498231fa.19.1715113701763; Tue, 07 May 2024
 13:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328111904.992068-1-kiran.k@intel.com> <20240328111904.992068-2-kiran.k@intel.com>
 <0e701a78-201e-4eee-9f1d-e17774a96c99@molgen.mpg.de> <PH0PR11MB75854D378E8E4234EF9D9EE8F5E42@PH0PR11MB7585.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB75854D378E8E4234EF9D9EE8F5E42@PH0PR11MB7585.namprd11.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 May 2024 16:28:08 -0400
Message-ID: <CABBYNZJDceiMGeWQdWwRjoBviSOGuGyBmK=yOkyhtU810W0o3Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] Bluetooth: btintel_pcie: Add support for PCIE transport
To: "K, Kiran" <kiran.k@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, "Von Dentz, Luiz" <luiz.von.dentz@intel.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, 
	"Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>, "An, Tedd" <tedd.an@intel.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, May 7, 2024 at 9:48=E2=80=AFAM K, Kiran <kiran.k@intel.com> wrote:
>
> Hi Paul,
>
> Appreciate your comments :).
>
> > -----Original Message-----
> > From: Paul Menzel <pmenzel@molgen.mpg.de>
> > Sent: Thursday, March 28, 2024 5:55 PM
> > To: K, Kiran <kiran.k@intel.com>
> > Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar
> > <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> > <chethan.tumkur.narayan@intel.com>; An, Tedd <tedd.an@intel.com>; linux=
-
> > pci@vger.kernel.org
> > Subject: Re: [PATCH v1 2/3] Bluetooth: btintel_pcie: Add support for PC=
IE
> > transport
> >
> > Dear Tedd, dear Kiran,
> >
> >
> > Thank you for the patch. What a diffstat. ;-) Nice work.
> >
> > Am 28.03.24 um 12:19 schrieb Kiran K:
> > > From: Tedd Ho-Jeong An <tedd.an@intel.com>
> > >
> > > Add initial code to support Intel bluetooth devices based on PICE
> > > transport. This patch allocates memory for buffers, internal structur=
es,
> > > initializes interrupts for TX & RX and initializes PCIE device.
> >
> > For a 1782 diffstat this is quite terse. Could you elaborate?
> >
> > Also, it=E2=80=99d be great if you mentioned the datasheet, and how you=
 tested
> > this. Maybe even paste the new log messages.
> >
> Datasheet details are internal to Intel. Sorry I can't provide those deta=
ils. But surely I will add kernel logs and output of hciconfig -a.
>
> > Also how well does the driver perform? What tools did you run to verify
> > the correctness und the =E2=80=9Cspeed=E2=80=9D?
> This driver has been tested on silicon (BT Filmore Peak2).  Not sure of a=
ny tools to test the speed. Pls suggest if any.  I will run the same and sh=
are the data.
> >
> > > Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> > > Co-developed-by: Kiran K <kiran.k@intel.com>
> > > Signed-off-by: Kiran K <kiran.k@intel.com>
> > > ---
> > >   drivers/bluetooth/Kconfig        |   14 +
> > >   drivers/bluetooth/Makefile       |    1 +
> > >   drivers/bluetooth/btintel.h      |    2 +-
> > >   drivers/bluetooth/btintel_pcie.c | 1317
> > ++++++++++++++++++++++++++++++
> > >   drivers/bluetooth/btintel_pcie.h |  449 ++++++++++
> > >   5 files changed, 1782 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/bluetooth/btintel_pcie.c
> > >   create mode 100644 drivers/bluetooth/btintel_pcie.h
> >
> > Should an entry be added to `MAINTAINERS`? It=E2=80=99d be good to ment=
ion in
> > the commit message, who the maintainer is.
> Individual files under drivers/bluetooth/ are not updated in  MAINTAINERS=
.  There is "F:      drivers/bluetooth/" entry present. I haven't added any=
 files in the past.
> @Von Dentz, Luiz - Any comments here ?

That should fallback to driver/bluetooth/ maintainers so it should be
fine since myself and Marcel are listed there.

>
> >
> > >
> > > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> > > index bc211c324206..387f7b14461d 100644
> > > --- a/drivers/bluetooth/Kconfig
> > > +++ b/drivers/bluetooth/Kconfig
> > > @@ -23,6 +23,20 @@ config BT_MTK
> > >     tristate
> > >     select FW_LOADER
> > >
> > > +config BT_INTEL_PCIE
> > > +   tristate "Intel Bluetooth transport driver for PCIe"
> >
> > In the commit message summary you spell it PCIE. Please be consistent.
> >
> Ack.
>
> > > +   depends on PCI
> > > +   select BT_INTEL
> > > +   select FW_LOADER
> > > +   default y
> > > +   help
> > > +     Intel Bluetooth transport driver for PCIe.
> > > +     This driver is required if you want to use Intel Bluetooth devi=
ce
> > > +     with PCIe interface.
> > > +
> > > +     Say Y here to compiler support for Intel Bluetooth PCIe device =
into
> > > +     the kernel or say M to compile it as module (btintel_pcie)
> > > +
> > >   config BT_HCIBTUSB
> > >     tristate "HCI USB driver"
> > >     depends on USB
> > > diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> > > index 7a5967e9ac48..0730d6684d1a 100644
> > > --- a/drivers/bluetooth/Makefile
> > > +++ b/drivers/bluetooth/Makefile
> > > @@ -17,6 +17,7 @@ obj-$(CONFIG_BT_HCIBTUSB) +=3D btusb.o
> > >   obj-$(CONFIG_BT_HCIBTSDIO)        +=3D btsdio.o
> > >
> > >   obj-$(CONFIG_BT_INTEL)            +=3D btintel.o
> > > +obj-$(CONFIG_BT_INTEL_PCIE)        +=3D btintel_pcie.o btintel.o
> > >   obj-$(CONFIG_BT_ATH3K)            +=3D ath3k.o
> > >   obj-$(CONFIG_BT_MRVL)             +=3D btmrvl.o
> > >   obj-$(CONFIG_BT_MRVL_SDIO)        +=3D btmrvl_sdio.o
> > > diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.=
h
> > > index 1462a57420a0..5d4685b5c1fa 100644
> > > --- a/drivers/bluetooth/btintel.h
> > > +++ b/drivers/bluetooth/btintel.h
> > > @@ -209,7 +209,7 @@ struct btintel_data {
> > >   #define btintel_wait_on_flag_timeout(hdev, nr, m, to)
> >       \
> > >             wait_on_bit_timeout(btintel_get_flag(hdev), (nr), m, to)
> > >
> > > -#if IS_ENABLED(CONFIG_BT_INTEL)
> > > +#if IS_ENABLED(CONFIG_BT_INTEL) ||
> > IS_ENABLED(CONFIG_BT_INTEL_PCIE)
> > >
> > >   int btintel_check_bdaddr(struct hci_dev *hdev);
> > >   int btintel_enter_mfg(struct hci_dev *hdev);
> > > diff --git a/drivers/bluetooth/btintel_pcie.c
> > b/drivers/bluetooth/btintel_pcie.c
> > > new file mode 100644
> > > index 000000000000..e6ce2304dc57
> > > --- /dev/null
> > > +++ b/drivers/bluetooth/btintel_pcie.c
> > > @@ -0,0 +1,1317 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Intel Bluetooth PCIE driver
> > > + *
> > > + * Copyright (C) 2017 Intel Corporation. All rights reserved.
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU General Public License versi=
on
> > > + * 2 as published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + * Copyright (C) 2022  Intel Corporation
> >
> > Are two copyright lines needed?
> >
> No. I overlooked this. I will fix in v2 version.
> > > + *
> > > + * Intel Bluetooth Driver for PCIE interface.
> > > + */
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/firmware.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/wait.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/interrupt.h>
> > > +
> > > +#include <asm/unaligned.h>
> > > +
> > > +#include <net/bluetooth/bluetooth.h>
> > > +#include <net/bluetooth/hci_core.h>
> > > +
> > > +#include "btintel.h"
> > > +#include "btintel_pcie.h"
> > > +
> > > +#define VERSION "0.1"
> > > +
> > > +#define BTINTEL_PCI_DEVICE(dev, subdev)    \
> > > +   .vendor =3D PCI_VENDOR_ID_INTEL,  \
> > > +   .device =3D (dev),                \
> > > +   .subvendor =3D PCI_ANY_ID,        \
> > > +   .subdevice =3D (subdev),          \
> > > +   .driver_data =3D 0
> > > +
> > > +/* Intel Bluetooth PCIe device id table */
> > > +static const struct pci_device_id btintel_pcie_table[] =3D {
> > > +   { BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
> > > +   { 0 }
> > > +};
> > > +MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
> > > +
> > > +/* Intel PCIe uses 4 bytes of HCI type instead of 1 byte BT SIG HCI =
type */
> > > +#define BTINTEL_PCIE_HCI_TYPE_LEN  4
> > > +#define BTINTEL_PCIE_HCI_CMD_PKT   0x00000001
> > > +#define BTINTEL_PCIE_HCI_ACL_PKT   0x00000002
> > > +#define BTINTEL_PCIE_HCI_SCO_PKT   0x00000003
> > > +#define BTINTEL_PCIE_HCI_EVT_PKT   0x00000004
> > > +
> > > +#define BTITNEL_PCIE_ENABLE_HCI_DUMP       0
> >
> > Mention this macro in the commit message?
> I will remove this macro as we have monitor to dump all the HCI traffic.
> >
> > > +
> > > +#if BTITNEL_PCIE_ENABLE_HCI_DUMP
> > > +static inline void btintel_pcie_hci_dump(const char *p, const void *=
b, int s)
> > > +{
> > > +   const unsigned char *ptr =3D (const unsigned char *)b;
> > > +   char str[64];
> > > +   int c, i;
> > > +
> > > +   for (i =3D c =3D 0; c < s; c++) {
> > > +           i +=3D snprintf(str + i, sizeof(str) - i, "%02x ", ptr[c]=
);
> > > +           if ((c > 0 && (c + 1) % 8 =3D=3D 0) || (c =3D=3D s - 1)) =
{
> > > +                   BT_DBG("%s: %s", p, str);
> > > +                   i =3D 0;
> > > +           }
> > > +   }
> > > +}
> > > +#else
> > > +static inline void btintel_pcie_hci_dump(const char *p, const void *=
b, int s)
> > > +{
> > > +}
> > > +#endif
> >
> > Is there a way to test this code, that means some CI setting
> > `BTITNEL_PCIE_ENABLE_HCI_DUMP`? Would the linker remove unneeded
> > code,
> > if you did
> >
> >      static inline void btintel_pcie_hci_dump(const char *p, const void
> > *b, int s)
> >      {
> >       if (BTITNEL_PCIE_ENABLE_HCI_DUMP) {
> >               Everything here.
> >       }
> >      }
> >
> > > +
> > > +static void ipc_print_ia_ring(struct ia *ia, u16 queue_num)
> > > +{
> > > +   BT_DBG("[%s] ---------------- ia ----------------",
> > > +          queue_num =3D=3D TXQ_NUM ? "TXQ" : "RXQ");
> > > +   BT_DBG("[%s] tr-h:%02u  tr-t:%02u  cr-h:%02u  cr-t:%02u",
> > > +          queue_num =3D=3D TXQ_NUM ? "TXQ" : "RXQ",
> > > +          ia->tr_hia[queue_num], ia->tr_tia[queue_num],
> > > +          ia->cr_hia[queue_num], ia->cr_tia[queue_num]);
> > > +}
> > > +
> > > +static void ipc_print_urbd0(struct urbd0 *urbd0, u16 index)
> > > +{
> > > +   BT_DBG("[TXQ] -------------- urbd0[%u] --------------", index);
> > > +   BT_DBG("[TXQ] tfd_index:%u num_txq:%u cmpl_cnt:%u
> > immediate_cmpl:0x%x",
> > > +          urbd0->tfd_index, urbd0->num_txq, urbd0->cmpl_count,
> > > +          urbd0->immediate_cmpl);
> > > +}
> > > +
> > > +static void ipc_print_frbd(struct frbd *frbd, u16 index)
> > > +{
> > > +   BT_DBG("[RXQ] -------------- frbd[%u] --------------", index);
> > > +   BT_DBG("[RXQ] tag:%u addr:0x%llx", frbd->tag, frbd->addr);
> > > +}
> > > +
> > > +static void ipc_print_urbd1(struct urbd1 *urbd1, u16 index)
> > > +{
> > > +   BT_DBG("[RXQ] -------------- urbd1[%u] --------------", index);
> > > +   BT_DBG("[RXQ] frbd_tag:%u status: 0x%x fixed:0x%x",
> > > +          urbd1->frbd_tag, urbd1->status, urbd1->fixed);
> > > +}
> > > +
> > > +/* Poll internal in microseconds */
> > > +#define POLL_INTERVAL                      10
> >
> > Please put the unit into the name: `POLL_INTERVAL_MS`. Then the comment
> > can also be removed as redundant.
> Ack.
> >
> > > +
> > > +static int btintel_pcie_poll_bit(struct btintel_pcie_data *data, u32=
 offset,
> > > +                            u32 bits, u32 mask, int timeout)
> >
> > Add the unit to `timeout`
> Ack.
>
> >
> > > +{
> > > +   int t =3D 0;
> > > +   u32 reg;
> > > +
> > > +   BT_DBG("Enter poll_bit");
> >
> > Is this needed? Doesn=E2=80=99t Linux=E2=80=99 tracing framework cover =
this already?
> Ack.
> >
> > > +   do {
> > > +           reg =3D btintel_pcie_rd_reg32(data, offset);
> > > +           BT_DBG("CURRENT FUNC_CTRL_REG: 0x%x", reg);
> > > +
> > > +           if ((reg & mask) =3D=3D (bits & mask)) {
> > > +                   BT_DBG("Poll bit matched");
> > > +                   return t;
> > > +           }
> > > +           udelay(POLL_INTERVAL);
> > > +           t +=3D POLL_INTERVAL;
> > > +           BT_DBG("Poll wait: %d", t);
> >
> > Maybe elaborate, so it=E2=80=99s clear it=E2=80=99s the cummulative tim=
e. Maybe also
> > print `timeout` value?
> Timeout values are static. Let me know if its really required. BTW, I wil=
l remove BT_DBG logs which are not of much help.
> >
> > > +   } while (t < timeout);
> > > +
> > > +   return -ETIMEDOUT;
> > > +}
> > > +
> > > +static struct btintel_pcie_data *btintel_pcie_get_data(struct msix_e=
ntry
> > *entry)
> > > +{
> > > +   u8 queue =3D entry->entry;
> > > +   struct msix_entry *entries =3D entry - queue;
> > > +
> > > +   return container_of(entries, struct btintel_pcie_data, msix_entri=
es[0]);
> > > +}
> > > +
> > > +/* Set the doorbell for RXQ to notify the device that @index(actuall=
y index-
> > 1)
> > > + * is available to receive the data
> > > + */
> > > +static void btintel_pcie_set_rx_db(struct btintel_pcie_data *data, u=
16
> > index)
> > > +{
> > > +   u32 val;
> > > +
> > > +   val =3D index;
> > > +   val |=3D (513 << 16);
> > > +
> > > +   BT_DBG("[RXQ] Set doorbell for index: %u", index);
> > > +   btintel_pcie_wr_reg32(data, CSR_HBUS_TARG_WRPTR, val);
> > > +}
> > > +
> > > +/* Update the FRBD(free buffer descriptor) with the @frbd_index and =
the
> > > + * DMA address of the free buffer.
> > > + */
> > > +static void btintel_pcie_prepare_rx(struct rxq *rxq, u16 frbd_index)
> > > +{
> > > +   struct data_buf *buf;
> > > +   struct frbd *frbd;
> > > +
> > > +   /* Get the buffer of the frbd for DMA */
> > > +   buf =3D &rxq->bufs[frbd_index];
> > > +
> > > +   frbd =3D &rxq->frbds[frbd_index];
> > > +   memset(frbd, 0, sizeof(*frbd));
> > > +
> > > +   /* Update FRBD */
> > > +   frbd->tag =3D frbd_index;
> > > +   frbd->addr =3D buf->data_p_addr;
> > > +   ipc_print_frbd(frbd, frbd_index);
> > > +}
> > > +
> > > +static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
> > > +{
> > > +   u16 frbd_index;
> > > +   struct rxq *rxq =3D &data->rxq;
> > > +
> > > +   /* Read the frbd index from the TR_HIA(Head Index Array) for RXQ =
*/
> > > +   frbd_index =3D data->ia.tr_hia[RXQ_NUM];
> > > +   BT_DBG("[RXQ] current frbd_index: %u", frbd_index);
> > > +
> > > +   /* Make sure the index value is within the range. It shouldn't be
> > > +    * bigger than the total count of the queue.
> > > +    */
> > > +   if (frbd_index > rxq->count) {
> > > +           BT_ERR("[RXQ] RXQ out of range: (0x%x)", frbd_index);
> > > +           return -ERANGE;
> > > +   }
> > > +
> > > +   /* Prepare for RX submit. It updates the FRBD with the address of
> > DMA
> > > +    * buffer
> > > +    */
> > > +   btintel_pcie_prepare_rx(rxq, frbd_index);
> > > +
> > > +   /* Update TR_HIA with new FRBD index */
> > > +   frbd_index =3D (frbd_index + 1) % rxq->count;
> > > +   data->ia.tr_hia[RXQ_NUM] =3D frbd_index;
> > > +   ipc_print_ia_ring(&data->ia, RXQ_NUM);
> > > +
> > > +   /* Set the doorbell to notify the device */
> > > +   btintel_pcie_set_rx_db(data, frbd_index);
> > > +
> > > +   BT_DBG("[RXQ] rx sumbit completed");
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
> > > +{
> > > +   int i, ret;
> > > +
> > > +   for (i =3D 0; i < RX_MAX_QUEUE; i++) {
> > > +           ret =3D btintel_pcie_submit_rx(data);
> > > +           if (ret) {
> > > +                   BT_ERR("[RXQ] failed to submit frbd(%d)", ret);
> > > +                   return ret;
> > > +           }
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static void btintel_pcie_reset_ia(struct btintel_pcie_data *data)
> > > +{
> > > +   memset(data->ia.tr_hia, 0, sizeof(u16) * NUM_QUEUES);
> > > +   memset(data->ia.tr_tia, 0, sizeof(u16) * NUM_QUEUES);
> > > +   memset(data->ia.cr_hia, 0, sizeof(u16) * NUM_QUEUES);
> > > +   memset(data->ia.cr_tia, 0, sizeof(u16) * NUM_QUEUES);
> > > +   BT_DBG("Index Arrays are reset");
> > > +}
> > > +
> > > +static void btintel_pcie_reset_bt(struct btintel_pcie_data *data)
> > > +{
> > > +   BT_INFO("Reset BT Function ");
> > > +   btintel_pcie_wr_reg32(data, CSR_FUNC_CTRL_REG,
> > CSR_FUNC_CTRL_SW_RESET);
> > > +}
> > > +
> > > +/* This function enables BT function by setting CSR_FUNC_CTRL_MAC_IN=
IT
> > bit in
> > > + * CSR_FUNC_CTRL_REG register and wait for MSI-X with
> > MSIX_HW_INT_CAUSES_GP0.
> > > + * Then the host reads firmware version from CSR_F2D_MBX and the boo=
t
> > stage
> > > + * from CSR_BOOT_STAGE_REG.
> > > + */
> > > +static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
> > > +{
> > > +   int err;
> > > +   u32 reg;
> > > +
> > > +   data->gp0_received =3D false;
> > > +
> > > +   /* Update the DMA address of CI struct to CSR */
> > > +   btintel_pcie_wr_reg32(data, CSR_CI_ADDR_LSB_REG,
> > > +                         data->ci_p_addr & 0xffffffff);
> > > +   btintel_pcie_wr_reg32(data, CSR_CI_ADDR_MSB_REG,
> > > +                         data->ci_p_addr >> 32);
> > > +
> > > +   /* Reset the cached value of boot stage. it is updated by the msi=
x
> > > +    * gp0 interrupt handler.
> > > +    */
> > > +   data->boot_stage_cache =3D 0x0;
> > > +
> > > +   /* Set MAC_INIT bit to start primary bootloader */
> > > +   reg =3D btintel_pcie_rd_reg32(data, CSR_FUNC_CTRL_REG);
> > > +   BT_INFO("Before: FUNC_CTRL_REG: 0x%x", reg);
> > > +
> > > +   btintel_pcie_set_reg_bits(data, CSR_FUNC_CTRL_REG,
> > > +                             CSR_FUNC_CTRL_MAC_INIT);
> > > +   BT_INFO("MAC_INIT is set");
> > > +
> > > +   /* Wait until MAC_ACCESS is granted */
> > > +   err =3D btintel_pcie_poll_bit(data, CSR_FUNC_CTRL_REG,
> > > +                               CSR_FUNC_CTRL_MAC_ACCESS_STS,
> > > +                               CSR_FUNC_CTRL_MAC_ACCESS_STS,
> > > +                               DEFAULT_MAC_ACCESS_TIMEOUT);
> > > +   if (err < 0) {
> > > +           BT_ERR("Failed to start bootloader even after %u ns",
> > > +                  DEFAULT_MAC_ACCESS_TIMEOUT);
> > > +           return -ENODEV;
> > > +   }
> > > +
> > > +   /* MAC is ready. Enable BT FUNC */
> > > +   btintel_pcie_set_reg_bits(data, CSR_FUNC_CTRL_REG,
> > > +                             CSR_FUNC_CTRL_FUNC_ENA |
> > > +                             CSR_FUNC_CTRL_FUNC_INIT);
> > > +
> > > +   reg =3D btintel_pcie_rd_reg32(data, CSR_FUNC_CTRL_REG);
> > > +   BT_INFO("After: FUNC_CTRL_REG: 0x%x", reg);
> > > +
> > > +   /* wait for interrupt from the device after booting up to primary
> > > +    * bootloader.
> > > +    */
> > > +   err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> > > +                            msecs_to_jiffies(DEFAULT_INTR_TIMEOUT));
> > > +   if (!err) {
> > > +           BT_ERR("Failed to receive mac_init interrupt");
> > > +           return -ETIME;
> > > +   }
> > > +
> > > +   /* Check cached boot stage is CSR_BOOT_STAGE_ROM(BIT(0)) */
> > > +   if (~data->boot_stage_cache & CSR_BOOT_STAGE_ROM) {
> > > +           BT_ERR("Device is not running in rom");
> > > +           return -ENODEV;
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +/* This function handles the MSI-X interrupt for gp0 cause(bit 0 in
> > > + * CSR_MSIX_HW_INT_CAUSES) which is sent for boot stage and image
> > response.
> > > + */
> > > +static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *=
data)
> > > +{
> > > +   u32 reg;
> > > +
> > > +   /* This interrupt is for three different causes and it is not eas=
y to
> > > +    * know what causes the interrupt. So, it compares each register =
value
> > > +    * with cached value and update it before it wake up the queue.
> > > +    */
> > > +   reg =3D btintel_pcie_rd_reg32(data, CSR_BOOT_STAGE_REG);
> > > +   if (reg !=3D data->boot_stage_cache) {
> > > +           data->boot_stage_cache =3D reg;
> > > +
> > > +           BT_DBG("Boot Stage updated: 0x%x", reg);
> > > +   }
> > > +
> > > +   reg =3D btintel_pcie_rd_reg32(data, CSR_IMG_RESPONSE_REG);
> > > +   if (reg !=3D data->img_resp_cache) {
> > > +           data->img_resp_cache =3D reg;
> > > +
> > > +           BT_DBG("Image Response updated: 0x%x", reg);
> > > +   }
> > > +
> > > +   BT_DBG("---------- cached GP0 registers ----------");
> > > +   BT_DBG("Cached Boot Stage Reg: 0x%x", data->boot_stage_cache);
> > > +   BT_DBG("Cached Image Resp Reg: 0x%x", data->img_resp_cache);
> > > +
> > > +   data->gp0_received =3D true;
> > > +
> > > +   /* If the boot stage is OP or IML, reset IA and start RX again */
> > > +   if (data->boot_stage_cache & CSR_BOOT_STAGE_OPFW ||
> > > +       data->boot_stage_cache & CSR_BOOT_STAGE_IML) {
> > > +           btintel_pcie_reset_ia(data);
> > > +           btintel_pcie_start_rx(data);
> > > +   }
> > > +
> > > +   wake_up(&data->gp0_wait_q);
> > > +}
> > > +
> > > +/* This function handles the MSX-X interrupt for rx queue 0 which is=
 for TX
> > > + */
> > > +static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *da=
ta)
> > > +{
> > > +   u16 cr_tia, cr_hia;
> > > +   struct txq *txq;
> > > +   struct urbd0 *urbd0;
> > > +
> > > +   cr_tia =3D data->ia.cr_tia[TXQ_NUM];
> > > +   cr_hia =3D data->ia.cr_hia[TXQ_NUM];
> > > +
> > > +   BT_DBG("[TXQ] cr_hia=3D%u  cr_tia=3D%u", cr_hia, cr_tia);
> > > +
> > > +   /* Check CR_TIA and CR_HIA for change */
> > > +   if (cr_tia =3D=3D cr_hia) {
> > > +           BT_ERR("[TXQ] no new CD found");
> > > +           return;
> > > +   }
> > > +
> > > +   txq =3D &data->txq;
> > > +
> > > +   while (cr_tia !=3D cr_hia) {
> > > +           BT_DBG("[TXQ] wake up tx_wait_q");
> > > +
> > > +           data->tx_wait_done =3D true;
> > > +           wake_up(&data->tx_wait_q);
> > > +
> > > +           /* Get URBD0 pointed by cr_tia */
> > > +           urbd0 =3D &txq->urbd0s[cr_tia];
> > > +           ipc_print_urbd0(urbd0, cr_tia);
> > > +
> > > +           /* Make sure the completed TFD index is within the range =
*/
> > > +           if (urbd0->tfd_index > txq->count) {
> > > +                   BT_ERR("[TXQ] out of range: (0x%x)", urbd0-
> > >tfd_index);
> > > +                   return;
> > > +           }
> > > +
> > > +           /* Increase cr_tia */
> > > +           cr_tia =3D (cr_tia + 1) % txq->count;
> > > +           data->ia.cr_tia[TXQ_NUM] =3D cr_tia;
> > > +           ipc_print_ia_ring(&data->ia, TXQ_NUM);
> > > +   }
> > > +}
> > > +
> > > +static int btintel_pcie_recv_event_intel(struct hci_dev *hdev,
> > > +                                    struct sk_buff *skb)
> > > +{
> > > +   if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
> > > +           struct hci_event_hdr *hdr =3D (void *)skb->data;
> > > +
> > > +           if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt =3D=3D 0xff=
 &&
> > > +               hdr->plen > 0) {
> > > +                   const void *ptr =3D skb->data + HCI_EVENT_HDR_SIZ=
E +
> > 1;
> > > +                   unsigned int len =3D skb->len - HCI_EVENT_HDR_SIZ=
E -
> > 1;
> > > +
> > > +                   switch (skb->data[2]) {
> > > +                   case 0x02:
> > > +                           /* When switching to the operational
> > firmware
> > > +                            * the device sends a vendor specific eve=
nt
> > > +                            * indicating that the bootup completed.
> > > +                            */
> > > +                           btintel_bootup(hdev, ptr, len);
> > > +                           break;
> > > +                   case 0x06:
> > > +                           /* When the firmware loading completes th=
e
> > > +                            * device sends out a vendor specific eve=
nt
> > > +                            * indicating the result of the firmware
> > > +                            * loading.
> > > +                            */
> > > +                           btintel_secure_send_result(hdev, ptr, len=
);
> > > +                           break;
> > > +                   }
> > > +           }
> > > +   }
> > > +
> > > +   return hci_recv_frame(hdev, skb);
> > > +}
> > > +
> > > +/* Process the received rx data
> > > + * It check the frame header to identify the data type and create sk=
b
> > > + * and calling HCI API
> > > + */
> > > +static int btintel_pcie_hci_recv_frame(struct btintel_pcie_data *dat=
a,
> > > +                                  void *buf, int count)
> > > +{
> > > +   struct hci_dev *hdev =3D data->hdev;
> > > +   int ret;
> > > +   u32 pkt_type;
> > > +   u16 plen;
> > > +   struct sk_buff *skb;
> > > +
> > > +   spin_lock(&data->hci_rx_lock);
> > > +
> > > +   /* The first 4 bytes indicates the Intel PCIe specific packet typ=
e.
> > > +    * Read the packet type here before remove it.
> > > +    */
> > > +   pkt_type =3D get_unaligned_le32(buf);
> > > +   bt_dev_dbg(hdev, "pkt_type=3D%u count=3D%d", pkt_type, count);
> > > +
> > > +   buf +=3D BTINTEL_PCIE_HCI_TYPE_LEN;
> > > +   count -=3D BTINTEL_PCIE_HCI_TYPE_LEN;
> > > +
> > > +   hdev->stat.byte_rx +=3D count;
> > > +
> > > +   skb =3D bt_skb_alloc(count, GFP_ATOMIC);
> > > +   if (!skb) {
> > > +           bt_dev_err(hdev, "Failed to allocate skb for event");
> > > +           ret =3D -ENOMEM;
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   switch (pkt_type) {
> > > +   case BTINTEL_PCIE_HCI_ACL_PKT:
> > > +           hci_skb_pkt_type(skb) =3D HCI_ACLDATA_PKT;
> > > +           memcpy(skb_put(skb, HCI_ACL_HDR_SIZE), buf,
> > HCI_ACL_HDR_SIZE);
> > > +           plen =3D hci_acl_hdr(skb)->dlen;
> > > +           buf +=3D HCI_ACL_HDR_SIZE;
> > > +           break;
> > > +   case BTINTEL_PCIE_HCI_SCO_PKT:
> > > +           hci_skb_pkt_type(skb) =3D HCI_SCODATA_PKT;
> > > +           memcpy(skb_put(skb, HCI_SCO_HDR_SIZE), buf,
> > HCI_SCO_HDR_SIZE);
> > > +           plen =3D hci_sco_hdr(skb)->dlen;
> > > +           buf +=3D HCI_SCO_HDR_SIZE;
> > > +           break;
> > > +   case BTINTEL_PCIE_HCI_EVT_PKT:
> > > +           hci_skb_pkt_type(skb) =3D HCI_EVENT_PKT;
> > > +           memcpy(skb_put(skb, HCI_EVENT_HDR_SIZE), buf,
> > > +                  HCI_EVENT_HDR_SIZE);
> > > +           plen =3D hci_event_hdr(skb)->plen;
> > > +           buf +=3D HCI_EVENT_HDR_SIZE;
> > > +           break;
> > > +   default:
> > > +           ret =3D -EILSEQ;
> > > +           kfree_skb(skb);
> > > +           goto exit_error;
> > > +   }
> > > +   memcpy(skb_put(skb, plen), buf, plen);
> > > +
> > > +   if (pkt_type =3D=3D BTINTEL_PCIE_HCI_EVT_PKT)
> > > +           ret =3D btintel_pcie_recv_event_intel(hdev, skb);
> > > +   else
> > > +           ret =3D hci_recv_frame(hdev, skb);
> > > +
> > > +exit_error:
> > > +   if (ret)
> > > +           hdev->stat.err_rx++;
> > > +
> > > +   spin_unlock(&data->hci_rx_lock);
> > > +
> > > +   return ret;
> > > +}
> > > +
> > > +/* RX work queue */
> > > +static void btintel_pcie_rx_work(struct work_struct *work)
> > > +{
> > > +   struct btintel_pcie_data *data =3D container_of(work,
> > > +                                   struct btintel_pcie_data, rx_work=
);
> > > +   struct sk_buff *skb;
> > > +   int err;
> > > +
> > > +   /* Process the sk_buf in queue and send to the hci layer */
> > > +   while ((skb =3D skb_dequeue(&data->rx_skb_q))) {
> > > +           err =3D btintel_pcie_hci_recv_frame(data, skb->data, skb-=
>len);
> > > +           if (err) {
> > > +                   BT_ERR("Failed to send received frame: %d", err);
> > > +                   kfree_skb(skb);
> > > +           }
> > > +   }
> > > +}
> > > +
> > > +/* create the sk_buff with data and save it to queue and start rx wo=
rk
> > > + */
> > > +static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *dat=
a, u8
> > status,
> > > +                                  void *buf)
> > > +{
> > > +   int ret, len;
> > > +   struct rfh_hdr *rfh_hdr;
> > > +   struct sk_buff *skb;
> > > +
> > > +   rfh_hdr =3D (struct rfh_hdr *)buf;
> > > +   btintel_pcie_hci_dump("RFH HDR", buf, sizeof(*rfh_hdr));
> > > +
> > > +   len =3D rfh_hdr->packet_len;
> > > +
> > > +   /* Remove RFH header */
> > > +   buf +=3D sizeof(*rfh_hdr);
> > > +   btintel_pcie_hci_dump("RX", buf, len);
> > > +
> > > +   /* Create the sk_buf with packet in the buf and save it to sk_buf
> > queue
> > > +    */
> > > +   skb =3D alloc_skb(len, GFP_ATOMIC);
> > > +   if (!skb) {
> > > +           ret =3D -ENOMEM;
> > > +           goto resubmit;
> > > +   }
> > > +
> > > +   /* Copy the data to skb */
> > > +   memcpy(skb_put(skb, len), buf, len);
> > > +
> > > +   /* Save the skb to rx queue */
> > > +   skb_queue_tail(&data->rx_skb_q, skb);
> > > +
> > > +   /* Calling rx_work queue to process the skb */
> > > +   queue_work(data->workqueue, &data->rx_work);
> > > +
> > > +resubmit:
> > > +   BT_DBG("submit next read request");
> > > +
> > > +   /* submit read */
> > > +   ret =3D btintel_pcie_submit_rx(data);
> > > +
> > > +   return ret;
> > > +}
> > > +
> > > +/* This function handles the MSI-X interrupt for rx queue 1 which is=
 for RX
> > > + */
> > > +static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *da=
ta)
> > > +{
> > > +   u16 cr_hia, cr_tia;
> > > +   struct rxq *rxq;
> > > +   struct urbd1 *urbd1;
> > > +   struct frbd *frbd;
> > > +   struct data_buf *buf;
> > > +   int ret;
> > > +
> > > +   cr_hia =3D data->ia.cr_hia[RXQ_NUM];
> > > +   cr_tia =3D data->ia.cr_tia[RXQ_NUM];
> > > +
> > > +   BT_DBG("[RXQ] cr_hia=3D%u  cr_tia=3D%u", cr_hia, cr_tia);
> > > +
> > > +   /* Check CR_TIA and CR_HIA for change */
> > > +   if (cr_tia =3D=3D cr_hia) {
> > > +           BT_ERR("[RXQ] no new CD found");
> > > +           return;
> > > +   }
> > > +
> > > +   rxq =3D &data->rxq;
> > > +
> > > +   /* The firmware sends multiple CD in a single MSIX and it needs t=
o
> > > +    * process all received CDs in this interrupt.
> > > +    */
> > > +   while (cr_tia !=3D cr_hia) {
> > > +           /* Get URBD1 pointed by cr_tia */
> > > +           urbd1 =3D &rxq->urbd1s[cr_tia];
> > > +           ipc_print_urbd1(urbd1, cr_tia);
> > > +
> > > +           /* Get FRBD poined by urbd1->frbd_tag */
> > > +           frbd =3D &rxq->frbds[urbd1->frbd_tag];
> > > +
> > > +           /* Get buf from FRBD tag */
> > > +           buf =3D &rxq->bufs[urbd1->frbd_tag];
> > > +           if (!buf) {
> > > +                   BT_ERR("[RXQ] failed to get the DMA buffer for %d=
",
> > > +                          urbd1->frbd_tag);
> > > +                   return;
> > > +           }
> > > +
> > > +           /* prepare RX work */
> > > +           ret =3D btintel_pcie_submit_rx_work(data, urbd1->status,
> > > +                                             buf->data);
> > > +           if (ret) {
> > > +                   BT_ERR("[RXQ] failed to submit rx request");
> > > +                   return;
> > > +           }
> > > +
> > > +           /* Update cr_tia */
> > > +           cr_tia =3D (cr_tia + 1) % rxq->count;
> > > +           data->ia.cr_tia[RXQ_NUM] =3D cr_tia;
> > > +           ipc_print_ia_ring(&data->ia, RXQ_NUM);
> > > +   }
> > > +   BT_DBG("[RXQ] completed rx interrupt");
> > > +}
> > > +
> > > +static irqreturn_t btintel_pcie_msix_isr(int irq, void *data)
> > > +{
> > > +   return IRQ_WAKE_THREAD;
> > > +}
> > > +
> > > +static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_=
id)
> > > +{
> > > +   struct msix_entry *entry =3D dev_id;
> > > +   struct btintel_pcie_data *data =3D btintel_pcie_get_data(entry);
> > > +   u32 intr_fh, intr_hw;
> > > +
> > > +   BT_DBG("handling msix(irq=3D%d dev_id=3D0x%p)", irq, dev_id);
> > > +
> > > +   spin_lock(&data->irq_lock);
> > > +   intr_fh =3D btintel_pcie_rd_reg32(data, CSR_MSIX_FH_INT_CAUSES);
> > > +   intr_hw =3D btintel_pcie_rd_reg32(data, CSR_MSIX_HW_INT_CAUSES);
> > > +
> > > +   /* Clear causes registers to avoid being handling the same cause =
*/
> > > +   btintel_pcie_wr_reg32(data, CSR_MSIX_FH_INT_CAUSES, intr_fh);
> > > +   btintel_pcie_wr_reg32(data, CSR_MSIX_HW_INT_CAUSES, intr_hw);
> > > +   spin_unlock(&data->irq_lock);
> > > +
> > > +   BT_DBG("intr_fh=3D0x%x intr_hw=3D0x%x", intr_fh, intr_hw);
> > > +
> > > +   if (unlikely(!(intr_fh | intr_hw))) {
> > > +           BT_DBG("Ignore interrupt, inta =3D=3D 0");
> > > +           return IRQ_NONE;
> > > +   }
> > > +
> > > +   /* This interrupt is triggered by the firmware after updating
> > > +    * boot_stage register and image_response register
> > > +    */
> > > +   if (intr_hw & MSIX_HW_INT_CAUSES_GP0) {
> > > +           BT_DBG("intr for MSIX_HW_INT_CAUSES_GP0");
> > > +           btintel_pcie_msix_gp0_handler(data);
> > > +   }
> > > +
> > > +   /* For TX */
> > > +   if (intr_fh & MSIX_FH_INT_CAUSES_0) {
> > > +           BT_DBG("intr for MSIX_FH_INT_CAUSES_0");
> > > +           btintel_pcie_msix_tx_handle(data);
> > > +   }
> > > +
> > > +   /* For RX */
> > > +   if (intr_fh & MSIX_FH_INT_CAUSES_1) {
> > > +           BT_DBG("intr for MSIX_FH_INT_CAUSES_1");
> > > +           btintel_pcie_msix_rx_handle(data);
> > > +   }
> > > +
> > > +   /* TODO: Add handler for other causes */
> > > +   /*
> > > +    * Before sending the interrupt the HW disables it to prevent
> > > +    * a nested interrupt. This is done by writing 1 to the correspon=
ding
> > > +    * bit in the mask register. After handling the interrupt, it sho=
uld be
> > > +    * re-enabled by clearing this bit. This register is defined as
> > > +    * write 1 clear (W1C) register, meaning that it's being clear
> > > +    * by writing 1 to the bit.
> > > +    */
> > > +   btintel_pcie_wr_reg32(data, CSR_MSIX_AUTOMASK_ST, BIT(entry-
> > >entry));
> > > +
> > > +   return IRQ_HANDLED;
> > > +}
> > > +
> > > +/* This function requests the irq for msix and registers the handler=
s per irq.
> > > + * Currently, it requests only 1 irq for all interrupt causes.
> > > + */
> > > +static int btintel_pcie_setup_irq(struct btintel_pcie_data *data)
> > > +{
> > > +   int err;
> > > +   int num_irqs, i;
> > > +
> > > +   BT_DBG("Initialize msix_entries...");
> > > +   for (i =3D 0; i < MSIX_VEC_MAX; i++) {
> > > +           data->msix_entries[i].entry =3D i;
> > > +           BT_DBG("msix_entries[%d] vector=3D0x%x entry=3D0x%x",
> > > +                  i, data->msix_entries[i].vector,
> > > +                  data->msix_entries[i].entry);
> > > +   }
> > > +
> > > +   num_irqs =3D pci_enable_msix_range(data->pdev, data->msix_entries=
,
> > > +                                    MSIX_VEC_MIN,
> > > +                                    MSIX_VEC_MAX);
> > > +   if (num_irqs < 0) {
> > > +           BT_ERR("Failed to enable msix range (%d)", num_irqs);
> > > +           return num_irqs;
> > > +   }
> > > +
> > > +   data->alloc_vecs =3D num_irqs;
> > > +   data->msix_enabled =3D 1;
> > > +   data->def_irq =3D 0;
> > > +
> > > +   BT_DBG("Returned num_irqs=3D%d", num_irqs);
> > > +   for (i =3D 0; i < num_irqs; i++) {
> > > +           BT_DBG("msix_entries[%d] vector=3D0x%x entry=3D0x%x", i,
> > > +                  data->msix_entries[i].vector,
> > > +                  data->msix_entries[i].entry);
> > > +   }
> > > +
> > > +   BT_DBG("setup irq handler");
> > > +   for (i =3D 0; i < data->alloc_vecs; i++) {
> > > +           struct msix_entry *msix_entry;
> > > +
> > > +           msix_entry =3D &data->msix_entries[i];
> > > +
> > > +           err =3D devm_request_threaded_irq(&data->pdev->dev,
> > > +                                           msix_entry->vector,
> > > +                                           btintel_pcie_msix_isr,
> > > +
> >       btintel_pcie_irq_msix_handler,
> > > +                                           IRQF_SHARED,
> > > +                                           KBUILD_MODNAME,
> > > +                                           msix_entry);
> > > +           if (err) {
> > > +                   BT_ERR("Failed to allocate irq handler (%d)", err=
);
> > > +                   return err;
> > > +           }
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +struct btintel_pcie_causes_list {
> > > +   u32 cause;
> > > +   u32 mask_reg;
> > > +   u8 cause_num;
> > > +};
> > > +
> > > +struct btintel_pcie_causes_list causes_list[] =3D {
> > > +   { MSIX_FH_INT_CAUSES_0,         CSR_MSIX_FH_INT_MASK,
> >       0x00 },
> > > +   { MSIX_FH_INT_CAUSES_1,         CSR_MSIX_FH_INT_MASK,
> >       0x01 },
> > > +   { MSIX_HW_INT_CAUSES_GP0,       CSR_MSIX_HW_INT_MASK,   0x20
> > },
> > > +};
> > > +
> > > +/* This function configures the interrupt masks for both HW_INT_CAUS=
ES
> > and
> > > + * FH_INT_CAUSES which are meaningful to us.
> > > + *
> > > + * After resetting BT function via PCIE FLR or FUNC_CTRL reset, the =
driver
> > > + * need to call this function again to configure it again since the =
masks
> > > + * are reset to 0xFFFFFFFF after reset.
> > > + */
> > > +static void btintel_pcie_config_msix(struct btintel_pcie_data *data)
> > > +{
> > > +   int i;
> > > +   int val =3D data->def_irq | MSIX_NON_AUTO_CLEAR_CAUSE;
> > > +
> > > +   /* Set Non Auto Clear Cause */
> > > +   for (i =3D 0; i < ARRAY_SIZE(causes_list); i++) {
> > > +           btintel_pcie_wr_reg8(data,
> > > +                                CSR_MSIX_IVAR(causes_list[i].cause_n=
um),
> > > +                                val);
> > > +           btintel_pcie_clr_reg_bits(data,
> > > +                                     causes_list[i].mask_reg,
> > > +                                     causes_list[i].cause);
> > > +   }
> > > +
> > > +   /* Save the initial interrupt mask */
> > > +   data->fh_init_mask =3D ~btintel_pcie_rd_reg32(data,
> > CSR_MSIX_FH_INT_MASK);
> > > +   data->hw_init_mask =3D ~btintel_pcie_rd_reg32(data,
> > CSR_MSIX_HW_INT_MASK);
> > > +   BT_DBG("init_mask: fh=3D0x%x hw=3D0x%x", data->fh_init_mask,
> > > +          data->hw_init_mask);
> > > +}
> > > +
> > > +static int btintel_pcie_config_pcie(struct pci_dev *pdev,
> > > +                               struct btintel_pcie_data *data)
> > > +{
> > > +   int err;
> > > +
> > > +   err =3D pcim_enable_device(pdev);
> > > +   if (err) {
> > > +           BT_ERR("Failed to enable pci device (%d)", err);
> > > +           return err;
> > > +   }
> > > +   pci_set_master(pdev);
> > > +
> > > +   /* Setup DMA mask */
> > > +   BT_DBG("Set DMA_MASK(64)");
> > > +   err =3D dma_set_mask_and_coherent(&pdev->dev,
> > DMA_BIT_MASK(64));
> > > +   if (err) {
> > > +           BT_DBG("Set DMA_MASK(32)");
> > > +           err =3D dma_set_mask_and_coherent(&pdev->dev,
> > DMA_BIT_MASK(32));
> > > +           /* Both attempt failed */
> > > +           if (err) {
> > > +                   BT_ERR("No suitable DMA available");
> > > +                   return err;
> > > +           }
> > > +   }
> > > +
> > > +   /* Get BAR to access CSR */
> > > +   err =3D pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
> > > +   if (err) {
> > > +           BT_ERR("Failed to get iomap regions (%d)", err);
> > > +           return err;
> > > +   }
> > > +
> > > +   data->base_addr =3D pcim_iomap_table(pdev)[0];
> > > +   if (!data->base_addr) {
> > > +           BT_ERR("Failed to get base address");
> > > +           return -ENODEV;
> > > +   }
> > > +
> > > +   err =3D btintel_pcie_setup_irq(data);
> > > +   if (err) {
> > > +           BT_ERR("Failed to setup irq for msix");
> > > +           return err;
> > > +   }
> > > +
> > > +   /* Configure MSI-X with causes list */
> > > +   btintel_pcie_config_msix(data);
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static void btintel_pcie_init_ci(struct btintel_pcie_data *data,
> > > +                            struct ctx_info *ci)
> > > +{
> > > +   ci->version =3D 0x1;
> > > +   ci->size =3D sizeof(*ci);
> > > +   ci->config =3D 0x0000;
> > > +   ci->addr_cr_hia =3D data->ia.cr_hia_p_addr;
> > > +   ci->addr_tr_tia =3D data->ia.tr_tia_p_addr;
> > > +   ci->addr_cr_tia =3D data->ia.cr_tia_p_addr;
> > > +   ci->addr_tr_hia =3D data->ia.tr_hia_p_addr;
> > > +   ci->num_cr_ia =3D NUM_QUEUES;
> > > +   ci->num_tr_ia =3D NUM_QUEUES;
> > > +   ci->addr_urbdq0 =3D data->txq.urbd0s_p_addr;
> > > +   ci->addr_tfdq =3D data->txq.tfds_p_addr;
> > > +   ci->num_tfdq =3D data->txq.count;
> > > +   ci->num_urbdq0 =3D data->txq.count;
> > > +   ci->tfdq_db_vec =3D TXQ_NUM;
> > > +   ci->urbdq0_db_vec =3D TXQ_NUM;
> > > +   ci->rbd_size =3D RBD_SIZE_4K;
> > > +   ci->addr_frbdq =3D data->rxq.frbds_p_addr;
> > > +   ci->num_frbdq =3D data->rxq.count;
> > > +   ci->frbdq_db_vec =3D RXQ_NUM;
> > > +   ci->addr_urbdq1 =3D data->rxq.urbd1s_p_addr;
> > > +   ci->num_urbdq1 =3D data->rxq.count;
> > > +   ci->urbdq_db_vec =3D RXQ_NUM;
> > > +}
> > > +
> > > +static void btintel_pcie_free_txq_bufs(struct btintel_pcie_data *dat=
a,
> > > +                                  struct txq *txq)
> > > +{
> > > +   /* Free data buffers first */
> > > +   dma_free_coherent(&data->pdev->dev, txq->count * BUFFER_SIZE,
> > > +                     txq->buf_v_addr, txq->buf_p_addr);
> > > +   kfree(txq->bufs);
> > > +   BT_DBG("txq buffers are freed");
> > > +}
> > > +
> > > +static int btintel_pcie_setup_txq_bufs(struct btintel_pcie_data *dat=
a,
> > > +                                  struct txq *txq)
> > > +{
> > > +   int err =3D 0, i;
> > > +   struct data_buf *buf;
> > > +
> > > +   if (txq->count =3D=3D 0) {
> > > +           BT_ERR("invalid parameter: txq->count");
> > > +           err =3D -EINVAL;
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   /* Allocate the same number of buffers as the descriptor */
> > > +   txq->bufs =3D kmalloc_array(txq->count, sizeof(*buf), GFP_KERNEL)=
;
> > > +   if (!txq->bufs) {
> > > +           err =3D -ENOMEM;
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   /* Allocate full chunk of data buffer for DMA first and do indexi=
ng and
> > > +    * initialization next, so it can be freed easily
> > > +    */
> > > +   txq->buf_v_addr =3D dma_alloc_coherent(&data->pdev->dev,
> > > +                                        txq->count * BUFFER_SIZE,
> > > +                                        &txq->buf_p_addr,
> > > +                                        GFP_KERNEL | __GFP_NOWARN);
> > > +   if (!txq->buf_v_addr) {
> > > +           BT_ERR("Failed to allocate DMA buf");
> > > +           err =3D -ENOMEM;
> > > +           kfree(txq->bufs);
> > > +           goto exit_error;
> > > +   }
> > > +   memset(txq->buf_v_addr, 0, txq->count * BUFFER_SIZE);
> > > +
> > > +   BT_DBG("alloc bufs: p=3D0x%llx v=3D0x%p", txq->buf_p_addr, txq-
> > >buf_v_addr);
> > > +
> > > +   /* Setup the allocated DMA buffer to bufs. Each data_buf should
> > > +    * have virtual address and physical address
> > > +    */
> > > +   for (i =3D 0; i < txq->count; i++) {
> > > +           buf =3D &txq->bufs[i];
> > > +           buf->data_p_addr =3D txq->buf_p_addr + (i * BUFFER_SIZE);
> > > +           buf->data =3D txq->buf_v_addr + (i * BUFFER_SIZE);
> > > +   }
> > > +
> > > +exit_error:
> > > +   return err;
> > > +}
> > > +
> > > +static void btintel_pcie_free_rxq_bufs(struct btintel_pcie_data *dat=
a,
> > > +                                  struct rxq *rxq)
> > > +{
> > > +   /* Free data buffers first */
> > > +   dma_free_coherent(&data->pdev->dev, rxq->count * BUFFER_SIZE,
> > > +                     rxq->buf_v_addr, rxq->buf_p_addr);
> > > +   kfree(rxq->bufs);
> > > +   BT_DBG("rxq buffers are freed");
> > > +}
> > > +
> > > +static int btintel_pcie_setup_rxq_bufs(struct btintel_pcie_data *dat=
a,
> > > +                                  struct rxq *rxq)
> > > +{
> > > +   int err =3D 0, i;
> > > +   struct data_buf *buf;
> > > +
> > > +   if (rxq->count =3D=3D 0) {
> > > +           BT_ERR("invalid parameter: rxq->count");
> > > +           err =3D -EINVAL;
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   /* Allocate the same number of buffers as the descriptor */
> > > +   rxq->bufs =3D kmalloc_array(rxq->count, sizeof(*buf), GFP_KERNEL)=
;
> > > +   if (!rxq->bufs) {
> > > +           err =3D -ENOMEM;
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   /* Allocate full chunk of data buffer for DMA first and do indexi=
ng and
> > > +    * initialization next, so it can be freed easily
> > > +    */
> > > +   rxq->buf_v_addr =3D dma_alloc_coherent(&data->pdev->dev,
> > > +                                        rxq->count * BUFFER_SIZE,
> > > +                                        &rxq->buf_p_addr,
> > > +                                        GFP_KERNEL | __GFP_NOWARN);
> > > +   if (!rxq->buf_v_addr) {
> > > +           BT_ERR("Failed to allocate DMA buf");
> > > +           err =3D -ENOMEM;
> > > +           kfree(rxq->bufs);
> > > +           goto exit_error;
> > > +   }
> > > +   memset(rxq->buf_v_addr, 0, rxq->count * BUFFER_SIZE);
> > > +
> > > +   BT_DBG("alloc bufs: p=3D0x%llx v=3D0x%p", rxq->buf_p_addr, rxq-
> > >buf_v_addr);
> > > +
> > > +   /* Setup the allocated DMA buffer to bufs. Each data_buf should
> > > +    * have virtual address and physical address
> > > +    */
> > > +   for (i =3D 0; i < rxq->count; i++) {
> > > +           buf =3D &rxq->bufs[i];
> > > +           buf->data_p_addr =3D rxq->buf_p_addr + (i * BUFFER_SIZE);
> > > +           buf->data =3D rxq->buf_v_addr + (i * BUFFER_SIZE);
> > > +   }
> > > +
> > > +exit_error:
> > > +
> > > +   return err;
> > > +}
> > > +
> > > +static void btintel_pcie_setup_ia(struct btintel_pcie_data *data,
> > > +                             dma_addr_t p_addr, void *v_addr,
> > > +                             struct ia *ia)
> > > +{
> > > +   /* TR Head Index Array */
> > > +   ia->tr_hia_p_addr =3D p_addr;
> > > +   ia->tr_hia =3D v_addr;
> > > +
> > > +   /* TR Tail Index Array */
> > > +   ia->tr_tia_p_addr =3D p_addr + sizeof(u16) * NUM_QUEUES;
> > > +   ia->tr_tia =3D v_addr + sizeof(u16) * NUM_QUEUES;
> > > +
> > > +   /* CR Head index Array */
> > > +   ia->cr_hia_p_addr =3D p_addr + (sizeof(u16) * NUM_QUEUES * 2);
> > > +   ia->cr_hia =3D v_addr + (sizeof(u16) * NUM_QUEUES * 2);
> > > +
> > > +   /* CR Tail Index Array */
> > > +   ia->cr_tia_p_addr =3D p_addr + (sizeof(u16) * NUM_QUEUES * 3);
> > > +   ia->cr_tia =3D v_addr + (sizeof(u16) * NUM_QUEUES * 3);
> > > +}
> > > +
> > > +static void btintel_pcie_free(struct btintel_pcie_data *data)
> > > +{
> > > +   btintel_pcie_free_rxq_bufs(data, &data->rxq);
> > > +   btintel_pcie_free_txq_bufs(data, &data->txq);
> > > +
> > > +   dma_pool_free(data->dma_pool, data->dma_v_addr, data-
> > >dma_p_addr);
> > > +   dma_pool_destroy(data->dma_pool);
> > > +   BT_DBG("DMA memory is freed");
> > > +}
> > > +
> > > +/* Allocate tx and rx queues, any related data structures and buffer=
s.
> > > + */
> > > +static int btintel_pcie_alloc(struct btintel_pcie_data *data)
> > > +{
> > > +   int err =3D 0;
> > > +   size_t total;
> > > +   dma_addr_t p_addr;
> > > +   void *v_addr;
> > > +
> > > +   /* Allocate the chunk of DMA memory for descriptors, index array,
> > and
> > > +    * context information, instead of allocating individually.
> > > +    * The DMA memory for data buffer is allocated while setting up t=
he
> > > +    * each queue.
> > > +    *
> > > +    * Total size is sum of the following
> > > +    *  + size of TFD * Number of descriptors in queue
> > > +    *  + size of URBD0 * Number of descriptors in queue
> > > +    *  + size of FRBD * Number of descriptors in queue
> > > +    *  + size of URBD1 * Number of descriptors in queue
> > > +    *  + size of index * Number of queues(2) * type of index array(4=
)
> > > +    *  + size of context information
> > > +    */
> > > +   total =3D (sizeof(struct tfd) + sizeof(struct urbd0) + sizeof(str=
uct frbd)
> > > +           + sizeof(struct urbd1)) * DESCS_COUNT;
> > > +
> > > +   /* Add the sum of size of index array and size of ci struct */
> > > +   total +=3D (sizeof(u16) * NUM_QUEUES * 4) + sizeof(struct ctx_inf=
o);
> > > +
> > > +   /* Allocate DMA Pool */
> > > +   data->dma_pool =3D dma_pool_create(KBUILD_MODNAME, &data-
> > >pdev->dev,
> > > +                                    total, DMA_POOL_ALIGNMENT, 0);
> > > +   if (!data->dma_pool) {
> > > +           BT_ERR("Failed to allocate dma pool for queues");
> > > +           err =3D -ENOMEM;
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   v_addr =3D dma_pool_zalloc(data->dma_pool, GFP_KERNEL |
> > __GFP_NOWARN,
> > > +                            &p_addr);
> > > +   if (!v_addr) {
> > > +           BT_ERR("Failed to alloc dma memory for queues");
> > > +           dma_pool_destroy(data->dma_pool);
> > > +           err =3D -ENOMEM;
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   data->dma_p_addr =3D p_addr;
> > > +   data->dma_v_addr =3D v_addr;
> > > +
> > > +   BT_DBG("dma pool: p_addr=3D0x%llx v_addr=3D0x%p", p_addr, v_addr)=
;
> > > +
> > > +   /* Setup descriptor count */
> > > +   data->txq.count =3D DESCS_COUNT;
> > > +   data->rxq.count =3D DESCS_COUNT;
> > > +
> > > +   /* Setup tfds */
> > > +   data->txq.tfds_p_addr =3D p_addr;
> > > +   data->txq.tfds =3D v_addr;
> > > +
> > > +   p_addr +=3D (sizeof(struct tfd) * DESCS_COUNT);
> > > +   v_addr +=3D (sizeof(struct tfd) * DESCS_COUNT);
> > > +
> > > +   /* Setup urbd0 */
> > > +   data->txq.urbd0s_p_addr =3D p_addr;
> > > +   data->txq.urbd0s =3D v_addr;
> > > +
> > > +   p_addr +=3D (sizeof(struct urbd0) * DESCS_COUNT);
> > > +   v_addr +=3D (sizeof(struct urbd0) * DESCS_COUNT);
> > > +
> > > +   /* Setup frbd */
> > > +   data->rxq.frbds_p_addr =3D p_addr;
> > > +   data->rxq.frbds =3D v_addr;
> > > +
> > > +   p_addr +=3D (sizeof(struct frbd) * DESCS_COUNT);
> > > +   v_addr +=3D (sizeof(struct frbd) * DESCS_COUNT);
> > > +
> > > +   /* Setup urbd1 */
> > > +   data->rxq.urbd1s_p_addr =3D p_addr;
> > > +   data->rxq.urbd1s =3D v_addr;
> > > +
> > > +   p_addr +=3D (sizeof(struct urbd1) * DESCS_COUNT);
> > > +   v_addr +=3D (sizeof(struct urbd1) * DESCS_COUNT);
> > > +
> > > +   /* Setup data buffers for txq */
> > > +   err =3D btintel_pcie_setup_txq_bufs(data, &data->txq);
> > > +   if (err) {
> > > +           BT_ERR("Failed to setup txq buffers: %d", err);
> > > +           goto exit_error_pool;
> > > +   }
> > > +
> > > +   /* Setup data buffers for rxq */
> > > +   err =3D btintel_pcie_setup_rxq_bufs(data, &data->rxq);
> > > +   if (err) {
> > > +           BT_ERR("Failed to allocate rxq buffers: %d", err);
> > > +           goto exit_error_txq;
> > > +   }
> > > +
> > > +   /* Setup Index Array */
> > > +   btintel_pcie_setup_ia(data, p_addr, v_addr, &data->ia);
> > > +
> > > +   /* Setup Context Information */
> > > +   p_addr +=3D sizeof(u16) * NUM_QUEUES * 4;
> > > +   v_addr +=3D sizeof(u16) * NUM_QUEUES * 4;
> > > +
> > > +   data->ci =3D v_addr;
> > > +   data->ci_p_addr =3D p_addr;
> > > +
> > > +   /* Initialize the CI */
> > > +   btintel_pcie_init_ci(data, data->ci);
> > > +
> > > +   return 0;
> > > +
> > > +exit_error_txq:
> > > +   btintel_pcie_free_txq_bufs(data, &data->txq);
> > > +exit_error_pool:
> > > +   dma_pool_free(data->dma_pool, data->dma_v_addr, data-
> > >dma_p_addr);
> > > +   dma_pool_destroy(data->dma_pool);
> > > +exit_error:
> > > +   return err;
> > > +}
> > > +
> > > +static void btintel_pcie_release_hdev(struct btintel_pcie_data *data=
)
> > > +{
> > > +   struct hci_dev *hdev;
> > > +
> > > +   hdev =3D data->hdev;
> > > +   if (hdev) {
> > > +           hci_unregister_dev(hdev);
> > > +           hci_free_dev(hdev);
> > > +   }
> > > +   data->hdev =3D NULL;
> > > +}
> > > +
> > > +static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
> > > +{
> > > +   /* TODO: initialize hdev and assign the callbacks to hdev */
> > > +   return -ENODEV;
> > > +}
> > > +
> > > +static int btintel_pcie_probe(struct pci_dev *pdev,
> > > +                         const struct pci_device_id *ent)
> > > +{
> > > +   int err;
> > > +   struct btintel_pcie_data *data;
> > > +
> > > +   if (!pdev)
> > > +           return -ENODEV;
> > > +
> > > +   data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > > +   if (!data)
> > > +           return -ENOMEM;
> > > +
> > > +   /* initialize the btintel_pcie data struct */
> > > +   data->pdev =3D pdev;
> > > +
> > > +   spin_lock_init(&data->irq_lock);
> > > +   spin_lock_init(&data->hci_rx_lock);
> > > +
> > > +   init_waitqueue_head(&data->gp0_wait_q);
> > > +   data->gp0_received =3D false;
> > > +
> > > +   init_waitqueue_head(&data->tx_wait_q);
> > > +   data->tx_wait_done =3D false;
> > > +
> > > +   data->workqueue =3D alloc_ordered_workqueue(KBUILD_MODNAME,
> > WQ_HIGHPRI);
> > > +   if (!data->workqueue) {
> > > +           BT_ERR("Failed to create workqueue");
> > > +           return -ENOMEM;
> > > +   }
> > > +   skb_queue_head_init(&data->rx_skb_q);
> > > +   INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
> > > +
> > > +   data->boot_stage_cache =3D 0x00;
> > > +   data->img_resp_cache =3D 0x00;
> > > +
> > > +   /* PCIe specific all to configure it for this device includes
> > > +    * enabling pice device, setting master, reading BAR[0], configur=
ing
> > > +    * MSIx, setting DMA mask, and save the driver data.
> > > +    */
> > > +   err =3D btintel_pcie_config_pcie(pdev, data);
> > > +   if (err) {
> > > +           BT_ERR("Failed to config pcie (%d)", err);
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   /* Set driver data for this PCI device */
> > > +   pci_set_drvdata(pdev, data);
> > > +
> > > +   /* allocate the IPC struct */
> > > +   err =3D btintel_pcie_alloc(data);
> > > +   if (err) {
> > > +           BT_ERR("Failed to allocate queues(%d)", err);
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   /* Enable BT function */
> > > +   err =3D btintel_pcie_enable_bt(data);
> > > +   if (err) {
> > > +           BT_ERR("Failed to start bluetooth device(%d)", err);
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   /* CNV information (CNVi and CNVr) is in CSR */
> > > +   data->cnvi =3D btintel_pcie_rd_reg32(data, CSR_HW_REV_REG);
> > > +   BT_DBG("cnvi:   0x%08x", data->cnvi);
> > > +
> > > +   data->cnvr =3D btintel_pcie_rd_reg32(data, CSR_RF_ID_REG);
> > > +   BT_DBG("cnvr:   0x%08x", data->cnvr);
> > > +
> > > +   err =3D btintel_pcie_start_rx(data);
> > > +   if (err) {
> > > +           BT_ERR("Failed to start rx (%d)", err);
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   err =3D btintel_pcie_setup_hdev(data);
> > > +   if (err) {
> > > +           BT_ERR("Failed to setup HCI module");
> > > +           goto exit_error;
> > > +   }
> > > +
> > > +   return 0;
> > > +
> > > +exit_error:
> > > +   /* reset device before leave */
> > > +   btintel_pcie_reset_bt(data);
> > > +
> > > +   /* clear bus mastering */
> > > +   pci_clear_master(pdev);
> > > +
> > > +   /* Unset driver data for PCI device */
> > > +   pci_set_drvdata(pdev, NULL);
> > > +
> > > +   return err;
> > > +}
> > > +
> > > +static void btintel_pcie_remove(struct pci_dev *pdev)
> > > +{
> > > +   struct btintel_pcie_data *data;
> > > +
> > > +   if (!pdev) {
> > > +           BT_ERR("Invalid parameter: pdev");
> > > +           return;
> > > +   }
> > > +
> > > +   data =3D pci_get_drvdata(pdev);
> > > +   if (!data) {
> > > +           BT_ERR("data is empty");
> > > +           return;
> > > +   }
> > > +
> > > +   btintel_pcie_release_hdev(data);
> > > +
> > > +   flush_work(&data->rx_work);
> > > +
> > > +   destroy_workqueue(data->workqueue);
> > > +
> > > +   btintel_pcie_free(data);
> > > +
> > > +   /* reset device before leave */
> > > +   btintel_pcie_reset_bt(data);
> > > +
> > > +   /* clear bus mastering */
> > > +   pci_clear_master(pdev);
> > > +
> > > +   /* Unset driver data for PCI device */
> > > +   pci_set_drvdata(pdev, NULL);
> > > +}
> > > +
> > > +#ifdef CONFIG_PM
> > > +static int btintel_pcie_suspend(struct device *dev)
> > > +{
> > > +   /* TODO: Add support suspend */
> > > +   return 0;
> > > +}
> > > +
> > > +static int btintel_pcie_resume(struct device *dev)
> > > +{
> > > +   /* TODO: Add support resume */
> > > +   return 0;
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
> > > +                                                   btintel_pcie_resu=
me);
> > > +#endif /* CONFIG_PM */
> > > +
> > > +static struct pci_driver btintel_pcie_driver =3D {
> > > +   .name =3D KBUILD_MODNAME,
> > > +   .id_table =3D btintel_pcie_table,
> > > +   .probe =3D btintel_pcie_probe,
> > > +   .remove =3D btintel_pcie_remove,
> > > +#ifdef CONFIG_PM
> > > +   .driver.pm =3D &btintel_pcie_pm_ops,
> > > +#endif /* CONFIG_PM */
> > > +};
> > > +module_pci_driver(btintel_pcie_driver);
> > > +
> > > +MODULE_AUTHOR("Tedd Ho-Jeong An <tedd.an@intel.com>");
> > > +MODULE_DESCRIPTION("Intel Bluetooth PCIe transport driver ver "
> > VERSION);
> > > +MODULE_VERSION(VERSION);
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/drivers/bluetooth/btintel_pcie.h
> > b/drivers/bluetooth/btintel_pcie.h
> > > new file mode 100644
> > > index 000000000000..1554964686bd
> > > --- /dev/null
> > > +++ b/drivers/bluetooth/btintel_pcie.h
> > > @@ -0,0 +1,449 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + * Intel Bluetooth PCIE driver
> > > + *
> > > + * Copyright (C) 2017 Intel Corporation. All rights reserved.
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU General Public License versi=
on
> > > + * 2 as published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + * Copyright (C) 2022  Intel Corporation
> >
> > Ditto.
> Ack.
>
> >
> > > + *
> > > + * Intel Bluetooth Driver for PCIE interface.
> > > + */
> > > +
> > > +/* Control and Status Register(CSR) */
> > > +#define CSR_BASE                   (0x000)
> > > +#define CSR_FUNC_CTRL_REG          (CSR_BASE + 0x024)
> > > +#define CSR_HW_REV_REG                     (CSR_BASE + 0x028)
> > > +#define CSR_RF_ID_REG                      (CSR_BASE + 0x09C)
> > > +#define CSR_BOOT_STAGE_REG         (CSR_BASE + 0x108)
> > > +#define CSR_CI_ADDR_LSB_REG                (CSR_BASE + 0x118)
> > > +#define CSR_CI_ADDR_MSB_REG                (CSR_BASE + 0x11C)
> > > +#define CSR_IMG_RESPONSE_REG               (CSR_BASE + 0x12C)
> > > +#define CSR_HBUS_TARG_WRPTR                (CSR_BASE + 0x460)
> > > +
> > > +/* CSR Function Control Register */
> > > +#define CSR_FUNC_CTRL_FUNC_ENA             (BIT(0))
> > > +#define CSR_FUNC_CTRL_MAC_INIT             (BIT(6))
> > > +#define CSR_FUNC_CTRL_FUNC_INIT            (BIT(7))
> > > +#define CSR_FUNC_CTRL_MAC_ACCESS_STS       (BIT(20))
> > > +#define CSR_FUNC_CTRL_SW_RESET             (BIT(31))
> > > +
> > > +/* Value for CSR_BOOT_STAGE register */
> > > +#define CSR_BOOT_STAGE_ROM         (BIT(0))
> > > +#define CSR_BOOT_STAGE_IML         (BIT(1))
> > > +#define CSR_BOOT_STAGE_OPFW                (BIT(2))
> > > +#define CSR_BOOT_STAGE_ROM_LOCKDOWN        (BIT(10))
> > > +#define CSR_BOOT_STAGE_IML_LOCKDOWN        (BIT(11))
> > > +#define CSR_BOOT_STAGE_MAC_ACCESS_ON       (BIT(16))
> > > +#define CSR_BOOT_STAGE_ALIVE               (BIT(23))
> > > +
> > > +/* Registers for MSIX */
> > > +#define CSR_MSIX_BASE                      (0x2000)
> > > +#define CSR_MSIX_FH_INT_CAUSES             (CSR_MSIX_BASE + 0x0800)
> > > +#define CSR_MSIX_FH_INT_MASK               (CSR_MSIX_BASE + 0x0804)
> > > +#define CSR_MSIX_HW_INT_CAUSES             (CSR_MSIX_BASE +
> > 0x0808)
> > > +#define CSR_MSIX_HW_INT_MASK               (CSR_MSIX_BASE + 0x080C)
> > > +#define CSR_MSIX_AUTOMASK_ST               (CSR_MSIX_BASE + 0x0810)
> > > +#define CSR_MSIX_AUTOMASK_EN               (CSR_MSIX_BASE + 0x0814)
> > > +#define CSR_MSIX_IVAR_BASE         (CSR_MSIX_BASE + 0x0880)
> > > +#define CSR_MSIX_IVAR(cause)               (CSR_MSIX_IVAR_BASE +
> > (cause))
> > > +
> > > +/* Causes for the FH register interrupts */
> > > +enum msix_fh_int_causes {
> > > +   MSIX_FH_INT_CAUSES_0            =3D BIT(0),       /* cause 0 */
> > > +   MSIX_FH_INT_CAUSES_1            =3D BIT(1),       /* cause 1 */
> > > +};
> > > +
> > > +/* Causes for the HW register interrupts */
> > > +enum msix_hw_int_causes {
> > > +   MSIX_HW_INT_CAUSES_GP0          =3D BIT(0),       /* cause 32 */
> > > +};
> > > +
> > > +#define MSIX_NON_AUTO_CLEAR_CAUSE  BIT(7)
> > > +
> > > +/* Minimum and Maximum number of MSIx Vector
> > > + * Intel Bluetooth PCIe support only 1 vector
> > > + */
> > > +#define MSIX_VEC_MAX                       1
> > > +#define MSIX_VEC_MIN                       1
> > > +
> > > +/* Default Poll time for MAC access during init*/
> >
> > Missing space at the end.
> Ack.
>
> >
> > > +#define DEFAULT_MAC_ACCESS_TIMEOUT 200000
> >
> > Please specify the unit in the name.
> >
> Ack.
>
> > > +
> > > +/* Default interrupt timeout in msec */
> > > +#define DEFAULT_INTR_TIMEOUT               3000
> >
> > Ditto.
> Ack.
>
> >
> > > +
> > > +/* The number of descriptors in TX/RX queues */
> > > +#define DESCS_COUNT                16
> > > +
> > > +/* Number of Queue for TX and RX
> > > + * It indicates the index of the IA(Index Array)
> > > + */
> > > +enum {
> > > +   TXQ_NUM =3D 0,
> > > +   RXQ_NUM =3D 1,
> > > +   NUM_QUEUES =3D 2,
> > > +};
> > > +
> > > +/* The size of DMA buffer for TX and RX */
> > > +#define BUFFER_SIZE                        4096
> >
> > Is that bytes?
> Yes. I will update the same in the above comment.
> >
> > > +
> > > +/* DMA allocation alignment */
> > > +#define DMA_POOL_ALIGNMENT         256
> > > +
> > > +/* TX wait time (jiffies) */
> > > +#define TX_WAIT_TIMEOUT                    500
> >
> > Please add the unit to the name.
> Ack.
>
> >
> > > +
> > > +/* Number of pending RX requests for downlink */
> > > +#define RX_MAX_QUEUE                       6
> > > +
> > > +/* Enum for RBD buffer size mappting */
> > > +enum {
> > > +   RBD_SIZE_1K =3D 0x1,
> > > +   RBD_SIZE_2K =3D 0x2,
> > > +   RBD_SIZE_4K =3D 0x4,
> > > +   RBD_SIZE_8K =3D 0x8,
> > > +   RBD_SIZE_12K =3D 0x9,
> > > +   RBD_SIZE_16K =3D 0xA,
> > > +   RBD_SIZE_20K =3D 0xB,
> > > +   RBD_SIZE_24K =3D 0xC,
> > > +   RBD_SIZE_28K =3D 0xD,
> > > +   RBD_SIZE_32K =3D 0xE,
> > > +};
> > > +
> > > +/*
> > > + * Struct for Context Information (v2)
> > > + *
> > > + * All members are write-only for host and read-only for device.
> > > + *
> > > + * @version: Version of context information
> > > + * @size: Size of context information
> > > + * @config: Config with which host wants peripheral to execute
> > > + * Subset of capability register published by device
> > > + * @addr_tr_hia: Address of TR Head Index Array
> > > + * @addr_tr_tia: Address of TR Tail Index Array
> > > + * @addr_cr_hia: Address of CR Head Index Array
> > > + * @addr_cr_tia: Address of CR Tail Index Array
> > > + * @num_tr_ia: Number of entries in TR Index Arrays
> > > + * @num_cr_ia: Number of entries in CR Index Arrays
> > > + * @rbd_siz: RBD Size { 0x4=3D4K }
> > > + * @addr_tfdq: Address of TFD Queue(tx)
> > > + * @addr_urbdq0: Address of URBD Queue(tx)
> > > + * @num_tfdq: Number of TFD in TFD Queue(tx)
> > > + * @num_urbdq0: Number of URBD in URBD Queue(tx)
> > > + * @tfdq_db_vec: Queue number of TFD
> > > + * @urbdq0_db_vec: Queue number of URBD
> > > + * @addr_frbdq: Address of FRBD Queue(rx)
> > > + * @addr_urbdq1: Address of URBD Queue(rx)
> > > + * @num_frbdq: Number of FRBD in FRBD Queue(rx)
> > > + * @frbdq_db_vec: Queue number of FRBD
> > > + * @num_urbdq1: Number of URBD in URBD Queue(rx)
> > > + * @urbdq_db_vec: Queue number of URBDQ1
> > > + * @tr_msi_vec: Transfer Ring MSI Vector
> > > + * @cr_msi_vec: Completion Ring MSI Vector
> > > + * @dbgc_addr: DBGC first fragmemt address
> > > + * @dbgc_size: DBGC buffer size
> > > + * @early_enable: Enarly debug enable
> >
> > Early
> Ack.
>
> >
> > > + * @dbg_output_mode: Debug output mode
> > > + * Bit[4] DBGC O/P { 0=3DSRAM, 1=3DDRAM(not relevant for NPK) }
> > > + * Bit[5] DBGC I/P { 0=3DBDBG, 1=3DDBGI }
> > > + * Bits[6:7] DBGI O/P(relevant if bit[5] =3D 1)
> > > + *  0=3DBT DBGC, 1=3DWiFi DBGC, 2=3DNPK }
> > > + * @dbg_preset: Debug preset
> > > + * @ext_addr: Address of context information extension
> > > + * @ext_size: Size of context information part
> > > + *
> > > + * Total 38 DWords
> > > + *
> > > + */
> > > +struct ctx_info {
> > > +   u16     version;
> > > +   u16     size;
> > > +   u32     config;
> > > +   u32     reserved_dw02;
> > > +   u32     reserved_dw03;
> > > +   u64     addr_tr_hia;
> > > +   u64     addr_tr_tia;
> > > +   u64     addr_cr_hia;
> > > +   u64     addr_cr_tia;
> > > +   u16     num_tr_ia;
> > > +   u16     num_cr_ia;
> > > +   u32     rbd_size:4,
> > > +           reserved_dw13:28;
> > > +   u64     addr_tfdq;
> > > +   u64     addr_urbdq0;
> > > +   u16     num_tfdq;
> > > +   u16     num_urbdq0;
> > > +   u16     tfdq_db_vec;
> > > +   u16     urbdq0_db_vec;
> > > +   u64     addr_frbdq;
> > > +   u64     addr_urbdq1;
> > > +   u16     num_frbdq;
> > > +   u16     frbdq_db_vec;
> > > +   u16     num_urbdq1;
> > > +   u16     urbdq_db_vec;
> > > +   u16     tr_msi_vec;
> > > +   u16     cr_msi_vec;
> > > +   u32     reserved_dw27;
> > > +   u64     dbgc_addr;
> > > +   u32     dbgc_size;
> > > +   u32     early_enable:1,
> > > +           reserved_dw31:3,
> > > +           dbg_output_mode:4,
> > > +           dbg_preset:8,
> > > +           reserved2_dw31:16;
> > > +   u64     ext_addr;
> > > +   u32     ext_size;
> > > +   u32     test_param;
> > > +   u32     reserved_dw36;
> > > +   u32     reserved_dw37;
> > > +} __packed;
> > > +
> > > +/* Transfer Descriptor for TX
> > > + * @type: Not in use. Set to 0x0
> > > + * @size: Size of data in the buffer
> > > + * @addr: DMA Address of buffer
> > > + */
> > > +struct tfd {
> > > +   u8      type;
> > > +   u16     size;
> > > +   u8      reserved;
> > > +   u64     addr;
> > > +   u32     reserved1;
> > > +} __packed;
> > > +
> > > +/* URB Descriptor for TX
> > > + * @tfd_index: Index of TFD in TFDQ + 1
> > > + * @num_txq: Queue index of TFD Queue
> > > + * @cmpl_count: Completion count. Always 0x01
> > > + * @immediate_cmpl: Immediate completion flag: Always 0x01
> > > + */
> > > +struct urbd0 {
> > > +   u32     tfd_index:16,
> > > +           num_txq:8,
> > > +           cmpl_count:4,
> > > +           reserved:3,
> > > +           immediate_cmpl:1;
> > > +} __packed;
> > > +
> > > +/* FRB Descriptor for RX
> > > + * @tag: RX buffer tag (index of RX buffer queue)
> > > + * @addr: Address of buffer
> > > + */
> > > +struct frbd {
> > > +   u32     tag:16,
> > > +           reserved:16;
> > > +   u32     reserved2;
> > > +   u64     addr;
> > > +} __packed;
> > > +
> > > +/* URB Descriptor for RX
> > > + * @frbd_tag: Tag from FRBD
> > > + * @status: Status
> > > + */
> > > +struct urbd1 {
> > > +   u32     frbd_tag:16,
> > > +           status:1,
> > > +           reserved:14,
> > > +           fixed:1;
> > > +} __packed;
> > > +
> > > +/* RFH header in RX packet
> > > + * @packet_len: Length of the data in the buffer
> > > + * @rxq: RX Queue number
> > > + * @cmd_id: Command ID. Not in Use
> > > + */
> > > +struct rfh_hdr {
> > > +   u64     packet_len:16,
> > > +           rxq:6,
> > > +           reserved:10,
> > > +           cmd_id:16,
> > > +           reserved1:16;
> > > +} __packed;
> > > +
> > > +/* Internal data buffer
> > > + * @data: pointer to the data buffer
> > > + * @p_addr: physical address of data buffer
> > > + */
> > > +struct data_buf {
> > > +   u8              *data;
> > > +   dma_addr_t      data_p_addr;
> > > +};
> > > +
> > > +/* Index Array */
> > > +struct ia {
> > > +   dma_addr_t      tr_hia_p_addr;
> > > +   u16             *tr_hia;
> > > +   dma_addr_t      tr_tia_p_addr;
> > > +   u16             *tr_tia;
> > > +   dma_addr_t      cr_hia_p_addr;
> > > +   u16             *cr_hia;
> > > +   dma_addr_t      cr_tia_p_addr;
> > > +   u16             *cr_tia;
> > > +};
> > > +
> > > +/* Structure for TX Queue
> > > + * @count: Number of descriptors
> > > + * @tfds: Array of TFD
> > > + * @urbd0s: Array of URBD0
> > > + * @buf: Array of data_buf structure
> > > + */
> > > +struct txq {
> > > +   u16             count;
> > > +
> > > +   dma_addr_t      tfds_p_addr;
> > > +   struct tfd      *tfds;
> > > +
> > > +   dma_addr_t      urbd0s_p_addr;
> > > +   struct urbd0    *urbd0s;
> > > +
> > > +   dma_addr_t      buf_p_addr;
> > > +   void            *buf_v_addr;
> > > +   struct data_buf *bufs;
> > > +};
> > > +
> > > +/* Structure for RX Queue
> > > + * @count: Number of descriptors
> > > + * @frbds: Array of FRBD
> > > + * @urbd1s: Array of URBD1
> > > + * @buf: Array of data_buf structure
> > > + */
> > > +struct rxq {
> > > +   u16             count;
> > > +
> > > +   dma_addr_t      frbds_p_addr;
> > > +   struct frbd     *frbds;
> > > +
> > > +   dma_addr_t      urbd1s_p_addr;
> > > +   struct urbd1    *urbd1s;
> > > +
> > > +   dma_addr_t      buf_p_addr;
> > > +   void            *buf_v_addr;
> > > +   struct data_buf *bufs;
> > > +};
> > > +
> > > +/* struct btintel_pcie_data
> > > + * @pdev: pci device
> > > + * @hdev: hdev device
> > > + * @flags: driver state
> > > + * @irq_lock: spinlock for MSIX
> > > + * @hci_rx_lock: spinlock for HCI RX flow
> > > + * @base_addr: pci base address (from BAR)
> > > + * @msix_entries: array of MSIX entries
> > > + * @msix_enabled: true if MSIX is enabled;
> > > + * @alloc_vecs: number of interrupt vectors allocated
> > > + * @def_irq: default irq for all causes
> > > + * @fh_init_mask: initial unmasked rxq causes
> > > + * @hw_init_mask: initial unmaksed hw causes
> > > + * @boot_stage_cache: cached value of boot stage register
> > > + * @img_resp_cache: cached value of image response register
> > > + * @cnvi: CNVi register value
> > > + * @cnvr: CNVr register value
> > > + * @gp0_received: condition for gp0 interrupt
> > > + * @gp0_wait_q: wait_q for gp0 interrupt
> > > + * @tx_wait_done: condition for tx interrupt
> > > + * @tx_wait_q: wait_q for tx interrupt
> > > + * @workqueue: workqueue for RX work
> > > + * @rx_skb_q: SKB queue for RX packet
> > > + * @rx_work: RX work struct to process the RX packet in @rx_skb_q
> > > + * @dma_pool: DMA pool for descriptors, index array and ci
> > > + * @dma_p_addr: DMA address for pool
> > > + * @dma_v_addr: address of pool
> > > + * @ci_p_addr: DMA address for CI struct
> > > + * @ci: CI struct
> > > + * @ia: Index Array struct
> > > + * @txq: TX Queue struct
> > > + * @rxq: RX Queue struct
> > > + */
> > > +struct btintel_pcie_data {
> > > +   struct pci_dev  *pdev;
> > > +   struct hci_dev  *hdev;
> > > +
> > > +   unsigned long   flags;
> > > +   /* lock used in MSIX interrupt */
> > > +   spinlock_t      irq_lock;
> > > +   /* lock to serialize rx events */
> > > +   spinlock_t      hci_rx_lock;
> > > +
> > > +   void __iomem    *base_addr;
> > > +
> > > +   struct msix_entry       msix_entries[MSIX_VEC_MAX];
> > > +   bool    msix_enabled;
> > > +   u32     alloc_vecs;
> > > +   u32     def_irq;
> > > +
> > > +   u32     fh_init_mask;
> > > +   u32     hw_init_mask;
> > > +
> > > +   u32     boot_stage_cache;
> > > +   u32     img_resp_cache;
> > > +
> > > +   u32     cnvi;
> > > +   u32     cnvr;
> > > +
> > > +   bool    gp0_received;
> > > +   wait_queue_head_t       gp0_wait_q;
> > > +
> > > +   bool    tx_wait_done;
> > > +   wait_queue_head_t       tx_wait_q;
> > > +
> > > +   struct workqueue_struct *workqueue;
> > > +   struct sk_buff_head     rx_skb_q;
> > > +   struct work_struct      rx_work;
> > > +
> > > +   struct dma_pool *dma_pool;
> > > +   dma_addr_t      dma_p_addr;
> > > +   void            *dma_v_addr;
> > > +
> > > +   dma_addr_t      ci_p_addr;
> > > +   struct ctx_info *ci;
> > > +   struct ia       ia;
> > > +   struct txq      txq;
> > > +   struct rxq      rxq;
> > > +};
> > > +
> > > +static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *da=
ta,
> > > +                                   u32 offset)
> > > +{
> > > +   return ioread32(data->base_addr + offset);
> > > +}
> > > +
> > > +static inline void btintel_pcie_wr_reg8(struct btintel_pcie_data *da=
ta,
> > > +                                   u32 offset, u8 val)
> > > +{
> > > +   iowrite8(val, data->base_addr + offset);
> > > +}
> > > +
> > > +static inline void btintel_pcie_wr_reg32(struct btintel_pcie_data *d=
ata,
> > > +                                    u32 offset, u32 val)
> > > +{
> > > +   iowrite32(val, data->base_addr + offset);
> > > +}
> > > +
> > > +static inline void btintel_pcie_set_reg_bits(struct btintel_pcie_dat=
a *data,
> > > +                                        u32 offset, u32 bits)
> > > +{
> > > +   u32 r;
> > > +
> > > +   r =3D ioread32(data->base_addr + offset);
> > > +   r |=3D bits;
> > > +   iowrite32(r, data->base_addr + offset);
> > > +}
> > > +
> > > +static inline void btintel_pcie_clr_reg_bits(struct btintel_pcie_dat=
a *data,
> > > +                                        u32 offset, u32 bits)
> > > +{
> > > +   u32 r;
> > > +
> > > +   r =3D ioread32(data->base_addr + offset);
> > > +   r &=3D ~bits;
> > > +   iowrite32(r, data->base_addr + offset);
> > > +}
> >
> >
> > Kind regards,
> >
> > Paul
>
> Thanks,
> Kiran
>


--=20
Luiz Augusto von Dentz

