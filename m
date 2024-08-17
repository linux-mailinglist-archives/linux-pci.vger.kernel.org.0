Return-Path: <linux-pci+bounces-11788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F73955813
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 15:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DF51F21B04
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009E14D28A;
	Sat, 17 Aug 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVYdbLmX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9C14C59A;
	Sat, 17 Aug 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723900986; cv=none; b=RWoalKNzUlFPYpZm6jaDdQGOMuBZEql83QQF6EYXAQWiGggZWE/nFSTtkuMzztUAZk+pJSZwGTSTtgAH+pBHezFyYlEzLOviPijJNGW/tZBPWuGrG/WyWV8B6XPJwmzv50FFCWFE8qcmplRQIcj0+LZfullz/82XTdL4NBMKUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723900986; c=relaxed/simple;
	bh=XLpgNezakyxWeTHueoRrYUNG0P16ghj5NWPfCv6tHxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tC5n5Tao3G5ouFejAql30NoHOguaWj3bLbRRkE9CrWVu9F7eSLFDDOyv4zfUEI1XimPdnYtz8w4BAJ58NGiiKXihSB+IiP4799raZfDxGB8lLb/kdHJnFSoYhhv6WLrh0N0lvDQ4dHnMIAvmX3uhA0RBfpjy9CCEd5t3lFxYNCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVYdbLmX; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2700d796019so1378758fac.2;
        Sat, 17 Aug 2024 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723900983; x=1724505783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpjFf6UtMxXIKBFkYjEqHAxWDPB4s5651mhGcNrSxmU=;
        b=iVYdbLmXIntqwyf56rVJonGVTaDP/TSO6/10BzoOuUnLxfbnoC/NoyxK+84yjuFVyh
         szrrqG4UbGGkcCx3fqhSUnEMPhiR0RAFgcZy8XlhAGc65R0ZO1PjfmuW3ld4RPMXXPhU
         W+t/SQ7twKHPbLhpNdCcFyK3ZkIOaz3BLUu6puwrQ16icWwuTRzM2iqEIZsnVwPhAaGS
         Pg7MJQtyKcPnMHqkqEKS3V3K6qfbCTl7DZ9MyTHxTh5u5a3aRjw/+mUmVZuQKAer3c/h
         3A1SJV8QfpRWAWBQD7lyxrcpuwErokC9gAX3r/iHAZeZU3mwm8JY73EqYcXUo5aV4Bvv
         fDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723900983; x=1724505783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpjFf6UtMxXIKBFkYjEqHAxWDPB4s5651mhGcNrSxmU=;
        b=ngUjCrnvVcUY9M6U5mAePLqL4AmmWg422PzW+KMzqif8MQd9z5DDZpB93veXNs/pXA
         G8nE9gnEBTXPjmWuU/NYWg7bmIyj0Yi+OKl0AEvAANXnu9kLpIl+bB3DoOEp/61iAXcX
         +1eC3KXifLBr1SsZpctW3ZLRZ0hQiTXcwjErzyR6rzbDm+gsRkebcD5OoXQVHE7M+26D
         gzQCIoKc8IvvMaNW9h+R4nRzTWQ6jzPl9/C584J8XJeDOP9qHdyQvhgz8limnrtw0FSm
         beR1ezfOx5zFtb+zrgqDWavbKQQxqmCXWwe7UgzT80lUwfuwM/01Ig5DoDaJZSpCdi/E
         gOFg==
X-Forwarded-Encrypted: i=1; AJvYcCXH7yYSyuy3nOstCgHcfrcvwZpXAnTUr6/TDRNEyrx4RmxhqaRrXfcXYt3Sg2MS6bwyFliLngDCjY62BvteQGGJBsma5scpCAfdjZxozGUrQXH/xCqJ9UHXJHTWuboVo6fSULXh2A0G
X-Gm-Message-State: AOJu0YyOj68JxowEvnFsXWPQNc+W+ZSx3M84kBUK2TOg2G/CkUuOU8ys
	x9nBGNSPHC1MeACLPk4VJ68OciHQu/9EQUVk2Oomf/WYYOu7hCux7xfxFUd6zW5RrngOb4ar/Td
	TiHXv/oG9lCrp1nVB2IhFhFF6hERM7w==
