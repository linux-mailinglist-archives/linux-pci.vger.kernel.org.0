Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E1A41DC6F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 16:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350759AbhI3Okd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 10:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349422AbhI3Okc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 10:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fj331J8gANBz1gR6zaAgnFZdzxi9a1lUWPYZsgHCyYI=;
        b=NPTK6uGC+tk9Ziuexcd+AsM2IXdYOi30kHFeytqbaDMLWuYXOI6KEL6Mvw9bbtviw7mwCh
        I024+7ZQgKfYskNpOOWHOLzDayr42Cb6g1FPj22JGOs5iaM6p80KEmNxcJ4+ODw5MNyZXV
        tAo+ngQCR7oTcEG8utpzMMS9tAXHONM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453--RoIYFcuOp-7DPvLoLrX9g-1; Thu, 30 Sep 2021 10:38:48 -0400
X-MC-Unique: -RoIYFcuOp-7DPvLoLrX9g-1
Received: by mail-ed1-f71.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so6555776edn.5
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 07:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fj331J8gANBz1gR6zaAgnFZdzxi9a1lUWPYZsgHCyYI=;
        b=HOmfwvht3mtoPr0jK/+D3CNE/pTin8MaJ6i9D/r6atprEPxih+UO04OKiGVHoweqRG
         zxIfK6rwQD7e8W8qlGnlGw2UzCJa0FWHIv4pDDkpk4NjZ72+iwdoEbgnUeQBkekbIYBq
         HJVo1ZFR5P3FjzlDJuyxRQMWQrVzEEM7S8HD8NQwz5DG5vQcsma12pOJXdaUe/GlfWyQ
         6bjvWBRpQ5jTM7uzBgm3PINczY7TKJ3aVXnqdkwOV+A4s9EEKWGLCV7kOBZMXNZX0rR7
         oC2maSIog4Pd5U0i3T3KNGKH2D8sXz7rN+m70engfLU0QhoHW3gAGka7YXzAyTU1/aNM
         DLzg==
X-Gm-Message-State: AOAM530HFEDPKzLAl+uCXiXCuFthkdL1ftVND5fqz97BqI2X6woHJdNx
        eEgJPddD7ZDCxIV3dS/1x3AzWp7G8ZO/qG6qi995bZVEKHB9bB3RBrok944gqf7eM1NQUCw96BQ
        BX9/vWw2v5cJ8oSACieP5
X-Received: by 2002:a50:cfcb:: with SMTP id i11mr7532205edk.347.1633012727151;
        Thu, 30 Sep 2021 07:38:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyoY8MlHma3/meQa/alF0eoOEaUHfr4CeWPL4UOFREXT8lK5GBMJpzF9t0MEPSKJxLdjYaGA==
X-Received: by 2002:a50:cfcb:: with SMTP id i11mr7532190edk.347.1633012726972;
        Thu, 30 Sep 2021 07:38:46 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
        by smtp.gmail.com with ESMTPSA id u18sm1575656ejc.26.2021.09.30.07.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:38:46 -0700 (PDT)
Date:   Thu, 30 Sep 2021 10:38:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930103537-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVXBNJ431YIWwZdQ@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 03:52:52PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 30, 2021 at 06:59:36AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 29, 2021 at 06:05:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > While the common case for device-authorization is to skip probe of
> > > unauthorized devices, some buses may still want to emit a message on
> > > probe failure (Thunderbolt), or base probe failures on the
> > > authorization status of a related device like a parent (USB). So add
> > > an option (has_probe_authorization) in struct bus_type for the bus
> > > driver to own probe authorization policy.
> > > 
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > 
> > 
> > So what e.g. the PCI patch
> > https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > actually proposes is a list of
> > allowed drivers, not devices. Doing it at the device level
> > has disadvantages, for example some devices might have a legacy
> > unsafe driver, or an out of tree driver. It also does not
> > address drivers that poke at hardware during init.
> 
> Doing it at a device level is the only sane way to do this.
> 
> A user needs to say "this device is allowed to be controlled by this
> driver".  This is the trust model that USB has had for over a decade and
> what thunderbolt also has.
> 
> > Accordingly, I think the right thing to do is to skip
> > driver init for disallowed drivers, not skip probe
> > for specific devices.
> 
> What do you mean by "driver init"?  module_init()?
> 
> No driver should be touching hardware in their module init call.  They
> should only be touching it in the probe callback as that is the only
> time they are ever allowed to talk to hardware.  Specifically the device
> that has been handed to them.
> 
> If there are in-kernel PCI drivers that do not do this, they need to be
> fixed today.
> 
> We don't care about out-of-tree drivers for obvious reasons that we have
> no control over them.
> 
> thanks,
> 
> greg k-h

Well talk to Andi about it pls :)
https://lore.kernel.org/r/ad1e41d1-3f4e-8982-16ea-18a3b2c04019%40linux.intel.com

-- 
MST

