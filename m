Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCD94A36A7
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jan 2022 15:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354990AbiA3Oax (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jan 2022 09:30:53 -0500
Received: from mail-yb1-f180.google.com ([209.85.219.180]:41507 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354993AbiA3Oaw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jan 2022 09:30:52 -0500
Received: by mail-yb1-f180.google.com with SMTP id g14so32773239ybs.8;
        Sun, 30 Jan 2022 06:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaxK62DF2brZUuoILwZG6Sy3u6nklK5nRZA4Svlzegg=;
        b=G+6it9Z1wVGKPNcPzKLlYRCvuJ10vYgb+Qyv+JWPNvGi7LV47dNmnjQ+aFwoZmETnF
         wKqchiSaZqsakBdZuUVpEVGXrrtYgmLJe0nT9++DXV48NTJI1A2SEldhy3XuLSxLm4Zp
         NrkslOw3GiEz0riZ2u97PVpO6Un6cKRjJ3GaNeJjudBgD4S+LczaR9H88Kx9v9nkiV64
         ZChTsBPTKOSWFFvu4erCynTP0ePY9ZnC9M1MwynFXJRUvSBrD+WbLSU2jFfetQJ0DtvM
         ZlRbS+gelIsdVhGshpLV3nvrUU10NzKgaEalGZI1ZoZ4Cg49VnKsZODaXdnMNFhvpAr0
         X0AQ==
X-Gm-Message-State: AOAM532PIfeXIwcMbz7m7qBuarV8ardfXhp2eBPCzndozzrG2BLmvXLH
        +ttSBUhS25dNEsuwFGkWhhML7eeegi95TB6DSvU=
X-Google-Smtp-Source: ABdhPJzWR8xePVFxdG2RbvkLhEC1Xi6Vt9iaBmXP/b8POsGPpLJlCXtoumfEAl0n/L56OHWwuokGYMt2PiXRhc6fB7M=
X-Received: by 2002:a25:34c4:: with SMTP id b187mr24736922yba.78.1643553050777;
 Sun, 30 Jan 2022 06:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20220120000409.2706549-1-rajatja@google.com> <20220121214117.GA1154852@bhelgaas>
 <Ye5GvQbFKo+CFtRb@lahna> <Ye/X7E2dKb+zem34@lahna> <Ye/btvA1rLB2rp02@kroah.com>
 <Ye/zTHR5aCG58z87@lahna> <CAJZ5v0gitdeEAxcgSoB1=VHA9FnRdCtmUqA_cN_f1a2yFRDghQ@mail.gmail.com>
 <CACK8Z6H2DLTJgxgS3pcvfOh=5S8cxEMKvwEPfB9zoVf1g2H_UQ@mail.gmail.com>
 <YfOf2X7Snm7cvDRV@lahna> <CACK8Z6FMgc5UQY-ZGB9sKYR5Wt6L6huTnEKZaFyVRAmDmQt9XQ@mail.gmail.com>
In-Reply-To: <CACK8Z6FMgc5UQY-ZGB9sKYR5Wt6L6huTnEKZaFyVRAmDmQt9XQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 30 Jan 2022 15:30:39 +0100
Message-ID: <CAJZ5v0iuM_qjhPxvhzgvtKM-4pBB2skf9G=R=Qo6NzKnZ2LN=w@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
To:     Rajat Jain <rajatja@google.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Fri, Jan 28, 2022 at 10:34 PM Rajat Jain <rajatja@google.com> wrote:
>
> Hi Mika, All,
>
> On Thu, Jan 27, 2022 at 11:49 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Thu, Jan 27, 2022 at 02:26:07PM -0800, Rajat Jain wrote:
> > > Hello Rafael, Bjorn, Mika, Dmitry, Greg,
> > >
> > > Thanks a lot for your comments.
> > >
> > > On Tue, Jan 25, 2022 at 6:45 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Tue, Jan 25, 2022 at 1:55 PM Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > > > >
> > > > > On Tue, Jan 25, 2022 at 12:15:02PM +0100, Greg Kroah-Hartman wrote:
> > > > > > On Tue, Jan 25, 2022 at 12:58:52PM +0200, Mika Westerberg wrote:
> > > > > > > On Mon, Jan 24, 2022 at 08:27:17AM +0200, Mika Westerberg wrote:
> > > > > > > > > > This patch introduces a new "UntrustedDevice" property that can be used
> > > > > > > > > > by the firmware to mark any device as untrusted.
> > > > > > > >
> > > > > > > > I think this new property should be documented somewhere too (also
> > > > > > > > explain when to use it instead of ExternalFacingPort). If not in the
> > > > > > > > next ACPI spec or some supplemental doc then perhaps in the DT bindings
> > > > > > > > under Documentation/devicetree/bindings.
> > > > > > >
> > > > > > > Actually Microsoft has similar already:
> > > > > > >
> > > > > > > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> > > > > > >
> > > > > > > I think we should use that too here.
> > >
> > > But because this property also applies to a root port (only), it only
> > > helps if the device is downstream a PCIe root port. In our case, we
> > > have an internal (wifi) device 00:14.3 (sits on the internal PCI bus
> > > 0), so cannot use this.
> >
> > Right. I wonder if we can expand it to cover all internal devices, not
> > just PCIe root ports? We anyways need to support that property so does
> > not make much sense to me to invent yet another that does pretty much
> > the same thing.
>
> I'm open to doing so if the others also feel the same way. IMHO
> though, the semantics of ACPI "DmaProperty" differ from the semantics
> of the property I'm proposing here.
>
> The current (documented) semantics (of "DmaProperty"): *This device
> (root port) is trusted*, but any devices downstream are not to be
> trusted.
>
> What I need and am proposing (new "UntrustedDevice"): *This device as
> well as any downstream devices* are untrusted.
>
> Note that there may be firmware implementing "DmaProperty" already out
> there (for windows), and if we decide to use it for my purposes, then
> there shall be a discrepancy in how Linux uses that property vs
> Windows. Is that acceptable?

It may be confusing, so I'd rather not do that.

The platform firmware will use it with the Windows use case in mind
and if it has side effects in Linux, problems are likely to appear in
the field.

So the question is rather not about it being acceptable, but about
whether or not this is generally going to work.