X-Google-Smtp-Source: AGHT+IFWAmDr/Bt4R6dnak4yRXkQGsTMdauNalKkKZlt2wfMUS6ZvJSQ15297ULvJB73OTWwioL3pp2TZgPvFLXLGC4=
X-Received: by 2002:a05:6870:4694:b0:25d:e3d:b441 with SMTP id
 586e51a60fabf-2701c522a1bmr6267890fac.40.1723900983244; Sat, 17 Aug 2024
 06:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625104039.48311-1-linux.amoon@gmail.com> <20240625104039.48311-2-linux.amoon@gmail.com>
 <20240815162004.GF2562@thinkpad>
In-Reply-To: <20240815162004.GF2562@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 17 Aug 2024 18:52:47 +0530
Message-ID: <CANAwSgR-k1x1cBbLZ-OErSiEDcnkqs9uiBy77BEd2tz-CGC3OQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

On Thu, 15 Aug 2024 at 21:50, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Jun 25, 2024 at 04:10:33PM +0530, Anand Moon wrote:
> > Refactor the reset control handling in the Rockchip PCIe driver,
> > introducing a more robust and efficient method for assert and
> > deassert reset controller using reset_control_bulk*() API. Using the
> > reset_control_bulk APIs, the reset handling for the core clocks reset
> > unit becomes much simpler.
> >
> > As per rockchip rk3399 TRM SOFTRST_CON8 soft reset controller
> > have clock reset unit value set to 0x1 for example "pcie_pipe",
> > "pcie_mgmt_sticky", "pcie_mgmt" and "pci_core", hence group then under
> > one reset bulk controller.
> >
> > Where as "pcie_pm", "presetn_pcie", "aresetn_pcie" have reset value
> > set to 0x0, hence group them under reset control bulk controller.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v4: use dev_err_probe in error path.
> > v3: Fix typo in commit message, dropped reported by.
> > v2: Fix compilation error reported by Intel test robot
> >     fixed checkpatch warning
> > ---
> >  drivers/pci/controller/pcie-rockchip.c | 149 +++++--------------------
> >  drivers/pci/controller/pcie-rockchip.h |  25 +++--
> >  2 files changed, 47 insertions(+), 127 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/contr=
oller/pcie-rockchip.c
> > index 804135511528..024308bb6ac8 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
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
> > +     err =3D devm_reset_control_bulk_get_optional_exclusive(dev,
> > +                                                          ROCKCHIP_NUM=
_PM_RSTS,
> > +                                                          rockchip->pm=
_rsts);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "cannot get the reset cont=
rol\n");
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
> > +     err =3D devm_reset_control_bulk_get_optional_exclusive(dev,
> > +                                                          ROCKCHIP_NUM=
_CORE_RSTS,
> > +                                                          rockchip->co=
re_rsts);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "cannot get the reset cont=
rol\n");
> >
> >       if (rockchip->is_rc) {
> >               rockchip->ep_gpio =3D devm_gpiod_get_optional(dev, "ep",
> > @@ -150,23 +118,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie =
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
> > +             return dev_err_probe(dev, err, "reset bulk assert pm rese=
t\n");
> >
> >       for (i =3D 0; i < MAX_LANE_NUM; i++) {
> >               err =3D phy_init(rockchip->phys[i]);
> > @@ -176,47 +131,17 @@ int rockchip_pcie_init_port(struct rockchip_pcie =
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
> > +             return dev_err_probe(dev, err, "reset bulk assert core re=
set\n");
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
> > -     if (err) {
> > -             dev_err(dev, "deassert aclk_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->pclk_rst);
> > +     err =3D reset_control_bulk_deassert(ROCKCHIP_NUM_PM_RSTS,
> > +                                       rockchip->pm_rsts);
> >       if (err) {
> > -             dev_err(dev, "deassert pclk_rst err %d\n", err);
> > +             dev_err(dev, "reset bulk deassert pm err %d\n", err);
> >               goto err_exit_phy;
> >       }
> >
> > @@ -259,31 +184,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie =
*rockchip)
> >        * Please don't reorder the deassert sequence of the following
> >        * four reset pins.
> >        */
>
> The comment above says that the resets should not be reordered. But you h=
ave
> reordered the resets.
>
As per the TRM [1], CRU_SOFTRST_CON8  clock reset unit has two groups
one with reset value 0x1 and the other 0x0, so this patch groups them
accordingly.

[1] https://opensource.rock-chips.com/images/e/ee/Rockchip_RK3399TRM_V1.4_P=
art1-20170408.pdf

If I only use reset_control_bulk_assert and
reset_control_bulk_deassert for all the reset
I get the below reset warning.

[    6.116766] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 rang=
es:
[    6.117439] rockchip-pcie f8000000.pcie:      MEM
0x00fa000000..0x00fbdfffff -> 0x00fa000000
[    6.118200] rockchip-pcie f8000000.pcie:       IO
0x00fbe00000..0x00fbefffff -> 0x00fbe00000
[    6.119420] ------------[ cut here ]------------
[    6.119843] WARNING: CPU: 3 PID: 48 at drivers/reset/core.c:792
__reset_control_get_internal+0x68/0x17c
[    6.120681] Modules linked in: phy_rockchip_pcie
snd_soc_rockchip_i2s videobuf2_common drm_display_helper
drm_dma_helper mc rockchip_thermal cfg80211 rtc_rk808 drm_kms_helper
rfkill coresight_cpu_debug coresight pcie_rockchip_host fuse drm
dm_mod backlight ip_tables x_tables ipv6
[    6.122895] CPU: 3 UID: 0 PID: 48 Comm: kworker/u24:1 Not tainted
6.11.0-rc3-00282-g17c3afeb956a #1
[    6.123699] Hardware name: 96boards Rock960 (DT)
[    6.124122] Workqueue: events_unbound deferred_probe_work_func
[    6.124648] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    6.125260] pc : __reset_control_get_internal+0x68/0x17c
[    6.125733] lr : __of_reset_control_get+0x1e4/0x280
[    6.126167] sp : ffff8000803038c0
[    6.126459] x29: ffff8000803038c0 x28: ffffa2f1c22479c0 x27: 00000000000=
00004
[    6.127092] x26: 0000000000000001 x25: ffffa2f1c25cd080 x24: 00000000000=
00001
[    6.127723] x23: 0000000000000000 x22: ffff237bc05b4080 x21: 00000000000=
00082
[    6.128353] x20: ffff237bc05b40a0 x19: ffff237bc7fe0f80 x18: 00000000000=
00001
[    6.128984] x17: 6666666666656266 x16: ffffa2f1c0298b2c x15: 00000000000=
00000
[    6.129615] x14: 0000000000000000 x13: 0000000000000002 x12: 00000000000=
6fb2a
[    6.130246] x11: 7379732e30303030 x10: ffffa2f1c20c2398 x9 : 00000000000=
00020
[    6.130877] x8 : 0101010101010101 x7 : 0000737465736573 x6 : 00000000806=
27436
[    6.131507] x5 : ffffffffff5ff198 x4 : 0000000000000000 x3 : 00000000000=
00001
[    6.132137] x2 : 0000000000000082 x1 : 0000000000000082 x0 : 00000000000=
00000
[    6.132767] Call trace:
[    6.132986]  __reset_control_get_internal+0x68/0x17c
[    6.133429]  __of_reset_control_get+0x1e4/0x280
[    6.133832]  __reset_control_get+0x48/0x1d8
[    6.134205]  __reset_control_bulk_get+0x74/0x114
[    6.134615]  __devm_reset_control_bulk_get+0x78/0xe8
[    6.135056]  rockchip_pcie_parse_dt+0x120/0x1f0
[    6.135461]  rockchip_pcie_probe+0x60/0x59c [pcie_rockchip_host]
[    6.135997]  platform_probe+0x68/0xdc
[    6.136324]  really_probe+0xbc/0x298
[    6.136646]  __driver_probe_device+0x78/0x12c
[    6.137034]  driver_probe_device+0xdc/0x160
[    6.137406]  __device_attach_driver+0xb8/0x134
[    6.137803]  bus_for_each_drv+0x80/0xdc
[    6.138146]  __device_attach+0xa8/0x1b0
[    6.138490]  device_initial_probe+0x14/0x20
[    6.138862]  bus_probe_device+0xa8/0xac
[    6.139204]  deferred_probe_work_func+0x88/0xc0
[    6.139606]  process_one_work+0x150/0x294
[    6.139963]  worker_thread+0x2e4/0x3ec
[    6.140308]  kthread+0x118/0x11c
[    6.140624]  ret_from_fork+0x10/0x20
[    6.140946] ---[ end trace 0000000000000000 ]---
[    6.146403] rockchip-pcie f8000000.pcie: error -EBUSY: cannot get
the reset control
[    6.147085] rockchip-pcie f8000000.pcie: probe with driver
rockchip-pcie failed with error -16
[    6.149348] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 rang=
es:
[    6.149982] rockchip-pcie f8000000.pcie:      MEM
0x00fa000000..0x00fbdfffff -> 0x00fa000000
[    6.150722] rockchip-pcie f8000000.pcie:       IO
0x00fbe00000..0x00fbefffff -> 0x00fbe00000
[    6.151717] ------------[ cut here ]------------
[    6.152122] WARNING: CPU: 5 PID: 48 at drivers/reset/core.c:792
__reset_control_get_internal+0x68/0x17c
[    6.152954] Modules linked in: phy_rockchip_pcie
snd_soc_rockchip_i2s videobuf2_common drm_display_helper
drm_dma_helper mc rockchip_thermal cfg80211 rtc_rk808 drm_kms_helper
rfkill coresight_cpu_debug coresight pcie_rockchip_host fuse drm
dm_mod backlight ip_tables x_tables ipv6
[    6.155144] CPU: 5 UID: 0 PID: 48 Comm: kworker/u24:1 Tainted: G
    W          6.11.0-rc3-00282-g17c3afeb956a #1
[    6.156061] Tainted: [W]=3DWARN
[    6.156321] Hardware name: 96boards Rock960 (DT)
[    6.156726] Workqueue: events_unbound deferred_probe_work_func
[    6.157242] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    6.157850] pc : __reset_control_get_internal+0x68/0x17c
[    6.158318] lr : __of_reset_control_get+0x1e4/0x280
[    6.158748] sp : ffff8000803038c0
[    6.159039] x29: ffff8000803038c0 x28: ffffa2f1c22479c0 x27: 00000000000=
00004
[    6.159665] x26: 0000000000000001 x25: ffffa2f1c25cd080 x24: 00000000000=
00001
[    6.160292] x23: 0000000000000000 x22: ffff237bc05b4080 x21: 00000000000=
00082
[    6.160918] x20: ffff237bc05b40a0 x19: ffff237bc64edb00 x18: fffffffffff=
fffff
[    6.161544] x17: 6666666666656266 x16: ffffa2f1c0298b2c x15: 6674616c702=
d2d32
[    6.162170] x14: 0000000000000000 x13: 0032312e7968702d x12: 656963703a6=
e6f63
[    6.162796] x11: 7379732e30303030 x10: ffffa2f1c20c2398 x9 : 00000000000=
00020
[    6.163423] x8 : 0101010101010101 x7 : 0000737465736573 x6 : 00000000806=
27436
[    6.164049] x5 : ffffffffff5ff198 x4 : 0000000000000000 x3 : 00000000000=
00001
[    6.164675] x2 : 0000000000000082 x1 : 0000000000000082 x0 : 00000000000=
00000
[    6.165301] Call trace:
[    6.165517]  __reset_control_get_internal+0x68/0x17c
[    6.165954]  __of_reset_control_get+0x1e4/0x280
[    6.166353]  __reset_control_get+0x48/0x1d8
[    6.166722]  __reset_control_bulk_get+0x74/0x114
[    6.167129]  __devm_reset_control_bulk_get+0x78/0xe8
[    6.167566]  rockchip_pcie_parse_dt+0x120/0x1f0
[    6.167965]  rockchip_pcie_probe+0x60/0x59c [pcie_rockchip_host]
[    6.168494]  platform_probe+0x68/0xdc
[    6.168815]  really_probe+0xbc/0x298
[    6.169132]  __driver_probe_device+0x78/0x12c
[    6.169516]  driver_probe_device+0xdc/0x160
[    6.169886]  __device_attach_driver+0xb8/0x134
[    6.170278]  bus_for_each_drv+0x80/0xdc
[    6.170617]  __device_attach+0xa8/0x1b0
[    6.170956]  device_initial_probe+0x14/0x20
[    6.171326]  bus_probe_device+0xa8/0xac
[    6.171665]  deferred_probe_work_func+0x88/0xc0
[    6.172064]  process_one_work+0x150/0x294
[    6.172419]  worker_thread+0x2e4/0x3ec
[    6.172749]  kthread+0x118/0x11c
[    6.173036]  ret_from_fork+0x10/0x20
[    6.173353] ---[ end trace 0000000000000000 ]---
[    6.173817] rockchip-pcie f8000000.pcie: error -EBUSY: cannot get
the reset control
[    6.174494] rockchip-pcie f8000000.pcie: probe with driver
rockchip-pcie failed with error -16

> - Mani

Thanks

-Anand
>
> > -     err =3D reset_control_deassert(rockchip->mgmt_sticky_rst);
> > -     if (err) {
> > -             dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> > -             goto err_power_off_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->core_rst);
> > +     err =3D reset_control_bulk_deassert(ROCKCHIP_NUM_CORE_RSTS,
> > +                                       rockchip->core_rsts);
> >       if (err) {
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
> > -     if (err) {
> > -             dev_err(dev, "deassert pipe_rst err %d\n", err);
> > +             dev_err(dev, "reset bulk deassert core err %d\n", err);
> >               goto err_power_off_phy;
> >       }
> >
> >       return 0;
> > +
> >  err_power_off_phy:
> >       while (i--)
> >               phy_power_off(rockchip->phys[i]);
> > diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/contr=
oller/pcie-rockchip.h
> > index 72346e17e45e..27e951b41b80 100644
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
> > @@ -289,6 +290,8 @@
> >                ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
> >
> >  #define ROCKCHIP_NUM_CLKS    ARRAY_SIZE(rockchip_pci_clks)
> > +#define ROCKCHIP_NUM_PM_RSTS ARRAY_SIZE(rockchip_pci_pm_rsts)
> > +#define ROCKCHIP_NUM_CORE_RSTS       ARRAY_SIZE(rockchip_pci_core_rsts=
)
> >
> >  static const char * const rockchip_pci_clks[] =3D {
> >       "aclk",
> > @@ -297,18 +300,26 @@ static const char * const rockchip_pci_clks[] =3D=
 {
> >       "pm",
> >  };
> >
> > +static const char * const rockchip_pci_pm_rsts[] =3D {
> > +     "pm",
> > +     "pclk",
> > +     "aclk",
> > +};
> > +
> > +static const char * const rockchip_pci_core_rsts[] =3D {
> > +     "core",
> > +     "mgmt",
> > +     "mgmt-sticky",
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
> >       struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
> >       struct  regulator *vpcie12v; /* 12V power supply */
> >       struct  regulator *vpcie3v3; /* 3.3V power supply */
> > --
> > 2.44.0
> >
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

