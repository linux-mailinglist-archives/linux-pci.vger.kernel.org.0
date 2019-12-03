Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04924110548
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 20:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfLCTg1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 14:36:27 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:42264 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLCTg1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2019 14:36:27 -0500
Received: by mail-io1-f44.google.com with SMTP id f82so5080787ioa.9
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2019 11:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbCm+sboO//ec+9mJyUZQfBjgbVhZp2u3dmOtW+Tw+c=;
        b=thVNI2dYbYLDW7LST1GvzlBiAIZzDGO78uzN5JdQEO7M2lDOMNOZANxdYW/Y7S1E6z
         AcwyTekhqytphND8+4zCsLKXRktkres1MuM7s1pYrPxWFAnFY1Tp2Wd8xvzwZX4PBfcn
         Tm+WvtYdvApcHjn6toWDudMHLN9YunqMDWB67jvfly7Y6o47uSik+1Jg3cl20RL4da7P
         WT0pEGwL7R5GvTy4QRe9JCbM2ia3Ljd68N4ly17rWbUsvkBsNs6r3AMCu/Io//k/PPtF
         ILNKPshiXXSd4xHgkaSDLBCJ3xCGvHOJlmYSftmXic4Lvhqhc9cp1iPk6kJlcGCelnxr
         vF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbCm+sboO//ec+9mJyUZQfBjgbVhZp2u3dmOtW+Tw+c=;
        b=sgT5E/a3cHQDjJZf2dklOoEsPf759J/InHkjX/h6M64x9cdWHyDDXDBMZJCWLt3MD6
         L9dExQDdYVK8YTaUrrV/UftDQitUr3WNhA1GfGYpMxMxoAe20ZcStNo229128QLJjVgE
         x9Q9203HLtk5UpSYDWRkUNP9OzQycNVEpHKqKSgAdsNNJFN1Z8ucKRUSPgC0TQa9m7Gu
         1odUE+Y2tQWnUpkqCiTu0XMBnuWXubK8xWUqf5ddOu4EXukphTp2DEQ4fsA52XOA5UGv
         Lxo/i1tCmei1tE3il30k1KWtbYoxUf83h52VVmH6KF/UhvIk2mMPzqOEVoENxQM/pkSD
         FCRA==
X-Gm-Message-State: APjAAAV6CFInRFLFWFPEYd++7wRAeoOGstTd2oryT1AcCgUZTdf/OeJk
        dii9tAQkBP3WtUD0lFbGSK6+dQvFtVuP16N3T4kwZQ==
X-Google-Smtp-Source: APXvYqwXTemaEQu0/mYQjJ1bcWTg9q8UAwit2frvVQwe/2qP7ctCZJKto+d/csaEagHBKXglAWZRppbsdsVOSBecxrw=
X-Received: by 2002:a05:6602:187:: with SMTP id m7mr3775316ioo.16.1575401786293;
 Tue, 03 Dec 2019 11:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CACdnJus7nHdr4p4H1j5as9eB=FG-uX+wy_tjvTQ5ObErDJHdow@mail.gmail.com>
 <CAKv+Gu8emrf7WbTyGc8QDykX_hZbrVtxJKkRVbGFhd8rd13yww@mail.gmail.com> <9c58f2d2-5712-0972-6ea7-092500f37cf9@redhat.com>
In-Reply-To: <9c58f2d2-5712-0972-6ea7-092500f37cf9@redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 3 Dec 2019 11:36:14 -0800
Message-ID: <CACdnJutpgeUsGcscVJsxsj5-E=0JwYUFqEfjT4VJ+BMjn2RpAQ@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 3, 2019 at 5:38 AM Laszlo Ersek <lersek@redhat.com> wrote:

> (2) I'm not 100% convinced this threat model -- I hope I'm using the
> right term -- is useful. A PCI device will likely not "itself" set up
> DMA (maliciously or not) without a matching driver.

A malicious PCI device can absolutely set up DMA itself without a
matching driver. There's a couple of cases:

1) A device that's entirely under the control of an attacker. Using
external Thunderbolt devices to overwrite OS data has been
demonstrated on multiple occasions.

2) A device that's been compromised in some way. The UEFI driver is a
long way from the only software that's related to the device -
discrete GPUs boot themselves even in the absence of a driver, and if
that on-board code can be compromised in any persistent way then they
can be used to attack the OS.

> Is this a scenario where we trust the device driver that comes from the
> device's ROM BAR (let's say after the driver passes Secure Boot
> verification and after we measure it into the TPM), but don't trust the
> silicon jammed in the motherboard that presents the driver?

Yes, though it's not just internal devices that we need to worry about.

> (3) I never understood why the default behavior (or rather, "only"
> behavior) for system firmware wrt. the IOMMU at EBS was "whitelist
> everything". Why not "blacklist everything"?
>
> I understand the compat perspective, but the OS should at least be able
> to request such a full blackout through OsIndications or whatever. (With
> the SEV IOMMU driver in OVMF, that's what we do -- we set everything to
> encrypted.)

I'm working on that, but it would be nice to have an approach for
existing systems.
