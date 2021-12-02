Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85F465C42
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 03:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhLBCpY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 21:45:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40334 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354817AbhLBCpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 21:45:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BED39CE2152;
        Thu,  2 Dec 2021 02:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67E3C53FAD;
        Thu,  2 Dec 2021 02:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638412887;
        bh=3m7u+sZ/JfXv7vqQawelWiRYjzHEFtbgYJYUWG9r1b8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hjCrMloeAlo//c8uV0wTXGJY0VQVzX9ss7WawxL7wQRoAuBKXP0WojV1OZOv4aujV
         KCtvKUcdYwiK8Q+W2ZiGz8xHCknfrXPF+AME8sulXPEwr4WchGXsDsfg9GFWTg/8jN
         4hch1iY5Y7fLi1vXa8GySt12r/DDBlSevFTd2XJcgNbYePsSpep1f3wXVRuYQNweGQ
         aYarJWYG3EexQmMMETCQoOvgQt73cuu+DL122qwK9gjVpuCynAe/DmHnoxF5AxGQ7z
         kIIkLxmECwJbaIebeWVqGGGVPdiZwTYtNghm+NvS6bYRqQUe0KoNHgUii9KGHxfuwc
         c34XVzxEryGyQ==
Received: by mail-ed1-f44.google.com with SMTP id t5so110118732edd.0;
        Wed, 01 Dec 2021 18:41:27 -0800 (PST)
X-Gm-Message-State: AOAM53394BURSf8kjVpS1Ms0BpZTSnnu+v1ZaBg0tA3ekV4bWI3d9Lra
        rZ1gc607Cd13VhXyTzhQd+1mE3gsOzAjHCFRBw==
X-Google-Smtp-Source: ABdhPJx3F1WjNpDHru/DM96kME/hsAFfccUE3YKHA93VV80AISgDEazU3AyQVF7UBufYAD4s9o/PG7DqPjwpNjKq0MU=
X-Received: by 2002:a17:906:9941:: with SMTP id zm1mr11679319ejb.466.1638412886275;
 Wed, 01 Dec 2021 18:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20211101180243.23761-1-tharvey@gateworks.com> <CAJ+vNU2Pfwz5e0Jj6c5npceOwuNTB_dTVuL4NMD2qxr0CGyeGQ@mail.gmail.com>
 <AS8PR04MB86769FC6021C2C137776D7A68C699@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86769FC6021C2C137776D7A68C699@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Dec 2021 20:41:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKLqcRdHBQRnra20mkoPsEjy0Boni-mOVNQxNTwhbc7sQ@mail.gmail.com>
Message-ID: <CAL_JsqKLqcRdHBQRnra20mkoPsEjy0Boni-mOVNQxNTwhbc7sQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx: do not remap invalid res
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 1, 2021 at 6:48 PM Hongxing Zhu <hongxing.zhu@nxp.com> wrote:
>
>
> > -----Original Message-----
> > From: Tim Harvey <tharvey@gateworks.com>
> > Sent: Thursday, December 2, 2021 6:07 AM
> > To: Jingoo Han <jingoohan1@gmail.com>; Gustavo Pimentel
> > <gustavo.pimentel@synopsys.com>; Rob Herring <robh@kernel.org>;
> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Krzysztof Wilczy=C5=84sk=
i
> > <kw@linux.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > linux-pci@vger.kernel.org
> > Cc: open list <linux-kernel@vger.kernel.org>; Hongxing Zhu
> > <hongxing.zhu@nxp.com>
> > Subject: Re: [PATCH] PCI: imx: do not remap invalid res

Please fix your quoting style with all the headers (hint: don't use
Outlook). It's base64 encoded too which isn't ideal for maillists, but
somewhat tolerated nowadays.

> >
> > On Mon, Nov 1, 2021 at 11:03 AM Tim Harvey <tharvey@gateworks.com>
> > wrote:
> > >
> > > On imx6 and perhaps others when pcie probes you get a:
> > > imx6q-pcie 33800000.pcie: invalid resource
> > >
> > > This occurs because the atu is not specified in the DT and as such it
> > > should not be remapped.
> > >
> > > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> [Richard Zhu] Please merge Rob's commit log changes.

The maintainer tools do that automatically.

> Then, Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

But probably not when you prefix your tag with 'Then, '... :(

Rob
