Return-Path: <linux-pci+bounces-30488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D92AE6258
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 12:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0AC7A6752
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC23017A2E8;
	Tue, 24 Jun 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/bwkwj6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833B223704
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760680; cv=none; b=G+VCVTcXGoUus4F0RwdV/BhLx+TtymvhF6QDRni6G7QJm/BnGjQMNRVt57rAJYsDRUCAIPqiac8Esw0F9XJPcrD/HzxVot6UK5EzyRSUV4JFfO4zskfgo3UAGEINOqNR/JpKunOTk2zV4ehX1lj9UpfdJOs3rKZDHgFhtNiENOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760680; c=relaxed/simple;
	bh=uYzyf6u9g+2u/fc8pntUhfnHbD/oh8PxsiC6jUobfTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxVX4YRWzrFUxSzcEjeHl1Gns58ciLVhr02OONeoF4A9vPHem/3UEhMRSB6TR7D8S8EHX4T/AJb4qCl+uamedsRRpWFfj5TJKTsD6VepBJRrXCFj8N9QV/vFvtio3sAUpRTZ1SljKxq7WlZyZa349OsRkPh3kDlwbLd9zWLQnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/bwkwj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A07C4CEEE
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 10:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750760680;
	bh=uYzyf6u9g+2u/fc8pntUhfnHbD/oh8PxsiC6jUobfTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S/bwkwj610QgVPiFglc3L9QvjGfYyec6eFLT38C1+yEwNDLUhh3d/uPBkWfuAeBdq
	 zLMF6wuZb6e4k6GqX4AACwAI9kxXo8dGPAsRM27yygweokeX53zotPGS0vwZIqtVOA
	 k1ufErth+neo/ZlnhjchoxgnmUb1as35yOWzFnhkDhNtn3ArMqtc+NddX+M5faeTUe
	 uygHmZhEnJoyRUqESydXvfdsYXP0sTFn5/kF6zowbrfPH/Jkxo0q5h8ytZvjQL/F6T
	 5uezbWWwD2+hJDNAr/59C7vcYPpgGXlMNq/ICcbH8Pjdc3HduDY2CpYkgxUZZqOzuU
	 O7q+A2uCjA81w==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-610cbca60cdso3274087eaf.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 03:24:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6vapxDs7cGDQm26VwCcZzoUuA9DdvlAY7h+klicBAQBwL4+qhbj6uWDebuDas3MK68qDcXpdcKOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYaJBGmPeS4rVH8Bas3Y6POdulZsGXvb/fFwrfTwhq3i+L1K2P
	p2HNWvo/RSj7ZknKOV92dHtZaS3Tb0rMAeaSNgGxNAFF6KuptMmbQnmnKxo1vXJzYoyyvhBQdHO
	VNz9sBh8TrbYpVrpGPvSKfZgacsuT2ps=
X-Google-Smtp-Source: AGHT+IGBT9k+TTOyyslhUBoU2cbFUtZZVKloVThhp8jVHVIR+hq7givNCG+VWnR/t2KgMEmSPBClk4j/MEpZ7PZKXkU=
X-Received: by 2002:a05:6820:1b08:b0:611:7ebe:c6b1 with SMTP id
 006d021491bc7-6117ebec863mr5998287eaf.3.1750760679290; Tue, 24 Jun 2025
 03:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623191335.3780832-1-superm1@kernel.org> <aFpSTT_UHakY91_q@wunner.de>
In-Reply-To: <aFpSTT_UHakY91_q@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Jun 2025 12:24:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gjCdpARy5NzCZ71xb_M0-LU0110F_eGaPZsuCHGWWARg@mail.gmail.com>
X-Gm-Features: AX0GCFuBXVGBCbgwPBkqyRT7k1BHSGzrhAxKsWI23-Aij71A-7McNew7J_yJ3Tg
Message-ID: <CAJZ5v0gjCdpARy5NzCZ71xb_M0-LU0110F_eGaPZsuCHGWWARg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI/PM: Skip resuming to D0 if disconnected
To: Lukas Wunner <lukas@wunner.de>, Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 9:22=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> [cc +=3D Rafael, Mika]
>
> On Mon, Jun 23, 2025 at 02:13:34PM -0500, Mario Limonciello wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > When a USB4 dock is unplugged the PCIe bridge it's connected to will
> > issue a "Link Down" and "Card not detected event". The PCI core will
> > treat this as a surprise hotplug event and unconfigure all downstream
> > devices. This involves setting the device error state to
> > `pci_channel_io_perm_failure` which pci_dev_is_disconnected() will chec=
k.
> >
> > It doesn't make sense to runtime resume disconnected devices to D0 and
> > report the (expected) error, so bail early.
> >
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>
> > ---
> > v4:
> >  * no info message
> > v3:
> >  * Adjust text and subject
> >  * Add an info message instead
> > v2:
> >  * Use pci_dev_is_disconnected()
> > v1: https://lore.kernel.org/linux-usb/20250609020223.269407-1-superm1@k=
ernel.org/T/#mf95c947990d016fbfccfd11afe60b8ae08aafa0b
> > ---
> >  drivers/pci/pci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 9e42090fb1089..160a9a482c732 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
> >               return -EIO;
> >       }
> >
> > +     if (pci_dev_is_disconnected(dev)) {
> > +             dev->current_state =3D PCI_D3cold;

Why not PCI_UNKNOWN?

> > +             return -EIO;
> > +     }
> > +
> >       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >       if (PCI_POSSIBLE_ERROR(pmcsr)) {
> >               pci_err(dev, "Unable to change power state from %s to D0,=
 device inaccessible\n",
> > --
> > 2.43.0

