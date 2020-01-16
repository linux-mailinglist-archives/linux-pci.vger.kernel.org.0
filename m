Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4538A13DD8E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 15:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgAPOhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 09:37:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37328 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPOhX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 09:37:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so19429717wru.4;
        Thu, 16 Jan 2020 06:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ao9ecw6eTFgKaKQJe1zn6/MAY37uMpnY+Wyi9DHZCHA=;
        b=qrS/i4CS4G6n3S4yRmIaFd0FefJkN2j7D6ffx4ZY7oi+k8DwBj8cltFzlBrzAmjHa7
         BtFrAjqnwlnjsNQvsEjJoexK84RwFrMr+EWl8XlNAtmyKu/Y7ZWSW0zXfsVoLPIS6AHQ
         T6phXoS/r/9H/L253mE6CNdTfloiSonDXSvgYfK7GwI/baH/8O5VJs1wEU2cdsBvLQzI
         jP9tzcoEMYdbFVJMOMrOi60jhuSm1kBCD+Y6aDTUvxSAAz3RXDqHuHDE+ZNCI+9GDbez
         BXlCwcWRt2k90QgtINN7qjSe6lc+KO93gg5/X9R6wF4Cu/Go/NufBsWlfPfFG6e6F97j
         qc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ao9ecw6eTFgKaKQJe1zn6/MAY37uMpnY+Wyi9DHZCHA=;
        b=T6Dmb7Lqzl1qVSiRRv/OC6Cwb7K6rCysRKyBc5QBEvQ5fuRAdAYOsxD74ZJYgesSWD
         IJasZlW+G0lLyCogPkjp8Tnw/aB2CButs4cpaJeUxEl167oLOY/5Bbvb1eGUFB+zkkDD
         5NSpOaDnt2rCJoUZSB6K0FvSKNB7y7J6ZwiGJ8p31T6pVph/u/P1U93xmmscALY+fiqn
         LGnbb5JVXfvRExE2JGn38/4quljk/EQGlifA2u1aTnCHltJAMfCvsV/6ymM4LhEgvoQv
         fuwIUpg8HnPBjWEpNQ70P8SOV9duL9u9S/git/6I1drT+f41NI4edXPMA76WRTU6/0b2
         uzSg==
X-Gm-Message-State: APjAAAV18K0MJVUh5ZVCgz3CbgcfFcFXFcIeols8kr11zla3xfS2Q2r0
        6nRY0nVlfkik4iROmhH4buMT80/Y+r9p0bLNHlI=
X-Google-Smtp-Source: APXvYqxLQ6y3fUZYo/hqHdOVVkW3DDWqe/fr59dH3ldpL8NbaNVKIkOOf69+QCKbCgJ2IaMbKBfD7+4/rjel+LBPB3s=
X-Received: by 2002:adf:e547:: with SMTP id z7mr3745675wrm.258.1579185441083;
 Thu, 16 Jan 2020 06:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20200114170231.16421-1-andrew.smirnov@gmail.com> <AM0PR0402MB35708B48AF371E81BFCCED158C370@AM0PR0402MB3570.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB35708B48AF371E81BFCCED158C370@AM0PR0402MB3570.eurprd04.prod.outlook.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 16 Jan 2020 06:37:09 -0800
Message-ID: <CAHQ1cqFg_EcLRUtOO65P-K4hFdkx0OyzxOupqdqwicnhROiZ6A@mail.gmail.com>
Subject: Re: [EXT] [PATCH] PCI: imx6: Add L1SS support for i.MX8MQ
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 7:26 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
>
> > -----Original Message-----
> > From: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Sent: 2020=E5=B9=B41=E6=9C=8815=E6=97=A5 1:03
> > To: linux-pci@vger.kernel.org
> > Cc: Andrey Smirnov <andrew.smirnov@gmail.com>; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>; Chris
> > Healy <cphealy@gmail.com>; Lucas Stach <l.stach@pengutronix.de>; Richar=
d
> > Zhu <hongxing.zhu@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: [EXT] [PATCH] PCI: imx6: Add L1SS support for i.MX8MQ
> >
> > Caution: EXT Email
> >
> > Add code to configure PCI IP block to utilize supported ASPM features.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> [Richard Zhu]  HI Andrey:
> This patch does the regmap to the src region, right?

Indeed.

> How about to add another reset to manipulate the *_OVERRIDE bit.
> Just like the following bits.
>                         resets =3D <&src IMX8MQ_RESET_PCIEPHY>,
>                                  <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
>                                  <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOF=
F>;
>                         reset-names =3D "pciephy", "apps", "turnoff";
>

Last time I talked to Philipp Zabel (maintainer of reset subsystem) he
made it pretty clear that he though that exposing those PCIe related
bits via reset subsystem (for both imx7 and imx8mq) was a mistake and
going forward he'd like to see only true reset functionality to be
exposed that way. IMX8MQ_PCIE_CTRL_APPS_CLK_REQ is definitely not a
reset line, so the case for adding it to reset driver is even weaker.

Lucas, do you mind sharing your thoughts on this?

Thanks,
Andrey Smirnov
