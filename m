Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4771C41BBAC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhI2AXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:23:21 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:36556 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbhI2AXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:23:20 -0400
Received: by mail-lf1-f54.google.com with SMTP id b20so3374243lfv.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 17:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CqUNWmcivn0lftYNEYzbLY1cZb4U9btRsNzP8dQXXzU=;
        b=mcKpkQGIV6NkQFSLsCqw5ZbNEvRfbOlZWMrFAM4Q9iAMraHQZ7JY5jxrq0jffxK1v/
         8r8ojvarej7u2vDtRdMrH+IQpWfEZMZXlWWziUqjCB1apfD0L5RKS6U6BOu3DhicJC1/
         LVP5sTCw5R9wSPQiSNXOAxx/X5/eB3SY4XpX5e+ubX34pasmN/HN+HBRCj7wIPz8fy5J
         WsQH863z6ju1sbyXX2LDZOCtEAK959yZqwMx26ngtJWk8sKr1CI9YJwLup/1n/Pd0f62
         XBbmvpG8E2UXCLo//TDuyx+6EHQGC/wyodiqo2+8TAxKlq7CKgDGs7uCa8bbBLfVNWHc
         3zfg==
X-Gm-Message-State: AOAM531zEhi51M3aQEaktZvMpLyxGjqfZEtmDnCAwvVDy9tO7OXse/mi
        MRiHplbQexBPxK6nT+vr0jabSx638+be9g==
X-Google-Smtp-Source: ABdhPJy5J2uIt6lyMbACGeQjrXHJUIYx64UKIo1Bn5Sy5cvP0zuTIO+P0WFAU5OC3GZEkP3Xs7gJvQ==
X-Received: by 2002:a19:6512:: with SMTP id z18mr8644138lfb.106.1632874899437;
        Tue, 28 Sep 2021 17:21:39 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q1sm51491lfg.18.2021.09.28.17.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:21:38 -0700 (PDT)
Date:   Wed, 29 Sep 2021 02:21:37 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     David Jaundrew <david@jaundrew.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
 Coprocessor
Message-ID: <YVOxkeJt6Rw10e+w@rocinante>
References: <20210928214558.GA736874@bhelgaas>
 <9e85bcad-a73c-cccd-4522-a45e599309d7@jaundrew.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e85bcad-a73c-cccd-4522-a45e599309d7@jaundrew.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi David,

Just a note: it might have been better to sent this as v2, but given how
small this patch is, albeit Bjorn might be fine with taking it as-is.

> This patch fixes another FLR bug for the Starship/Matisse controller:
> 
> AMD Starship/Matisse Cryptogrpahic Coprocessor PSPCPP
> 
> This patch allows functions on the same Starship/Matisse device (such as
> USB controller,sound card) to properly pass through to a guest OS using
> vfio-pc. Without this patch, the virtual machine does not boot and
> eventually times out.
> 
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

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
