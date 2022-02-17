Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0F74BACFB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 23:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiBQW7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 17:59:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiBQW7x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 17:59:53 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DBA281985
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 14:59:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lw4so10657357ejb.12
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 14:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZZr4u1F7q0TNUVjy94cng8Amu3zRRKq2aiETFgnadVw=;
        b=I8yJhWzB1aXbElkPkoP4Um+SH7lye/b0lpa1CMK0w5F099OZ8yNT++sWsssLXZmN3q
         carbvVB2rrxHaB37x753hkS5yNaljmQRGFnLB4Jugvp+sAxnWRSFvcUn/wv6tDLkrYT8
         HPiR+F3+z1ein6Qjdp4cNKJuYCBIsSNBKo3/KLhQgGtM4kfOCySG1q+HXBYHymZ27E5C
         OTaz9tftXoDeKxg6kBDuPEAg39p/gCcrc4giZ7P0q3Jc3tJPYie8RMeHlkbKgMCZv2QO
         8MZjS8QTtbqNwZz8YYLxaROMHU0/tuz1eskj0MmMGnSdYmdczKeMFjL8YnfFOEvQVQWt
         NONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZZr4u1F7q0TNUVjy94cng8Amu3zRRKq2aiETFgnadVw=;
        b=w006w5GmM/zkxUhSADPhLErhV/1kqFB4OuDj2Pg1X6nu/pvhPyvmg4hkN+wLJ6ENip
         UnKqp6xojkbXpzEjVPkf/IOLUtferuPqFnGam2ZZTJ14fwnIhQKwIICFi95vv+ebKid+
         OeJ8cW5wtITnvp0Gq2siKw25g5ZQBQakc5Ne6m5uUyMvayQH+gN8ziacPPfpUzgP1Ayd
         BGQV8YuG7J5mblYsuVBEj2sob9bzVLnx/pZRRgcr1gXMeuyOF0jtuzT5cT5Twi+oP8Wj
         Rg3KIQeuj+5oN+3IDHEGXXw1ppYcyvm/osBQc8O9w+jHPIGIX7gNmLQsLVw4eyS0huXx
         BWBw==
X-Gm-Message-State: AOAM530sU0GWnMhB4YoASqCl22SxM5XVAHkLtJFlTXWBBHbdSB1KbIvo
        xLgLROEPqN5uaZcPCWVsLuwoiaAxHfI3PyylM4o=
X-Google-Smtp-Source: ABdhPJy28VfpfgbuI8xsLgeO0wh3xdaoN82ni3+pPSi6gAyGtYCFCP86QgXMM2Hra7Z3mHRlG31UWVbSsu1NFJgp9AA=
X-Received: by 2002:a17:906:7245:b0:6cf:d3c6:8c63 with SMTP id
 n5-20020a170906724500b006cfd3c68c63mr3942300ejk.677.1645138770957; Thu, 17
 Feb 2022 14:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20220215053844.7119-4-Frank.Li@nxp.com> <20220217223849.GA309053@bhelgaas>
In-Reply-To: <20220217223849.GA309053@bhelgaas>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 17 Feb 2022 16:59:20 -0600
Message-ID: <CAHrpEqQEkLgekOHwKnbF+tEgHFv5b6x0PZ6tR-p2CeigVBo_fA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] NTB: EPF: support NTB transfer between PCI RC and
 EP connection
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 17, 2022 at 4:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Jon, Dave, Allen, linux-ntb]
>
> This patch only touches drivers/pci; the subject line should reflect
> that to help people know which things to look at.
>
> Maybe something like:
>
>   PCI: endpoint: Support NTB transfer between RC and EP
>
> On Mon, Feb 14, 2022 at 11:38:43PM -0600, Frank Li wrote:
> > Add NTB function driver and virtual PCI BUS and Virtual NTB driver
> > to implement communication between PCIe RC and PCIe EP devices
>
> s/PCI BUS/PCI Bus/
> s/PCIe RC/PCIe Root Port/ (I think; the RC itself doesn't have a
> software representation)
>
> > =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90         =E2=94=8C=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> > =E2=94=82            =E2=94=82         =E2=94=82                       =
              =E2=94=82
> > =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=94=82=
                      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=A4
> > =E2=94=82 NTB        =E2=94=82         =E2=94=82                      =
=E2=94=82 NTB          =E2=94=82
> > =E2=94=82 NetDev     =E2=94=82         =E2=94=82                      =
=E2=94=82 NetDev       =E2=94=82
> > =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=94=82=
                      =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=A4
> > =E2=94=82 NTB        =E2=94=82         =E2=94=82                      =
=E2=94=82 NTB          =E2=94=82
> > =E2=94=82 Transfer   =E2=94=82         =E2=94=82                      =
=E2=94=82 Transfer     =E2=94=82
> > =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=94=82=
                      =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=A4
> > =E2=94=82            =E2=94=82         =E2=94=82                      =
=E2=94=82              =E2=94=82
> > =E2=94=82  PCI NTB   =E2=94=82         =E2=94=82                      =
=E2=94=82              =E2=94=82
> > =E2=94=82    EPF     =E2=94=82         =E2=94=82                      =
=E2=94=82              =E2=94=82
> > =E2=94=82   Driver   =E2=94=82         =E2=94=82                      =
=E2=94=82 PCI Virtual  =E2=94=82
> > =E2=94=82            =E2=94=82         =E2=94=9C=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =E2=94=82 NTB Driver =
  =E2=94=82
> > =E2=94=82            =E2=94=82         =E2=94=82 PCI EP NTB    =E2=94=
=82=E2=97=84=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA=E2=94=82         =
     =E2=94=82
