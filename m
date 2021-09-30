Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED141DCDC
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352041AbhI3PCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 11:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352104AbhI3PB6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 11:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633014015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Uhm+QYM76Q/NUVbbvm//7rv1aKv+wtBYWvx/Vlkg4E=;
        b=SucXab1gQHa/Umh2MgoDVgzG1AhGw+EfI0kz421wbzXrJWInvhzsbL41RH7OlQ4oDVK/iP
        qt7On/M8ibIU5ucS45aNMLALZ1Pxrjxj07H8YNexME27WVKIzIo0Ob6gYB5HWy30LHAfuD
        SUq6s7oybrFwysJH8XMfkYxfpdJNQeU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-Bp6giNe8NuiUEipQm6xJAA-1; Thu, 30 Sep 2021 11:00:14 -0400
X-MC-Unique: Bp6giNe8NuiUEipQm6xJAA-1
Received: by mail-ed1-f72.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso6662321edx.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 08:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Uhm+QYM76Q/NUVbbvm//7rv1aKv+wtBYWvx/Vlkg4E=;
        b=cU+SHstiUlLmLqjWyUnG/gEpdtBTyXb9TzRI7Pt2gpsjcJ730bRUloUOQvK2r/yVH8
         OLS0FqD3ueyZhzOPfwhPpIGEdPacgHcqCTju1bSnOo3HlGVhtqp6w8Hq6Czfoo+hFgsF
         CwutTl+sI3w3LbJ+1ssN19eh15F8DSAHdAHFRxr0X4UEsmKNLJ/NsxznWPlwu5uCnDiB
         zyiClg62aJzu30cWMfEX5eY30KD135Vmfp8G/+gBwG0X+BKJ94SfW9lNIVb4Oy6mnWkj
         CcgerKgXxz0Smc5lsZYlNtaG6Mgb6aAb9qGcfcT4vkvlF2e67F0dYPH1bN7nhsgbQ2Hl
         ilnA==
X-Gm-Message-State: AOAM531MmkmELxHZZfwzhpxWOPsDQYqPEgDKYMYTSpzoyVxgTQh4kKjb
        S7qwoCpHEzkb6tYfMSg9OaXwTlTjNiS3Ycn3gXyX7UcCurMnWS3KeWGuNN8L28GrS2tPCj2qwyN
        yZZyPrUKgihpj+X3nzETH
X-Received: by 2002:a17:906:1b08:: with SMTP id o8mr7415459ejg.21.1633014012970;
        Thu, 30 Sep 2021 08:00:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz5aESHhTZJzzyTWIqcWelf63OI2y13i3Gz90wHayn2gr4CKl6nhaZlq4TjwGKZXxkJMK2Wg==
X-Received: by 2002:a17:906:1b08:: with SMTP id o8mr7415439ejg.21.1633014012775;
        Thu, 30 Sep 2021 08:00:12 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
        by smtp.gmail.com with ESMTPSA id l10sm1630936edr.14.2021.09.30.08.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 08:00:12 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:00:07 -0400
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
Message-ID: <20210930105852-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930103537-mutt-send-email-mst@kernel.org>
 <YVXOc3IbcHsVXUxr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVXOc3IbcHsVXUxr@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 04:49:23PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 30, 2021 at 10:38:42AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 30, 2021 at 03:52:52PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Sep 30, 2021 at 06:59:36AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 29, 2021 at 06:05:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > > > While the common case for device-authorization is to skip probe of
> > > > > unauthorized devices, some buses may still want to emit a message on
> > > > > probe failure (Thunderbolt), or base probe failures on the
> > > > > authorization status of a related device like a parent (USB). So add
> > > > > an option (has_probe_authorization) in struct bus_type for the bus
> > > > > driver to own probe authorization policy.
> > > > > 
> > > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > 
> > > > 
> > > > 
> > > > So what e.g. the PCI patch
> > > > https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > > > actually proposes is a list of
> > > > allowed drivers, not devices. Doing it at the device level
> > > > has disadvantages, for example some devices might have a legacy
> > > > unsafe driver, or an out of tree driver. It also does not
> > > > address drivers that poke at hardware during init.
> > > 
> > > Doing it at a device level is the only sane way to do this.
> > > 
> > > A user needs to say "this device is allowed to be controlled by this
> > > driver".  This is the trust model that USB has had for over a decade and
> > > what thunderbolt also has.
> > > 
> > > > Accordingly, I think the right thing to do is to skip
> > > > driver init for disallowed drivers, not skip probe
> > > > for specific devices.
> > > 
> > > What do you mean by "driver init"?  module_init()?
> > > 
> > > No driver should be touching hardware in their module init call.  They
> > > should only be touching it in the probe callback as that is the only
> > > time they are ever allowed to talk to hardware.  Specifically the device
> > > that has been handed to them.
> > > 
> > > If there are in-kernel PCI drivers that do not do this, they need to be
> > > fixed today.
> > > 
> > > We don't care about out-of-tree drivers for obvious reasons that we have
> > > no control over them.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Well talk to Andi about it pls :)
> > https://lore.kernel.org/r/ad1e41d1-3f4e-8982-16ea-18a3b2c04019%40linux.intel.com
> 
> As Alan said, the minute you allow any driver to get into your kernel,
> it can do anything it wants to.
> 
> So just don't allow drivers to be added to your kernel if you care about
> these things.  The system owner has that mechanism today.
> 
> thanks,
> 
> greg k-h

The "it" that I referred to is the claim that no driver should be
touching hardware in their module init call. Andi seems to think
such drivers are worth working around with a special remap API.

-- 
MST

