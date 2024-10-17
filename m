Return-Path: <linux-pci+bounces-14729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585159A1977
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 05:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C30F1C2195B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B7113AD33;
	Thu, 17 Oct 2024 03:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7y6XhTq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957856BFC0;
	Thu, 17 Oct 2024 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729136874; cv=none; b=Dz505TOhkS64kwsHUgtUmzqaRBhYlLPER45IRsdd1s4DxtvyLZVSTJvYhLugp7JVHktN+2vUitHgODUp/08BDDqI6wUEDpHyF6d6P0w34YEP2fTKLDRXeP8JiesO8p2JYr3TpeSWFbuY9RiCgf99eeor8jsBR0lMWr+snVSbY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729136874; c=relaxed/simple;
	bh=aMsip7pjhyg6JnmW6w9memy2aloNkxXgSLqCQTzXKPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLJSQ2T066QJc1odLFZ/R2nHwRQS9z5ueoMqTF+1ZZNsgEfAza7nnJcHAlA30hyx832PZH5KhuTnz65rnUrHYpUVu1AZ8g6/p1K8rgjUvBWARd3J+r0bmw9S03Uc6phU/SVD770oDxoX3fqltiybd6CgC4oFf22gtpSxgZwOoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7y6XhTq; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-28847f4207dso228677fac.0;
        Wed, 16 Oct 2024 20:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729136871; x=1729741671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiDw++hef03OiPKwQh86usuqIMKf/hTJwKuSaI1Ilxw=;
        b=A7y6XhTqLZg8LPkRHYPpxHhSVIrsXEbB7LZwBB//RsXRxKUTcObUmzmJXp3D/cumgi
         IIU+dmoJ5/pdn+NlgHzJlKylgfv2sQukjaTCPp09CVS8BbCf7Zt55GWwXacS9PqK075n
         QYHDNHOAtFNElwwbLINYBca6C9zTYonTap23UpzWFbaZbgvazSoenrdG5UbBAh2Wy3qn
         UJRCx9ibo4PeMMGWFG+GU6BLyOTlDc9DKXFGDYi/+kEFUH622DV3zEYKsm/sFo4S4YoR
         Gk2QuP+yb2cOf7Ug9EjV3cCx1p2+tZ2OpvwjFfkJzCQqWsCWBhcVO7uHQN1u2+JNO6ZN
         hx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729136871; x=1729741671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiDw++hef03OiPKwQh86usuqIMKf/hTJwKuSaI1Ilxw=;
        b=iy9CgIGnCnMml1SCZqO7iMbLGbQPPI/C+KGy8bW7b5K4FtXxcKO26BqZMj31OV0LbL
         v5Ijhp7T+89QZwXNyJLyX7xTyZJgZ9Luy0sqHOSDOaDXHdx3OJBDQfKOf2n9nhQ8C0dI
         +aTaxMBTBbGkWd2ZzozDdbSjZWqE4eaELXL7OaNJbnvEHi132gZPyFWbIFLYrM0h/vow
         Xeo1P5x+qx2kuhQ9JBI+wlmVpXXRrDC/smKAJQ/RujpiAIyFXmRcj69AjUyMbXcrau70
         4bwKASRU/M7BM/Qxt8R9jbUBeVLyrR69PGhGEceC7jqhvx+U5lHJYUeX0FtMtednXz5b
         7ANg==
X-Forwarded-Encrypted: i=1; AJvYcCVfhClrrewL4DDMCZlECQXXMxaZr+c/vu/4KsCJW8wKSgzhvRzuWuoYUAY/KBH659z+/0AaysR25uts@vger.kernel.org, AJvYcCXPuiWDEfmoy3iCrWk6DgrhjBX79uBStzCQKmB+k+JN6sHtWohQWywiLeAz2BOaE/FsUrcsjsqYzOAkMNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCmLGp9t+lPB7ch3QaEGiTWMV/TJQZc6Lv5FZFuwWxwCkRBzP
	waj9n0JeygGs+WpphxKEYbS9rLMLuZyYHeXAWix6HHa7gpulqA0JWmpyhAlFiwve9gRYFY9nfY+
	p3dt/xk/uQZlVKy9H2T5p0Tzliks=
X-Google-Smtp-Source: AGHT+IHzqrfe95JjMnIoV1GWVhXHOR447G+fTy+gBygoR1Yms502xbDHkrmI/mS/8wj8Tsk294qahZ1JbK1EhNxknis=
X-Received: by 2002:a05:6870:9e08:b0:27b:7370:f610 with SMTP id
 586e51a60fabf-2886dd51bc4mr15496034fac.10.1729136871367; Wed, 16 Oct 2024
 20:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016114915.2823-1-linux.amoon@gmail.com> <20241016114915.2823-3-linux.amoon@gmail.com>
 <20241016182343.vocxyi5ry33btw5o@thinkpad>
