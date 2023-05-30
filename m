Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6863716D2D
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 21:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjE3THg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 15:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjE3THf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 15:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA68E
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685473614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fSmFtWgu65TksWT+Us90A+D3QMtRR1H00zZMfgSmti4=;
        b=QzszITu9pKqNPFfMBBMa5xC9116n+6/rmfdzOhAMa7t33AK+aOrk/yp24XlOQgR6bE3CIU
        SZSY+cwSEGSQj5L9wikVJ7c3cOWYS+dfJBcM10jeim4ayA0Zky1tkv0q+zevG4IMtH44oi
        NvFZp2A9JCatBERWmsKNamUadFODUv4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-DAJIgW6yOl-fa65Y-b80bA-1; Tue, 30 May 2023 15:06:52 -0400
X-MC-Unique: DAJIgW6yOl-fa65Y-b80bA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f4b2a2040bso2565174e87.0
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 12:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685473611; x=1688065611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSmFtWgu65TksWT+Us90A+D3QMtRR1H00zZMfgSmti4=;
        b=brsyvRluzN7Hol76vbmNp4QkQP8ZUT35ovtCbG9Q8Nr7rCJhM84F7J0d4Lna1vP5TG
         XWHlIJOVRHUv6aBsuGYvoPjqD3YxskJOIzcVA9YuBufQwW4K87D996R3L+8KnbeicItI
         Uy8YYe2cmp/gsKHtshonW5AXRIepoxf9CmPQ3SPjgpWA9WauJm5lSa2SUiGr46p102vL
         FhE1L+KOTUwAEpLrYtUpcCs3sBgcOi0bRx/dFvISMIqZf1KshkSBr9PudF4HbskqjEJE
         ll5hEMEY1pHCufNq7zbZZH8Ag+sMzT5f6buKv6/I510iRaJ0R3a/6ODe21+L07D5K+YC
         h8ew==
X-Gm-Message-State: AC+VfDy9nCpMe2H1xp2bSdD+crvziJeAIyq0tbcihT23ECIUUgr1cKBr
        uiW6VKdxiFdhuodxszGdefdxvRxxiqYWAaISkdeL43TOppCOol5O8FOUZlGZyin8Vqzt7DjRa1d
        A6lBkNkK0D1rajsZTphnl
X-Received: by 2002:ac2:43c7:0:b0:4f3:a49b:121f with SMTP id u7-20020ac243c7000000b004f3a49b121fmr1286303lfl.40.1685473611539;
        Tue, 30 May 2023 12:06:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6i347dAklPJbPv8EkDS2YnvF4+V4rWvJj6xX7aXx26i4gIYG6DhV3FoTipjX8Q0zjzNeUxZQ==
X-Received: by 2002:ac2:43c7:0:b0:4f3:a49b:121f with SMTP id u7-20020ac243c7000000b004f3a49b121fmr1286284lfl.40.1685473611189;
        Tue, 30 May 2023 12:06:51 -0700 (PDT)
Received: from redhat.com ([176.12.143.106])
        by smtp.gmail.com with ESMTPSA id d10-20020ac24c8a000000b004f252f48e5fsm429049lfl.40.2023.05.30.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 12:06:50 -0700 (PDT)
Date:   Tue, 30 May 2023 15:06:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <20230530150019-mutt-send-email-mst@kernel.org>
References: <20230530141321-mutt-send-email-mst@kernel.org>
 <ZHZGkAg34ltZLV9J@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHZGkAg34ltZLV9J@bhelgaas>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 30, 2023 at 01:55:12PM -0500, Bjorn Helgaas wrote:
> On Tue, May 30, 2023 at 02:16:36PM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 30, 2023 at 12:12:44PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Apr 24, 2023 at 09:15:57PM +0200, Igor Mammedov wrote:
> > > > When using ACPI PCI hotplug, hotplugging a device with
> > > > large BARs may fail if bridge windows programmed by
> > > > firmware are not large enough.
> > > > 
> > > > Reproducer:
> > > >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> > > >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
> > > >       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
> > > >       disk_image
> > > > 
> > > >  wait till linux guest boots, then hotplug device
> > > >    (qemu) device_add qxl,bus=rp1
> > > > 
> > > >  hotplug on guest side fails with:
> > > >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> > > >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> > > >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> > > >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> > > >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> > > >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> > > >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> > > >    qxl 0000:01:00.0: enabling device (0000 -> 0003)
> > > 
> > > Ugh, I just noticed that we turned on PCI_COMMAND_MEMORY even though
> > > BARs 0 and 1 haven't been assigned.  How did that happen?  It looks
> > > like pci_enable_resources() checks for that, but there must be a hole
> > > somewhere.
> > 
> > Maybe because BAR2 was assigned? I think pci_enable_resources just
> > does
> >                 if (r->flags & IORESOURCE_MEM)
> >                         cmd |= PCI_COMMAND_MEMORY;
> > in a loop so if any memory BARs are assigned then PCI_COMMAND_MEMORY
> > is set.
> 
> It does, but it also bails out if it finds IORESOURCE_UNSET:
> 
>   pci_enable_resources()
>   {
>     ...
>     pci_dev_for_each_resource(dev, r, i) {
>       ...
>       if (r->flags & IORESOURCE_UNSET) {
>         pci_err(dev, "can't enable device: BAR %d %pR not assigned\n");
>         return -EINVAL;
>       }
>       ...
>       if (r->flags & IORESOURCE_MEM)
>         cmd |= PCI_COMMAND_MEMORY;
>     }
>     ...
>   }
> 
> I expected that IORESOURCE_UNSET would still be there from
> pci_assign_resource(), since we saw the "failed to assign" messages,
> but there must be more going on.
> 
> Bjorn

Oh you are right. I donnu.

-- 
MST

