Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5FEA19B7FA
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 23:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbgDAVzb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 17:55:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33206 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733095AbgDAVzb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 17:55:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id z65so1774958ede.0
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2020 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IJfTn+n0wfDmkCqTPnJmRqCMkG1gjssa+UPmJu7EOJk=;
        b=BK4QcjK0MzMMRSGGWNy+X5fl+1x7NtzkDcL6yhfMrALUHI5DoQ24W5c5AFp3QEF1U2
         vqXxt+pberXqK7upByEA0sFiqbFWeknoZcr36yF8fFVwL/0MdTWC44Lle/c768i6kON6
         54dNy+qJaZjQU1c+S96JG1NDXooeaoCRalJfNoPIMz1NkLnxEF4AS9culN7EebGNSPGU
         4H46iBeIePBCXSf20+546et9gmWLzenKaHpTmziwoJB+mk6JdbRNcU8y5dRIRiS8RV3k
         E9gyJnTUDtu4cYj61jPKb3QvIboppEqmjXv3Bwcwbd1DW3kbS7+ynJsaRxSqQo0J4Go9
         7e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IJfTn+n0wfDmkCqTPnJmRqCMkG1gjssa+UPmJu7EOJk=;
        b=YS+sJzhvariszDBRs4ZAQsjuap/DZoViRx1/0jX7AlSVAXs8zeda+EE8lXBHNEq4bI
         CEeh+x+0EjTgiVAdU4N6FePBNdCdI0iOiEj25fm9xkIvVdLmRjF/Dr3ztgusbFsI0GYc
         CtSUlK52h5RPzdBLF1wB07tHyAfaDXGHdWZUO4vUkmXJDsnh4GWZumK78XdsM4EFzFDs
         Ki8OgOH/ajaJy0Up8oXC3i9HNbG9rUZgUKrKPsWfjcRgivuNHThu1C+mzr6wend0BcLz
         m3ctqLSVZuYmVZIdxrxYwg9h8BbgaU3tpTx3dEeEeHV5vWHI2ovb2kAexs/arTekvDD8
         8oYw==
X-Gm-Message-State: AGi0PuZ/gCn7blU5+wJgZcz/zX7nhH5nj3qLVLUvEHxnYLziwoTXDVwy
        vVUdPj78JQ/dlbhVIKDRJJA0mtkoc7UtlwB6+Xc=
X-Google-Smtp-Source: APiQypJyrI2juezkhj0ErC4mZXNUpO0XWrMr0RLQZfE14UtaA/lAvYA82DHYuJGAcMTpJYmvBqHkl2/KOcbWd3jwO+E=
X-Received: by 2002:aa7:c251:: with SMTP id y17mr65269edo.117.1585778129750;
 Wed, 01 Apr 2020 14:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1q1ufa1GoL_ZXdqothu_Dub4SAV1KZ_JFcpuF-p0f2Z4w@mail.gmail.com>
 <20200401181632.GA96762@google.com> <CAEzXK1pZufvY9VcXnjrrDMmiMoURtTaL1+8jGWL7k+yyGhKyDw@mail.gmail.com>
In-Reply-To: <CAEzXK1pZufvY9VcXnjrrDMmiMoURtTaL1+8jGWL7k+yyGhKyDw@mail.gmail.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Wed, 1 Apr 2020 22:55:18 +0100
Message-ID: <CAEzXK1p-cqNGoZVb+3pa92US=dYk6_GLGn2y_xa8CX2bWXiG5w@mail.gmail.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on Linux
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjiorn

I don't see any log of __pci_bridge_assign_resources. This platform
makes use of pci-bridge-emul.c functions. Don't know if that can be
responsible for not calling __pci_bridge_assign_resources(...).

Lu=C3=ADs

On Wed, Apr 1, 2020 at 10:20 PM Lu=C3=ADs Mendes <luis.p.mendes@gmail.com> =
wrote:
>
> Hi Bjorn,
>
> Here is the dmesg output with the new kernel patch:
> https://paste.ubuntu.com/p/7cv7ZcyrnG/
>
> Lu=C3=ADs
>
> On Wed, Apr 1, 2020 at 7:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Mar 31, 2020 at 10:28:51PM +0100, Lu=C3=ADs Mendes wrote:
> > > I've removed all other PCIe devices to make the analysis easier.
> > > The dmesg with the traces can be found at:
> > > https://paste.ubuntu.com/p/W3m2VQCYqg/
> > >
> > > Didn't find anything new related to BAR0 or BAR2, in the dmesg,
> > > though. Anyway I'm no expert in this, maybe it can give you some
> > > useful information, still.
> >
> > It looks like we assigned the right amount of space to the bridge, but
> > for some reason didn't assign it to the device *below* the bridge.
> >
> > I added a few more messages in this patch.  Can you remove the first
> > one and replace it with this?  This is still based on v5.6-rc1.
> >
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 8e40b3e6da77..2cdb705752de 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> ...