> > =E2=94=82            =E2=94=82         =E2=94=82  FN Driver    =E2=94=
=82      =E2=94=82              =E2=94=82
> > =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=94=9C=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4      =
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> > =E2=94=82            =E2=94=82         =E2=94=82               =E2=94=
=82      =E2=94=82              =E2=94=82
> > =E2=94=82  PCI BUS   =E2=94=82 =E2=97=84=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=96=BA =E2=94=82  PCI EP BUS   =E2=94=82      =E2=94=82  =
Virtual PCI =E2=94=82
> > =E2=94=82            =E2=94=82  PCI    =E2=94=82               =E2=94=
=82      =E2=94=82     BUS      =E2=94=82
> > =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98         =E2=94=94=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>
> s/PCI BUS/PCI Bus/
>
> >     PCI RC                        PCI EP
>
> s/PCI RC/PCIe Root Port/ ?
>
> > This driver include 3 part:
> >  1 PCI EP NTB function driver
> >  2 Virtual PCI bus
> >  3 PCI virutal NTB driver, which is loaded only by above virtual pci bu=
s
>
> s/include 3 part/includes 3 parts/
> s/virutal/virtual/
> s/pci bus/PCI bus/
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/endpoint/functions/Kconfig        |   11 +
> >  drivers/pci/endpoint/functions/Makefile       |    1 +
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1425 +++++++++++++++++
> >  3 files changed, 1437 insertions(+)
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vntb.c
> >
> > diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpo=
int/functions/Kconfig
> > index 5f1242ca2f4e4..362555b024e8f 100644
> > --- a/drivers/pci/endpoint/functions/Kconfig
> > +++ b/drivers/pci/endpoint/functions/Kconfig
> > @@ -25,3 +25,14 @@ config PCI_EPF_NTB
> >         device tree.
> >
> >         If in doubt, say "N" to disable Endpoint NTB driver.
> > +
> > +config PCI_EPF_VNTB
> > +        tristate "PCI Endpoint NTB driver"
> > +        depends on PCI_ENDPOINT
> > +        select CONFIGFS_FS
> > +        help
> > +          Select this configuration option to enable the Non-Transpare=
nt
> > +          Bridge (NTB) driver for PCI Endpoint. NTB driver implements =
NTB
> > +          between PCI host and PCIe Endpoint.
>
> "PCI Endpoint" vs "PCIe Endpoint".  Pick one.  It seems like you
> require an upstream bridge, i.e., a Root Port, so maybe "PCIe Root
> Port" and "PCIe Endpoint" is what you want?
>
> > +          If in doubt, say "N" to disable Endpoint NTB driver.
> > diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endp=
oint/functions/Makefile
> > index 96ab932a537a2..5c13001deaba1 100644
> > --- a/drivers/pci/endpoint/functions/Makefile
> > +++ b/drivers/pci/endpoint/functions/Makefile
> > @@ -5,3 +5,4 @@
> >
> >  obj-$(CONFIG_PCI_EPF_TEST)           +=3D pci-epf-test.o
> >  obj-$(CONFIG_PCI_EPF_NTB)            +=3D pci-epf-ntb.o
> > +obj-$(CONFIG_PCI_EPF_VNTB)           +=3D pci-epf-vntb.o
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pc=
i/endpoint/functions/pci-epf-vntb.c
> > new file mode 100644
> > index 0000000000000..ebf7e243eefa4
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -0,0 +1,1425 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Endpoint Function Driver to implement Non-Transparent Bridge functi=
onality
> > + * Between PCI RC and EP
> > + *
> > + * Copyright (C) 2020 Texas Instruments
> > + * Copyright (C) 2022 NXP
> > + *
> > + * Based on pci-epf-ntb.c
> > + * Author: Frank Li <Frank.Li@nxp.com>
> > + * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > + */
> > +
> > +/**
> > + * +------------+         +---------------------------------------+
> > + * |            |         |                                       |
> > + * +------------+         |                        +--------------+
> > + * | NTB        |         |                        | NTB          |
> > + * | NetDev     |         |                        | NetDev       |
> > + * +------------+         |                        +--------------+
> > + * | NTB        |         |                        | NTB          |
> > + * | Transfer   |         |                        | Transfer     |
> > + * +------------+         |                        +--------------+
> > + * |            |         |                        |              |
> > + * |  PCI NTB   |         |                        |              |
> > + * |    EPF     |         |                        |              |
> > + * |   Driver   |         |                        | PCI Virtual  |
> > + * |            |         +---------------+        | NTB Driver   |
> > + * |            |         | PCI EP NTB    |<------>|              |
> > + * |            |         |  FN Driver    |        |              |
> > + * +------------+         +---------------+        +--------------+
> > + * |            |         |               |        |              |
> > + * |  PCI BUS   | <-----> |  PCI EP BUS   |        |  Virtual PCI |
> > + * |            |  PCI    |               |        |     BUS      |
> > + * +------------+         +---------------+--------+--------------+
> > + *     PCI RC                        PCI EP
>
> s/PCI RC/PCIe Root Port/ ?
>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +
> > +#include <linux/pci-epc.h>
> > +#include <linux/pci-epf.h>
> > +#include <linux/ntb.h>
> > +
> > +static struct workqueue_struct *kpcintb_workqueue;
> > +
> > +#define COMMAND_CONFIGURE_DOORBELL   1
> > +#define COMMAND_TEARDOWN_DOORBELL    2
> > +#define COMMAND_CONFIGURE_MW         3
> > +#define COMMAND_TEARDOWN_MW          4
> > +#define COMMAND_LINK_UP                      5
> > +#define COMMAND_LINK_DOWN            6
> > +
> > +#define COMMAND_STATUS_OK            1
> > +#define COMMAND_STATUS_ERROR         2
> > +
> > +#define LINK_STATUS_UP                       BIT(0)
> > +
> > +#define SPAD_COUNT                   64
> > +#define DB_COUNT                     4
> > +#define NTB_MW_OFFSET                        2
> > +#define DB_COUNT_MASK                        GENMASK(15, 0)
> > +#define MSIX_ENABLE                  BIT(16)
> > +#define MAX_DB_COUNT                 32
> > +#define MAX_MW                               4
> > +
> > +#define VNTB_VID                     0x1957
>
> This looks like PCI_VENDOR_ID_NXP (or PCI_VENDOR_ID_FREESCALE).
> How did you choose that, why is it safe to use, and why don't use use
> PCI_VENDOR_ID_NXP instead?

This is a problem.  I am working on NXP.  But I have not found an apartment=
,
who managed the PCIe PID list yet.

I can put it in the configfs, let the user change it. Or someone can
donate one PID/VID.

>
> > +#define VNTB_PID                     0x080A
> > +
> > +enum epf_ntb_bar {
> > +     BAR_CONFIG,
> > +     BAR_DB,
> > +     BAR_MW0,
> > +     BAR_MW1,
> > +     BAR_MW2,
> > +};
> > +
> > +/*
> > + * +--------------------------------------------------+ Base
> > + * |                                                  |
> > + * |                                                  |
> > + * |                                                  |
> > + * |          Common Control Register                 |
> > + * |                                                  |
> > + * |                                                  |
> > + * |                                                  |
> > + * +-----------------------+--------------------------+ Base+span_offs=
et
> > + * |                       |                          |
> > + * |    Peer Span Space    |    Span Space            |
> > + * |                       |                          |
> > + * |                       |                          |
> > + * +-----------------------+--------------------------+ Base+span_offs=
et
> > + * |                       |                          |     +span_coun=
t * 4
> > + * |                       |                          |
> > + * |     Span Space        |   Peer Span Space        |
> > + * |                       |                          |
> > + * +-----------------------+--------------------------+
> > + *       Virtual PCI             Pcie Endpoint
> > + *       NTB Driver               NTB Driver
>
> s/Pcie/PCIe/
>
> > + */
> > +struct epf_ntb_ctrl {
> > +     u32     command;
> > +     u32     argument;
> > +     u16     command_status;
> > +     u16     link_status;
> > +     u32     topology;
> > +     u64     addr;
> > +     u64     size;
> > +     u32     num_mws;
> > +     u32     reserved;
> > +     u32     spad_offset;
> > +     u32     spad_count;
> > +     u32     db_entry_size;
> > +     u32     db_data[MAX_DB_COUNT];
> > +     u32     db_offset[MAX_DB_COUNT];
> > +} __packed;
> > +
> > +struct epf_ntb {
> > +     struct ntb_dev ntb;
> > +     struct pci_epf *epf;
> > +     struct config_group group;
> > +
> > +     u32 num_mws;
> > +     u32 db_count;
> > +     u32 spad_count;
> > +     u64 mws_size[MAX_MW];
> > +     u64 db;
> > +     u32 vbus_number;
> > +
> > +     bool linkup;
> > +     u32 spad_size;
> > +
> > +     enum pci_barno epf_ntb_bar[6];
> > +
> > +     struct epf_ntb_ctrl *reg;
> > +
> > +     phys_addr_t epf_db_phy;
> > +     void __iomem *epf_db;
> > +
> > +     phys_addr_t vpci_mw_phy[MAX_MW];
> > +     void __iomem *vpci_mw_addr[MAX_MW];
> > +
> > +     struct delayed_work cmd_handler;
> > +};
> > +
> > +#define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb=
, group)
> > +#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> > +
> > +static struct pci_epf_header epf_ntb_header =3D {
> > +     .vendorid       =3D PCI_ANY_ID,
> > +     .deviceid       =3D PCI_ANY_ID,
> > +     .baseclass_code =3D PCI_BASE_CLASS_MEMORY,
> > +     .interrupt_pin  =3D PCI_INTERRUPT_INTA,
> > +};
> > +
> > +/**
> > + * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host
> > + * @ntb: NTB device that facilitates communication between HOST and VH=
OST
> > + * @link_up: true or false indicating Link is UP or Down
> > + *
> > + * Once NTB function in HOST invoke ntb_link_enable(),
> > + * this NTB function driver will trigger a link event to vhost.
> > + */
> > +static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> > +{
> > +     if (link_up)
> > +             ntb->reg->link_status |=3D LINK_STATUS_UP;
> > +     else
> > +             ntb->reg->link_status &=3D ~LINK_STATUS_UP;
> > +
> > +     ntb_link_event(&ntb->ntb);
> > +     return 0;
> > +}
> > +
> > +/**
> > + * epf_ntb_configure_mw() - Configure the Outbound Address Space for v=
host
> > + *   to access the memory window of host
> > + * @ntb: NTB device that facilitates communication between host and vh=
ost
> > + * @mw: Index of the memory window (either 0, 1, 2 or 3)
> > + *
> > + *                          EP Outbound Window
> > + * +--------+              +-----------+
> > + * |        |              |           |
> > + * |        |              |           |
> > + * |        |              |           |
> > + * |        |              |           |
> > + * |        |              +-----------+
> > + * | Virtual|              | Memory Win|
> > + * | NTB    | -----------> |           |
> > + * | Driver |              |           |
> > + * |        |              +-----------+
> > + * |        |              |           |
> > + * |        |              |           |
> > + * +--------+              +-----------+
> > + *  VHost                   PCI EP
> > + */
> > +static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
> > +{
> > +     phys_addr_t phys_addr;
> > +     u8 func_no, vfunc_no;
> > +     u64 addr, size;
> > +     int ret =3D 0;
> > +
> > +     phys_addr =3D ntb->vpci_mw_phy[mw];
> > +     addr =3D ntb->reg->addr;
> > +     size =3D ntb->reg->size;
> > +
> > +     func_no =3D ntb->epf->func_no;
> > +     vfunc_no =3D ntb->epf->vfunc_no;
> > +
> > +     ret =3D pci_epc_map_addr(ntb->epf->epc, func_no, vfunc_no, phys_a=
ddr, addr, size);
> > +     if (ret)
> > +             dev_err(&ntb->epf->epc->dev,
> > +                     "intf: Failed to map memory window %d address\n",=
 mw);
>
> Lots of these messages start with "intf:".  What is that telling us?
> Is it useful?

I will clear it.

>
> > +     return ret;
> > +}
> > +
> > +/**
> > + * epf_ntb_teardown_mw() - Teardown the configured OB ATU
> > + * @ntb: NTB device that facilitates communication between HOST and vH=
OST
> > + * @mw: Index of the memory window (either 0, 1, 2 or 3)
> > + *
> > + * Teardown the configured OB ATU configured in epf_ntb_configure_mw()=
 using
> > + * pci_epc_unmap_addr()
> > + */
> > +static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
> > +{
> > +     pci_epc_unmap_addr(ntb->epf->epc,
> > +                        ntb->epf->func_no,
> > +                        ntb->epf->vfunc_no,
> > +                        ntb->vpci_mw_phy[mw]);
> > +}
> > +
> > +/**
> > + * epf_ntb_cmd_handler() - Handle commands provided by the NTB Host
> > + * @work: work_struct for the epf_ntb_epc
> > + *
> > + * Workqueue function that gets invoked for the two epf_ntb_epc
> > + * periodically (once every 5ms) to see if it has received any command=
s
> > + * from NTB host. The host can send commands to configure doorbell or
> > + * configure memory window or to update link status.
> > + */
> > +static void epf_ntb_cmd_handler(struct work_struct *work)
> > +{
> > +     struct epf_ntb_ctrl *ctrl;
> > +     u32 command, argument;
> > +     struct epf_ntb *ntb;
> > +     struct device *dev;
> > +     int ret;
> > +     int i;
> > +
> > +     ntb =3D container_of(work, struct epf_ntb, cmd_handler.work);
> > +
> > +     for (i =3D 1; i < ntb->db_count; i++) {
> > +             if (readl(ntb->epf_db + i * 4)) {
> > +                     if (readl(ntb->epf_db + i * 4))
> > +                             ntb->db |=3D 1 << (i - 1);
> > +
> > +                     ntb_db_event(&ntb->ntb, i);
> > +                     writel(0, ntb->epf_db + i * 4);
> > +             }
> > +     }
> > +
> > +     ctrl =3D ntb->reg;
> > +     command =3D ctrl->command;
> > +     if (!command)
> > +             goto reset_handler;
> > +     argument =3D ctrl->argument;
> > +
> > +     ctrl->command =3D 0;
> > +     ctrl->argument =3D 0;
> > +
> > +     ctrl =3D ntb->reg;
> > +     dev =3D &ntb->epf->dev;
> > +
> > +     switch (command) {
> > +     case COMMAND_CONFIGURE_DOORBELL:
> > +             ctrl->command_status =3D COMMAND_STATUS_OK;
> > +             break;
> > +     case COMMAND_TEARDOWN_DOORBELL:
> > +             ctrl->command_status =3D COMMAND_STATUS_OK;
> > +             break;
> > +     case COMMAND_CONFIGURE_MW:
> > +             ret =3D epf_ntb_configure_mw(ntb, argument);
> > +             if (ret < 0)
> > +                     ctrl->command_status =3D COMMAND_STATUS_ERROR;
> > +             else
> > +                     ctrl->command_status =3D COMMAND_STATUS_OK;
> > +             break;
> > +     case COMMAND_TEARDOWN_MW:
> > +             epf_ntb_teardown_mw(ntb, argument);
> > +             ctrl->command_status =3D COMMAND_STATUS_OK;
> > +             break;
> > +     case COMMAND_LINK_UP:
> > +             ntb->linkup =3D true;
> > +             ret =3D epf_ntb_link_up(ntb, true);
> > +             if (ret < 0)
> > +                     ctrl->command_status =3D COMMAND_STATUS_ERROR;
> > +             else
> > +                     ctrl->command_status =3D COMMAND_STATUS_OK;
> > +             goto reset_handler;
> > +     case COMMAND_LINK_DOWN:
> > +             ntb->linkup =3D false;
> > +             ret =3D epf_ntb_link_up(ntb, false);
> > +             if (ret < 0)
> > +                     ctrl->command_status =3D COMMAND_STATUS_ERROR;
> > +             else
> > +                     ctrl->command_status =3D COMMAND_STATUS_OK;
> > +             break;
> > +     default:
> > +             dev_err(dev, "intf UNKNOWN command: %d\n", command);
> > +             break;
> > +     }
> > +
> > +reset_handler:
> > +     queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
> > +                        msecs_to_jiffies(5));
> > +}
> > +
> > +/**
> > + * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad B=
AR
> > + * @ntb_epc: EPC associated with one of the HOST which holds peer's ou=
tbound
> > + *        address.
> > + *
> > + * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
> > + * self scratchpad region (removes inbound ATU configuration). While B=
AR0 is
> > + * the default self scratchpad BAR, an NTB could have other BARs for s=
elf
> > + * scratchpad (because of reserved BARs). This function can get the ex=
act BAR
> > + * used for self scratchpad from epf_ntb_bar[BAR_CONFIG].
> > + *
> > + * Please note the self scratchpad region and config region is combine=
d to
> > + * a single region and mapped using the same BAR. Also note HOST2's pe=
er
> > + * scratchpad is HOST1's self scratchpad.
> > + */
> > +static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
> > +{
> > +     struct pci_epf_bar *epf_bar;
> > +     enum pci_barno barno;
> > +
> > +     barno =3D ntb->epf_ntb_bar[BAR_CONFIG];
> > +     epf_bar =3D &ntb->epf->bar[barno];
> > +
> > +     pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfu=
nc_no, epf_bar);
> > +}
> > +
> > +/**
> > + * epf_ntb_config_sspad_bar_set() - Set Config + Self scratchpad BAR
> > + * @ntb: NTB device that facilitates communication between HOST and vH=
OST
> > + *
> > + * Map BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
> > + * self scratchpad region.
> > + *
> > + * Please note the self scratchpad region and config region is combine=
d to
> > + * a single region and mapped using the same BAR.
> > + */
> > +static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
> > +{
> > +     struct pci_epf_bar *epf_bar;
> > +     enum pci_barno barno;
> > +     u8 func_no, vfunc_no;
> > +     struct device *dev;
> > +     int ret;
> > +
> > +     dev =3D &ntb->epf->dev;
> > +     func_no =3D ntb->epf->func_no;
> > +     vfunc_no =3D ntb->epf->vfunc_no;
> > +     barno =3D ntb->epf_ntb_bar[BAR_CONFIG];
> > +     epf_bar =3D &ntb->epf->bar[barno];
> > +
> > +     ret =3D pci_epc_set_bar(ntb->epf->epc, func_no, vfunc_no, epf_bar=
);
> > +     if (ret) {
> > +             dev_err(dev, "inft: Config/Status/SPAD BAR set failed\n")=
;
> > +             return ret;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/**
> > + * epf_ntb_config_spad_bar_free() - Free the physical memory associate=
d with
> > + *   config + scratchpad region
> > + * @ntb: NTB device that facilitates communication between HOST and vH=
OST
> > + */
> > +static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
> > +{
> > +     enum pci_barno barno;
> > +
> > +     barno =3D ntb->epf_ntb_bar[BAR_CONFIG];
> > +     pci_epf_free_space(ntb->epf, ntb->reg, barno, 0);
> > +}
> > +
> > +/**
> > + * epf_ntb_config_spad_bar_alloc() - Allocate memory for config + scra=
tchpad
> > + *   region
> > + * @ntb: NTB device that facilitates communication between HOST1 and H=
OST2
> > + *
> > + * Allocate the Local Memory mentioned in the above diagram. The size =
of
> > + * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD=
 REGION
> > + * is obtained from "spad-count" configfs entry.
> > + */
> > +static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
> > +{
> > +     size_t align;
> > +     enum pci_barno barno;
> > +     struct epf_ntb_ctrl *ctrl;
> > +     u32 spad_size, ctrl_size;
> > +     u64 size;
> > +     struct pci_epf *epf =3D ntb->epf;
> > +     struct device *dev =3D &epf->dev;
> > +     u32 spad_count;
> > +     void *base;
> > +     int i;
> > +     const struct pci_epc_features *epc_features =3D pci_epc_get_featu=
res(epf->epc,
> > +                                                             epf->func=
_no,
> > +                                                             epf->vfun=
c_no);
> > +     barno =3D ntb->epf_ntb_bar[BAR_CONFIG];
> > +     size =3D epc_features->bar_fixed_size[barno];
> > +     align =3D epc_features->align;
> > +
> > +     if ((!IS_ALIGNED(size, align)))
> > +             return -EINVAL;
> > +
> > +     spad_count =3D ntb->spad_count;
> > +
> > +     ctrl_size =3D sizeof(struct epf_ntb_ctrl);
> > +     spad_size =3D 2 * spad_count * 4;
> > +
> > +     if (!align) {
> > +             ctrl_size =3D roundup_pow_of_two(ctrl_size);
> > +             spad_size =3D roundup_pow_of_two(spad_size);
> > +     } else {
> > +             ctrl_size =3D ALIGN(ctrl_size, align);
> > +             spad_size =3D ALIGN(spad_size, align);
> > +     }
> > +
> > +     if (!size)
> > +             size =3D ctrl_size + spad_size;
> > +     else if (size < ctrl_size + spad_size)
> > +             return -EINVAL;
> > +
> > +     base =3D pci_epf_alloc_space(epf, size, barno, align, 0);
> > +     if (!base) {
> > +             dev_err(dev, "intf: Config/Status/SPAD alloc region fail\=
n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     ntb->reg =3D base;
> > +
> > +     ctrl =3D ntb->reg;
> > +     ctrl->spad_offset =3D ctrl_size;
> > +
> > +     ctrl->spad_count =3D spad_count;
> > +     ctrl->num_mws =3D ntb->num_mws;
> > +     ntb->spad_size =3D spad_size;
> > +
> > +     ctrl->db_entry_size =3D 4;
> > +
> > +     for (i =3D 0; i < ntb->db_count; i++) {
> > +             ntb->reg->db_data[i] =3D 1 + i;
> > +             ntb->reg->db_offset[i] =3D 0;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
> > + * @ntb: NTB device that facilitates communication between HOST and vH=
OST
> > + *
> > + * Configure MSI/MSI-X capability for each interface with number of
> > + * interrupts equal to "db_count" configfs entry.
> > + */
> > +static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
> > +{
> > +     const struct pci_epc_features *epc_features;
> > +     bool msix_capable, msi_capable;
> > +     u8 func_no, vfunc_no;
> > +     struct device *dev;
> > +     u32 db_count;
> > +     int ret;
> > +
> > +     dev =3D &ntb->epf->dev;
> > +
> > +     epc_features =3D pci_epc_get_features(ntb->epf->epc, ntb->epf->fu=
nc_no, ntb->epf->vfunc_no);
> > +     msix_capable =3D epc_features->msix_capable;
> > +     msi_capable =3D epc_features->msi_capable;
> > +
> > +     if (!(msix_capable || msi_capable)) {
>
> I don't think the "msix_capable" and "msi_capable" local variables
> really add any readability since they're only used once.
>
> Not sure about "func_no", "vfunc_no", either.  If you keep them, you
> could at least assign them earlier and use them in the
> pci_epc_get_features() call.
>
> > +             dev_err(dev, "MSI or MSI-X is required for doorbell\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     func_no =3D ntb->epf->func_no;
> > +     vfunc_no =3D ntb->epf->vfunc_no;
> > +
> > +     db_count =3D ntb->db_count;
> > +     if (db_count > MAX_DB_COUNT) {
> > +             dev_err(dev, "DB count cannot be more than %d\n", MAX_DB_=
COUNT);
> > +             return -EINVAL;
> > +     }
> > +
> > +     ntb->db_count =3D db_count;
> > +
> > +     if (msi_capable) {
> > +             ret =3D pci_epc_set_msi(ntb->epf->epc, func_no, vfunc_no,=
 16);
> > +             if (ret) {
> > +                     dev_err(dev, "intf: MSI configuration failed\n");
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * epf_ntb_db_bar_init() - Configure Doorbell window BARs
> > + * @ntb: NTB device that facilitates communication between HOST and vH=
OST
> > + *
>
> Spurious blank line.
>
> > + */
> > +static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
> > +{
> > +     const struct pci_epc_features *epc_features;
> > +     u32 align;
> > +     struct device *dev =3D &ntb->epf->dev;
> > +     int ret;
> > +     struct pci_epf_bar *epf_bar;
> > +     void __iomem *mw_addr;
> > +     enum pci_barno barno;
> > +     size_t size =3D 4 * ntb->db_count;
> > +
> > +     epc_features =3D pci_epc_get_features(ntb->epf->epc,
> > +                                         ntb->epf->func_no,
> > +                                         ntb->epf->vfunc_no);
> > +     align =3D epc_features->align;
> > +
> > +     if (size < 128)
> > +             size =3D 128;
> > +
> > +     if (align)
> > +             size =3D ALIGN(size, align);
> > +     else
> > +             size =3D roundup_pow_of_two(size);
> > +
> > +     barno =3D ntb->epf_ntb_bar[BAR_DB];
> > +
> > +     mw_addr =3D pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
> > +     if (!mw_addr) {
> > +             dev_err(dev, "intf: Failed to allocate OB address\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     ntb->epf_db =3D mw_addr;
> > +
> > +     epf_bar =3D &ntb->epf->bar[barno];
> > +
> > +     ret =3D pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->ep=
f->vfunc_no, epf_bar);
> > +     if (ret) {
> > +             dev_err(dev, "intf: DoorBell BAR set failed\n");
>
> s/DoorBell/Doorbell/
>
> > +                     goto err_alloc_peer_mem;
> > +     }
> > +     return ret;
> > +
> > +err_alloc_peer_mem:
> > +     pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr,=
 epf_bar->size);
> > +     return -1;
> > +}
> > +
> > +/**
> > + * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
> > + *   allocated in peers outbound address space
>
> s/peers/peer's/
>
> > + * @ntb: NTB device that facilitates communication between HOST and vH=
OST
> > + */
> > +static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
> > +{
> > +     enum pci_barno barno;
> > +
> > +     barno =3D ntb->epf_ntb_bar[BAR_DB];
> > +     pci_epf_free_space(ntb->epf, ntb->epf_db, barno, 0);
> > +     pci_epc_clear_bar(ntb->epf->epc,
> > +                       ntb->epf->func_no,
> > +                       ntb->epf->vfunc_no,
> > +                       &ntb->epf->bar[barno]);
> > +}
> > +
> > +/**
> > + * epf_ntb_mw_bar_init() - Configure Memory window BARs
> > + * @ntb: NTB device that facilitates communication between HOST and vH=
OST
> > + *
> > + */
> > +static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> > +{
> > +     int ret =3D 0;
> > +     int i;
> > +     u64 size;
> > +     enum pci_barno barno;
> > +     struct device *dev =3D &ntb->epf->dev;
> > +
> > +     for (i =3D 0; i < ntb->num_mws; i++) {
> > +
>
> Spurious blank line.
>
> > +             size =3D ntb->mws_size[i];
> > +
> > +             barno =3D ntb->epf_ntb_bar[BAR_MW0 + i];
> > +
> > +             ntb->epf->bar[barno].barno =3D barno;
> > +             ntb->epf->bar[barno].size =3D size;
> > +             ntb->epf->bar[barno].addr =3D 0;
> > +             ntb->epf->bar[barno].phys_addr =3D 0;
> > +             ntb->epf->bar[barno].flags |=3D upper_32_bits(size) ?
> > +                             PCI_BASE_ADDRESS_MEM_TYPE_64 :
> > +                             PCI_BASE_ADDRESS_MEM_TYPE_32;
> > +
> > +             ret =3D pci_epc_set_bar(ntb->epf->epc,
> > +                                   ntb->epf->func_no,
> > +                                   ntb->epf->vfunc_no,
> > +                                   &ntb->epf->bar[barno]);
> > +             if (ret) {
> > +                     dev_err(dev, "intf: MW set failed\n");
> > +                     goto err_alloc_mem;
> > +             }
> > +
> > +             /* allocate epc outbound memory windows to vpci vntb devi=
ce */
>
> s/allocate/Allocate/ to match other comments
> s/epc/EPC/
>
> > +             ntb->vpci_mw_addr[i] =3D pci_epc_mem_alloc_addr(ntb->epf-=
>epc,
> > +                                                           &ntb->vpci_=
mw_phy[i],
> > +                                                           size);
> > +             if (!ntb->vpci_mw_addr[i]) {
> > +                     dev_err(dev, "Failed to allocate source address\n=
");
> > +                     goto err_alloc_mem;
> > +             }
> > +     }
> > +
> > +     return ret;
> > +err_alloc_mem:
> > +     return ret;
> > +}
> > +
> > +/**
> > + * epf_ntb_mw_bar_clear() - Clear Memory window BARs
> > + * @ntb: NTB device that facilitates communication between HOST and vH=
OST
> > + *
>
> Spurious blank line.
>
> > + */
> > +static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
> > +{
> > +     enum pci_barno barno;
> > +     int i;
> > +
> > +     for (i =3D 0; i < ntb->num_mws; i++) {
> > +             barno =3D ntb->epf_ntb_bar[BAR_MW0 + i];
> > +             pci_epc_clear_bar(ntb->epf->epc,
> > +                               ntb->epf->func_no,
> > +                               ntb->epf->vfunc_no,
> > +                               &ntb->epf->bar[barno]);
> > +
> > +             pci_epc_mem_free_addr(ntb->epf->epc,
> > +                                   ntb->vpci_mw_phy[i],
> > +                                   ntb->vpci_mw_addr[i],
> > +                                   ntb->mws_size[i]);
> > +     }
> > +}
> > +
> > +/**
> > + * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
> > + * @ntb: NTB device that facilitates communication between HOST and vH=
OST
> > + *
> > + * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB =
interfaces
> > + */
> > +static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
> > +{
> > +     pci_epc_remove_epf(ntb->epf->epc, ntb->epf, 0);
> > +     pci_epc_put(ntb->epf->epc);
> > +}
> > +
> > +/**
> > + * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the N=
TB
> > + * constructs (scratchpad region, doorbell, memorywindow)
> > + * @ntb: NTB device that facilitates communication between HOST and vH=
OST
> > + *
>
> Spurious blank line.
>
> > + */
> > +static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
> > +{
> > +     const struct pci_epc_features *epc_features;
> > +     enum pci_barno barno;
> > +     enum epf_ntb_bar bar;
> > +     struct device *dev;
> > +     u32 num_mws;
> > +     int i;
> > +
> > +     barno =3D BAR_0;
> > +     num_mws =3D ntb->num_mws;
> > +     dev =3D &ntb->epf->dev;
> > +     epc_features =3D pci_epc_get_features(ntb->epf->epc, ntb->epf->fu=
nc_no, ntb->epf->vfunc_no);
> > +
> > +     /* These are required BARs which are mandatory for NTB functional=
ity */
> > +     for (bar =3D BAR_CONFIG; bar <=3D BAR_MW0; bar++, barno++) {
> > +             barno =3D pci_epc_get_next_free_bar(epc_features, barno);
> > +             if (barno < 0) {
> > +                     dev_err(dev, "intf: Fail to get NTB function BAR\=
n");
> > +                     return barno;
> > +             }
> > +             ntb->epf_ntb_bar[bar] =3D barno;
> > +     }
> > +
> > +     /* These are optional BARs which don't impact NTB functionality *=
/
> > +     for (bar =3D BAR_MW1, i =3D 1; i < num_mws; bar++, barno++, i++) =
{
> > +             barno =3D pci_epc_get_next_free_bar(epc_features, barno);
> > +             if (barno < 0) {
> > +                     ntb->num_mws =3D i;
> > +                     dev_dbg(dev, "BAR not available for > MW%d\n", i =
+ 1);
> > +             }
> > +             ntb->epf_ntb_bar[bar] =3D barno;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * epf_ntb_epc_init() - Initialize NTB interface
> > + * @ntb: NTB device that facilitates communication between HOST and vH=
OST2
> > + *
> > + * Wrapper to initialize a particular EPC interface and start the work=
queue
> > + * to check for commands from host. This function will write to the
> > + * EP controller HW for configuring it.
> > + */
> > +static int epf_ntb_epc_init(struct epf_ntb *ntb)
> > +{
> > +     u8 func_no, vfunc_no;
> > +     struct pci_epc *epc;
> > +     struct pci_epf *epf;
> > +     struct device *dev;
> > +     int ret;
> > +
> > +     epf =3D ntb->epf;
> > +     dev =3D &epf->dev;
> > +     epc =3D epf->epc;
> > +     func_no =3D ntb->epf->func_no;
> > +     vfunc_no =3D ntb->epf->vfunc_no;
> > +
> > +     ret =3D epf_ntb_config_sspad_bar_set(ntb);
> > +     if (ret) {
> > +             dev_err(dev, "intf: Config/self SPAD BAR init failed");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D epf_ntb_configure_interrupt(ntb);
> > +     if (ret) {
> > +             dev_err(dev, "intf: Interrupt configuration failed\n");
> > +             goto err_config_interrupt;
> > +     }
> > +
> > +     ret =3D epf_ntb_db_bar_init(ntb);
> > +     if (ret) {
> > +             dev_err(dev, "intf: DB BAR init failed\n");
> > +             goto err_db_bar_init;
> > +     }
> > +
> > +     ret =3D epf_ntb_mw_bar_init(ntb);
> > +     if (ret) {
> > +             dev_err(dev, "intf: MW BAR init failed\n");
> > +             goto err_mw_bar_init;
> > +     }
> > +
> > +     if (vfunc_no <=3D 1) {
> > +             ret =3D pci_epc_write_header(epc, func_no, vfunc_no, epf-=
>header);
> > +             if (ret) {
> > +                     dev_err(dev, "intf: Configuration header write fa=
iled\n");
> > +                     goto err_write_header;
> > +             }
> > +     }
> > +
> > +     INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
> > +     queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
> > +
> > +     return 0;
> > +
> > +err_write_header:
> > +     epf_ntb_mw_bar_clear(ntb);
> > +err_mw_bar_init:
> > +     epf_ntb_db_bar_clear(ntb);
> > +err_db_bar_init:
> > +err_config_interrupt:
> > +     epf_ntb_config_sspad_bar_clear(ntb);
> > +
> > +     return ret;
> > +}
> > +
> > +
> > +/**
> > + * epf_ntb_epc_cleanup() - Cleanup all NTB interfaces
> > + * @ntb: NTB device that facilitates communication between HOST1 and H=
OST2
> > + *
> > + * Wrapper to cleanup all NTB interfaces.
> > + */
> > +static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
> > +{
> > +     epf_ntb_db_bar_clear(ntb);
> > +     epf_ntb_mw_bar_clear(ntb);
> > +}
> > +
> > +#define EPF_NTB_R(_name)                                             \
> > +static ssize_t epf_ntb_##_name##_show(struct config_item *item,       =
       \
> > +                                   char *page)                       \
> > +{                                                                    \
> > +     struct config_group *group =3D to_config_group(item);            =
 \
> > +     struct epf_ntb *ntb =3D to_epf_ntb(group);                       =
 \
> > +                                                                     \
> > +     return sprintf(page, "%d\n", ntb->_name);                       \
> > +}
> > +
> > +#define EPF_NTB_W(_name)                                             \
> > +static ssize_t epf_ntb_##_name##_store(struct config_item *item,     \
> > +                                    const char *page, size_t len)    \
> > +{                                                                    \
> > +     struct config_group *group =3D to_config_group(item);            =
 \
> > +     struct epf_ntb *ntb =3D to_epf_ntb(group);                       =
 \
> > +     u32 val;                                                        \
> > +     int ret;                                                        \
> > +                                                                     \
> > +     ret =3D kstrtou32(page, 0, &val);                                =
 \
> > +     if (ret)                                                        \
> > +             return ret;                                             \
> > +                                                                     \
> > +     ntb->_name =3D val;                                              =
 \
> > +                                                                     \
> > +     return len;                                                     \
> > +}
> > +
> > +#define EPF_NTB_MW_R(_name)                                          \
> > +static ssize_t epf_ntb_##_name##_show(struct config_item *item,       =
       \
> > +                                   char *page)                       \
> > +{                                                                    \
> > +     struct config_group *group =3D to_config_group(item);            =
 \
> > +     struct epf_ntb *ntb =3D to_epf_ntb(group);                       =
 \
> > +     int win_no;                                                     \
> > +                                                                     \
> > +     sscanf(#_name, "mw%d", &win_no);                                \
> > +                                                                     \
> > +     return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);      \
> > +}
> > +
> > +#define EPF_NTB_MW_W(_name)                                          \
> > +static ssize_t epf_ntb_##_name##_store(struct config_item *item,     \
> > +                                    const char *page, size_t len)    \
> > +{                                                                    \
> > +     struct config_group *group =3D to_config_group(item);            =
 \
> > +     struct epf_ntb *ntb =3D to_epf_ntb(group);                       =
 \
> > +     struct device *dev =3D &ntb->epf->dev;                           =
 \
> > +     int win_no;                                                     \
> > +     u64 val;                                                        \
> > +     int ret;                                                        \
> > +                                                                     \
> > +     ret =3D kstrtou64(page, 0, &val);                                =
 \
> > +     if (ret)                                                        \
> > +             return ret;                                             \
> > +                                                                     \
> > +     if (sscanf(#_name, "mw%d", &win_no) !=3D 1)                      =
 \
> > +             return -EINVAL;                                         \
> > +                                                                     \
> > +     if (ntb->num_mws < win_no) {                                    \
> > +             dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws)=
; \
> > +             return -EINVAL;                                         \
> > +     }                                                               \
> > +                                                                     \
> > +     ntb->mws_size[win_no - 1] =3D val;                               =
 \
> > +                                                                     \
> > +     return len;                                                     \
> > +}
> > +
> > +static ssize_t epf_ntb_num_mws_store(struct config_item *item,
> > +                                  const char *page, size_t len)
> > +{
> > +     struct config_group *group =3D to_config_group(item);
> > +     struct epf_ntb *ntb =3D to_epf_ntb(group);
> > +     u32 val;
> > +     int ret;
> > +
> > +     ret =3D kstrtou32(page, 0, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (val > MAX_MW)
> > +             return -EINVAL;
> > +
> > +     ntb->num_mws =3D val;
> > +
> > +     return len;
> > +}
> > +
> > +EPF_NTB_R(spad_count)
> > +EPF_NTB_W(spad_count)
> > +EPF_NTB_R(db_count)
> > +EPF_NTB_W(db_count)
> > +EPF_NTB_R(num_mws)
> > +EPF_NTB_R(vbus_number)
> > +EPF_NTB_W(vbus_number)
> > +EPF_NTB_MW_R(mw1)
> > +EPF_NTB_MW_W(mw1)
> > +EPF_NTB_MW_R(mw2)
> > +EPF_NTB_MW_W(mw2)
> > +EPF_NTB_MW_R(mw3)
> > +EPF_NTB_MW_W(mw3)
> > +EPF_NTB_MW_R(mw4)
> > +EPF_NTB_MW_W(mw4)
> > +
> > +CONFIGFS_ATTR(epf_ntb_, spad_count);
> > +CONFIGFS_ATTR(epf_ntb_, db_count);
> > +CONFIGFS_ATTR(epf_ntb_, num_mws);
> > +CONFIGFS_ATTR(epf_ntb_, mw1);
> > +CONFIGFS_ATTR(epf_ntb_, mw2);
> > +CONFIGFS_ATTR(epf_ntb_, mw3);
> > +CONFIGFS_ATTR(epf_ntb_, mw4);
> > +CONFIGFS_ATTR(epf_ntb_, vbus_number);
> > +
> > +static struct configfs_attribute *epf_ntb_attrs[] =3D {
> > +     &epf_ntb_attr_spad_count,
> > +     &epf_ntb_attr_db_count,
> > +     &epf_ntb_attr_num_mws,
> > +     &epf_ntb_attr_mw1,
> > +     &epf_ntb_attr_mw2,
> > +     &epf_ntb_attr_mw3,
> > +     &epf_ntb_attr_mw4,
> > +     &epf_ntb_attr_vbus_number,
> > +     NULL,
> > +};
> > +
> > +static const struct config_item_type ntb_group_type =3D {
> > +     .ct_attrs       =3D epf_ntb_attrs,
> > +     .ct_owner       =3D THIS_MODULE,
> > +};
> > +
> > +/**
> > + * epf_ntb_add_cfs() - Add configfs directory specific to NTB
> > + * @epf: NTB endpoint function device
> > + * @group: A pointer to the config_group structure referencing a group=
 of
> > + *      config_items of a specific type that belong to a specific sub-=
system.
> > + *
> > + * Add configfs directory specific to NTB. This directory will hold
> > + * NTB specific properties like db_count, spad_count, num_mws etc.,
> > + */
> > +static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
> > +                                         struct config_group *group)
> > +{
> > +     struct epf_ntb *ntb =3D epf_get_drvdata(epf);
> > +     struct config_group *ntb_group =3D &ntb->group;
> > +     struct device *dev =3D &epf->dev;
> > +
> > +     config_group_init_type_name(ntb_group, dev_name(dev), &ntb_group_=
type);
> > +
> > +     return ntb_group;
> > +}
> > +
> > +/*=3D=3D=3D=3D virtual PCI bus driver, which only load virutal ntb pci=
 driver =3D=3D=3D=3D*/
>
> s/virutal ntb pci/virtual NTB PCI/
>
> > +#define VPCI_BUS_NUM 0x10
>
> How did you pick this number and how do we know it is available?

This is problem. Do you know auto detect bus number method?
or can I put it to configfs, let user to config it.

>
> > +uint32_t pci_space[] =3D {
>
> "static u32"?
>
> > +     (VNTB_VID | (VNTB_PID << 16)),  //DeviceID, Vendor ID
> > +     0,              // status, Command
> > +     0xffffffff,     // Class code, subclass, prog if, revision id
> > +     0x40,           //bist, header type, latency Timer, cache line si=
ze
> > +     0,              //bar 0
> > +     0,              //bar 1
> > +     0,              //bar 2
> > +     0,              //bar 3
> > +     0,              //bar 4
> > +     0,              //bar 5
>
> s/bar/BAR/
>
> > +     0,              //cardbus cis point
> > +     0,              //Subsystem ID Subystem vendor id
> > +     0,              //ROM Base Address
> > +     0,              //Reserved, Cap. Point
> > +     0,              //Reserved,
> > +     0,              //Max Lat, Min Gnt, interrupt pin, interrupt line
>
> Use /* */ instead of //, like the rest of drivers/pci/
>
> > +};
> > +
> > +int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int s=
ize, u32 *val)
> > +{
> > +     if (devfn =3D=3D 0) {
> > +             memcpy(val, ((uint8_t *)pci_space) + where, size);
>
> "u8 *"?
>
> > +             return 0;
> > +     }
> > +     return -1;
>
> These should return PCIBIOS_SUCCESSFUL or PCIBIOS_DEVICE_NOT_FOUND.
>
> > +}
> > +
> > +int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int =
size, u32 val)
> > +{
> > +     return 0;
> > +}
> > +
> > +struct pci_ops vpci_ops =3D {
> > +     .read =3D pci_read,
> > +     .write =3D pci_write,
> > +};
> > +
> > +static int vpci_bus(void *sysdata)
>
> The function name should say something about what it does.  Maybe
> vpci_scan_bus() or something?
>
> > +{
> > +     struct pci_bus *vpci_bus;
> > +
> > +     vpci_bus =3D pci_scan_bus(VPCI_BUS_NUM, &vpci_ops, sysdata);
> > +     if (vpci_bus)
> > +             pr_err("create pci bus\n");
> > +
> > +     pci_bus_add_devices(vpci_bus);
> > +
> > +     return 0;
> > +}
> > +
> > +/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Virtual=
 PCIe NTB driver =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D*/
> > +
> > +static int vntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
> > +{
> > +     struct epf_ntb *ndev =3D ntb_ndev(ntb);
> > +
> > +     return ndev->num_mws;
> > +}
> > +
> > +static int vntb_epf_spad_count(struct ntb_dev *ntb)
> > +{
> > +     return ntb_ndev(ntb)->spad_count;
> > +}
> > +
> > +static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
> > +{
> > +     return ntb_ndev(ntb)->num_mws;
> > +}
> > +
> > +static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
> > +{
> > +     return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
> > +}
> > +
> > +static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int i=
dx,
> > +             dma_addr_t addr, resource_size_t size)
> > +{
> > +     struct epf_ntb *ntb =3D ntb_ndev(ndev);
> > +     struct pci_epf_bar *epf_bar;
> > +     enum pci_barno barno;
> > +     int ret;
> > +     struct device *dev;
> > +
> > +     dev =3D &ntb->ntb.dev;
> > +     barno =3D ntb->epf_ntb_bar[BAR_MW0 + idx];
> > +     epf_bar =3D &ntb->epf->bar[barno];
> > +     epf_bar->phys_addr =3D addr;
> > +     epf_bar->barno =3D barno;
> > +     epf_bar->size =3D size;
> > +
> > +     ret =3D pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> > +     if (ret) {
> > +             dev_err(dev, "failure set mw trans\n");
> > +             return ret;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int vntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int =
idx)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
> > +                             phys_addr_t *base, resource_size_t *size)
> > +{
> > +
> > +     struct epf_ntb *ntb =3D ntb_ndev(ndev);
> > +
> > +     if (base)
> > +             *base =3D ntb->vpci_mw_phy[idx];
> > +
> > +     if (size)
> > +             *size =3D ntb->mws_size[idx];
> > +
> > +     return 0;
> > +}
> > +
> > +static int vntb_epf_link_enable(struct ntb_dev *ntb,
> > +                     enum ntb_speed max_speed,
> > +                     enum ntb_width max_width)
> > +{
> > +     return 0;
> > +}
> > +
> > +static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
> > +{
> > +     struct epf_ntb *ntb =3D ntb_ndev(ndev);
> > +     int off =3D ntb->reg->spad_offset, ct =3D ntb->reg->spad_count * =
4;
> > +     u32 val;
> > +     void __iomem *base =3D ntb->reg;
> > +
> > +     val =3D readl(base + off + ct + idx * 4);
> > +     return val;
> > +}
> > +
> > +static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
> > +{
> > +     struct epf_ntb *ntb =3D ntb_ndev(ndev);
> > +     struct epf_ntb_ctrl *ctrl =3D ntb->reg;
> > +     int off =3D ctrl->spad_offset, ct =3D ctrl->spad_count * 4;
> > +     void __iomem *base =3D ntb->reg;
> > +
> > +     writel(val, base + off + ct + idx * 4);
> > +     return 0;
> > +}
> > +
> > +static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int=
 idx)
> > +{
> > +     struct epf_ntb *ntb =3D ntb_ndev(ndev);
> > +     struct epf_ntb_ctrl *ctrl =3D ntb->reg;
> > +     int off =3D ctrl->spad_offset;
> > +     void __iomem *base =3D ntb->reg;
> > +     u32 val;
> > +
> > +     val =3D readl(base + off + idx * 4);
> > +     return val;
> > +}
> > +
> > +static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, in=
t idx, u32 val)
> > +{
> > +     struct epf_ntb *ntb =3D ntb_ndev(ndev);
> > +     struct epf_ntb_ctrl *ctrl =3D ntb->reg;
> > +     int off =3D ctrl->spad_offset;
> > +     void __iomem *base =3D ntb->reg;
> > +
> > +     writel(val, base + off + idx * 4);
> > +     return 0;
> > +}
> > +
> > +static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
> > +{
> > +     u32 interrupt_num =3D ffs(db_bits) + 1;
> > +     struct epf_ntb *ntb =3D ntb_ndev(ndev);
> > +     u8 func_no, vfunc_no;
> > +     int ret;
> > +
> > +     func_no =3D ntb->epf->func_no;
> > +     vfunc_no =3D ntb->epf->vfunc_no;
> > +
> > +     ret =3D pci_epc_raise_irq(ntb->epf->epc,
> > +                             func_no,
> > +                             vfunc_no,
> > +                             PCI_EPC_IRQ_MSI,
> > +                             interrupt_num + 1);
> > +     if (ret) {
> > +             dev_err(&ntb->ntb.dev, "intf: Failed to raise IRQ\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
>
> Equivalent to:
>
>   if (ret)
>     dev_err(...);
>
>   return ret;
>
> > +}
> > +
> > +static u64 vntb_epf_db_read(struct ntb_dev *ndev)
> > +{
> > +     struct epf_ntb *ntb =3D ntb_ndev(ndev);
> > +
> > +     return ntb->db;
> > +}
> > +
> > +static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int i=
dx,
> > +                     resource_size_t *addr_align,
> > +                     resource_size_t *size_align,
> > +                     resource_size_t *size_max)
> > +{
> > +     struct epf_ntb *ntb =3D ntb_ndev(ndev);
> > +
> > +     if (addr_align)
> > +             *addr_align =3D SZ_4K;
> > +
> > +     if (size_align)
> > +             *size_align =3D 1;
> > +
> > +     if (size_max)
> > +             *size_max =3D ntb->mws_size[idx];
> > +
> > +     return 0;
> > +}
> > +
> > +static u64 vntb_epf_link_is_up(struct ntb_dev *ndev,
> > +                     enum ntb_speed *speed,
> > +                     enum ntb_width *width)
> > +{
> > +     struct epf_ntb *ntb =3D ntb_ndev(ndev);
> > +
> > +     return ntb->reg->link_status;
> > +}
> > +
> > +static int vntb_epf_db_clear_mask(struct ntb_dev *ndev, u64 db_bits)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
> > +{
> > +     struct epf_ntb *ntb =3D ntb_ndev(ndev);
> > +
> > +     ntb->db &=3D ~db_bits;
> > +     return 0;
> > +}
> > +
> > +static int vntb_epf_link_disable(struct ntb_dev *ntb)
> > +{
> > +     return 0;
> > +}
> > +
> > +static const struct ntb_dev_ops vntb_epf_ops =3D {
> > +     .mw_count               =3D vntb_epf_mw_count,
> > +     .spad_count             =3D vntb_epf_spad_count,
> > +     .peer_mw_count          =3D vntb_epf_peer_mw_count,
> > +     .db_valid_mask          =3D vntb_epf_db_valid_mask,
> > +     .db_set_mask            =3D vntb_epf_db_set_mask,
> > +     .mw_set_trans           =3D vntb_epf_mw_set_trans,
> > +     .mw_clear_trans         =3D vntb_epf_mw_clear_trans,
> > +     .peer_mw_get_addr       =3D vntb_epf_peer_mw_get_addr,
> > +     .link_enable            =3D vntb_epf_link_enable,
> > +     .spad_read              =3D vntb_epf_spad_read,
> > +     .spad_write             =3D vntb_epf_spad_write,
> > +     .peer_spad_read         =3D vntb_epf_peer_spad_read,
> > +     .peer_spad_write        =3D vntb_epf_peer_spad_write,
> > +     .peer_db_set            =3D vntb_epf_peer_db_set,
> > +     .db_read                =3D vntb_epf_db_read,
> > +     .mw_get_align           =3D vntb_epf_mw_get_align,
> > +     .link_is_up             =3D vntb_epf_link_is_up,
> > +     .db_clear_mask          =3D vntb_epf_db_clear_mask,
> > +     .db_clear               =3D vntb_epf_db_clear,
> > +     .link_disable           =3D vntb_epf_link_disable,
> > +};
> > +
> > +static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_devic=
e_id *id)
> > +{
> > +     int ret;
> > +     struct epf_ntb *ndev =3D (struct epf_ntb *)pdev->sysdata;
> > +     struct device *dev =3D &pdev->dev;
> > +
> > +     ndev->ntb.pdev =3D pdev;
> > +     ndev->ntb.topo =3D NTB_TOPO_NONE;
> > +     ndev->ntb.ops =3D  &vntb_epf_ops;
> > +
> > +     ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > +     if (ret) {
> > +             dev_err(dev, "Cannot set DMA mask\n");
> > +             return -1;
>
> return -EINVAL;
>
> > +     }
> > +
> > +     ret =3D ntb_register_device(&ndev->ntb);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to register NTB device\n");
> > +             goto err_register_dev;
> > +     }
> > +
> > +     dev_info(dev, "PCI Virtual NTB driver loaded\n");
> > +     return 0;
> > +
> > +err_register_dev:
> > +     return -1;
>
> return -EINVAL;
>
> > +}
> > +
> > +static const struct pci_device_id pci_vntb_table[] =3D {
> > +     {
> > +             PCI_DEVICE(VNTB_VID, VNTB_PID),
> > +     },
> > +     {},
> > +};
> > +
> > +static struct pci_driver vntb_pci_driver =3D {
> > +     .name           =3D "pci-vntb",
> > +     .id_table       =3D pci_vntb_table,
> > +     .probe          =3D pci_vntb_probe,
> > +};
> > +
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D PCIe EPF Driver Bind =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
> > +
> > +/**
> > + * epf_ntb_bind() - Initialize endpoint controller to provide NTB func=
tionality
> > + * @epf: NTB endpoint function device
> > + *
> > + * Initialize both the endpoint controllers associated with NTB functi=
on device.
> > + * Invoked when a primary interface or secondary interface is bound to=
 EPC
> > + * device. This function will succeed only when EPC is bound to both t=
he
> > + * interfaces.
> > + */
> > +static int epf_ntb_bind(struct pci_epf *epf)
> > +{
> > +     struct epf_ntb *ntb =3D epf_get_drvdata(epf);
> > +     struct device *dev =3D &epf->dev;
> > +     int ret;
> > +
> > +     if (!epf->epc) {
> > +             dev_dbg(dev, "PRIMARY EPC interface not yet bound\n");
> > +             return 0;
> > +     }
> > +
> > +     ret =3D epf_ntb_init_epc_bar(ntb);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to create NTB EPC\n");
> > +             goto err_bar_init;
> > +     }
> > +
> > +     ret =3D epf_ntb_config_spad_bar_alloc(ntb);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to allocate BAR memory\n");
> > +             goto err_bar_alloc;
> > +     }
> > +
> > +     ret =3D epf_ntb_epc_init(ntb);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to initialize EPC\n");
> > +             goto err_bar_alloc;
> > +     }
> > +
> > +     epf_set_drvdata(epf, ntb);
> > +
> > +     if (pci_register_driver(&vntb_pci_driver)) {
> > +             dev_err(dev, "failure register vntb pci driver\n");
> > +             goto err_bar_alloc;
> > +     }
> > +
> > +     vpci_bus(ntb);
> > +
> > +     return 0;
> > +
> > +err_bar_alloc:
> > +     epf_ntb_config_spad_bar_free(ntb);
> > +
> > +err_bar_init:
> > +     epf_ntb_epc_destroy(ntb);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * epf_ntb_unbind() - Cleanup the initialization from epf_ntb_bind()
> > + * @epf: NTB endpoint function device
> > + *
> > + * Cleanup the initialization from epf_ntb_bind()
> > + */
> > +static void epf_ntb_unbind(struct pci_epf *epf)
> > +{
> > +     struct epf_ntb *ntb =3D epf_get_drvdata(epf);
> > +
> > +     epf_ntb_epc_cleanup(ntb);
> > +     epf_ntb_config_spad_bar_free(ntb);
> > +     epf_ntb_epc_destroy(ntb);
> > +
> > +     pci_unregister_driver(&vntb_pci_driver);
> > +}
> > +
> > +// EPF driver probe
> > +static struct pci_epf_ops epf_ntb_ops =3D {
> > +     .bind   =3D epf_ntb_bind,
> > +     .unbind =3D epf_ntb_unbind,
> > +     .add_cfs =3D epf_ntb_add_cfs,
> > +};
> > +
> > +/**
> > + * epf_ntb_probe() - Probe NTB function driver
> > + * @epf: NTB endpoint function device
> > + *
> > + * Probe NTB function driver when endpoint function bus detects a NTB
> > + * endpoint function.
> > + */
> > +static int epf_ntb_probe(struct pci_epf *epf)
> > +{
> > +     struct epf_ntb *ntb;
> > +     struct device *dev;
> > +
> > +     dev =3D &epf->dev;
> > +
> > +     ntb =3D devm_kzalloc(dev, sizeof(*ntb), GFP_KERNEL);
> > +     if (!ntb)
> > +             return -ENOMEM;
> > +
> > +     epf->header =3D &epf_ntb_header;
> > +     ntb->epf =3D epf;
> > +     epf_set_drvdata(epf, ntb);
> > +
> > +     dev_info(dev, "pci-ep epf driver loaded\n");
>
> I think most drivers don't announce when they're loaded because it
> really doesn't help the user.
>
> > +     return 0;
> > +}
> > +
> > +static const struct pci_epf_device_id epf_ntb_ids[] =3D {
> > +     {
> > +             .name =3D "pci_epf_vntb",
> > +     },
> > +     {},
> > +};
> > +
> > +static struct pci_epf_driver epf_ntb_driver =3D {
> > +     .driver.name    =3D "pci_epf_vntb",
> > +     .probe          =3D epf_ntb_probe,
> > +     .id_table       =3D epf_ntb_ids,
> > +     .ops            =3D &epf_ntb_ops,
> > +     .owner          =3D THIS_MODULE,
> > +};
> > +
> > +
>
> Spurious blank line.
>
> > +static int __init epf_ntb_init(void)
> > +{
> > +     int ret;
> > +
> > +     kpcintb_workqueue =3D alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
> > +                                         WQ_HIGHPRI, 0);
> > +     ret =3D pci_epf_register_driver(&epf_ntb_driver);
> > +     if (ret) {
> > +             destroy_workqueue(kpcintb_workqueue);
> > +             pr_err("Failed to register pci epf ntb driver --> %d\n", =
ret);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +module_init(epf_ntb_init);
> > +
> > +static void __exit epf_ntb_exit(void)
> > +{
> > +     pci_epf_unregister_driver(&epf_ntb_driver);
> > +     destroy_workqueue(kpcintb_workqueue);
> > +}
> > +module_exit(epf_ntb_exit);
> > +
> > +MODULE_DESCRIPTION("PCI EPF NTB DRIVER");
> > +MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.24.0.rc1
> >
