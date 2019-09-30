Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F2DC1CB2
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 10:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfI3IQt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 04:16:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41276 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3IQt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 04:16:49 -0400
Received: by mail-io1-f65.google.com with SMTP id n26so7431064ioj.8
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KaBpRATfAtf4rWki+RpmtqBvaUEKw92ROi6AWnbW4po=;
        b=fS8z/+o9gZKlME62G3wlVM8YKSqCtbi8/0Aau2btXZxoF1ivfmYl8ARUibDLfqv9T9
         lppjHYQuSo8wZNchmNxwUR9ufOrQlrEIkadOy/M4VmU3Rvag0Q15d+cUFxxAUGMahHPT
         0/+6hQvOYh650R0ti62E4zOuKYaIlkA2dBYUICZDdRAdq5RGvLg5+HDcFNdwLJXnjgAk
         PbJ8XkAEw46E3Cbc66f/nPxJWEcD5iSaumf4rqQTbkfrKJeqvtyo7nH/jT5elUdBglfI
         L+rhj6Cmx5pH3EiasJUNJIv6prBQEZf3ZUtp/EP2yWxoXxQDcgxwS6IRsMkbyGFR7LA7
         UY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KaBpRATfAtf4rWki+RpmtqBvaUEKw92ROi6AWnbW4po=;
        b=BbtGZmvmkt0TAO2m2SGX3j1i5AbzL4fzUbAiqED4qCH7UHmD+g8LvOUGjFFiobFoiV
         5/3o/fe4ugaYfSVZb1R0EYAAvcktzw5SdjlV3Wq26Jgx+MIWpkWUqkEcKdGWrUs28F7p
         85YvlJb6hIMwHjh8x9DnXsuAPMljUvTlK23pAXvbbMpohOpofDblCnW7km+cAPgH+I3x
         BDGVwLlc0/PeIokmAfDFyYjgotYTrPE+Fa3PPd6uOKEApXhr6GzKFSgmtCGhhnsKZBjq
         1JYEGr8KTSoodLe1caop6c2Y7fmQ2+5wtkLX/HejRRtzDd7cMx3yW5QFknIU8VzomwLl
         glMQ==
X-Gm-Message-State: APjAAAV+hu81s7nPwlWj6uFU4C1MN3zty+76RmUZEgwy8DD8Yt4+bPGL
        B7BoevFf3in5iQNeF58EV3BQIEvly6qoooNyQv7lGQ==
X-Google-Smtp-Source: APXvYqzVpU47qXAsHPMapDkMIY9pYLHDZ5ygLihtYcuDjBun+ROeUa2rTg/P4070Jv9HNhFiipYv2n8L7Sd/Klcx6p4=
X-Received: by 2002:a5e:c747:: with SMTP id g7mr3347342iop.70.1569831408182;
 Mon, 30 Sep 2019 01:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <1563279226-30804-1-git-send-email-jaz@semihalf.com>
In-Reply-To: <1563279226-30804-1-git-send-email-jaz@semihalf.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Mon, 30 Sep 2019 10:16:37 +0200
Message-ID: <CAH76GKN9-VHu5yMDxm8jZmhoiZP+6jgMP0bNiSSyq7dOXXODsg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: pci-bridge-emul: fix big-endian support
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marcin Wojtas <mw@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I want to kindly remind about this patch.

Best regards,
Grzegorz


