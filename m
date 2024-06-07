Return-Path: <linux-pci+bounces-8488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ABC900E43
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jun 2024 01:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F751F213F5
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 23:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5841AAC4;
	Fri,  7 Jun 2024 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCaCpf9k"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5619E57D
	for <linux-pci@vger.kernel.org>; Fri,  7 Jun 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717801325; cv=none; b=mnAMbXvM9LfkDgChGkDLNOj+IPIxcT4CF77wHOiyKreRPokkXkplri8AAhiL2zJbUk+tQqjt9NRTY+ZMpA3bg21s2Jg6zkAQiZQ0iPTzAZjvKhDNT8XflNv8fZXIPraRA+YpPR8CcbOkbN5BrTCn30jbuHDqKzuwAM02/2qRPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717801325; c=relaxed/simple;
	bh=WB+aBLcHixBBFEMdFoBS4XjWx3sl0koKj/MkRxcsI8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHYABOqa3MAgB44cEujhv9Rf+giuw5Wvh57VoUN3jqTtnXB6Xz95FXJFaAc+7Wmqwvc8dtSMPyWZ3V2OzDGZ8uaXIKBQi8Xdt0e6YgT2Qp0hUJCscCNq6LrNbuIgchMhhsLorBDLo6HjExm5P8pspnrJQTMjHhLrfUFoO1uCA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCaCpf9k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717801322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMcIPQrlXdwbHm2xvoE66pWpz2Kt67vwkMRpRSht8PQ=;
	b=LCaCpf9kGYdxA76aDVLKWy7UQu+uU5ahxY6yotg7iPRfD0ZoSqc1+i0FM8KUsQxDbPTBeM
	MTaMDIVCmsz0csH4gCSltZh69vlugyfxuhvHsa2sPUaWU4/mY3/KsMqra4+IrC3RjiCiG3
	jTuICZWNFSi9ZWhCyosvxoUsmqyIfos=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-OcEIt90QOfG1IySWKaY5zw-1; Fri, 07 Jun 2024 19:01:59 -0400
X-MC-Unique: OcEIt90QOfG1IySWKaY5zw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb3db8593cso318486339f.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Jun 2024 16:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717801318; x=1718406118;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMcIPQrlXdwbHm2xvoE66pWpz2Kt67vwkMRpRSht8PQ=;
        b=o0uXXPrX84s0r17dPBTjsOLsZvmsPPBVni2lbgZJkbVRe8B/3i6oHXcaaDAsRG3S60
         zObbakeXtvUPcD/TIFuz2c06i3ydGGzQP5+xgoM1SlH5TJ86OHW1E4bVDLtJsAWiThtt
         TE2G3w5OfuUYPQR+GpHwBgEh+kfYdxEgSVpJMdlxuywolE9Kf5XnFxuuPATnlrjG09KO
         PyXbVBNKBD7EZoOGWL06rTHaAVeD7HhqSJA9JNqcrKiL6O8r64+ILL54C1HMeXoMPQSw
         IAd1Ms7UQVGUQCPBXfpi8EKj4mv1YfLOIJyXnwU0/UsCVccmkxfDdv628KAt5Y5r0YpU
         X3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWj84V0c2n6w5GvOmekfMv3e6fxzbUN2+THMDVFJLlMdXYRR73F+98vDkNzLat2wpvyqJW/fFeqJD2UaxqRQtNebwtGqjjQP/nG
X-Gm-Message-State: AOJu0YzuGukpZm14nKGdr0cEwIMbGLn4gyG+z9lv06AWkAjIMeaizYG0
	DDkg8l9Sz0Ogexw9aFnf/uHF0slRiwNo8XWB4ZP6ePS6AeEEgGCHjPKX76yo7RcexFYYKv0uJFO
	fQ6NPtFhlaOi/KZoHYImqvbLQmauy92kcFudpB375gvfyeO7gRYsuJhxuYQ==
X-Received: by 2002:a05:6e02:170e:b0:374:9c39:18dc with SMTP id e9e14a558f8ab-3758039f84amr44950075ab.30.1717801318616;
        Fri, 07 Jun 2024 16:01:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4tInLyrXDsw5WaAliR+gAhvEFfSlMk2ErZhIhmrmDaL2scIU1+Y2F73rAHmHJmEaqpo2Ptg==
