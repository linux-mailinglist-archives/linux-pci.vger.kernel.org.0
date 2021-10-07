Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D26D4255CA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 16:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242185AbhJGOwY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhJGOwY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 10:52:24 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2F1C061570;
        Thu,  7 Oct 2021 07:50:30 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id j38so637663vkd.10;
        Thu, 07 Oct 2021 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xxLvyP5M4081+d+g5i05w8p8756WzGkVuz6hEEok8lI=;
        b=j2Nf4VrT0khn7OJoKdjVWEaYgNjFmOU5xuZsGlq/mnmrSvTOHkj4hb6h+Ib/tkKih+
         LWiZYsPjTxzBz/vQrddpElW9grZGvHgBESc43SrLyNcAnzx3q1hbGWvl9y1BdVoUyTK2
         DrGPCW++5Ig5GAr3dPQPUkyvwHYpGSv3+GIvwODLQSeMNbku/TX17kA+sA/FbsH0qZzA
         JuA8ECwSZipsBGNwKGWk0neuC9muzpykiLx18s1eFMW8DHmrl1dKsHC7E40py8IBMgG+
         qFl8qWqT0xsmhzWKrbgfagNDvIkzYSYOiEE4FW3WSN0t7fgrQdYm+ie6C1mKjWkix1lv
         egjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xxLvyP5M4081+d+g5i05w8p8756WzGkVuz6hEEok8lI=;
        b=dYyzJbaCtGNx0Odr4p+W9VPEAoPeR7kYI7EIZ+K3EzVRN2xmYIgiV4T6XIfsumzcCo
         XTWVHDXygnTSZX1JxG4R+vfTguCTUKDYgw1MGWOvRasqZkSHp0geBje+juPVlPrX672s
         gGO0thGhT+o9sfB3iKdzVFsfA5NtAky7NwdC9UyDqARExXfIlMcr/cIpPec/HDa7UeNF
         UMtKbAboeFfHqIk25FLjNoJ263texV4fcX5xK9mbf28gcBxkgocpkBLyPNjpmzHrNdzT
         W3M4HE6JqjJACuLTMPUlUDGOG5v4WTrBmTwg1DFguyj7bbNeESvxMdGMcMtM77m7h+cI
         gqmg==
X-Gm-Message-State: AOAM531CkkZ+eBPQqAyc/C0axA1tm13ZOUW6C0PD6h3KAi/2mS60M26p
        VbGo3Y4fzxPTU6UE7f4dTa9ql+eF19KvpzILIw==
X-Google-Smtp-Source: ABdhPJz/AJ63Nrrz51cmzGxPn2zjajFtDBrX0OKdWSZOEegLC8imkZezWHVRBjD0E8g8P6CQaoc3TATjsnhv2+8Jr8s=
X-Received: by 2002:a1f:4a82:: with SMTP id x124mr3935529vka.11.1633618229157;
 Thu, 07 Oct 2021 07:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <87ee8yquyi.wl-maz@kernel.org> <CALjTZvakX8Hz+ow3UeAuQiicVXtbkXEDFnHU-+n8Ts6i1LRyHQ@mail.gmail.com>
 <87bl41qkrh.wl-maz@kernel.org> <CALjTZvbsvsD6abpw0H5D4ngUXPrgM2mDV0DX5BQi0z8cd-yxzA@mail.gmail.com>
 <878rz5qbee.wl-maz@kernel.org> <CALjTZvZZf25tqoQWM_HsBb84JgKpMKAxqfhUdpD_e5M-Bc_yzA@mail.gmail.com>
 <875yu8rj5t.wl-maz@kernel.org>
In-Reply-To: <875yu8rj5t.wl-maz@kernel.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 7 Oct 2021 15:50:18 +0100
Message-ID: <CALjTZvbZK3vxexyoEHmh9TPoceckvGV7ACHjOa0rJ9HH=YAyYA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi again, Marc,

