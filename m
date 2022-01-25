Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A256649AB83
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 06:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243471AbiAYFIv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 00:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S251072AbiAYEU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 23:20:27 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB7C061747;
        Mon, 24 Jan 2022 18:51:21 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id b16so34851796uaq.4;
        Mon, 24 Jan 2022 18:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P6LscLp3E2WiwXwgZ3WD+U4l8G1jH7CQCRwujnNFTjc=;
        b=C6roxTp7cIEMMOzhn5NzBDFNFNYpPNPbj+Bmw5Wm5qzD+W1emZSbnLEbF/eoHGn3hj
         yOeZEeKK0g45s2eepfhK/i3TjW/9/jtvnxRvUVYnIJA5fDWOoQrDFmq+nmYxCD5w68xd
         L/TvsEImBtY658ga1Pocieu6WwJNP5Gd0hG44lkGY9pgvKfzADfp/DIqyiJWZ2J4uK38
         v6vqAWmwxzWJ+ITi/XOK3DcQ8mTIzOOtKk8xD0EB/mIaP0a3KJ3T60Gr76ojmyQ9mxES
         Pwu/4XbBMcuFH/oDj7sA0VO+r/XLoUM87AOPuYHSQiALZsyDD1ZCwD4+LGlrZz1ZY0jh
         1nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P6LscLp3E2WiwXwgZ3WD+U4l8G1jH7CQCRwujnNFTjc=;
        b=cB82EcZ7xmlIUITyhudMVKb03D7DPp8oapAzKDa93eI97YCyvYD3+jrccfUPUEcXZG
         y2GwWUWhjmeRShphHcT31f6kPzxRII3gbC8mLUJZewatSYbjWjeVlWSjGXqivItFp0FC
         +jx3iLrCCN5w9YXS9JbamqxmxqTy1e2esrKuaMBIQY3FCqRTFBAW8Xr57Jp/jkrIc/rS
         kl42UgN+mxkLjuaGOUDs1FR1GroGfZinZHIBPeUq4dSfuHLRr+0/GjJCzXS7xmhB3eT6
         7siWjTpw6wC4yj5QDbag8zTJfzp6yCw69gO3FZxu04aIbtZtCp9dPAJWu7eInr1DORKU
         jlNQ==
X-Gm-Message-State: AOAM531UbvCKqXwujFhCZrwGtjyVnH4Qlh6xn2E8lAMtYZts7pr4/Kv/
        GFAtfLIbugOjJyuZwhSIuT23PH9fPE5DmIkq4Rg=
X-Google-Smtp-Source: ABdhPJySuvGbS5oFtYEekeKllgHwzNZ+MK9av1jtitp922jy95mnp/l3oDyWun9G86XHmtfmKGQa6XGOf2NXuGo96Qw=
X-Received: by 2002:a67:b807:: with SMTP id i7mr6423171vsf.52.1643079080652;
 Mon, 24 Jan 2022 18:51:20 -0800 (PST)
MIME-Version: 1.0
References: <CAAhV-H4BTAKdRwv+Wq7QRfMQRajQYzz3CqjvoGTrKujn47F3Yg@mail.gmail.com>
 <20220106162058.GA284940@bhelgaas>
In-Reply-To: <20220106162058.GA284940@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 25 Jan 2022 10:51:15 +0800
Message-ID: <CAAhV-H4GAgKh4HBeWQ+LGf2x_uKy_T5MaMv0dNcYXFKVGAZEzw@mail.gmail.com>
Subject: Re: [PATCH v8 04/10] vgaarb: Move framebuffer detection to ADD_DEVICE path
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

