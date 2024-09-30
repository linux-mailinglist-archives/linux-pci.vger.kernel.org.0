Return-Path: <linux-pci+bounces-13633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBCB989E53
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 11:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFAA1F2146B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 09:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1737188718;
	Mon, 30 Sep 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="WiaKVJvR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E91885A1
	for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688690; cv=none; b=n2FnDmC8kZWbJs/mmyNiW6K2SDqH+X9N3DKW8CNGeJdK5uvC0vhhyAT3Y6lOuG2ewmsp+/LIdGQfEeqxI+pANm2OHuuAETB0oYZSBZJjjxWQpmlU08qdIAJ8x4gK7upFShyZEVDpAtpS5AtHCaP+QQ4nryWO3UfXxf47JE58jHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688690; c=relaxed/simple;
	bh=nCs6FKCjKBOetwtxF9nrvTt/IMTsk78fyiw5Egieybk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMlD0V7X0yeZ9y753tsYNCw6oSMnPZd1AgwAsNeExkwHgzu94sQ0CywV76QjBCGlOT8WySCLoHTwQLwTOxQmYaVqYjg+yoxCt+FQlNFHVa9IAs0kmkHDCYlAvY+6auUMwpJYSczQ3rT8D0C8d98VQ0NJca/as/BFWv/UV2Hx/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=WiaKVJvR; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e25d15846baso3371076276.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727688687; x=1728293487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxZyqKrnaoOfhz9e6NtLyIlT2I06I9kff0OkB3B4AVY=;
        b=WiaKVJvRfWdVAz3wkAgHpHOJ/S3lg0NML9ZcyEeyHUwc/B5bY5wFkiSS7D3T1j5hK1
         jV1pc9BINVmnzm1JhRYEV8UfKV6iun2RGmEgCyJpELcoY9YKuVj7+3UgQu31+MffBZZZ
         pFzbrUBV+Y5sYC9o9tTxgoaI1+d2brCbCNs6HWtU8INuyi1LJyZUf5cvrn8ENY/u2z8R
         xGvPhPVjlI6mG2dwX7cN9ZvOfjFeWq4ika1dNJJcSaUp+rBJrBSZ1FETPkz2k+Lexe+I
         zOBvVurE3qljUtXU81uI6Ef5b8wpyOpIIEVUOEK+Awpgy3y2xtZKaAsPlGKXhVRwjcAG
         iMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688687; x=1728293487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxZyqKrnaoOfhz9e6NtLyIlT2I06I9kff0OkB3B4AVY=;
        b=DCi1pAhyXtSiWkkWHfj8mhYDMvkVVbOTK4YEV3WmbdtpxGqRWqnMYgSXa3cIvSnNQE
         DHQK/zeGEVSrXSIhzX5jg2qwk9DCB7B5o29NFiUGZnjrWc9lcG8mv6dwJN8vnBt3Sjj7
         KIawfPzXMW/H6fjZMyMPryJV6j9OCnwz3s80k78iIlVe9KJmlJ86HWSwaMh1g5ptOOtE
         8j4SoGPsZOSUKCdQS2zjFzNDzFFdGfTSjCXoZ9d07nvsfDdlAsATybEL7JNMGBVfJ4R+
         tSDBlb2s4pTSb8rnm2IEcRwGgO2LlsFTqh8NMMHlgWrJF2J+cO9y2UlNAUfBy5+cyg0J
         s6gw==
X-Forwarded-Encrypted: i=1; AJvYcCX/pEF2jntmbEjVO4+cLnlXn0bMQn6mEdsHSr9fA0TWLXZRwfWXXPcRlgffu86LYUygyYMXqfd9iLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1jwryLp4hPEZNHhlOBVOErnIlqY18LbKHK1Ecxon9MdYO1No
	G8UgGFkJdrmP3MQohrnkKyNba5FMS6dsvgqvM5WYi4fTzCCz71AEOMcS5mRge6sz71pFfMF8yjW
	xIx/wHA0plAQTiUssB7qzBJX5Gh/1iSkTRQODBA==
X-Google-Smtp-Source: AGHT+IHsjj409DwAgG3iTMFd2BikTnOcKbFqzYwFBtkTa8KGwuYprz3wGxSeN2o22o7NlxZGozGAKgppYiKCPGYI6lg=
X-Received: by 2002:a05:6902:12c5:b0:e20:11fc:325b with SMTP id
 3f1490d57ef6-e2604c9ce5amr7044631276.56.1727688687430; Mon, 30 Sep 2024
 02:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927103231.24244-2-jhp@endlessos.org> <20240927103723.24622-2-jhp@endlessos.org>
 <a6502c65-770b-4dee-3fab-2ec58c277404@linux.intel.com>
In-Reply-To: <a6502c65-770b-4dee-3fab-2ec58c277404@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Mon, 30 Sep 2024 17:30:51 +0800
Message-ID: <CAPpJ_edFBRCk6LciQ+hVkq93NOneeCJHk3B1s_QQsZO20zSoQw@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save both
 child and parent's L1SS configuration
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
	David Box <david.e.box@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E6=96=BC 2024=E5=B9=B49=