On Thu, 7 Oct 2021 at 15:42, Marc Zyngier <maz@kernel.org> wrote:
>
> Right. Let's see if we can be less brutal and only quirk the AHCI
> device (patch below, completely untested). I'm a bit concerned that
> all the devices in this system seem to report 'Maskable-'...

True. However=E2=80=A6

rui@vedder:~$ cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:        124          0          0          0   IO-APIC   2-edge      ti=
mer
  1:          0          0          0          0   IO-APIC   1-edge      i8=
042
  8:          0          0          0          1   IO-APIC   8-edge      rt=
c0
  9:          0          0          0          0   IO-APIC   9-fasteoi   ac=
pi
 12:          0          1          0          0   IO-APIC  12-edge      i8=
042
 20:          0          0      12734     852750   IO-APIC  20-fasteoi
  ehci_hcd:usb2, enp0s10
 21:         25          0          0          0   IO-APIC  21-fasteoi
  ohci_hcd:usb4
 22:      25672        288          0          0   IO-APIC  22-fasteoi
  ehci_hcd:usb1
 23:          0          0          0        709   IO-APIC  23-fasteoi
  ohci_hcd:usb3, snd_hda_intel:card0
 29:          0          0      83164       1779   PCI-MSI
1572864-edge      nvkm
 30:       3595       5645          0          0   PCI-MSI 180224-edge
     ahci[0000:00:0b.0]
NMI:          0          0          0          0   Non-maskable interrupts
LOC:     202323     194669     107282     197322   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:          0          0          0          0   Performance
monitoring interrupts
IWI:          0          0          0          0   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:        179        995        208        273   Rescheduling interrupts
CAL:       1149       1495        949       1211   Function call interrupts
TLB:        110         76         79         79   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupt=
s
MCE:          0          0          0          0   Machine check exceptions
MCP:         20         20         20         20   Machine check polls
ERR:          1
MIS:          0
PIN:          0          0          0          0   Posted-interrupt
notification event
NPI:          0          0          0          0   Nested posted-interrupt =
event
PIW:          0          0          0          0   Posted-interrupt wakeup =
event
rui@vedder:~$

=E2=80=A6 the only devices using MSIs are the AHCI controller and the GPU, =
so
I think any damage would be more contained (and obvious), in this
case.

>
>         M.
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0099a00af361..2f9ec7210991 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -479,6 +479,9 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct=
 irq_affinity *affd)
>                 goto out;
>
>         pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control)=
;
> +       /* Lies, damned lies, and MSIs */

Best comment ever. :)

> +       if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
> +               control |=3D PCI_MSI_FLAGS_MASKBIT;
>
>         entry->msi_attrib.is_msix       =3D 0;
>         entry->msi_attrib.is_64         =3D !!(control & PCI_MSI_FLAGS_64=
BIT);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4537d1ea14fd..dc7741431bf3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5795,3 +5795,9 @@ static void apex_pci_fixup_class(struct pci_dev *pd=
ev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>                                PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_c=
lass);
> +
> +static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
> +{
> +       pdev->dev_flags |=3D PCI_MSI_FLAGS_MASKBIT;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fi=
xup);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd8aa6fce204..152a4d74f87f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -233,6 +233,8 @@ enum pci_dev_flags {
>         PCI_DEV_FLAGS_NO_FLR_RESET =3D (__force pci_dev_flags_t) (1 << 10=
),
>         /* Don't use Relaxed Ordering for TLPs directed at this device */
>         PCI_DEV_FLAGS_NO_RELAXED_ORDERING =3D (__force pci_dev_flags_t) (=
1 << 11),
> +       /* Device does honor MSI masking despite saying otherwise */
> +       PCI_DEV_FLAGS_HAS_MSI_MASKING =3D (__force pci_dev_flags_t) (1 <<=
 12),
>  };
>
>  enum pci_irq_reroute_variant {
>
>
> --

I'm taking this one for a ride too and report back.

Thanks,
Rui
