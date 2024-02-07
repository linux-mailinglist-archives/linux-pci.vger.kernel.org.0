Return-Path: <linux-pci+bounces-3184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5337284C503
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 07:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71621F251F9
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 06:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF551773D;
	Wed,  7 Feb 2024 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="u2BJ1zHU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D61CD2C
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707287529; cv=none; b=dOMjXvFem21OBzRUsZ6PiC1J14lpsvU7PgC2+eBKYNAauErt5p1cZetrStuaIf/xsrTo95qkSMI43kZCFK+tJCZeKoCjlKe777awpUPXeP2LlxiOf0V/vyioY7T9PdI897GvchzjCCs6mMfjwwIME6o1DiK6YFJsJ+VFOQbquTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707287529; c=relaxed/simple;
	bh=jtmLBplwCG56G8uZAmBLDccQpfNCfshXHxvjHmht6Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSuqq+o9LQkOtONjg7ZohqLSBulmI9S68gw4QO0v9vLDricL3UujlyVHSV0mAiW6Mn2DJVRqf7qt6QQSOqP5F/IpDcfOd/qTnyNX2MUQJhuaKsW65yo+xoRjJ99BGjaa9BPw8jLMUMafZg7TM2UcIok77VK6pFwpn/7nLaTG8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=u2BJ1zHU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-604842b3726so3665307b3.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2024 22:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707287525; x=1707892325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MLmYhwM6V0Q4nXC/yPki6tk1W/Oozpyls+lfDZ2B0U=;
        b=u2BJ1zHU1zzwhH+jvFH3/papExRRABjBxZua6Ro/OHim9XFUsdC4MmxAoqnIGEsCLp
         197knX75EplRV4X/XP3KmOu7tfVibqM233XYjV4BnbYxq2X7S0mK3nyQdGR7S9UcOVFH
         PdS/gSqUMnSmWEkuiCJUZFBF2nj88eAGcXGNJya9wfJbX2ARDi0jDvOHnSwlpXWZEy9d
         d16V/fyITKB/KuGqV11T0QMx6P+GiXk46ba3WXqjvRBtxFxvLIoACGhtl4CgA7Ko5vAK
         Vu0xcaKWmLJNOgTt3LYkdUx3rMKf8K/0FTQDwu9D/RqbQQuhg4vnRSOPqnqGwoA8CoDe
         pDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707287525; x=1707892325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MLmYhwM6V0Q4nXC/yPki6tk1W/Oozpyls+lfDZ2B0U=;
        b=GXF0Zfnha8+YyujjTZAfiB80SSdhCNmR/3FsVLwfvnf713iJk3uC/u3tZ+KxOlAl8X
         /RK+LSrb6RjNxNM3bvI/0VHLYw/g8HwFpweL/dOL5GFFnkXs3D75YKC1L39C7ny/42iG
         Jd+rm/omxaSycuAqafUB1ZpWTei2yJ44FzPo0J2+x9bSku5vuzmqOaIpWFeyzhZZOeTc
         vLiDzuJaUK/KOyzXYDEET5jjmmcwwMheI7WoF151i0m6tzksRNY73W8amD/XABaGIasm
         WuBcV2hAr1h5rv6OZde90ITqBIHRck/fEOBI4Tt2nAzKMI4emZ4lm82U3T8Vmzy/eFu5
         xxmg==
X-Forwarded-Encrypted: i=1; AJvYcCXjE5Y4iTBQ+TTI2t4Hsow+pDy/pb7R9WGIvXq6Zsdc6x3HH3ZUMNnQxy/enfoWfiNPF7tiq39aZxemuOrzvNxYbbogiZN9UUX6
X-Gm-Message-State: AOJu0YwkgvzdJ4JWIRriIHJ9z+F8kagvbXHg+kIYfENS9FlVD5m82xoZ
	sahmvC5HrzbzGXgK31Ry6eYYzhwEE5Id/4xHQsraQ7F5sEwFBcbWIY8O76VkD6u4XW5UNvU9Xew
	9ybeKymYoQR7oMFJY7PWdgr2bPmXj/wWMsi3ulA==
