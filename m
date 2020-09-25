Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6F12789DC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgIYNpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 09:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728148AbgIYNpG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 09:45:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601041504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fZRx9scO9WyM5XbTggDdmGbPU+j83eUOkEATeFu9ti4=;
        b=W4x6zwKaDFYr9mtYLpgKSXDMF/FKkYrK31H3Y3RLPj4I57C59DTsAsd2o1f3CRxNFOPYR3
        qT4tz+865YrUCyY/ugmeQBPAF7fW6V/mHKLs5fwoaNcJ6hHF3yBRf5t73iTG17Qu5MRojL
        08tcF/pjSozSpLuSivj63W9B+xsIS7g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-4nbXMvg_OVifReWKHbuNZw-1; Fri, 25 Sep 2020 09:44:57 -0400
X-MC-Unique: 4nbXMvg_OVifReWKHbuNZw-1
Received: by mail-wm1-f70.google.com with SMTP id r10so1119729wmh.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 06:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fZRx9scO9WyM5XbTggDdmGbPU+j83eUOkEATeFu9ti4=;
        b=PArdXQ1CuD8cgF5s/fd38+jOkkWac7EtWatDbXs7zVAIYe6SLxZ/yxR4b5vOyAea0Z
         /b5CtgObLUBamCnxWXLzfIAmKWU1BhIcmKpcdDq0TgtMpP/5QEzmNPRwyU69vOs9x6IC
         QIr9GdPH4lPH7Grg3HLek5KkOIXDXz3H0zbrqw5mO/1rvWr30otziU8hkBYSUJGttnIw
         ow+1adCb9ENKctSDV9rOQ9UrXBNc4+uMKFnH31IXBur6LH+0A3Ye1ZYF7l/LU6g3p+Yi
         pIig+SbmZe2gw4s1Ed58MqqQB3h0Bygs99rPDLsPm3xwZdixQldCvrTgLruoe7p0fzn3
         yxSQ==
X-Gm-Message-State: AOAM5311wuTaWgfhZo7AM+F7+v2JxLzSbirz2xVPmgqqXHXTY3UmNhEB
        PFxE7jpKfNvisHJ2TgzXV1OBqgGhYSiUfKz2uExGnVP0Mylu8Q21x3+Hdikrwdsak+OFegXq39J
        bQdQHiaxBUIbZuENLthuv
X-Received: by 2002:adf:f586:: with SMTP id f6mr4592259wro.299.1601041496244;
        Fri, 25 Sep 2020 06:44:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyzirwf5XpSmefqK4OCJ1HWoHY6oYQyzhyq40peFQP4a/fELc27oT+7SBUBLPslSbZBqRMGQ==
X-Received: by 2002:adf:f586:: with SMTP id f6mr4592230wro.299.1601041495971;
        Fri, 25 Sep 2020 06:44:55 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id p11sm2803109wma.11.2020.09.25.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 06:44:54 -0700 (PDT)
Date:   Fri, 25 Sep 2020 09:44:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        joro@8bytes.org, bhelgaas@google.com, jasowang@redhat.com,
        kevin.tian@intel.com, sebastien.boeuf@intel.com,
        eric.auger@redhat.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200925094405-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200925084806.GB490533@myrica>
 <20200925062230-mutt-send-email-mst@kernel.org>
 <20200925112629.GA1337555@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925112629.GA1337555@myrica>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 25, 2020 at 01:26:29PM +0200, Jean-Philippe Brucker wrote:
> On Fri, Sep 25, 2020 at 06:22:57AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 25, 2020 at 10:48:06AM +0200, Jean-Philippe Brucker wrote:
> > > On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> > > > Add a topology description to the virtio-iommu driver and enable x86
> > > > platforms.
> > > > 
> > > > Since [v2] we have made some progress on adding ACPI support for
> > > > virtio-iommu, which is the preferred boot method on x86. It will be a
> > > > new vendor-agnostic table describing para-virtual topologies in a
> > > > minimal format. However some platforms don't use either ACPI or DT for
> > > > booting (for example microvm), and will need the alternative topology
> > > > description method proposed here. In addition, since the process to get
> > > > a new ACPI table will take a long time, this provides a boot method even
> > > > to ACPI-based platforms, if only temporarily for testing and
> > > > development.
> > > > 
> > > > v3:
> > > > * Add patch 1 that moves virtio-iommu to a subfolder.
> > > > * Split the rest:
> > > >   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
> > > >     support.
> > > >   * Patch 4 adds definitions.
> > > >   * Patch 5 adds parser in topology.c.
> > > > * Address other comments.
> > > > 
> > > > Linux and QEMU patches available at:
> > > > https://jpbrucker.net/git/linux virtio-iommu/devel
> > > > https://jpbrucker.net/git/qemu virtio-iommu/devel
> > > 
> > > I'm parking this work again, until we make progress on the ACPI table, or
> > > until a platform without ACPI and DT needs it. Until then, I've pushed v4
> > > to my virtio-iommu/topo branch and will keep it rebased on master.
> > > 
> > > Thanks,
> > > Jean
> > 
> > I think you guys need to work on virtio spec too, not too much left to
> > do there ...
> 
> I know it's ready and I'd really like to move on with this, but I'd rather
> not commit it to the spec until we know it's going to be used at all. As
> Gerd pointed out the one example we had, microvm, now supports ACPI. Since
> we've kicked off the ACPI work anyway it isn't clear that the built-in
> topology will be useful.
> 
> Thanks,
> Jean

Many power platforms are OF based, thus without ACPI or DT support.

-- 
MST

