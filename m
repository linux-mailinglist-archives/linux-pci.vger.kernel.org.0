Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2921A3B20
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 22:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgDIUIB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 16:08:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35028 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgDIUIB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 16:08:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id c7so1582515edl.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2020 13:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cKZ2HgTM4bszn9n+B0c+DnGsJ2tutPa060dufv4ta1Q=;
        b=OmKuQOk/UvRfoY8BGx8PnM97zLPmAwrzJUq6l3JNtgbHyoaGgiKBiA3aZgye4z+8nk
         aHMv2WHQ0fLMP70cTd4j8v4MA/QL9xjjczFCy8y3jhnbUzkj69LCvBXstKyvq3OnNsTV
         shqZphMxqnrKimJ85ok8CZKEELpJJ1/y1UmY1EtnNKhiPeCcKh3zbq5kd9aPdd3hoxYe
         mIprWu+eHIz5hs7FwYCzMvzgdxhmXJL86GPgf0Yz5VYGZSJpVqqy0xZk4XN7YMZ50aFC
         yFOBFvCuG/0d3R373esnZLS/477jpZchMSae9HNf47DTdhtD4mGQVX3vDByhXvKFjTE8
         tIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cKZ2HgTM4bszn9n+B0c+DnGsJ2tutPa060dufv4ta1Q=;
        b=eTC6wI+lrSUFt/imkxnYLNDibqRfQNoxtZ03a1akxjDfJv0ECvPtS/qJzFOWJCOSkn
         PE6nzWGxAVAuoAHma93/6Z28sHKjmbcbhtO9M9ODEteoYrGN76UZLqjp96VxLAbZXk/T
         MLCvY9r1yqCKpXnFJAFdIyz0x8WsZ83Y7+Vz+7Elet9MynN3ltCOOaZr35bJgFuSX2Bb
         jbOLDSbFim7qM/1aUnDUdd6S3473sEDx1h7ubUZ/XYAwpz07V10jO34PGwn0c17DpA7m
         SZfjYdl41fy9gaPtOXMicXdw7bV2itC4+8QhO2WdftYXnae5uYjv21J+hkXQSNgXKnNf
         NA4w==
X-Gm-Message-State: AGi0PuazNyAQb96Se1jPuA7AIwF7FQOYqA4/ZHwOBaLTT715d2RI7sW3
        ZcEUTM8szs5X2XnRqRdyu6nuCWB0UWaY4p6rHUw=
X-Google-Smtp-Source: APiQypI3jXtqqmy1yy45hha9z+8hMzWcBld29DSMCGc6LuLUoSwuWCSwd03P/1ou9P0hNP8MVk35SoJgHOYjDujOxIE=
X-Received: by 2002:a50:9e29:: with SMTP id z38mr1731937ede.345.1586462878270;
 Thu, 09 Apr 2020 13:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200409163010.GA8879@google.com> <20200409180840.GA23054@google.com>
In-Reply-To: <20200409180840.GA23054@google.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Thu, 9 Apr 2020 21:07:46 +0100
Message-ID: <CAEzXK1oGTCQfQq1LFunvU53CxD+zmNcoB4B8ze6qb+LRQA1mXg@mail.gmail.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on Linux
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

I've just tested with linux-next master branch 20200409.

You can add:
Tested-by: Luis Mendes <luis.p.mendes@gmail.com>

Thanks,
Lu=C3=ADs

01:00.0 System peripheral: Device 1ac1:089a (prog-if ff)
    Subsystem: Device 1ac1:089a
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 0
    Region 0: Memory at e8100000 (64-bit, prefetchable) [disabled] [size=3D=
16K]
    Region 2: Memory at e8000000 (64-bit, prefetchable) [disabled] [size=3D=
1M]
    Capabilities: <access denied>

