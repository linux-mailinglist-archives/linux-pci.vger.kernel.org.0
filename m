Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8983F22E7
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 00:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhHSWT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 18:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235679AbhHSWT5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 18:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629411559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EbhZJqeN1nM9qIrKQm6mxxNUIRdgxznhenqwUNNt6uM=;
        b=IYbl6FGEUZN0CgLVj9Q2tvLRbGaTSkfWW7aWXdzMpbxEjVSn0IICuA7XXu0Bne07oXpzPh
        VSst/rxjWvyvNTio0TBnQP8yjzEu2mQ5/0i+Szj4QILHcMXVPJywAqvgq84YGJ62L2uYkj
        FEsX4gUUJSfLC0WbeSUsxhV5JBOYNPs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-43CRYewyPWG7rk-4Ot4g_Q-1; Thu, 19 Aug 2021 18:19:17 -0400
X-MC-Unique: 43CRYewyPWG7rk-4Ot4g_Q-1
Received: by mail-oi1-f199.google.com with SMTP id c6-20020aca35060000b029025c5504f461so2751734oia.22
        for <linux-pci@vger.kernel.org>; Thu, 19 Aug 2021 15:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EbhZJqeN1nM9qIrKQm6mxxNUIRdgxznhenqwUNNt6uM=;
        b=VjkEAgt/OgkmY5Rj/xLGFC1W1FR5lXlThbbtouKSl2yOHp/ape0IClBbmAnOPe9ApC
         ScyM7Eirevq2mpzczx3+un6bvKGMc+4dL8ZRcZZug7Cp8QP+dBZm+QKjdylOkDEMEE6e
         UUaV8+V7pTgT4xQlOuU1izSIUzm9YwkhDcqCli1lIwGxkyg8zjxOa0RqHmkrI4RIV64w
         8vQ02LKcSdPPBjYUI9Ig9hs2iB3TMVRqQdBBpa9jmhzJtO9qiA8GRfVPt16PyISQKvEy
         48f91w9oPF/QrJ6ZbHG5bM5tfa1ety1fU//t4mFSNhFNqsa9WhJocfpJR6uq+FAaL02u
         CPQw==
X-Gm-Message-State: AOAM5309nKVs7Tp3Ifg+GkD6D0EMxn+G/iIli1yPS8JJ4Rljsv2BNvw0
        3ufvOxYCHhyAE+/VIJ4soTOXPtu6fEZynSJ+a5NANcK2YjtsDGyaTJRYy1lOF8y/AnSozUlIGiz
        dgA16HXj2XLNLEhT8vOGu
X-Received: by 2002:a4a:a552:: with SMTP id s18mr13338726oom.1.1629411556752;
        Thu, 19 Aug 2021 15:19:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzX5rfq5sQLsDwtph+vjRR0C26I9lgF4XK9hL1qrYyyg0cWYI/hPwJPKxCIkfjVts0o9JG5Kg==
X-Received: by 2002:a4a:a552:: with SMTP id s18mr13338701oom.1.1629411556534;
        Thu, 19 Aug 2021 15:19:16 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id z25sm942600oic.24.2021.08.19.15.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 15:19:16 -0700 (PDT)
Date:   Thu, 19 Aug 2021 16:19:14 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>, <bhelgaas@google.com>,
        <corbet@lwn.net>, <diana.craciun@oss.nxp.com>,
        <kwankhede@nvidia.com>, <eric.auger@redhat.com>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-kbuild@vger.kernel.org>, <jgg@nvidia.com>,
        <maorg@nvidia.com>, <leonro@nvidia.com>
Subject: Re: [PATCH V2 09/12] PCI: Add 'override_only' bitmap to struct
 pci_device_id
Message-ID: <20210819161914.7ad2e80e.alex.williamson@redhat.com>
In-Reply-To: <cd749d14-16ba-6442-0855-32c1bfac6e2d@nvidia.com>
References: <20210819163945.GA3211852@bjorn-Precision-5520>
        <cd749d14-16ba-6442-0855-32c1bfac6e2d@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 19 Aug 2021 22:57:30 +0300
Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> On 8/19/2021 7:39 PM, Bjorn Helgaas wrote:
> > On Thu, Aug 19, 2021 at 07:16:20PM +0300, Yishai Hadas wrote:  
> >> On 8/19/2021 6:15 PM, Bjorn Helgaas wrote:  
> >>> On Wed, Aug 18, 2021 at 06:16:03PM +0300, Yishai Hadas wrote:  
> >>>> From: Max Gurtovoy <mgurtovoy@nvidia.com>
> >>>>    /**
> >>>>     * struct pci_device_id - PCI device ID structure
> >>>>     * @vendor:		Vendor ID to match (or PCI_ANY_ID)
> >>>> @@ -34,12 +38,14 @@ typedef unsigned long kernel_ulong_t;
> >>>>     *			Best practice is to use driver_data as an index
> >>>>     *			into a static list of equivalent device types,
> >>>>     *			instead of using it as a pointer.
> >>>> + * @override_only:	Bitmap for override_only PCI drivers.  
> >>> "Match only when dev->driver_override is this driver"?  
> >> Just to be aligned here,
> >>
> >> This field will stay __u32 and may hold at the most 1 bit value set to
> >> represent the actual subsystem/driver.  
> > The PCI core does not require "at most 1 bit is set."
> >
> > Actually, I don't think even the file2alias code requires that.  If
> > you set two bits, you can generate two aliases.
> >  
> >> This is required to later on set the correct prefix in the modules.alias
> >> file, and you just suggested to change the comment as of above, right ?  
> > Yes, __u32 is fine and I'm only suggesting a comment change here.  
> 
> great.
> 
> 
> >  
> >>> As far as PCI core is concerned there's no need for this to be a
> >>> bitmap.
> >>>
> >>> I think this would make more sense if split into two patches.  The
> >>> first would add override_only and change pci_match_device().  Then
> >>> there's no confusion about whether this is specific to VFIO.  
> >> Splitting may end-up the first patch with a dead-code on below, as
> >> found_id->override_only will be always 0.
> >>
> >> If you still believe that this is better we can do it.  
> > I think it's fine to add the functionality in one patch and use it in
> > the next if it makes the commit clearer.  I wouldn't want to add
> > functionality that's not used at all in the series, but it's OK when
> > they're both posted together.  
> 
> Ok. We can do the separation if all agree that the first commit is have 
> a dead section.
> 
> Alex,
> 
> we would like to get few more reviewed-by signatures and we'll send the 
> V3 series in a couple of days to make it to 5.15 merge window as we planned.
> 
> Are you ok with the series after we got the green light for this patch ?
> 
> do you think we need another pair of eyes to review the other patches ?

More eyes is always better, but I'm not finding much to complain about
in this series.  This patch was probably the most pivotal for agreement,
the rest is largely mechanical at this point.

In addition to Bjorn for the PCI parts of this, I'd also like to see an
ack from Yamada-san or Michal for scripts/mod/, who are already cc'd 

I also notice include/linux/vfio_pci_core.h doesn't get added to
MAINTAINERS in the series.  Please fix in patch 12/

It seems plausible that this could be ready for v5.15.  Thanks,

Alex