X-Received: by 2002:a05:6e02:170e:b0:374:9c39:18dc with SMTP id e9e14a558f8ab-3758039f84amr44949805ab.30.1717801318151;
        Fri, 07 Jun 2024 16:01:58 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-374bc12e5c8sm10329575ab.9.2024.06.07.16.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 16:01:57 -0700 (PDT)
Date: Fri, 7 Jun 2024 17:01:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, geoff@hostfission.com
Subject: Re: [PATCH] PCI: Release unused bridge resources during resize
Message-ID: <20240607170156.3e59f580.alex.williamson@redhat.com>
In-Reply-To: <20240607223320.GA863404@bhelgaas>
References: <20240507213125.804474-1-alex.williamson@redhat.com>
	<20240607223320.GA863404@bhelgaas>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 17:33:20 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, May 07, 2024 at 03:31:23PM -0600, Alex Williamson wrote:
> > Resizing BARs can be blocked when a device in the bridge hierarchy
> > itself consumes resources from the resized range.  This scenario is
> > common with Intel Arc DG2 GPUs where the following is a typical
> > topology:
> > 
> >  +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Intel Corporation DG2 [Arc A380]
> >                                              \-04.0-[61]----00.0  Intel Corporation DG2 Audio Controller
> > 
> > Here the system BIOS has provided a large 64bit, prefetchable window:
> > 
> > pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff window]
> > 
> > But only a small portion is programmed into the root port aperture:
> > 
> > pci 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]
> > 
> > The upstream port then provides the following aperture:
> > 
> > pci 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> > 
> > With the missing range found to be consumed by the switch port itself:
> > 
> > pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]
> > 
> > The downstream port above the GPU provides the same aperture as upstream:
> > 
> > pci 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> > 
> > Which is entirely consumed by the GPU:
> > 
> > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> > 
> > In summary, iomem reports the following:
> > 
> > b000000000-bfffffffff : PCI Bus 0000:5d
> >   bfe0000000-bff07fffff : PCI Bus 0000:5e
> >     bfe0000000-bfefffffff : PCI Bus 0000:5f
> >       bfe0000000-bfefffffff : PCI Bus 0000:60
> >         bfe0000000-bfefffffff : 0000:60:00.0
> >     bff0000000-bff07fffff : 0000:5e:00.0
> > 
> > The GPU at 0000:60:00.0 supports a Resizable BAR:
> > 
> > 	Capabilities: [420 v1] Physical Resizable BAR
> > 		BAR 2: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB 8GB
> > 
> > However when attempting a resize we get -ENOSPC:
> > 
> > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> > pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> > pcieport 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> > pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
> > pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
> > pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
> > pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
> > pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: can't assign; no space
> > pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: failed to assign
> > pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> > pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > pcieport 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]
> > pcieport 0000:5e:00.0: PCI bridge to [bus 5f-61]
> > pcieport 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > pcieport 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> > pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> > pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> > pcieport 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: assigned
> > 
> > In this example we need to resize all the way up to the root port
> > aperture, but we refuse to change the root port aperture while resources
> > are allocated for the upstream port BAR.
> > 
> > The solution proposed here builds on the idea in commit 91fa127794ac
> > ("PCI: Expose PCIe Resizable BAR support via sysfs") where the BAR can
> > be resized while there is no driver attached.  In this case, when there
> > is no driver bound to the upstream switch port we'll release resources
> > of the bridge which match the reallocation.  Therefore we can achieve
> > the below successful resize operation by unbinding 0000:5e:00.0 from the
> > pcieport driver before invoking the resource2_resize interface on the
> > GPU at 0000:60:00.0.  
> 
> resource2_resize?  Oh, I guess this is the sysfs interface
> (resourceN_resize, which leads to pci_resize_resource(), and in this
> case we're resizing BAR 2 to 8GB,

Exactly.

> so it must have been something like
> this?  (2 ^ (13+20) == 8G)
> 
>   # echo 0000:5f:01.0 > /sys/bus/pci/drivers/pcieport/unbind
>   # echo 0000:5e:00.0 > /sys/bus/pci/drivers/pcieport/unbind
>   # echo 0000:5d:00.0 > /sys/bus/pci/drivers/pcieport/unbind
>   # echo 13 > /sys/bus/pci/devices/0000:60:00.0/resource2_resize
> 
> (Maybe we don't need 5d:00.0, since that looks like a Root Port and
> doesn't have a BAR that needs to be released?)

We don't actually need to unbind either the root port (5d:00.0) or the
downstream switch port (5f:01.0) since they don't consume any resources
from the aperture we need to resize.

For example if this were an AMD GPU we'd have a similar PCIe switch
topology but the upstream switch does not expose a 64-bit prefetchable
BAR, only the GPU endpoint itself consumes resources from that
aperture.  Therefore we'd only need to unbind the endpoint driver,
effect the resize, and rebind the endpoint driver.  Ex (assuming the
same topology):

# echo 0000:60:00.0 > /sys/bus/pci/devices/0000:60:00.0/driver/unbind
# echo 13 > /sys/bus/pci/devices/0000:60:00.0/resource2_resize
# echo 0000:60:00.0 > /sys/bus/pci/drivers_probe

The Intel GPU has made the unfortunate hardware decision to have the
upstream port consume resources from the same aperture as used by the
downstream resizable BAR, therefore the above steps fail with the
-ENOSPC error for an Intel Arc GPU.  This proposal allows it to work as:

# echo 0000:60:00.0 > /sys/bus/pci/devices/0000:60:00.0/driver/unbind
# echo 0000:5e:00.0 > /sys/bus/pci/devices/0000:5e:00.0/driver/unbind
# echo 13 > /sys/bus/pci/devices/0000:60:00.0/resource2_resize
# echo 0000:5e:00.0 > /sys/bus/pci/drivers_probe
# echo 0000:60:00.0 > /sys/bus/pci/drivers_probe

> And I guess we probably need to rebind pcieport afterwards so hotplug,
> etc will work again?

Yep.  Thanks,

Alex

> > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> > pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> > pci 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> > pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]: releasing
> > pcieport 0000:5d:00.0: bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]: releasing
> > pcieport 0000:5d:00.0: bridge window [mem 0xb000000000-0xb2ffffffff 64bit pref]: assigned
> > pci 0000:5e:00.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> > pci 0000:5e:00.0: BAR 0 [mem 0xb200000000-0xb2007fffff 64bit pref]: assigned
> > pcieport 0000:5f:01.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> > pci 0000:60:00.0: BAR 2 [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> > pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> > pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> > pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> > pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > pcieport 0000:5d:00.0:   bridge window [mem 0xb000000000-0xb2ffffffff 64bit pref]
> > pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> > pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> > pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> > pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> > pcieport 0000:5f:01.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/setup-bus.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 909e6a7c3cc3..15fc8e4e84c9 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -2226,6 +2226,26 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
> >  
> > +static void pci_release_resource_type(struct pci_dev *pdev, unsigned long type)
> > +{
> > +	int i;
> > +
> > +	if (!device_trylock(&pdev->dev))
> > +		return;
> > +
> > +	if (pdev->dev.driver)
> > +		goto unlock;
> > +
> > +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > +		if (pci_resource_len(pdev, i) &&
> > +		    !((pci_resource_flags(pdev, i) ^ type) & PCI_RES_TYPE_MASK))
> > +			pci_release_resource(pdev, i);
> > +	}
> > +
> > +unlock:
> > +	device_unlock(&pdev->dev);
> > +}
> > +
> >  int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
> >  {
> >  	struct pci_dev_resource *dev_res;
> > @@ -2260,8 +2280,10 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
> >  
> >  			pci_info(bridge, "%s %pR: releasing\n", res_name, res);
> >  
> > -			if (res->parent)
> > +			if (res->parent) {
> >  				release_resource(res);
> > +				pci_release_resource_type(bridge, type);
> > +			}
> >  			res->start = 0;
> >  			res->end = 0;
> >  			break;
> > -- 
> > 2.44.0
> >   
> 