On Thu, Apr 9, 2020 at 7:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Todd]
>
> On Thu, Apr 09, 2020 at 11:30:10AM -0500, Bjorn Helgaas wrote:
> > On Thu, Apr 09, 2020 at 04:25:40PM +0100, Lu=C3=ADs Mendes wrote:
> > > Hi Bjorn,
> > >
> > > I've good news. I've found the culprit and it is a pretty simple
> > > issue, however the good solution is not obvious to me.
> > > Can you help in finding the best way to patch this issue?
> > >
> > > So first detailing the problem in file setup_bus.c there is this *if
> > > condition* to ignore resources from classless devices and so
> > > it is that this Google/Coral Edge TPU is a classless device with clas=
s 0xff:
> > >
> > > static void __dev_sort_resources(struct pci_dev *dev, struct list_hea=
d *head)
> > > {
> > >     u16 class =3D dev->class >> 8;
> > >
> > >        pci_info(dev, "%s\n", __func__);
> > >     /* Don't touch classless devices or host bridges or IOAPICs */
> > >     if (class =3D=3D PCI_CLASS_NOT_DEFINED || class =3D=3D PCI_CLASS_=
BRIDGE_HOST)
> > >         return;
> > >    ....
> > >
> > > So the one possible trivial, non generic, attempt that works is to do=
:
> > > static void __dev_sort_resources(struct pci_dev *dev, struct list_hea=
d *head)
> > > {
> > >     u16 class =3D dev->class >> 8;
> > >
> > >        pci_info(dev, "%s\n", __func__);
> > >     /* Don't touch classless devices or host bridges or IOAPICs */
> > >     if ((class =3D=3D PCI_CLASS_NOT_DEFINED &&  !(dev->vendor =3D=3D =
0x1ac1 &&
> > > dev->device=3D=3D0x089a)) || class =3D=3D PCI_CLASS_BRIDGE_HOST)
> > >         return;
> > >    ....
> > >
> > > What is your suggestion to make the solution generic? Create a
> > > whitelist? Remove this verification? I have no idea... nothing sounds
> > > good to me...
> >
> > Good detective work, thanks for chasing this down!
> >
> > I should have seen that check when adding the debug.  Guess I thought
> > "sort", hmmm, that just re-orders things without actually changing the
> > content.  But pdev_sort_resources() in fact *adds* resources to a
> > list, and if resources aren't on the list, we apparently don't assign
> > space for them.
> >
> > In any event, I would first check to see if there's an Edge TPU
> > firmware update that might set the class code.
> >
> > If not, we should probably add a quirk to override the class code,
> > similar to quirk_eisa_bridge(), fixup_rev1_53c810(),
> > fixup_ti816x_class(), quirk_tw686x_class().
>
> In fact, apex_pci_fixup_class() already exists!  But it's in
> apex_driver.c.  Do you happen to have CONFIG_STAGING_APEX_DRIVER=3Dm
> (built as a module)?  If so, that quirk won't be run until the module
> is loaded, and that happens long after resource assignment.
>
> Building with CONFIG_STAGING_APEX_DRIVER=3Dy (not =3Dm) should be a
> workaround.  But I think the real fix would be moving
> apex_pci_fixup_class() from apex_driver.c to drivers/pci/quirks.c,
> like the following.  Would you mind testing it?
>
>
> commit 59f3165318b3 ("PCI: Move Apex Edge TPU class quirk to fix BAR assi=
gnment")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Apr 9 12:43:45 2020 -0500
>
>     PCI: Move Apex Edge TPU class quirk to fix BAR assignment
>
>     Some Google Apex Edge TPU devices have a class code of 0
>     (PCI_CLASS_NOT_DEFINED).  This prevents the PCI core from assigning
>     resources for the Apex BARs because __dev_sort_resources() ignores
>     classless devices, host bridges, and IOAPICs.
>
>     On x86, firmware typically assigns those resources, so this was not a
>     problem.  But on some architectures, firmware does *not* assign BARs,=
 and
>     since the PCI core didn't do it either, the Apex device didn't work
>     correctly:
>
>       apex 0000:01:00.0: can't enable device: BAR 0 [mem 0x00000000-0x000=
03fff 64bit pref] not claimed
>       apex 0000:01:00.0: error enabling PCI device
>
>     f390d08d8b87 ("staging: gasket: apex: fixup undefined PCI class") add=
ed a
>     quirk to fix the class code, but it was in the apex driver, and if th=
e
>     driver was built as a module, it was too late to help.
>
>     Move the quirk to the PCI core, where it will always run early enough=
 that
>     the PCI core will assign resources if necessary.
>
>     Link: https://lore.kernel.org/r/CAEzXK1r0Er039iERnc2KJ4jn7ySNUOG9H=3D=
Ha8TD8XroVqiZjgg@mail.gmail.com
>     Fixes: f390d08d8b87 ("staging: gasket: apex: fixup undefined PCI clas=
s")
>     Reported-by: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
>     Debugged-by: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 28c9a2409c50..ca9ed5774eb1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5567,3 +5567,10 @@ static void pci_fixup_no_d0_pme(struct pci_dev *de=
v)
>         dev->pme_support &=3D ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT=
);
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_p=
me);
> +
> +static void apex_pci_fixup_class(struct pci_dev *pdev)
> +{
> +       pdev->class =3D (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
> +}
> +DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
> +                              PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_c=
lass);
> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gaske=
t/apex_driver.c
> index 46199c8ca441..f12f81c8dd2f 100644
> --- a/drivers/staging/gasket/apex_driver.c
> +++ b/drivers/staging/gasket/apex_driver.c
> @@ -570,13 +570,6 @@ static const struct pci_device_id apex_pci_ids[] =3D=
 {
>         { PCI_DEVICE(APEX_PCI_VENDOR_ID, APEX_PCI_DEVICE_ID) }, { 0 }
>  };
>
> -static void apex_pci_fixup_class(struct pci_dev *pdev)
> -{
> -       pdev->class =3D (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
> -}
> -DECLARE_PCI_FIXUP_CLASS_HEADER(APEX_PCI_VENDOR_ID, APEX_PCI_DEVICE_ID,
> -                              PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_c=
lass);
> -
>  static int apex_pci_probe(struct pci_dev *pci_dev,
>                           const struct pci_device_id *id)
>  {