X-Google-Smtp-Source: AGHT+IH785L7G8bGbuWEDhetEWGon5IfyyMyXQ4okyvhpWeiGgm8OmTnGt7st1LaD+Jkftr3t7dJuZ8/QQQTflhkoow=
X-Received: by 2002:a81:bc54:0:b0:5eb:1d7a:2664 with SMTP id
 b20-20020a81bc54000000b005eb1d7a2664mr3698543ywl.29.1707287524989; Tue, 06
 Feb 2024 22:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130095933.14158-1-jhp@endlessos.org> <20240130101335.GU2543524@black.fi.intel.com>
 <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>
 <Zbonprq/1SircQon@x1-carbon> <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>
 <ZbrNLxHL03R66PxQ@x1-carbon> <ZbuyVbMEBWKi729y@x1-carbon> <CAPpJ_efmzy_FU0urdHDmO5htOBCPaX-T5W+Er7AmWYhqUTwnyA@mail.gmail.com>
 <ZcDHjsYJNlJ/9nNT@x1-carbon> <CAPpJ_ec0H6zr6wcNstFn9dRcFgPXspU3MYvgGMNAS5wnw-0pTw@mail.gmail.com>
 <ZcIwMb0WPZLG85LR@x1-carbon>
In-Reply-To: <ZcIwMb0WPZLG85LR@x1-carbon>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Feb 2024 14:31:29 +0800
Message-ID: <CAPpJ_efbRDqA9ybmdJ9iNunVmoHukGekuFtEE3X-nwOxfYivcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE
To: Niklas Cassel <cassel@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Daniel Drake <drake@endlessos.org>, 
	Vitalii Solomonov <solomonov.v@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	David Box <david.e.box@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-ide@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Niklas Cassel <cassel@kernel.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=886=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Feb 06, 2024 at 04:39:02PM +0800, Jian-Hong Pan wrote:
