Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5066141CBC8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 20:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbhI2S2C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 14:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244341AbhI2S2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 14:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632939980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sq7Ohnv+IKXYY6cC32iPCXTKEDXsw7nc5qr6oiYX8jM=;
        b=Rh4iXFDdVHxXMTpNjxtNm716hRapFC0/wuxp1PyXZD+WzxvhrJBu9CZyD4jTHv29aQqUAI
        /c6JyQDmlN4eD2eCunhvESBQpE7EbqAM3Wt7R3FZ5p2K3bKIaYLEECYCyoNLK7u9Zzn+iW
        PMd8tuHMrfEp8MPwwM6XGz3LIb+rxlg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-V5qBXNzwNSqeWA-pjNGGIg-1; Wed, 29 Sep 2021 14:26:16 -0400
X-MC-Unique: V5qBXNzwNSqeWA-pjNGGIg-1
Received: by mail-oo1-f72.google.com with SMTP id v11-20020a4a314b000000b002a9d9728566so2828361oog.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 11:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sq7Ohnv+IKXYY6cC32iPCXTKEDXsw7nc5qr6oiYX8jM=;
        b=TW2zwk3RxqtMM1NS4fxYyTnPkN/xUEyi4Xg1wBjm7MHF0Whe1iyLe9TMWYIr1B3tbC
         SzMO9YtazRFAafecfxzG8rbKjAN9msMWDJBwLc0IoZGtA7NjfoRW/rAmQuQLqCScoSsV
         eX25mGXkAJ779pgUyqIkD1H9umu5JyBsqz58nPFoVYDHV48c7FbKgryqNW6WalG+tM0C
         FLgnmjW0vNeiWvf2EYBM4HI5aHXgflovn1Voe6BbDnJynasMGcJBqVmrnq7R+Uhsn6K7
         sAHnYT5eDxvzE8jo+s3aX//EA4pKNLrPynJYsdiRVX2yAEb6hIYbvVecxkANbE96/mBB
         nb+g==
X-Gm-Message-State: AOAM532UPe7aSFN4BDexdXC1h5CpV6tzLrInC20uRYsRaM1Jiw/YrwD0
        pMn07vv5gTTCJwPkg/uYUthANyM8YTLcZHZuaJRhkjWOY+jktdqSy8FXQXq0ikoxRHugJcM03YA
        J8RMJrBmy5V+i4/raaQoG
X-Received: by 2002:a05:6830:2784:: with SMTP id x4mr1309035otu.86.1632939973845;
        Wed, 29 Sep 2021 11:26:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzprPtCmWMix9RykwT8E3QEgfJRUsuWQMmktELnRvt3PsYvbQPfqM3dxdz9JHF2p5EARKVatA==
X-Received: by 2002:a05:6830:2784:: with SMTP id x4mr1309015otu.86.1632939973552;
        Wed, 29 Sep 2021 11:26:13 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id f10sm119666ooh.42.2021.09.29.11.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:26:13 -0700 (PDT)
Date:   Wed, 29 Sep 2021 12:26:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Jaundrew <david@jaundrew.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Subject: Re: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
 Coprocessor
Message-ID: <20210929122612.02e54434.alex.williamson@redhat.com>
In-Reply-To: <20210929015902.GA753214@bhelgaas>
References: <9e85bcad-a73c-cccd-4522-a45e599309d7@jaundrew.com>
 <20210929015902.GA753214@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 28 Sep 2021 20:59:02 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex, Krzysztof, AMD folks]
>=20
> On Tue, Sep 28, 2021 at 05:16:49PM -0700, David Jaundrew wrote:
> > This patch fixes another FLR bug for the Starship/Matisse controller:
> >=20
> > AMD Starship/Matisse Cryptogrpahic Coprocessor PSPCPP
> >=20
> > This patch allows functions on the same Starship/Matisse device (such as
> > USB controller,sound card) to properly pass through to a guest OS using
> > vfio-pc. Without this patch, the virtual machine does not boot and
> > eventually times out. =20
>=20
> Apparently yet another AMD device that advertises FLR support, but it
> doesn't work?
>=20
> I don't have a problem avoiding the FLR, but I *would* like some
> indication that:
>=20
>   - This is a known erratum and AMD has some plan to fix this in
>     future devices so we don't have to trip over them all
>     individually, and
>=20
>   - This is not a security issue.  Part of the reason VFIO resets
>     pass-through devices is to avoid leaking state from one guest to
>     another.  If reset doesn't work, that makes me wonder, especially
>     since this is a cryptographic coprocessor that sounds like it
>     might be full of secrets.  So I *assume* VFIO will use a different
>     type of reset instead of FLR, but I'm just double-checking.

It depends on what's available, chances are not good that we have
another means of function level reset, so this probably means it's
exposed as-is.  I agree, not great for a device managing something to
do with cryptography.  It's potentially a better security measure to
let the device wedge itself.  Thanks,

Alex
=20
> > Excerpt from lspci -nn showing crypto function on same device as USB and
> > sound card (which are already listed in quirks.c):
> >=20
> > 0e:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD]
> > =C2=A0 Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
> > 0e:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD]
> > =C2=A0 Matisse USB 3.0 Host Controller [1022:149c]
> > 0e:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD]
> > =C2=A0 Starship/Matisse HD Audio Controller [1022:1487]
> >=20
> > Fix tested successfully on an Asus ROG STRIX X570-E GAMING motherboard
> > with AMD Ryzen 9 3900X.
> >=20
> > Signed-off-by: David Jaundrew <david@jaundrew.com> =20
>=20
> The patch below still doesn't apply.  Looks like maybe it was pasted
> into the email and the tabs got changed to space?  No worries, I can
> apply it manually if appropriate.
>=20
> > ---
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 6d74386eadc2..0d19e7aa219a 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5208,6 +5208,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x44=
3, quirk_intel_qat_vf_cap);
> > =C2=A0/*
> > =C2=A0 * FLR may cause the following to devices to hang:
> > =C2=A0 *
> > + * AMD Starship/Matisse Cryptographic Coprocessor PSPCPP 0x1486
> > =C2=A0 * AMD Starship/Matisse HD Audio Controller 0x1487
> > =C2=A0 * AMD Starship USB 3.0 Host Controller 0x148c
> > =C2=A0 * AMD Matisse USB 3.0 Host Controller 0x149c
> > @@ -5219,6 +5220,7 @@ static void quirk_no_flr(struct pci_dev *dev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->dev_flags |=3D PCI_DEV_=
FLAGS_NO_FLR_RESET;
> > =C2=A0}
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1486, quirk_no_flr);
> > =C2=A0DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> > =C2=A0DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
> > =C2=A0DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
> >  =20
>=20

