Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B0F41BC81
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 03:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbhI2CAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 22:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243661AbhI2CAp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 22:00:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E1C261361;
        Wed, 29 Sep 2021 01:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632880744;
        bh=39iXj9HYLf1temi98LhI3C8d143z6muNxJQixXw0/jM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VP/waAwBCQP0dG1N8eqyl72WEXPIwRYd1VGQloeIhe4vkCFn/1/hY+yP4p6/b7NYN
         9kr73cl+4sgTWXTJvMAjUtQMzdd41n/zZrTga/+UhFhROoVitHHByRsWjpeKc1bZXv
         KZ2uu/9g7BhFUNVPAoW7+cyIRhdK5R2+s4Z9lJ5JRclLxGwiK1AJ7CCeExZUH4ZT3Q
         IiTjjklg6b1LUFebF/Xdr3diPi5gecOeNAdHlVFkrctvGRXckUH2iKhA5LtzDWFMQn
         fc9nu0RRZE3t9YCZInNsM0zBOykl9wZYjHmmOjp+UK/Y0gXP7mMqtnsr2/22fCgNS6
         zyln7oZsDhBMg==
Date:   Tue, 28 Sep 2021 20:59:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Jaundrew <david@jaundrew.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
 Coprocessor
Message-ID: <20210929015902.GA753214@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e85bcad-a73c-cccd-4522-a45e599309d7@jaundrew.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, Krzysztof, AMD folks]

On Tue, Sep 28, 2021 at 05:16:49PM -0700, David Jaundrew wrote:
> This patch fixes another FLR bug for the Starship/Matisse controller:
> 
> AMD Starship/Matisse Cryptogrpahic Coprocessor PSPCPP
> 
> This patch allows functions on the same Starship/Matisse device (such as
> USB controller,sound card) to properly pass through to a guest OS using
> vfio-pc. Without this patch, the virtual machine does not boot and
> eventually times out.

Apparently yet another AMD device that advertises FLR support, but it
doesn't work?

I don't have a problem avoiding the FLR, but I *would* like some
indication that:

  - This is a known erratum and AMD has some plan to fix this in
    future devices so we don't have to trip over them all
    individually, and

  - This is not a security issue.  Part of the reason VFIO resets
    pass-through devices is to avoid leaking state from one guest to
    another.  If reset doesn't work, that makes me wonder, especially
    since this is a cryptographic coprocessor that sounds like it
    might be full of secrets.  So I *assume* VFIO will use a different
    type of reset instead of FLR, but I'm just double-checking.

> Excerpt from lspci -nn showing crypto function on same device as USB and
> sound card (which are already listed in quirks.c):
> 
> 0e:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD]
>   Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
> 0e:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD]
>   Matisse USB 3.0 Host Controller [1022:149c]
> 0e:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD]
>   Starship/Matisse HD Audio Controller [1022:1487]
> 
> Fix tested successfully on an Asus ROG STRIX X570-E GAMING motherboard
> with AMD Ryzen 9 3900X.
> 
> Signed-off-by: David Jaundrew <david@jaundrew.com>

The patch below still doesn't apply.  Looks like maybe it was pasted
into the email and the tabs got changed to space?  No worries, I can
apply it manually if appropriate.

> ---
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6d74386eadc2..0d19e7aa219a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5208,6 +5208,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>  /*
>   * FLR may cause the following to devices to hang:
>   *
> + * AMD Starship/Matisse Cryptographic Coprocessor PSPCPP 0x1486
>   * AMD Starship/Matisse HD Audio Controller 0x1487
>   * AMD Starship USB 3.0 Host Controller 0x148c
>   * AMD Matisse USB 3.0 Host Controller 0x149c
> @@ -5219,6 +5220,7 @@ static void quirk_no_flr(struct pci_dev *dev)
>  {
>         dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
>  }
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1486, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
> 
