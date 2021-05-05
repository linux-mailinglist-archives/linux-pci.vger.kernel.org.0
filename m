Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A215D374884
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 21:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhEETPA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 15:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234254AbhEETO7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 May 2021 15:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620242042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WND2CpV8+IQjtov7jcu3oVwlqYfsz1FWGhFOziU4Cww=;
        b=DW0cxlQCyt0MYXtELqfKE/ptyOavTVBOi20ARrIfFs8CtYgEpOsDkUEIHysl3W1Jy+bd65
        7xnwurB/PJeDxV0mtvUFApCRWO+drMSMT/4hLgYxbkGfQe12KYpppOa2RbIy58xKaA0WzM
        h4Ra8jClj3nR/0jG8u0y9hirwsUH1IQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-eSptlj6_MlqCGhcOGIPW3A-1; Wed, 05 May 2021 15:14:00 -0400
X-MC-Unique: eSptlj6_MlqCGhcOGIPW3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 509936D58A;
        Wed,  5 May 2021 19:13:58 +0000 (UTC)
Received: from redhat.com (ovpn-113-225.phx2.redhat.com [10.3.113.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E15B25D6AC;
        Wed,  5 May 2021 19:13:57 +0000 (UTC)
Date:   Wed, 5 May 2021 13:13:57 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Shanker R Donthineni <sdonthineni@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Message-ID: <20210505131357.07e55042@redhat.com>
In-Reply-To: <20210505174032.sursnpwkfrc5qji2@archlinux>
References: <478efe56-fb64-6987-f64c-f3d930a3b330@nvidia.com>
        <20210505021236.GA1244944@bjorn-Precision-5520>
        <CAOSf1CFACC5V1OdA9i9APipTUE3GmXu487vt-btXWk5rP97UAQ@mail.gmail.com>
        <20210505174032.sursnpwkfrc5qji2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 5 May 2021 23:10:32 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> On 21/05/05 01:56PM, Oliver O'Halloran wrote:
> > On Wed, May 5, 2021 at 12:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > >
> > > On Mon, May 03, 2021 at 09:07:11PM -0500, Shanker R Donthineni wrote:  
> > > > On 5/3/21 5:42 PM, Bjorn Helgaas wrote:  
> > > > > Obviously _RST only works for built-in devices, since there's no AML
> > > > > for plug-in devices, right?  So if there's a plug-in card with this
> > > > > GPU, neither SBR nor _RST will work?  
> > > > These are not plug-in PCIe GPU cards, will exist on upcoming server
> > > > baseboards. ACPI-reset should wok for plug-in devices as well as long
> > > > as firmware has _RST method defined in ACPI-device associated with
> > > > the PCIe hot-plug slot.  
> > >
> > > Maybe I'm missing something, but I don't see how _RST can work for
> > > plug-in devices.  _RST is part of the system firmware, and that
> > > firmware knows nothing about what will be plugged into the slot.  So
> > > if system firmware supplies _RST that knows how to reset the Nvidia
> > > GPU, it's not going to do the right thing if you plug in an NVMe
> > > device instead.
> > >
> > > Can you elaborate on how _RST would work for plug-in devices?  

I'm not sure I really understand these concerns about plug-in devices.
In this case I believe we're dealing with an embedded GPU, there is no
case where one of these GPUs would be a discrete device on a plug-in
card.  I'm also assuming all SoCs integrating this GPU will provide a
_RST method, but we're also disabling SBR in this series to avoid the
only other generic reset option we'd have for this device.

In the more general case, I'd expect that system firmware isn't going
to implement an _RST method for a pluggable slot, so we'll lookup the
ACPI handle, fail to find a _RST method and drop to the next option.
For a PCI/e slot, at best the _RST method might be included in the _PRR
scope rather than the device scope to indicate it affects the entire
slot.  That could be something like the #PERST below or a warm reset.  I
don't think we're enabling that here, are we?

Otherwise system firmware would need to dynamically provide a _RST
method if it recognized and had support for the plugin card.

> > Power cycling the slot or just re-asserting #PERST probably. IBM has
> > been doing that on Power boxes since forever and it mostly works.
> > Mostly.  
> According to ACPI spec v6.3 section 7.3.25, _RST just performs normal
> FLR in most cases but if the device supports _PRR(Power Resource for Reset)
> then reset operation causes the device to be reported as missing from the bus
> that indicates that it affects all the devices on the bus.

We're only looking for _RST on the device handle, so I think we're
limited to the device context limitations.  Per the referenced section:

7.3.25 _RST (Device Reset)

  This object executes a reset on the associated device or devices. If
                                                                    ^^
  included in a device context, the reset must not affect any other
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ACPI-described devices; if included in a power resource for reset
  ^^^^^^^^^^^^^^^^^^^^^^
  (_PRR, Section 7.3.26) the reset must affect all ACPI-described
  devices that reference it.

  When this object is described in a device context, it executes a
  function level reset that only affects the device it is associated
  with; neither parent nor children should be affected by the execution
  of this reset. Executing this must only result in this device
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  resetting without the device appearing as if it has been removed from
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  the bus altogether, to prevent OSPM re-enumeration of devices on
  ^^^^^^^^^^^^^^^^^^
  hot-pluggable buses (e.g. USB).

  If a device reset is supported by the platform, but cannot meet the
  function level and bus requirement, the device should instead
  implement a _PRR (Section 7.3.26).

  Devices can define both a _RST and a _PRR if supported by the
  hardware.

  Arguments: Non

  Return Value: None


It's a bit unfortunate that they use the phrase "function level reset",
but since this method is not specific to a PCI device, I think this
could just as easily be replaced with "individual device scope reset".
The implementation of that could be an PCI FLR, or any number of device
or platform specific operations.  To me this reads like a system
firmware provided, device specific reset.  Thanks,

Alex

