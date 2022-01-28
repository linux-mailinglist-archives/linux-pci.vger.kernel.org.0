Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433AF4A02E4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 22:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbiA1Vey (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 16:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiA1Vex (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 16:34:53 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39129C061714
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 13:34:53 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j16so7355502plx.4
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 13:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sy/Y8yEWHigDuQdOlOLkaoU18i+f7DaCjn+DCmpwyFI=;
        b=hHmYyqdR9Q2JZUHGSGzbIgw7t9UNRsSBkuwDJ7oJU1ZVMuuh9q4jSdXlYRSA94DjTr
         V7R7MKNh/igjsct2gL3Zz4mzs1JXx2SE1S34DTakruz/UO9vRM/Mq2zEY3oQOUAOs2e9
         bRTNzUmQfMlcWPrDx+wmUaQdVwdzHb8AKtf3Na5NqORiHpssCKgffjD7uMWNsDC88jxj
         zvYRWSooCK5VAGDOcoIwq4kDvd7skeQK9isV7CULeYCsenIm8ouoCSNj0lrxzJIIDcf4
         XazTpdNAFlZ3tnnGjqh2ztDvByAn0dGNYTyHAaLt1VLG4+3BPhC0W2pGxqKHMEbx/SRD
         WZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sy/Y8yEWHigDuQdOlOLkaoU18i+f7DaCjn+DCmpwyFI=;
        b=MfmvJvI94HT0Txjy8FOinxSinvioHYw9zxV7YZvZd4g8CKEdtK2OauEJmeGGWGpDsv
         KdCDxTkuFOZ3XP+UQWeunEawAG8HcWLcmNbfw+YV+67KK/XvnWw2BHMhvlkemghFLESs
         8BsWMs8LwsSwLiGuy+/SaH4LIemCOV1nyxpKl70QNblQpv5gbampVfQEhZeF/oqNn0Hw
         ZRGWUVyaf1UU7x0rZ4VAxdFXvl6/Rux3RHYqkDx/uX6+iBV2e+K06iPqB3Jv2plVjoxh
         +KUKkzOomts0r0ETyPTmmsdzNZCCENbDbGZwwP6Go9HkHHcr/ESCMFr09aaQKBOXdEY6
         gFSw==
X-Gm-Message-State: AOAM531IHgFN6ra/wLAF74PPCA+xqYSx2d2PCv4hpjqMcYUNraiv5alI
        OqBTOWifHgPJF1eAR815V40dmEsuZwL9uPE9C1GlIQ==
X-Google-Smtp-Source: ABdhPJwV3BKyuOcH+josgcsSnfOibgxLTtv/8nRGPI4s0kEVOgyMJ0vb3Sfq3qOJtImXOMdLHXVvRVouTbuj3d3aaZc=
X-Received: by 2002:a17:90a:f485:: with SMTP id bx5mr21803979pjb.46.1643405692450;
 Fri, 28 Jan 2022 13:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20220120000409.2706549-1-rajatja@google.com> <20220121214117.GA1154852@bhelgaas>
 <Ye5GvQbFKo+CFtRb@lahna> <Ye/X7E2dKb+zem34@lahna> <Ye/btvA1rLB2rp02@kroah.com>
 <Ye/zTHR5aCG58z87@lahna> <CAJZ5v0gitdeEAxcgSoB1=VHA9FnRdCtmUqA_cN_f1a2yFRDghQ@mail.gmail.com>
 <CACK8Z6H2DLTJgxgS3pcvfOh=5S8cxEMKvwEPfB9zoVf1g2H_UQ@mail.gmail.com> <YfOf2X7Snm7cvDRV@lahna>
In-Reply-To: <YfOf2X7Snm7cvDRV@lahna>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 28 Jan 2022 13:34:16 -0800
Message-ID: <CACK8Z6FMgc5UQY-ZGB9sKYR5Wt6L6huTnEKZaFyVRAmDmQt9XQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika, All,

On Thu, Jan 27, 2022 at 11:49 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Thu, Jan 27, 2022 at 02:26:07PM -0800, Rajat Jain wrote:
> > Hello Rafael, Bjorn, Mika, Dmitry, Greg,
> >
> > Thanks a lot for your comments.
> >
> > On Tue, Jan 25, 2022 at 6:45 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Jan 25, 2022 at 1:55 PM Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> > > >
> > > > On Tue, Jan 25, 2022 at 12:15:02PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Tue, Jan 25, 2022 at 12:58:52PM +0200, Mika Westerberg wrote:
> > > > > > On Mon, Jan 24, 2022 at 08:27:17AM +0200, Mika Westerberg wrote:
> > > > > > > > > This patch introduces a new "UntrustedDevice" property that can be used
> > > > > > > > > by the firmware to mark any device as untrusted.
> > > > > > >
> > > > > > > I think this new property should be documented somewhere too (also
> > > > > > > explain when to use it instead of ExternalFacingPort). If not in the
> > > > > > > next ACPI spec or some supplemental doc then perhaps in the DT bindings
> > > > > > > under Documentation/devicetree/bindings.
> > > > > >
> > > > > > Actually Microsoft has similar already:
> > > > > >
> > > > > > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> > > > > >
> > > > > > I think we should use that too here.
> >
> > But because this property also applies to a root port (only), it only
> > helps if the device is downstream a PCIe root port. In our case, we
> > have an internal (wifi) device 00:14.3 (sits on the internal PCI bus
> > 0), so cannot use this.
>
> Right. I wonder if we can expand it to cover all internal devices, not
> just PCIe root ports? We anyways need to support that property so does
> not make much sense to me to invent yet another that does pretty much
> the same thing.

I'm open to doing so if the others also feel the same way. IMHO
though, the semantics of ACPI "DmaProperty" differ from the semantics
of the property I'm proposing here.

The current (documented) semantics (of "DmaProperty"): *This device
(root port) is trusted*, but any devices downstream are not to be
trusted.

What I need and am proposing (new "UntrustedDevice"): *This device as
well as any downstream devices* are untrusted.

Note that there may be firmware implementing "DmaProperty" already out
there (for windows), and if we decide to use it for my purposes, then
there shall be a discrepancy in how Linux uses that property vs
Windows. Is that acceptable?

Thanks & Best Regards,

Rajat
