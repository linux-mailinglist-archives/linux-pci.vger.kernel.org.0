Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAF61A38ED
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDIRco (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 13:32:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43700 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgDIRco (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 13:32:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id bd14so794040edb.10
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2020 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kLbua9RUTvB8Z4noBE8/pra0yF9XWjlvGofQzhuXQHY=;
        b=C9fEAWrBpyqru3/p8ek1qg+pZSPqUgcb6glEmi3A11BTu+vEXi85+sVOSyfqPIVb11
         Mf7GJFqPVvnLvZR79xwMxafZhyXlZDyL0oC1vn39RuEjB/MwNr/4kzNDX/d+TZQSYd/w
         Ns796JK+x79kiViCxe8b+JtUvGItM1xLTyZTesWjY9IGmQRxPiTrc5qW1TBJRMoVlFbF
         f/SvBGEEAzgSjo0fUlmREpnZr8IrjiWsZ8rSrBFhxz4oX2n1ocmPBvGpDpXzOqSaKpOG
         y00cJp0PczqZ6Q2YTk6CnJBwXcX9Fn2eMyy4ntFYRDwpRRPaY+J+7Gsoio0H5uiS6STh
         cJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kLbua9RUTvB8Z4noBE8/pra0yF9XWjlvGofQzhuXQHY=;
        b=SgOJSgdaYgmvCRgJNbnf/+GsI0yuWsITu4ldV05QLBsZn0v5Bz5k87Oa8Pb7TPgwys
         GzgE1fsWs+lymd5sZa6vjKsK1pWUtn1w5aEnoqjZBotXbMVPjrFD94RR7lvnMkv+txPH
         BOa+M1jdCKcGccXEmce1nd9RK/aF17QduodNTwfgt+pQ54cOueHQ/2jnwJoC9bQMlDTa
         mZkiXIlD2KP2r59wD6xIGS13Yfp+YsRCoYAH+I1NWZOc3t/Sdumt2Z/nYEOV1i/7s/YT
         Ki22VjPu2of4KMTRTjvlezC8DPzZJLIYoBKzSmdZ51n/IquQoG7MLMeb2oEhHCznVmFO
         5gXw==
X-Gm-Message-State: AGi0PuYh6jY1bNaqwYxpU4Qt0wdwMUSQnTPALbk4bqC4DzGUIP5dNkkG
        eFVFGE+RX6zMJFlDb+MwydagOQXJdYrv2z9kzFM=
X-Google-Smtp-Source: APiQypKC/1HHGegIKJ5UgT9sGq71bba+iYxz10Og+y5duQ0vMBcylCMNN/TvNeCyRKpT14RRKaGtjE6Eet9cU/jCwsQ=
X-Received: by 2002:aa7:c251:: with SMTP id y17mr1109512edo.117.1586453562842;
 Thu, 09 Apr 2020 10:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1oCwx=w3S0ednwM2mJEEidqF3saEKu9OQP=i82y3Az0Aw@mail.gmail.com>
 <20200409163010.GA8879@google.com>
In-Reply-To: <20200409163010.GA8879@google.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Thu, 9 Apr 2020 18:32:31 +0100
Message-ID: <CAEzXK1pRsgcHXiQ8yrVU_rknWfXbq7F5YQgB-UqjFKd9rf9S7A@mail.gmail.com>
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

I have looked at their webpage and I see no signs of a firmware that
can be downloaded.
https://coral.ai/products/pcie-accelerator

If it is acceptable for you I'll provide a patch for such a quirk.

Thanks,
Lu=C3=ADs

On Thu, Apr 9, 2020 at 5:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Apr 09, 2020 at 04:25:40PM +0100, Lu=C3=ADs Mendes wrote:
> > Hi Bjorn,
> >
> > I've good news. I've found the culprit and it is a pretty simple
> > issue, however the good solution is not obvious to me.
> > Can you help in finding the best way to patch this issue?
> >
> > So first detailing the problem in file setup_bus.c there is this *if
> > condition* to ignore resources from classless devices and so
> > it is that this Google/Coral Edge TPU is a classless device with class =
0xff:
> >
> > static void __dev_sort_resources(struct pci_dev *dev, struct list_head =
*head)
> > {
> >     u16 class =3D dev->class >> 8;
> >
> >        pci_info(dev, "%s\n", __func__);
> >     /* Don't touch classless devices or host bridges or IOAPICs */
> >     if (class =3D=3D PCI_CLASS_NOT_DEFINED || class =3D=3D PCI_CLASS_BR=
IDGE_HOST)
> >         return;
> >    ....
> >
> > So the one possible trivial, non generic, attempt that works is to do:
> > static void __dev_sort_resources(struct pci_dev *dev, struct list_head =
*head)
> > {
> >     u16 class =3D dev->class >> 8;
> >
> >        pci_info(dev, "%s\n", __func__);
> >     /* Don't touch classless devices or host bridges or IOAPICs */
> >     if ((class =3D=3D PCI_CLASS_NOT_DEFINED &&  !(dev->vendor =3D=3D 0x=
1ac1 &&
> > dev->device=3D=3D0x089a)) || class =3D=3D PCI_CLASS_BRIDGE_HOST)
> >         return;
> >    ....
> >
> > What is your suggestion to make the solution generic? Create a
> > whitelist? Remove this verification? I have no idea... nothing sounds
> > good to me...
>
> Good detective work, thanks for chasing this down!
>
> I should have seen that check when adding the debug.  Guess I thought
> "sort", hmmm, that just re-orders things without actually changing the
> content.  But pdev_sort_resources() in fact *adds* resources to a
> list, and if resources aren't on the list, we apparently don't assign
> space for them.
>
> In any event, I would first check to see if there's an Edge TPU
> firmware update that might set the class code.
>
> If not, we should probably add a quirk to override the class code,
> similar to quirk_eisa_bridge(), fixup_rev1_53c810(),
> fixup_ti816x_class(), quirk_tw686x_class().
>
> Bjorn