In-Reply-To: <20241016182343.vocxyi5ry33btw5o@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 17 Oct 2024 09:17:35 +0530
Message-ID: <CANAwSgRnd5jaZjoNtCLcq6nRGz3gC-VwjhxsiG7haiowrmZs_w@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

On Wed, 16 Oct 2024 at 23:53, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Oct 16, 2024 at 05:19:07PM +0530, Anand Moon wrote:
> > Currently, the driver acquires and asserts/deasserts the resets
> > individually thereby making the driver complex to read. But this
> > can be simplified by using the reset_control_bulk APIs.
> > Use devm_reset_control_bulk_get_exclusive() API to acquire all
> > the resets and use reset_control_bulk_{assert/deassert}() APIs to
> > assert/deassert them in bulk.
> >
> > Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':
> >
> > 1. Split the reset controls into two groups as per section '17.5.8.1.1 =
PCIe
> > as Root Complex'.
> >
> > 2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per
> > section '17.5.8.1.1 PCIe as Root Complex'. This is accomplished using t=
he
> > reset_control_bulk APIs.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v9: Improved the commit message and try to fix few review comments.
>
> You haven't fixed all of them... Please take a look at all of my comments=
.

It is becoming a nightmare for me, my confidence is a the lowest.
Can you fix this while applying or I will resend it with the fix?
>
> - Mani
>
Thanks
-Anand