wt., 16 lip 2019 o 14:14 Grzegorz Jaszczyk <jaz@semihalf.com> napisa=C5=82(=
a):
>
> Perform conversion to little-endian before every write to configuration
> space and converse back to cpu endianness during read. Additionally
> initialise every not-byte wide fields of config space with proper
> cpu_to_le* macro.
>
> This is required since the structure describing config space of emulated
> bridge assumes little-endian convention.
>
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
> v1->v2
> - use __le32 and __le16 for config fields
> - add missing cpu_to_le16 for pcie_conf.cap assignment
> - use __le32 for cfgspace pointer
> Issues with endianness were detected by Sparse tool recommended by Russel=
l King.
>
>  drivers/pci/pci-bridge-emul.c | 25 +++++++-------
>  drivers/pci/pci-bridge-emul.h | 78 +++++++++++++++++++++----------------=
------
>  2 files changed, 52 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.=
c
> index 83fb077..cfae566 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -270,10 +270,10 @@ const static struct pci_bridge_reg_behavior pcie_ca=
p_regs_behavior[] =3D {
>  int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
>                          unsigned int flags)
>  {
> -       bridge->conf.class_revision |=3D PCI_CLASS_BRIDGE_PCI << 16;
> +       bridge->conf.class_revision |=3D cpu_to_le32(PCI_CLASS_BRIDGE_PCI=
 << 16);
>         bridge->conf.header_type =3D PCI_HEADER_TYPE_BRIDGE;
>         bridge->conf.cache_line_size =3D 0x10;
> -       bridge->conf.status =3D PCI_STATUS_CAP_LIST;
> +       bridge->conf.status =3D cpu_to_le16(PCI_STATUS_CAP_LIST);
>         bridge->pci_regs_behavior =3D kmemdup(pci_regs_behavior,
>                                             sizeof(pci_regs_behavior),
>                                             GFP_KERNEL);
> @@ -284,8 +284,9 @@ int pci_bridge_emul_init(struct pci_bridge_emul *brid=
ge,
>                 bridge->conf.capabilities_pointer =3D PCI_CAP_PCIE_START;
>                 bridge->pcie_conf.cap_id =3D PCI_CAP_ID_EXP;
>                 /* Set PCIe v2, root port, slot support */
> -               bridge->pcie_conf.cap =3D PCI_EXP_TYPE_ROOT_PORT << 4 | 2=
 |
> -                       PCI_EXP_FLAGS_SLOT;
> +               bridge->pcie_conf.cap =3D
> +                       cpu_to_le16(PCI_EXP_TYPE_ROOT_PORT << 4 | 2 |
> +                                   PCI_EXP_FLAGS_SLOT);
>                 bridge->pcie_cap_regs_behavior =3D
>                         kmemdup(pcie_cap_regs_behavior,
>                                 sizeof(pcie_cap_regs_behavior),
> @@ -327,7 +328,7 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul =
*bridge, int where,
>         int reg =3D where & ~3;
>         pci_bridge_emul_read_status_t (*read_op)(struct pci_bridge_emul *=
bridge,
>                                                  int reg, u32 *value);
> -       u32 *cfgspace;
> +       __le32 *cfgspace;
>         const struct pci_bridge_reg_behavior *behavior;
>
>         if (bridge->has_pcie && reg >=3D PCI_CAP_PCIE_END) {
> @@ -343,11 +344,11 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emu=
l *bridge, int where,
>         if (bridge->has_pcie && reg >=3D PCI_CAP_PCIE_START) {
>                 reg -=3D PCI_CAP_PCIE_START;
>                 read_op =3D bridge->ops->read_pcie;
> -               cfgspace =3D (u32 *) &bridge->pcie_conf;
> +               cfgspace =3D (__le32 *) &bridge->pcie_conf;
>                 behavior =3D bridge->pcie_cap_regs_behavior;
>         } else {
>                 read_op =3D bridge->ops->read_base;
> -               cfgspace =3D (u32 *) &bridge->conf;
> +               cfgspace =3D (__le32 *) &bridge->conf;
>                 behavior =3D bridge->pci_regs_behavior;
>         }
>
> @@ -357,7 +358,7 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul =
*bridge, int where,
>                 ret =3D PCI_BRIDGE_EMUL_NOT_HANDLED;
>
>         if (ret =3D=3D PCI_BRIDGE_EMUL_NOT_HANDLED)
> -               *value =3D cfgspace[reg / 4];
> +               *value =3D le32_to_cpu(cfgspace[reg / 4]);
>
>         /*
>          * Make sure we never return any reserved bit with a value
> @@ -387,7 +388,7 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul=
 *bridge, int where,
>         int mask, ret, old, new, shift;
>         void (*write_op)(struct pci_bridge_emul *bridge, int reg,
>                          u32 old, u32 new, u32 mask);
> -       u32 *cfgspace;
> +       __le32 *cfgspace;
>         const struct pci_bridge_reg_behavior *behavior;
>
>         if (bridge->has_pcie && reg >=3D PCI_CAP_PCIE_END)
> @@ -414,11 +415,11 @@ int pci_bridge_emul_conf_write(struct pci_bridge_em=
ul *bridge, int where,
>         if (bridge->has_pcie && reg >=3D PCI_CAP_PCIE_START) {
>                 reg -=3D PCI_CAP_PCIE_START;
>                 write_op =3D bridge->ops->write_pcie;
> -               cfgspace =3D (u32 *) &bridge->pcie_conf;
> +               cfgspace =3D (__le32 *) &bridge->pcie_conf;
>                 behavior =3D bridge->pcie_cap_regs_behavior;
>         } else {
>                 write_op =3D bridge->ops->write_base;
> -               cfgspace =3D (u32 *) &bridge->conf;
> +               cfgspace =3D (__le32 *) &bridge->conf;
>                 behavior =3D bridge->pci_regs_behavior;
>         }
>
> @@ -431,7 +432,7 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul=
 *bridge, int where,
>         /* Clear the W1C bits */
>         new &=3D ~((value << shift) & (behavior[reg / 4].w1c & mask));
>
> -       cfgspace[reg / 4] =3D new;
> +       cfgspace[reg / 4] =3D cpu_to_le32(new);
>
>         if (write_op)
>                 write_op(bridge, reg, old, new, mask);
> diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.=
h
> index e65b1b7..b318830 100644
> --- a/drivers/pci/pci-bridge-emul.h
> +++ b/drivers/pci/pci-bridge-emul.h
> @@ -6,65 +6,65 @@
>
>  /* PCI configuration space of a PCI-to-PCI bridge. */
>  struct pci_bridge_emul_conf {
> -       u16 vendor;
> -       u16 device;
> -       u16 command;
> -       u16 status;
> -       u32 class_revision;
> +       __le16 vendor;
> +       __le16 device;
> +       __le16 command;
> +       __le16 status;
> +       __le32 class_revision;
>         u8 cache_line_size;
>         u8 latency_timer;
>         u8 header_type;
>         u8 bist;
> -       u32 bar[2];
> +       __le32 bar[2];
>         u8 primary_bus;
>         u8 secondary_bus;
>         u8 subordinate_bus;
>         u8 secondary_latency_timer;
>         u8 iobase;
>         u8 iolimit;
> -       u16 secondary_status;
> -       u16 membase;
> -       u16 memlimit;
> -       u16 pref_mem_base;
> -       u16 pref_mem_limit;
> -       u32 prefbaseupper;
> -       u32 preflimitupper;
> -       u16 iobaseupper;
> -       u16 iolimitupper;
> +       __le16 secondary_status;
> +       __le16 membase;
> +       __le16 memlimit;
> +       __le16 pref_mem_base;
> +       __le16 pref_mem_limit;
> +       __le32 prefbaseupper;
> +       __le32 preflimitupper;
> +       __le16 iobaseupper;
> +       __le16 iolimitupper;
>         u8 capabilities_pointer;
>         u8 reserve[3];
> -       u32 romaddr;
> +       __le32 romaddr;
>         u8 intline;
>         u8 intpin;
> -       u16 bridgectrl;
> +       __le16 bridgectrl;
>  };
>
>  /* PCI configuration space of the PCIe capabilities */
>  struct pci_bridge_emul_pcie_conf {
>         u8 cap_id;
>         u8 next;
> -       u16 cap;
> -       u32 devcap;
> -       u16 devctl;
> -       u16 devsta;
> -       u32 lnkcap;
> -       u16 lnkctl;
> -       u16 lnksta;
> -       u32 slotcap;
> -       u16 slotctl;
> -       u16 slotsta;
> -       u16 rootctl;
> -       u16 rsvd;
> -       u32 rootsta;
> -       u32 devcap2;
> -       u16 devctl2;
> -       u16 devsta2;
> -       u32 lnkcap2;
> -       u16 lnkctl2;
> -       u16 lnksta2;
> -       u32 slotcap2;
> -       u16 slotctl2;
> -       u16 slotsta2;
> +       __le16 cap;
> +       __le32 devcap;
> +       __le16 devctl;
> +       __le16 devsta;
> +       __le32 lnkcap;
> +       __le16 lnkctl;
> +       __le16 lnksta;
> +       __le32 slotcap;
> +       __le16 slotctl;
> +       __le16 slotsta;
> +       __le16 rootctl;
> +       __le16 rsvd;
> +       __le32 rootsta;
> +       __le32 devcap2;
> +       __le16 devctl2;
> +       __le16 devsta2;
> +       __le32 lnkcap2;
> +       __le16 lnkctl2;
> +       __le16 lnksta2;
> +       __le32 slotcap2;
> +       __le16 slotctl2;
> +       __le16 slotsta2;
>  };
>
>  struct pci_bridge_emul;
> --
> 2.7.4
>
