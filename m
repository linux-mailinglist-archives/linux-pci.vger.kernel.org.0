Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD1544E460
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 11:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbhKLKM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 05:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234911AbhKLKMZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 05:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636711774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GpT2YYqG29Jg+Uxsx2CrH+IJrT+DNnW+q/s5xR+/nO8=;
        b=chVFhlOEM41HG0kWG6eKDS1G72jpwZJGtAftfbZNpxxeOmEjE0H84QQ4X1POkl6SfrCGth
        P78XMJRGbmDbZ0HRojHfKOMgx+VbAsZQDp9SSOCbh03igWTQuepyuPl7bsvuE/U5jVXQjS
        +2AKDDz6Byud0DTUP0EheioJPkl2Zrs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-lTdKiSrnMwOl9o3P6CynYw-1; Fri, 12 Nov 2021 05:09:33 -0500
X-MC-Unique: lTdKiSrnMwOl9o3P6CynYw-1
Received: by mail-ed1-f71.google.com with SMTP id w12-20020a056402268c00b003e2ab5a3370so7870449edd.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Nov 2021 02:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GpT2YYqG29Jg+Uxsx2CrH+IJrT+DNnW+q/s5xR+/nO8=;
        b=0Z+LwNc9hRSEG41pEb3uPWElal02b1CfDFgilHRKO0yghWteu13t6AfbK/2f8eKSoh
         F53JRIf48MiU0Zm5RO+WJp7V3BGZ60bNWzAw0x5EXDzv8d40Wf8ZLUrCBc44gpNfjVzG
         EGch+EAyQotQ9V//BLQdtI7LCfx/uzZ6KcbpOb0qHlWXUbCeShNwgDR2W16y2DWE/tfW
         AAhKKcF4IDPOrA7KS+2+a1IobaKrHoeWwtOvoF1vZmC+wnpiqvp/AyhZwK1RJfRBw29Q
         TNCb1e77xTGt1nLMI+eyOoF1lnB59dF2qPoMSTI1x0y8h+AsKMUI/nWKEiRbyQBQ5wsl
         +SUQ==
X-Gm-Message-State: AOAM531orspbQMCL0Ylyg31gEiqmJmU5KwFgu1pcUu7ajwpf0WY+qWi4
        dKFZoWpf2FZjmuxLP//cjf7x8llbgGVBvDzR9F+dgsptIBP0Mo4PkeHWYbRxPtmmptcczX+D49Q
        zzMuwjHaXQ0F6FixqMicU
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr17383099ejc.356.1636711772008;
        Fri, 12 Nov 2021 02:09:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIZCg8KaRPHh5tzSrNXTPjAyfDOZFhQ7POM6eHpQhHd+dmXCDKysUay1ewM1e6Mb40QOB2uQ==
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr17383074ejc.356.1636711771835;
        Fri, 12 Nov 2021 02:09:31 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:ac28:448d:9310:293c:3a8b])
        by smtp.gmail.com with ESMTPSA id ho30sm2409248ejc.30.2021.11.12.02.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 02:09:31 -0800 (PST)
Date:   Fri, 12 Nov 2021 05:09:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211112050508-mutt-send-email-mst@kernel.org>
References: <20211111090225.946381-1-kraxel@redhat.com>
 <20211111115931-mutt-send-email-mst@kernel.org>
 <20211112095629.uoxfuhsvhicsdxgd@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112095629.uoxfuhsvhicsdxgd@sirius.home.kraxel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 12, 2021 at 10:56:29AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > This patch adds the fast_virtual_unplug module parameter to the
> > > pciehp driver.  When enabled (which is the default) the linux
> > > kernel will simply skip the delay for virtual pcie ports, which
> > > reduces the total time for the unplug operation from 6-7 seconds
> > > to 1-2 seconds.
> > 
> > BTW how come it's still taking seconds, not milliseconds?
> 
> I've tackled the 5 seconds only, biggest chunk and easy target because
> the only reason to have that is to allow operators press the attention
> button again to cancel, so the risk to break something here is rather
> low.
> 
> There are some more wait times elsewhere, to give the hardware the
> time needed when powering up/down slots, which sum up to roughly one
> second, and the time the driver needs to shutdown the device goes on
> top of that (typically not much).
> 
> take care,
>   Gerd

Probably also unnecessary for a virtual bridge. We'll need to fix these
up if we want native hotplug to be useful for workloads like kata -
these expect hotplug time in the milliseconds.

-- 
MST

