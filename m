Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA48563C178
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 14:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiK2Nxm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 08:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiK2Nxk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 08:53:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08862C752
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 05:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669729967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUKINdcrKvWHT60o4/jDaFuOhgNlRwxOx1pz6VL9BBY=;
        b=GUikNTqSAdBBTezwDscq11gneNgkOmcX3QE3q/9CsWTYJDkXkwm/koQXFZjIy7ixjU8kPA
        06UaPsBTUOrb7F02ozXa3hY/+OZrTA1HAFSXEIkU1xmH/Pc+CgPePx+9VEkOA54fUbSVa4
        kILgVMEXakg0kviupNojT9fSrwHZlC0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-p4hMbGNmM1OEg0MoIswFtA-1; Tue, 29 Nov 2022 08:52:46 -0500
X-MC-Unique: p4hMbGNmM1OEg0MoIswFtA-1
Received: by mail-io1-f69.google.com with SMTP id bf14-20020a056602368e00b006ce86e80414so8539320iob.7
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 05:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUKINdcrKvWHT60o4/jDaFuOhgNlRwxOx1pz6VL9BBY=;
        b=FhNzh2dTLZJEdB91j3Q09j4ygd65pdV0O4J6P9jGkdonIoYNiuUc001LDBZ7E8GOnr
         mZ9CnSkc08tbU/A8tj+aHI87TW6cW+cKARcQ3q66PmGaVBnAMMjlo/ilF7VaAl7QmyHM
         OX5T66qkhGz3Mwo8ZzzZE99hFla4xHAR/4/sQkwqIx8cVGrRFOCaWYRLJ6AmnkGYe9T/
         W6d/DjgMPg8JmHnbM1/gB+ayFmf03GT2ba9szYunuX669MFOohMYeGV7aPjc29QPQCr5
         3LjOibYCHHGZQIie/fkH65Lv7nOs3hNnliei04o236ghpYpYfKW4Z1wd1bqgigdviJUP
         M9pg==
X-Gm-Message-State: ANoB5pkzjCSc++6IGjgUtDS6eNkUGUaWbbcPgf8Gqvdei0Z69CrDeNIq
        odSfEX0rH2GLcK5tKu8I4Ei15jx4C8atrYKZ6FrMaShWD3srSA8Pk5/62sdzh8fN1e6Zr8qnuKm
        vU0otGQIjxrFZA+5Rna5P
X-Received: by 2002:a6b:fd0e:0:b0:6df:5e6c:f5c7 with SMTP id c14-20020a6bfd0e000000b006df5e6cf5c7mr7890805ioi.207.1669729964923;
        Tue, 29 Nov 2022 05:52:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4mkghA3lBj6pdKbZhM4hNalGXquCCa0RbMNpt81xYTlbTpCvPk+12bHhSGeWzAh+NwIA74Zw==
X-Received: by 2002:a6b:fd0e:0:b0:6df:5e6c:f5c7 with SMTP id c14-20020a6bfd0e000000b006df5e6cf5c7mr7890785ioi.207.1669729964692;
        Tue, 29 Nov 2022 05:52:44 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i14-20020a023b4e000000b00363dfbb145asm5219300jaf.30.2022.11.29.05.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:52:44 -0800 (PST)
Date:   Tue, 29 Nov 2022 06:52:42 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <20221129065242.07b5bcbf.alex.williamson@redhat.com>
In-Reply-To: <20221129064812.GA1555@wunner.de>
References: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
        <20221128203932.GA644781@bhelgaas>
        <20221128150617.14c98c2e.alex.williamson@redhat.com>
        <20221129064812.GA1555@wunner.de>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 29 Nov 2022 07:48:12 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Mon, Nov 28, 2022 at 03:06:17PM -0700, Alex Williamson wrote:
> > Agreed.  Is this convoluted removal process being used to force a SBR,
> > versus a FLR or PM reset that might otherwise be used by twiddling the
> > reset attribute of the GPU directly?  If so, the reset_method attribute
> > can be used to force a bus reset and perform all the state save/restore
> > handling to avoid reallocating BARs.  A reset from the upstream switch
> > port would only be necessary if you have some reason to also reset the
> > switch downstream ports.  Thanks,  
> 
> A Secondary Bus Reset is only offered as a reset_method if the
> device to be reset is the *only* child of the upstream bridge.
> I.e. if the device to be reset has siblings or children,
> a Secondary Bus Reset is not permitted.
> 
> Modern GPUs (including the one Mika is referring to) consist of
> a PCIe switch with the GPU, HD audio and telemetry devices below
> Downstream Bridges.  A Secondary Bus Reset of the Root Port is
> not allowed in this case because the Switch Upstream Port has
> children.

I didn't see such functions in the log provided, the GPU in question
seems to be a single function device at 53:00.0.  This matches what
I've seen on an ARC A380 GPU where the GPU and HD audio are each single
function devices under separate downstream ports of a PCIe switch.

> See this code in pci_parent_bus_reset():
> 
> 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
> 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> 		return -ENOTTY;
> 
> The dev->subordinate check disallows a SBR if there are children.
> Note that the code should probably instead check for...
> (dev->subordinate && !list_empty(dev->subordinate->devices))
> ...because the port may have a subordinate bus without children
> (may have been removed for example).
> 
> The "no siblings" rule is enforced by:
> 
> 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
> 		if (pdev != dev)
> 			return -ENOTTY;
> 
> Note that the devices list is iterated without holding pci_bus_sem,
> which looks fishy.
> 
> That said, it *is* possible that a Secondary Bus Reset is erroneously
> offered despite these checks because we perform them early on device
> enumeration when the subordinate bus hasn't been scanned yet.
> 
> So if the Root Port offers other reset methods besides SBR and the
> user switches to one of them, then reinstates the defaults,
> suddenly SBR will disappear because the subordinate bus has since
> been scanned.  What's missing here is that we re-check availability
> of the reset methods on siblings and the parent when a device is
> added or removed.  This is also necessary to make reset_method
> work properly with hotplug.  However, the result may be that the
> reset_method attribute in sysfs may become invisible after adding
> a device (because there is no reset method available) and reappear
> after removing a device.
> 
> So the reset_method logic is pretty broken right now I'm afraid.

I haven't checked for a while, but I thought we exposed SBR regardless
of siblings, though it can't be accessed via the reset attribute if
there are siblings.  That allows that the sibling devices could be soft
removed, a reset performed, and the bus re-scanned.  If there are in
fact sibling devices, it would make more sense to remove only those to
effect a bus reset to avoid the resource issues with rescanning SR-IOV
on the GPU.

> In any case, for Mika's use case it would be useful to have a
> "reset_subordinate" attribute on ports capable of a SBR such that
> the entire hierarchy below is reset.  The "reset" attribute is
> insufficient.

I'll toss out that a pretty simple vfio tool can be written to bind all
the siblings on a bus enabling the hot reset ioctl in vfio.  Thanks,

Alex

