Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FB049EE0C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 23:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiA0W0p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 17:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiA0W0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 17:26:45 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156DCC061714
        for <linux-pci@vger.kernel.org>; Thu, 27 Jan 2022 14:26:45 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id w8so3965611qkw.8
        for <linux-pci@vger.kernel.org>; Thu, 27 Jan 2022 14:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFJYwHho4FfiR59k7zwtTLakJoJ7lquDQcT100wA/fo=;
        b=rpfrv8BDIFTyw0uXk3zhjbYHebBePgDawS9sfK5yt/3wAcmbth4KY/h1zZYsTsLmfN
         fgtl4SHqwhNnU1VpfET/gxU+KeCIQuY2bY5tL049r02z/HXrI9EVe8pEkqCaOH7+l5iP
         MYM+4Ja/dB8RlQxMxP38UuFeP/X7Crbu69hVCO8cZExf21rOYU9+cdei7iXGuvusrtum
         629IrQY7wICIsgR94zbqAfNcOYwhKLk2SiOWNK6dOdtXsFIyz1nRbN322w3uSxtkSFsd
         AZHE+HjNKiIvU3wrfthwQ3i2Vtr4Rt93scHtFCDroNqbQvLrAzI9XLMuhIo2xo0ZGpo6
         DTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFJYwHho4FfiR59k7zwtTLakJoJ7lquDQcT100wA/fo=;
        b=jMnak/zxT+1HZv5ezHuqN0Fzf8gmVcvmV9Ok2U5boR6WyySl4oFRLPtm10ya3sciqu
         cWxVFSXsPeWe9hzosbVu18ONWoBGRzGIidEz2/oh2P1mqXZOk99gpCkPvK9+qVkCGH9O
         tykYgoedfdrMIf3WhYUjdRqxfl3u0itcExEjwTR7ok7a9QzJYKmnjfI5Pzm2axagv/2v
         RPu6OqgGKfiF/iVK8c8Y8qow/owDqi68kPLA/4+1/uhc/HnlLntJvgomXrnYpd7C60NK
         z5bft6PeRCOQj8kjjx/SgUXHEDIAOPhJPzz7wtYGeKFWPfQfLlfahU8o693hrKIc/bZh
         25eA==
X-Gm-Message-State: AOAM533bop3QptXuFru1KsXT42Z4q1YM5Q4e1PJlN/8CX7bs0iLwM8hC
        gXFPn0lqyGsjpdiMPuoIzCOcp/A4rKN39z2ww0DPzg==
X-Google-Smtp-Source: ABdhPJw5njHZn9FdtZ7mxK8u3dwjXowY9Gof5xx3mkPvo9kuP+l1BjCpbeMiOIXIS+bJzJ/qZ3NllMmkXJSqHlH+YyA=
X-Received: by 2002:a05:620a:103c:: with SMTP id a28mr4056658qkk.413.1643322403889;
 Thu, 27 Jan 2022 14:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20220120000409.2706549-1-rajatja@google.com> <20220121214117.GA1154852@bhelgaas>
 <Ye5GvQbFKo+CFtRb@lahna> <Ye/X7E2dKb+zem34@lahna> <Ye/btvA1rLB2rp02@kroah.com>
 <Ye/zTHR5aCG58z87@lahna> <CAJZ5v0gitdeEAxcgSoB1=VHA9FnRdCtmUqA_cN_f1a2yFRDghQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gitdeEAxcgSoB1=VHA9FnRdCtmUqA_cN_f1a2yFRDghQ@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 27 Jan 2022 14:26:07 -0800
Message-ID: <CACK8Z6H2DLTJgxgS3pcvfOh=5S8cxEMKvwEPfB9zoVf1g2H_UQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
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

Hello Rafael, Bjorn, Mika, Dmitry, Greg,

Thanks a lot for your comments.

On Tue, Jan 25, 2022 at 6:45 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jan 25, 2022 at 1:55 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Tue, Jan 25, 2022 at 12:15:02PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 25, 2022 at 12:58:52PM +0200, Mika Westerberg wrote:
> > > > On Mon, Jan 24, 2022 at 08:27:17AM +0200, Mika Westerberg wrote:
> > > > > > > This patch introduces a new "UntrustedDevice" property that can be used
> > > > > > > by the firmware to mark any device as untrusted.
> > > > >
> > > > > I think this new property should be documented somewhere too (also
> > > > > explain when to use it instead of ExternalFacingPort). If not in the
> > > > > next ACPI spec or some supplemental doc then perhaps in the DT bindings
> > > > > under Documentation/devicetree/bindings.
> > > >
> > > > Actually Microsoft has similar already:
> > > >
> > > > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> > > >
> > > > I think we should use that too here.

But because this property also applies to a root port (only), it only
helps if the device is downstream a PCIe root port. In our case, we
have an internal (wifi) device 00:14.3 (sits on the internal PCI bus
0), so cannot use this.

> > >
> > > But we do not have "dma protection" for Linux, so how will that value
> > > make sense?
> >
> > Yes I think we do - IOMMU. That's the same thing what we do now for
> > "External Facing Ports". This one just is for internal ones.
> >
> > > And shouldn't this be an ACPI standard?
> >
> > Probably should or some supplemental doc but not sure how easy these
> > "properties" can be added there to be honest.

AIUI, the principal comment I have received here is that this property
needs to be documented somewhere. I agree.

Rafael, do you know if this new property can be added to the ACPI
spec, and if so, how to do so? I'm happy to initiate a process if
someone can point me to, I just hope that publishing a new property to
the ACPI does not have to block this patch.

The other option I was thinking of was to use the same property name
(say "untrusted-device") for both ACPI and device tree platforms, and
document it in Documentation/devicetree/bindings/pci/pci.txt along
with others. Since there are other properties there that seem to be
used similarly (Mika highlighted some below), perhaps that is an
acceptable solution?

I had one last question on the property name itself. I was trying to
understand why a property might have 2 names i.e. "external-facing"
for DT and "ExternalFacingPort" in ACPI? Are there any naming
convention requirements that require ACPI and DT property names to be
different? Is "untrusted-device" an acceptable ACPI property name?

Thanks & Best Regards,

Rajat

> >
> > Some of these that we use in Linux too are from that same page:
> >
> > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> >
> > Namely these: HotPlugSupportInD3, ExternalFacingPort, usb4-host-interface,
> > usb4-port-number and StorageD3Enable.
>
> Right.
>
> We are kind of on the receiving end here, because at the time we learn
> about these things the decisions to use them have been made already.
