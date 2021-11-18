Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3647455413
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 06:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbhKRFLf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 00:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242463AbhKRFLc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 00:11:32 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505D7C061764;
        Wed, 17 Nov 2021 21:08:33 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id az37so10963881uab.13;
        Wed, 17 Nov 2021 21:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sQDsPGVQd+1fNvhzjKelD6Q5lErAJ0u05RDXxKrw7ko=;
        b=jmdU4K/BBfkz1zGIoMDv3bbhW951Y2fivg4UpcumIT4yqz5hFe+OtWSimJNNLV1v1/
         U/l0lURZo39B/9oHh1uojGg3ecQxZi0wOlHz+b57Liq2An84iIQYbrKkyboV0uWsZ5RC
         aYl7Cjy5S2kbcoJ6DQ/RQtBl7gewB5uAvmBJsK+9sIUSs3x/iRAefOqwWZ67c/Lxcqat
         UI5dFDwBIoj2xYqOspA260GyqCbupcYzlcH0zzRoWOsdUCywzeTWa36B+wwhbEu8ZotG
         CLw6zkqB5JLC9kKfrjGvOpdehT0tp1L87MgCxcpWKo1aq1MDVRRR2Be1MOnujBSuFlwj
         82KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sQDsPGVQd+1fNvhzjKelD6Q5lErAJ0u05RDXxKrw7ko=;
        b=dz7cAS82UM0SOdN0tQc041sfb+lvp4lek2NFmOT7H0JdFdoTHsJ+kW3BQB/EYOgjmr
         hTtMSZnEURPd3qUdltQnSVkUDltGXuhaQDBmuhu3jjLZnspi8u9581hoa4/gV5SqVNNT
         MLGupzVvR8xrn/bMO1xOY7mqDp9EqpvyVqUK43ez8oH7Y9inMH5bdQ3lLvjqdjpqwGAm
         iE4J1rBKAnrEHDaWya17vTbiM2hZekSv42ntM9bR17BUWGYz+DcAFwTqIPc+jWVYmylp
         1RoEKV/sSPyz6yj+90H54A64Hz8RnCGJL0pkGzeTYQUpMm9PG1H+z3pVBhFMAAykcVgW
         SuYw==
X-Gm-Message-State: AOAM531Gk5W2ff6tlHY11E/YCXkdhljIMOyye5qahf86ViFDNCth/QXp
        GAtn7BAGubfqVU3MyxbPYTm601nYUP4yDjN9HBY=
X-Google-Smtp-Source: ABdhPJyyK8OMJQXI0yDUrxVJ+9mF2J2fKcombqjddSyzUAijWjDIy87ErRmp3s6H94r9otGNCaJTtTd/6oUVoNxr+w4=
X-Received: by 2002:a05:6102:3a11:: with SMTP id b17mr77755865vsu.28.1637212112529;
 Wed, 17 Nov 2021 21:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20211117152952.12271-1-sergio.paracuellos@gmail.com> <YZVwtUO/j/ZYaL3q@rocinante>
In-Reply-To: <YZVwtUO/j/ZYaL3q@rocinante>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 18 Nov 2021 06:08:21 +0100
Message-ID: <CAMhs-H9KQbW=SQCyuR4008NPt8dWpGYspHTwJRRAeoi7Z1ygRg@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: declare 'mt7621_pci_ops' static
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On Wed, Nov 17, 2021 at 10:14 PM Krzysztof Wilczy=C5=84ski <kw@linux.com> w=
rote:
>
> Hi,
>
> > Sparse complains about 'mt7621_pci_ops' symbol is not declared and asks=
 if
> > it should be declared as 'static' instead. Sparse is right. Hence decla=
re
> > symbol as static.
>
> Thank you for taking care of this!
>
> [...]
> > -struct pci_ops mt7621_pci_ops =3D {
> > +static struct pci_ops mt7621_pci_ops =3D {
> >       .map_bus        =3D mt7621_pcie_map_bus,
> >       .read           =3D pci_generic_config_read,
> >       .write          =3D pci_generic_config_write,
>
> Thank you!
>
> Reviewed-by: Krzysztof Wilczy=C5=84ski <kw@linux.com>

Thanks!

Best regards,
     Sergio Paracuellos

>
>         Krzysztof
