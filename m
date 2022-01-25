Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E622749B6D9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 15:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388759AbiAYOuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 09:50:23 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:38739 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389262AbiAYOpa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 09:45:30 -0500
Received: by mail-yb1-f182.google.com with SMTP id i62so16004076ybg.5;
        Tue, 25 Jan 2022 06:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2baAB3uSLjYkpNcq5GaJvhhWWvmQdMQHFWAgaLKDTts=;
        b=OU7b01teOvLz6JMewIKe1XyupgILMDCitWHq0ZjsmbwwQSjobjeEtYofDCY/F4A4SX
         vHuF4CPknMAVUq1yyM0/5W4KmwFIhJPQAfNqFYfIp4LUbeYa00xSL2Au5kF5dPj72Vmr
         KX2kxnkLZSW4W7YnwA1r1GvN5eSEsa33s0wPep0x2Eh6W7Il10yR5bmgOd8zWBS/E3uo
         yFS2PHvIJJwcSMSMhP9kGRqBVYHJo/e7oN+9PiHEUjmNKdN7rDANLg+0sDzITjCMDwf0
         oTs/XcbHp22W2cjOtyS1CJ8d1caC4drReM0R5K+FyCbqslShQk6E9DKvEtgqkvpgUq7P
         ccXA==
X-Gm-Message-State: AOAM530e9fmZtAri3XrFpIPReg6c1XfKFIiZ4h4V4m66Rw8hNt0m+Hln
        lWUPJwhpua4hXkRwZAju5sPZMrXGtIipdo/KNvw=
X-Google-Smtp-Source: ABdhPJx9vrSpRJkKKf5kIzoUtq+zl70oDT8vSjH+qIonUx7kia+AgMNLIDN7W62c+iGhkScPGLk/xCU2bBrTF5JrbN0=
X-Received: by 2002:a5b:58d:: with SMTP id l13mr30663076ybp.475.1643121916245;
 Tue, 25 Jan 2022 06:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20220120000409.2706549-1-rajatja@google.com> <20220121214117.GA1154852@bhelgaas>
 <Ye5GvQbFKo+CFtRb@lahna> <Ye/X7E2dKb+zem34@lahna> <Ye/btvA1rLB2rp02@kroah.com>
 <Ye/zTHR5aCG58z87@lahna>
In-Reply-To: <Ye/zTHR5aCG58z87@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jan 2022 15:45:03 +0100
Message-ID: <CAJZ5v0gitdeEAxcgSoB1=VHA9FnRdCtmUqA_cN_f1a2yFRDghQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Tue, Jan 25, 2022 at 1:55 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Jan 25, 2022 at 12:15:02PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 25, 2022 at 12:58:52PM +0200, Mika Westerberg wrote:
> > > On Mon, Jan 24, 2022 at 08:27:17AM +0200, Mika Westerberg wrote:
> > > > > > This patch introduces a new "UntrustedDevice" property that can be used
> > > > > > by the firmware to mark any device as untrusted.
> > > >
> > > > I think this new property should be documented somewhere too (also
> > > > explain when to use it instead of ExternalFacingPort). If not in the
> > > > next ACPI spec or some supplemental doc then perhaps in the DT bindings
> > > > under Documentation/devicetree/bindings.
> > >
> > > Actually Microsoft has similar already:
> > >
> > > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> > >
> > > I think we should use that too here.
> >
> > But we do not have "dma protection" for Linux, so how will that value
> > make sense?
>
> Yes I think we do - IOMMU. That's the same thing what we do now for
> "External Facing Ports". This one just is for internal ones.
>
> > And shouldn't this be an ACPI standard?
>
> Probably should or some supplemental doc but not sure how easy these
> "properties" can be added there to be honest.
>
> Some of these that we use in Linux too are from that same page:
>
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
>
> Namely these: HotPlugSupportInD3, ExternalFacingPort, usb4-host-interface,
> usb4-port-number and StorageD3Enable.

Right.

We are kind of on the receiving end here, because at the time we learn
about these things the decisions to use them have been made already.