Why this series still missing in 5.17-rc1? :(

Huacai

On Fri, Jan 7, 2022 at 12:21 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jan 06, 2022 at 02:44:42PM +0800, Huacai Chen wrote:
> > On Thu, Jan 6, 2022 at 8:07 AM Bjorn Helgaas <helgaas@kernel.org> wrote=
:
> > > Previously we selected a device that owns the boot framebuffer as the
> > > default device in vga_arb_select_default_device().  This was only don=
e in
> > > the vga_arb_device_init() subsys_initcall, so devices enumerated late=
r,
> > > e.g., by pcibios_init(), were not eligible.
> > >
> > > Fix this by moving the framebuffer device selection from
> > > vga_arb_select_default_device() to vga_arbiter_add_pci_device(), whic=
h is
> > > called after every PCI device is enumerated, either by the
> > > vga_arb_device_init() subsys_initcall or as an ADD_DEVICE notifier.
> > >
> > > Note that if vga_arb_select_default_device() found a device owning th=
e boot
> > > framebuffer, it unconditionally set it to be the default VGA device, =
and no
> > > subsequent device could replace it.
> > >
> > > Link: https://lore.kernel.org/r/20211015061512.2941859-7-chenhuacai@l=
oongson.cn
> > > Based-on-patch-by: Huacai Chen <chenhuacai@loongson.cn>
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> > > ---
> > >  drivers/gpu/vga/vgaarb.c | 37 +++++++++++++++++--------------------
> > >  1 file changed, 17 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> > > index b0ae0f177c6f..aefa4f406f7d 100644
> > > --- a/drivers/gpu/vga/vgaarb.c
> > > +++ b/drivers/gpu/vga/vgaarb.c
> > > @@ -72,6 +72,7 @@ struct vga_device {
> > >         unsigned int io_norm_cnt;       /* normal IO count */
> > >         unsigned int mem_norm_cnt;      /* normal MEM count */
> > >         bool bridge_has_one_vga;
> > > +       bool is_framebuffer;    /* BAR covers firmware framebuffer */
> > >         unsigned int (*set_decode)(struct pci_dev *pdev, bool decode)=
;
> > >  };
> > >
> > > @@ -565,10 +566,9 @@ void vga_put(struct pci_dev *pdev, unsigned int =
rsrc)
> > >  }
> > >  EXPORT_SYMBOL(vga_put);
> > >
> > > -static void __init vga_select_framebuffer_device(struct pci_dev *pde=
v)
> > > +static bool vga_is_framebuffer_device(struct pci_dev *pdev)
> > >  {
> > >  #if defined(CONFIG_X86) || defined(CONFIG_IA64)
> > > -       struct device *dev =3D &pdev->dev;
> > >         u64 base =3D screen_info.lfb_base;
> > >         u64 size =3D screen_info.lfb_size;
> > >         u64 limit;
> > > @@ -583,15 +583,6 @@ static void __init vga_select_framebuffer_device=
(struct pci_dev *pdev)
> > >
> > >         limit =3D base + size;
> > >
> > > -       /*
> > > -        * Override vga_arbiter_add_pci_device()'s I/O based detectio=
n
> > > -        * as it may take the wrong device (e.g. on Apple system unde=
r
> > > -        * EFI).
> > > -        *
> > > -        * Select the device owning the boot framebuffer if there is
> > > -        * one.
> > > -        */
> > > -
> > >         /* Does firmware framebuffer belong to us? */
> > >         for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++) {
> > >                 flags =3D pci_resource_flags(pdev, i);
> > > @@ -608,13 +599,10 @@ static void __init vga_select_framebuffer_devic=
e(struct pci_dev *pdev)
> > >                 if (base < start || limit >=3D end)
> > >                         continue;
> > >
> > > -               if (!vga_default_device())
> > > -                       vgaarb_info(dev, "setting as boot device\n");
> > > -               else if (pdev !=3D vga_default_device())
> > > -                       vgaarb_info(dev, "overriding boot device\n");
> > > -               vga_set_default_device(pdev);
> > > +               return true;
> > >         }
> > >  #endif
> > > +       return false;
> > >  }
> > >
> > >  static bool vga_arb_integrated_gpu(struct device *dev)
> > > @@ -635,6 +623,7 @@ static bool vga_arb_integrated_gpu(struct device =
*dev)
> > >  static bool vga_is_boot_device(struct vga_device *vgadev)
> > >  {
> > >         struct vga_device *boot_vga =3D vgadev_find(vga_default_devic=
e());
> > > +       struct pci_dev *pdev =3D vgadev->pdev;
> > >
> > >         /*
> > >          * We select the default VGA device in this order:
> > > @@ -645,6 +634,18 @@ static bool vga_is_boot_device(struct vga_device=
 *vgadev)
> > >          *   Other device (see vga_arb_select_default_device())
> > >          */
> > >
> > > +       /*
> > > +        * We always prefer a firmware framebuffer, so if we've alrea=
dy
> > > +        * found one, there's no need to consider vgadev.
> > > +        */
> > > +       if (boot_vga && boot_vga->is_framebuffer)
> > > +               return false;
> > > +
> > > +       if (vga_is_framebuffer_device(pdev)) {
> > > +               vgadev->is_framebuffer =3D true;
> > > +               return true;
> > > +       }
> > Maybe it is better to rename vga_is_framebuffer_device() to
> > vga_is_firmware_device() and rename is_framebuffer to
> > is_fw_framebuffer?
>
> That's a great point, thanks!
>
> The "framebuffer" term is way too generic.  *All* VGA devices have a
> framebuffer, so it adds no information.  This is really about finding
> the device that was used by firmware.
>
> I renamed:
>
>   vga_is_framebuffer_device() -> vga_is_firmware_default()
>   vga_device.is_framebuffer   -> vga_device.is_firmware_default
>
> I updated my local branch and pushed it to:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=3D=
pci/vga
> with head 0f4caffa1297 ("vgaarb: Replace full MIT license text with
> SPDX identifier").
>
> I don't maintain drivers/gpu/vga/vgaarb.c, so this branch is just for
> reference.  It'll ultimately be up to the DRM folks to handle this.
>
> I'll wait for any other comments or testing reports before reposting.
>
> > >         /*
> > >          * A legacy VGA device has MEM and IO enabled and any bridges
> > >          * leading to it have PCI_BRIDGE_CTL_VGA enabled so the legac=
y
> > > @@ -1531,10 +1532,6 @@ static void __init vga_arb_select_default_devi=
ce(void)
> > >         struct pci_dev *pdev, *found =3D NULL;
> > >         struct vga_device *vgadev;
> > >
> > > -       list_for_each_entry(vgadev, &vga_list, list) {
> > > -               vga_select_framebuffer_device(vgadev->pdev);
> > > -       }
> > > -
> > >         if (!vga_default_device()) {
> > >                 list_for_each_entry_reverse(vgadev, &vga_list, list) =
{
> > >                         struct device *dev =3D &vgadev->pdev->dev;
> > > --
> > > 2.25.1
> > >