> > Niklas Cassel <cassel@kernel.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Have the comparison:
> >
> > * Bind LPM policy with the patch "ata: ahci: Add force LPM policy
> > quirk for ASUS B1400CEAE" based on kernel v6.8-rc2:
> >
> > $ dmesg | grep -E "(SATA|ata1|ahci)"
> > [    0.791497] ahci 10000:e0:17.0: version 3.0
> > [    0.791499] ahci 10000:e0:17.0: force controller follow LPM policy
> > [    0.791517] ahci 10000:e0:17.0: can't derive routing for PCI INT A
> > [    0.791518] ahci 10000:e0:17.0: PCI INT A: no GSI
> > [    0.791637] ahci 10000:e0:17.0: ahci_update_initial_lpm_policy: poli=
cy 3
> > [    0.791652] ahci 10000:e0:17.0: ahci_intel_pcs_quirk: not Intel,
> > the vendor is 0xffffffff
> > [    0.791662] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6
> > Gbps 0x1 impl SATA mode
> > [    0.791663] ahci 10000:e0:17.0: flags: 64bit ncq sntf pm clo only
> > pio slum part deso sadm sds
> > [    0.791771] scsi host0: ahci
> > [    0.791806] ata1: SATA max UDMA/133 abar m2048@0x76102000 port
> > 0x76102100 irq 145 lpm-pol 3
> > [    0.791808] ahci 10000:e0:17.0: ahci_init_one: probed
> > [    1.109393] ata1: sata_link_resume: rc=3D0
> > [    1.109415] ata1: BUSY ? 0 (status: 0x50) SStatus.DET: 0x3
> > [    1.109418] ata1: sata_link_hardreset: is 0
> > [    1.109420] ata1: sata_link_hardreset: is on line, returns 0
> > [    1.109444] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > [    1.110161] ata1.00: ATA-10: WDC WD10SPZX-80Z10T2, 04.01A04, max UDM=
A/133
> > [    1.112047] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth =
32), AA
> > [    1.112054] ata1.00: Features: NCQ-prio
> > [    1.114814] ata1.00: configured for UDMA/133
> > [    1.114821] ata1: ahci_set_lpm: policy=3D3
> > [    1.114837] ata1: sata_link_scr_lpm: policy is 3 and original
> > scontrol 0x00000300
> > [    1.114840] ata1: sata_link_scr_lpm: write scontrol 0x00000000
> >
> > The SATA link is up and SATA storage shows up.
> > Full dmesg as the attachment of
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217114#c28
> >
> > * Bind LPM policy with PCI IDs like commit 104ff59af73a ("ata: ahci:
> > Add Tiger Lake UP{3,4} AHCI controller"):
> >
> > $ dmesg | grep -E "(SATA|ata1|ahci)"
> > [    0.783125] ahci 10000:e0:17.0: version 3.0
> > [    0.783143] ahci 10000:e0:17.0: can't derive routing for PCI INT A
> > [    0.783145] ahci 10000:e0:17.0: PCI INT A: no GSI
> > [    0.783257] ahci 10000:e0:17.0: ahci_update_initial_lpm_policy: poli=
cy 3
> > [    0.783280] ahci 10000:e0:17.0: ahci_intel_pcs_quirk: PCS_6 is 0x000=
0
> > [    0.783281] ahci 10000:e0:17.0: ahci_intel_pcs_quirk: write PCS_6 wi=
th 0x0001
> > [    0.783296] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6
> > Gbps 0x1 impl SATA mode
> > [    0.783298] ahci 10000:e0:17.0: flags: 64bit ncq sntf pm clo only
> > pio slum part deso sadm sds
> > [    0.783402] scsi host0: ahci
> > [    0.783440] ata1: SATA max UDMA/133 abar m2048@0x76102000 port
> > 0x76102100 irq 144 lpm-pol 3
> > [    0.783442] ahci 10000:e0:17.0: ahci_init_one: probed
> > [    1.096930] ata1: sata_link_resume: rc=3D0
> > [    1.096960] ata1: sata_link_hardreset: ata_phys_link_offline is True
> > [    1.096962] ata1: sata_link_hardreset: is off line, returns 0
> > [    1.097000] ata1: SATA link down (SStatus 4 SControl 300)
> > [    1.097025] ata1: ahci_set_lpm: policy=3D3
> > [    1.097051] ata1: sata_link_scr_lpm: policy is 3 and original
> > scontrol 0x00000300
> > [    1.097054] ata1: sata_link_scr_lpm: write scontrol 0x00000304
> >
> > The SATA link is down and SATA storage disappears.
> > Full dmesg as the attachment of
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217114#c29
> >
>
> So in summary:
> When Intel VMD is on, and the ahci_intel_pcs_quirk is applied =3D> NOT OK
> When Intel VMD is on, and the ahci_intel_pcs_quirk is not applied =3D> OK
>
> When Intel VMD is off, and the ahci_intel_pcs_quirk is applied =3D> OK
> When Intel VMD is off, and the ahci_intel_pcs_quirk is not applied =3D> ?

When Intel VMD is off, and the ahci_intel_pcs_quirk is not applied =3D> OK

> Excellent find!
>
>
>
> In the bad case:
>
> sata_link_hardreset() sets SControl.DET to 1, to establish the interface
> communication. Then sleeps for 1 ms.
>
> Then it calls sata_link_resume(), which clears SControl.DET to 0.
> (This matches the AHCI spec which says that SControl.DET should be set
> to 1 for at least 1 ms.)
>
> sata_link_hardreset() then calls ata_phys_link_offline(),
> which is essentially defined as: return !(SStatus.DET =3D=3D 0x3)
> ata_phys_link_offline() returns true, since SStatus.DET =3D=3D 0x4.
>
> SStatus.DET =3D=3D 0x4 means: Phy in offline mode as a result of the
> interface being disabled or running in a BIST loopback mode.
>
> If the physical link is not established, there is no point to call
> ata_wait_ready() (which waits for the device to become ready on the
> protocol level), as the physical link could not even be established.
>
> After that, we write SControl.DET to set bit 4 to disable the port,
> in order to save power. This is only done because sata_link_hardreset()
> failed to establish a link after toggling SControl.DET =3D=3D 1.
>
> So the problem is that SStatus.DET never changed to 0x3 after toggling
> SControl.DET =3D=3D 1.
>
>
> >
> > However, I notice more interesting thing:
> > "drivers/ata/ahci.c:ahci_intel_pcs_quirk()"!
> > If bind LPM policy with PCI IDs matching, then it does the PCS quirk.
> > But, binding with the patch "ata: ahci: Add force LPM policy quirk for
> > ASUS B1400CEAE" does not, because the vendor is ANY vendor, not Intel.
> >
> > So, I did following test:
> >
> > If I modify the PCI vendor check condition with the pdev, not the PCI
> > ID's vendor:
> >
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index 7ecd56c8262a..ece709ac20d6 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -1706,12 +1709,16 @@ static void ahci_intel_pcs_quirk(struct
> > pci_dev *pdev, struct ahci_host_priv *hp
> >         /*
> >          * Only apply the 6-port PCS quirk for known legacy platforms.
> >          */
> > -       if (!id || id->vendor !=3D PCI_VENDOR_ID_INTEL)
> > +       if (!id || pdev->vendor !=3D PCI_VENDOR_ID_INTEL) {
> > +               dev_info(&pdev->dev, "%s: not Intel, the vendor is
> > 0x%08x\n", __func__, id->vendor);
> >                 return;
> > +       }
>
> The reason why you are seeing this is because Tiger Lake does not have
> an entry in the ahci_pci_tbl in mainline, so it uses the generic entry
> which matches on the AHCI class code:
> https://github.com/torvalds/linux/blob/v6.8-rc3/drivers/ata/ahci.c#L636
>
> If you revert 6210038aeaf4 ("ata: ahci: Revert "ata: ahci: Add Tiger Lake
> UP{3,4} AHCI controller""), you will get an explicit entry in the
> ahci_pci_tbl.
>
> But to clarify, I think that it would make sense to add:
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index d2460fa985b7..e462509a45e8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1672,12 +1672,18 @@ static void ahci_update_initial_lpm_policy(struct=
 ata_port *ap,
>
>  static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_=
priv *hpriv)
>  {
> -       const struct pci_device_id *id =3D pci_match_id(ahci_pci_tbl, pde=
v);
> +       const struct pci_device_id *id;
>         u16 tmp16;
>
> +       /* If the detected PCI device is not an Intel device, skip. */
> +       if (pdev->vendor !=3D PCI_VENDOR_ID_INTEL)
> +               return;
> +
>         /*
> -        * Only apply the 6-port PCS quirk for known legacy platforms.
> +        * See if there is an explicit entry for this PCI device in
> +        * ahci_pci_tbl, if there is not, do not apply the quirk.
>          */
> +       id =3D pci_match_id(ahci_pci_tbl, pdev);
>         if (!id || id->vendor !=3D PCI_VENDOR_ID_INTEL)
>                 return;
>
>
>
> >
> > Then, the SATA HDD always disappears like binding the LPM policy with
> > PCI IDs matching, even with the patch "ata: ahci: Add force LPM policy
> > quirk for ASUS B1400CEAE".
> > So, I think ahci_intel_pcs_quirk() is the key point.
>
> I agree.
>
>
> Can you verify that things work as expected when doing a:
> $ git revert 6210038aeaf49c395c2da57572246d93ec67f6d4
> to re-add the explicit entry, if you also do a:
>
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1672,6 +1672,7 @@ static void ahci_update_initial_lpm_policy(struct a=
ta_port *ap,
>
>  static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_=
priv *hpriv)
>  {
> +#if 0
>         const struct pci_device_id *id =3D pci_match_id(ahci_pci_tbl, pde=
v);
>         u16 tmp16;
>
> @@ -1698,6 +1699,7 @@ static void ahci_intel_pcs_quirk(struct pci_dev *pd=
ev, struct ahci_host_priv *hp
>                 tmp16 |=3D hpriv->port_map;
>                 pci_write_config_word(pdev, PCS_6, tmp16);
>         }
> +#endif
>  }
>
> To make the quirk a no-op?

Here is the test result:

Both enabled & disabled VMD with no-op ahci_intel_pcs_quirk() shows
the SATA storage on ASUS B1400CEAE. =3D> OK

$ cat /tmp/dmesg.log
[    0.799439] ahci 10000:e0:17.0: version 3.0
[    0.799459] ahci 10000:e0:17.0: can't derive routing for PCI INT A
[    0.799460] ahci 10000:e0:17.0: PCI INT A: no GSI
[    0.799582] ahci 10000:e0:17.0: ahci_update_initial_lpm_policy: policy 3
[    0.799615] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6
Gbps 0x1 impl SATA mode
[    0.799617] ahci 10000:e0:17.0: flags: 64bit ncq sntf pm clo only
pio slum part deso sadm sds
[    0.799722] scsi host0: ahci
[    0.799760] ata1: SATA max UDMA/133 abar m2048@0x76102000 port
0x76102100 irq 144 lpm-pol 3
[    0.799761] ahci 10000:e0:17.0: ahci_init_one: probed
[    1.112519] ata1: sata_link_resume: rc=3D0
[    1.112541] ata1: BUSY ? 0 (status: 0x50) SStatus.DET: 0x3
[    1.112545] ata1: sata_link_hardreset: is 0
[    1.112547] ata1: sata_link_hardreset: is on line, returns 0
[    1.112571] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.113280] ata1.00: ATA-10: WDC WD10SPZX-80Z10T2, 04.01A04, max UDMA/13=
3
[    1.114880] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    1.114887] ata1.00: Features: NCQ-prio
[    1.117148] ata1.00: configured for UDMA/133
[    1.117154] ata1: ahci_set_lpm: policy=3D3
[    1.117169] ata1: sata_link_scr_lpm: policy is 3 and original
scontrol 0x00000300
[    1.117172] ata1: sata_link_scr_lpm: write scontrol 0x00000000

Jian-Hong Pan

> To be honest, this quirk looks horrible.
>
> Looking at the original commit:
> c312ef176399 ("libata/ahci: Drop PCS quirk for Denverton and beyond")
>
> It claims that:
>
> Rather than try to fix the PCS quirk to consider the DNV register layout
> instead require explicit opt-in. The assumption is that the OS driver
> need not touch this register, and platforms can be added with a new
> boad_ahci_pcs7 board-id when / if problematic platforms are found in the
> future.
>
> However, it does NOT require an explicit opt-in!
>
> If we were to add an entry with board type "board_ahci" or
> "board_ahci_low_power" for Tiger Lake, the quirk gets applied...
>
> See also:
> 09d6ac8dc51a ("libata/ahci: Fix PCS quirk application")
>
> So basically, what ahci_intel_pcs_quirk() does is that it checks
> if there is an explicit entry in ahci_pci_tbl.
> If there is not, the quirk is not applied.
>
> If there is an entry, and the enum for that board has a value that
> is less than board_ahci_pcs7, the quirk is applied...
>
> But that will be *ALL* other board types since board_ahci_pcs7 is
> defined last in the enum:
> https://github.com/torvalds/linux/blob/v6.8-rc3/drivers/ata/ahci.c#L75
>
> Not only that but the comment for that enum is wrong:
> https://github.com/torvalds/linux/blob/v6.8-rc3/drivers/ata/ahci.c#L71-L7=
4
>
>         /*
>          * board IDs for Intel chipsets that support more than 6 ports
>          * *and* end up needing the PCS quirk.
>          */
>
> Is is the opposite... board IDs that do NOT need the PCS quirk...
>
> But this is not the way we add quirks.
> We add a flag and a new board_id and mark the PCI device and vendor ids
> that are affected to use that board, see e.g.
> 20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 con=
trollers")
>
> We don't add a quirk and apply it for everything (board_ahci,
> board_ahci_low_power) except for a specific entry (board_ahci_pcs7).
>
> It seems that at least Intel AHCI controllers that also have Intel VMD
> enabled break when this quirk is applied.
>
> I guess one way would be to do a:
> git show c312ef176399:drivers/ata/ahci.c | grep "PCI_VDEVICE(INTEL"
> and replace everything that is not: board_ahci_pcs7
> with a board_ahci_pcs_quirk, board_ahci_low_power_pcs_quirk, and
> board_ahci_avn_pcs_quirk, and after that change all board_ahci_pcs7
> entries to board_ahci, and assume that entries added since c312ef176399
> do not need the quirk.
>
> But it would be nice if someone from Intel could clean this up.
>
>
> Kind regards,
> Niklas