=E6=9C=8827=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:17=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Fri, 27 Sep 2024, Jian-Hong Pan wrote:
>
> > PCI devices' parameters on the VMD bus have been programmed properly
> > originally. But, cleared after pci_reset_bus() and have not been restor=
ed
> > correctly. This leads the link's L1.2 between PCIe Root Port and child
> > device gets wrong configs.
> >
> > Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
> > bridge and NVMe device should have the same LTR1.2_Threshold value.
> > However, they are configured as different values in this case:
> >
> > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Proces=
sor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
> >   ...
> >   Capabilities: [200 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Sub=
states+
> >       PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >     L1SubCtl2: T_PwrOn=3D0us
> >
> > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Bl=
ue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> >   ...
> >   Capabilities: [900 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Sub=
states+
> >       PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> >     L1SubCtl2: T_PwrOn=3D50us
> >
> > Here is VMD mapped PCI device tree:
> >
> > -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
> >  | ...
> >  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
> >               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> >
> > When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> > restores NVMe's state before and after reset.
>
> > Because bus [e1] has only one
> > device: 10000:e1:00.0 NVMe.
>
> This is incomplete sentence. And I don't understand why the number of
> devices is relevant. Perhaps just drop it?
>
> > The PCIe bridge is missed.
>
> Unclear what this refers to (I know what you mean but please write it
> so that other reading this 10 years from now will also get what is
> missed).
>
> > However, when it
> > restores the NVMe's state, it also restores the ASPM L1SS between the P=
CIe
> > bridge and the NVMe by pci_restore_aspm_l1ss_state().
>
> "it also restores ..." -> "ASPM code restores L1SS for both the parent
> bridge and the NVMe in pci_restore_aspm_l1ss_state()."
>
> > The NVMe's L1SS is
> > restored correctly. But, the PCIe bridge's L1SS is restored with the wr=
ong
> > value 0x0 [1]. Because, the parent device (PCIe bridge)'s L1SS is not s=
aved
>
> Join these sentences without . and drop the comma.
>
> I'd say "was not saved" because at that point it occurred clearly before
> the restore.
>
> > by pci_save_aspm_l1ss_state() before reset. That is why
> > pci_restore_aspm_l1ss_state() gets the parent device (PCIe bridge)'s sa=
ved
> > state capability data and restores L1SS with value 0.
>
> This last sentence seems duplicated.
>
> > So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() sav=
e
> > the parent's L1SS configuration, too. This is symmetric on
> > pci_restore_aspm_l1ss_state().
> >
> > [1]: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6S=
dS4eG9oGpEX1wmnMLkQ@mail.gmail.com/
>
> Just put this into Link tag.
>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
>
> Closes: ?
>
> Fixes tag is also missing.
>
> Add:
>
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> > v9:
> > - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instea=
d.
> >
> > v10:
> > - Drop the v9 fix about drivers/pci/controller/vmd.c
> > - Fix in PCIe ASPM to make it symmetric between pci_save_aspm_l1ss_stat=
e()
> >   and pci_restore_aspm_l1ss_state()
> >
> >  drivers/pci/pcie/aspm.c | 39 +++++++++++++++++++++++++++++++--------
> >  1 file changed, 31 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index bd0a8a05647e..823aaf813978 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -81,24 +81,47 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
> >
> >  void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> >  {
> > -     struct pci_cap_saved_state *save_state;
> > -     u16 l1ss =3D pdev->l1ss;
> > +     struct pci_cap_saved_state *pl_save_state, *cl_save_state;
> > +     struct pci_dev *parent;
> >       u32 *cap;
> >
> >       /*
> >        * Save L1 substate configuration. The ASPM L0s/L1 configuration
> >        * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
> >        */
> > -     if (!l1ss)
> > +     if (!pdev->l1ss)
> >               return;
> >
> > -     save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
> > -     if (!save_state)
> > +     cl_save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1S=
S);
> > +     if (!cl_save_state)
> >               return;
> >
> > -     cap =3D &save_state->cap.data[0];
> > -     pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
> > -     pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> > +     cap =3D &cl_save_state->cap.data[0];
> > +     pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
> > +     pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
> > +
> > +     /*
> > +      * If here is a parent device and it has not saved state, save pa=
rent's
> > +      * L1 substate configuration, too. This is symmetric on
> > +      * pci_restore_aspm_l1ss_state().
> > +      */
> > +     if (!pdev->bus || !pdev->bus->self)
> > +             return;
> > +
> > +     parent =3D pdev->bus->self;
> > +     if (!parent->l1ss)
> > +             return;
> > +
> > +     pl_save_state =3D pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L=
1SS);
> > +     if (!pl_save_state)
> > +             return;
> > +
> > +     if (parent->state_saved)
> > +             return;
>
> This decision can be made before even reading the pl_saved_state.
>
> > +
> > +     cap =3D &pl_save_state->cap.data[0];
> > +     pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, cap++=
);
> > +     pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, cap++=
);
>
> This approach duplicates code and that seems unnecessary to me.
>
> Could you instead leave the current function (nearly?) as is and use it a=
s
> a helper for a new pci_save_aspm_l1ss_state() which calls the helper firs=
t
> for the pdev and then for its parent (if needed). Or do I miss something
> why that is not possible?

I was thinking of invoking it recursively the first time. But, that
will go to parent's parent and so on ...
So, I flattened the code in pci_save_aspm_l1ss_state().

Having a helper doing what original pci_save_aspm_l1ss_state()'s work
sounds good!

Sent the v11 patch, including the modified commit message.

Jian-Hong Pan