> > v8: I tried to address reviews and comments from Mani.
> >     Follow the sequence of De-assert as per the driver code.
> >     Drop the comment in the driver.
> >     Improve the commit message with the description of the TMP section.
> >     Improve the reason for the core functional changes in the commit
> >     description.
> >     Improve the error handling messages of the code.
> > v7: replace devm_reset_control_bulk_get_optional_exclusive()
> >         with devm_reset_control_bulk_get_exclusive()
> >     update the functional changes.
> > V6: Add reason for the split of the RESET pins.
> > v5: Fix the De-assert reset core as per the TRM
> >     De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
> >     simultaneously.
> > v4: use dev_err_probe in error path.
> > v3: Fix typo in commit message, dropped reported by.
> > v2: Fix compilation error reported by Intel test robot
> >     fixed checkpatch warning.
> > ---
> >  drivers/pci/controller/pcie-rockchip.c | 154 +++++--------------------
> >  drivers/pci/controller/pcie-rockchip.h |  26 +++--
> >  2 files changed, 48 insertions(+), 132 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/contr=
oller/pcie-rockchip.c
> > index 2777ef0cb599..adf11208cc82 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -30,7 +30,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rock=
chip)
> >       struct platform_device *pdev =3D to_platform_device(dev);
> >       struct device_node *node =3D dev->of_node;
> >       struct resource *regs;
> > -     int err;
> > +     int err, i;
> >
> >       if (rockchip->is_rc) {
> >               regs =3D platform_get_resource_byname(pdev,
> > @@ -69,55 +69,23 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *ro=
ckchip)
> >       if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> >               rockchip->link_gen =3D 2;
> >
> > -     rockchip->core_rst =3D devm_reset_control_get_exclusive(dev, "cor=
e");
> > -     if (IS_ERR(rockchip->core_rst)) {
> > -             if (PTR_ERR(rockchip->core_rst) !=3D -EPROBE_DEFER)
> > -                     dev_err(dev, "missing core reset property in node=
\n");
> > -             return PTR_ERR(rockchip->core_rst);
> > -     }
> > -
> > -     rockchip->mgmt_rst =3D devm_reset_control_get_exclusive(dev, "mgm=
t");
> > -     if (IS_ERR(rockchip->mgmt_rst)) {
> > -             if (PTR_ERR(rockchip->mgmt_rst) !=3D -EPROBE_DEFER)
> > -                     dev_err(dev, "missing mgmt reset property in node=
\n");
> > -             return PTR_ERR(rockchip->mgmt_rst);
> > -     }
> > -
> > -     rockchip->mgmt_sticky_rst =3D devm_reset_control_get_exclusive(de=
v,
> > -                                                             "mgmt-sti=
cky");
> > -     if (IS_ERR(rockchip->mgmt_sticky_rst)) {
> > -             if (PTR_ERR(rockchip->mgmt_sticky_rst) !=3D -EPROBE_DEFER=
)
> > -                     dev_err(dev, "missing mgmt-sticky reset property =
in node\n");
> > -             return PTR_ERR(rockchip->mgmt_sticky_rst);
> > -     }
> > -
> > -     rockchip->pipe_rst =3D devm_reset_control_get_exclusive(dev, "pip=
e");
> > -     if (IS_ERR(rockchip->pipe_rst)) {
> > -             if (PTR_ERR(rockchip->pipe_rst) !=3D -EPROBE_DEFER)
> > -                     dev_err(dev, "missing pipe reset property in node=
\n");
> > -             return PTR_ERR(rockchip->pipe_rst);
> > -     }
> > +     for (i =3D 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
> > +             rockchip->pm_rsts[i].id =3D rockchip_pci_pm_rsts[i];
> >
> > -     rockchip->pm_rst =3D devm_reset_control_get_exclusive(dev, "pm");
> > -     if (IS_ERR(rockchip->pm_rst)) {
> > -             if (PTR_ERR(rockchip->pm_rst) !=3D -EPROBE_DEFER)
> > -                     dev_err(dev, "missing pm reset property in node\n=
");
> > -             return PTR_ERR(rockchip->pm_rst);
> > -     }
> > +     err =3D devm_reset_control_bulk_get_exclusive(dev,
> > +                                                 ROCKCHIP_NUM_PM_RSTS,
> > +                                                 rockchip->pm_rsts);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "Cannot get the PM reset\n=
");
> >
> > -     rockchip->pclk_rst =3D devm_reset_control_get_exclusive(dev, "pcl=
k");
> > -     if (IS_ERR(rockchip->pclk_rst)) {
> > -             if (PTR_ERR(rockchip->pclk_rst) !=3D -EPROBE_DEFER)
> > -                     dev_err(dev, "missing pclk reset property in node=
\n");
> > -             return PTR_ERR(rockchip->pclk_rst);
> > -     }
> > +     for (i =3D 0; i < ROCKCHIP_NUM_CORE_RSTS; i++)
> > +             rockchip->core_rsts[i].id =3D rockchip_pci_core_rsts[i];
> >
> > -     rockchip->aclk_rst =3D devm_reset_control_get_exclusive(dev, "acl=
k");
> > -     if (IS_ERR(rockchip->aclk_rst)) {
> > -             if (PTR_ERR(rockchip->aclk_rst) !=3D -EPROBE_DEFER)
> > -                     dev_err(dev, "missing aclk reset property in node=
\n");
> > -             return PTR_ERR(rockchip->aclk_rst);
> > -     }
> > +     err =3D devm_reset_control_bulk_get_exclusive(dev,
> > +                                                 ROCKCHIP_NUM_CORE_RST=
S,
> > +                                                 rockchip->core_rsts);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "Cannot get the CORE reset=
s\n");
> >
> >       if (rockchip->is_rc) {
> >               rockchip->ep_gpio =3D devm_gpiod_get_optional(dev, "ep",
> > @@ -147,23 +115,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie =
*rockchip)
> >       int err, i;
> >       u32 regs;
> >
> > -     err =3D reset_control_assert(rockchip->aclk_rst);
> > -     if (err) {
> > -             dev_err(dev, "assert aclk_rst err %d\n", err);
> > -             return err;
> > -     }
> > -
> > -     err =3D reset_control_assert(rockchip->pclk_rst);
> > -     if (err) {
> > -             dev_err(dev, "assert pclk_rst err %d\n", err);
> > -             return err;
> > -     }
> > -
> > -     err =3D reset_control_assert(rockchip->pm_rst);
> > -     if (err) {
> > -             dev_err(dev, "assert pm_rst err %d\n", err);
> > -             return err;
> > -     }
> > +     err =3D reset_control_bulk_assert(ROCKCHIP_NUM_PM_RSTS,
> > +                                     rockchip->pm_rsts);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "Couldn't assert PM resets=
\n");
> >
> >       for (i =3D 0; i < MAX_LANE_NUM; i++) {
> >               err =3D phy_init(rockchip->phys[i]);
> > @@ -173,47 +128,17 @@ int rockchip_pcie_init_port(struct rockchip_pcie =
*rockchip)
> >               }
> >       }
> >
> > -     err =3D reset_control_assert(rockchip->core_rst);
> > -     if (err) {
> > -             dev_err(dev, "assert core_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > -
> > -     err =3D reset_control_assert(rockchip->mgmt_rst);
> > -     if (err) {
> > -             dev_err(dev, "assert mgmt_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > -
> > -     err =3D reset_control_assert(rockchip->mgmt_sticky_rst);
> > -     if (err) {
> > -             dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > -
> > -     err =3D reset_control_assert(rockchip->pipe_rst);
> > -     if (err) {
> > -             dev_err(dev, "assert pipe_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > +     err =3D reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
> > +                                     rockchip->core_rsts);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "Couldn't assert Core rese=
ts\n");
> >
> >       udelay(10);
> >
> > -     err =3D reset_control_deassert(rockchip->pm_rst);
> > -     if (err) {
> > -             dev_err(dev, "deassert pm_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->aclk_rst);
> > +     err =3D reset_control_bulk_deassert(ROCKCHIP_NUM_PM_RSTS,
> > +                                       rockchip->pm_rsts);
> >       if (err) {
> > -             dev_err(dev, "deassert aclk_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->pclk_rst);
> > -     if (err) {
> > -             dev_err(dev, "deassert pclk_rst err %d\n", err);
> > +             dev_err(dev, "Couldn't deassert PM resets %d\n", err);
> >               goto err_exit_phy;
> >       }
> >
> > @@ -252,31 +177,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie =
*rockchip)
> >               goto err_power_off_phy;
> >       }
> >
> > -     /*
> > -      * Please don't reorder the deassert sequence of the following
> > -      * four reset pins.
> > -      */
> > -     err =3D reset_control_deassert(rockchip->mgmt_sticky_rst);
> > -     if (err) {
> > -             dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> > -             goto err_power_off_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->core_rst);
> > -     if (err) {
> > -             dev_err(dev, "deassert core_rst err %d\n", err);
> > -             goto err_power_off_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->mgmt_rst);
> > -     if (err) {
> > -             dev_err(dev, "deassert mgmt_rst err %d\n", err);
> > -             goto err_power_off_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->pipe_rst);
> > +     err =3D reset_control_bulk_deassert(ROCKCHIP_NUM_CORE_RSTS,
> > +                                       rockchip->core_rsts);
> >       if (err) {
> > -             dev_err(dev, "deassert pipe_rst err %d\n", err);
> > +             dev_err(dev, "Couldn't deassert CORE %d\n", err);
ok, it shipped my review process.
> >               goto err_power_off_phy;
> >       }
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/contr=
oller/pcie-rockchip.h
> > index bebab80c9553..cc667c73d42f 100644
> > --- a/drivers/pci/controller/pcie-rockchip.h
> > +++ b/drivers/pci/controller/pcie-rockchip.h
> > @@ -15,6 +15,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/pci.h>
> >  #include <linux/pci-ecam.h>
> > +#include <linux/reset.h>
> >
> >  /*
> >   * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lo=
wer 16
> > @@ -288,18 +289,29 @@
> >               (((c) << ((b) * 8 + 5)) & \
> >                ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
> >
> > +#define ROCKCHIP_NUM_PM_RSTS   ARRAY_SIZE(rockchip_pci_pm_rsts)
> > +#define ROCKCHIP_NUM_CORE_RSTS ARRAY_SIZE(rockchip_pci_core_rsts)
> > +
> > +static const char * const rockchip_pci_pm_rsts[] =3D {
> > +     "pm",
> > +     "pclk",
> > +     "aclk",
> > +};
> > +
> > +static const char * const rockchip_pci_core_rsts[] =3D {
> > +     "mgmt-sticky",
> > +     "core",
> > +     "mgmt",
> > +     "pipe",
> > +};
> > +
> >  struct rockchip_pcie {
> >       void    __iomem *reg_base;              /* DT axi-base */
> >       void    __iomem *apb_base;              /* DT apb-base */
> >       bool    legacy_phy;
> >       struct  phy *phys[MAX_LANE_NUM];
> > -     struct  reset_control *core_rst;
> > -     struct  reset_control *mgmt_rst;
> > -     struct  reset_control *mgmt_sticky_rst;
> > -     struct  reset_control *pipe_rst;
> > -     struct  reset_control *pm_rst;
> > -     struct  reset_control *aclk_rst;
> > -     struct  reset_control *pclk_rst;
> > +     struct  reset_control_bulk_data pm_rsts[ROCKCHIP_NUM_PM_RSTS];
> > +     struct  reset_control_bulk_data core_rsts[ROCKCHIP_NUM_CORE_RSTS]=
;
> >       struct  clk_bulk_data *clks;
> >       int     num_clks;
> >       struct  regulator *vpcie12v; /* 12V power supply */
> > --
> > 2.44.0
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

