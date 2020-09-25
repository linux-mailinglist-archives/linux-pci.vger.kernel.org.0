Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1571278500
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 12:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgIYKXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 06:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgIYKXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 06:23:13 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601029392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8U1FHT96w/PLZq5zU9S1B7ShBJVy7YnIM6zbSDnntI=;
        b=iBvhsCG/i415xEc64PjOVd3SPNTf+l0+P9y4OKS5sjWRuIh3XNORj5+cB9zye4uEcXEoyM
        byRbdKgK/qvUuzRYSOFACF6hgtPGetHKdwCCt04r9CPMbsuobdMwXZ/i6OtU0MQotC+jk2
        jmfFql6cU6yQVwWQSMcuXqFf6Sfthw8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-Z4gcJpY_NLuWrzOqUy7fvA-1; Fri, 25 Sep 2020 06:23:02 -0400
X-MC-Unique: Z4gcJpY_NLuWrzOqUy7fvA-1
Received: by mail-wr1-f72.google.com with SMTP id a12so892855wrg.13
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 03:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N8U1FHT96w/PLZq5zU9S1B7ShBJVy7YnIM6zbSDnntI=;
        b=JexoHSShjCKbpb3ayuVQ24NL7pirqs0Oblw/SD+9TVIAxNdCuRgKB4ysc3QTD6HMln
         2V19/rNNuEGQcEofnwRBm1kH1rSzm78CVI79S0simNVjiDF1XtLJuhmS4ufyClxKl2vi
         JGH4jyXwz36+9ru7EzLpj/5nvH5ZXkOzy1x4wPJCe4AxCBq+FcGhnkIEOo1zKoWgLtXL
         YHCuOUiqJVbIXKg6MU2mJTzZMlglxqQKbzwoZOEyzwVD9hCJrmhuBBKiDjoUo99Yb3lO
         Tg6ajzmW+kXW+lEFtK1p15UFCWWsJbuTSKKfW1Jah6xUKnpsbfQX63UNd1lBbLX/lE5T
         pLdg==
X-Gm-Message-State: AOAM533h1x5xDaJ9gfmUknsF30sG/1tpiecwSZZsHMA+stxng6to6pPx
        H9ECzhlYiZH71nh293lONQpMVdReGLWsHt4F0vVsAyUQnxZ3m2YNrNJRhQ9pEf7qXd6lSx4f+TA
        bUtgQh7zNwAuP7Tdw7LoN
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr3728304wrw.331.1601029381666;
        Fri, 25 Sep 2020 03:23:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiECiPGTS15kvZqa8R0xHOPr4KjpmYEDueiFgt/xYTRs755Rb+d0YFWnl/vVYKdot5K3D6nQ==
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr3728283wrw.331.1601029381484;
        Fri, 25 Sep 2020 03:23:01 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id d9sm2246590wmb.30.2020.09.25.03.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 03:23:00 -0700 (PDT)
Date:   Fri, 25 Sep 2020 06:22:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        joro@8bytes.org, bhelgaas@google.com, jasowang@redhat.com,
        kevin.tian@intel.com, sebastien.boeuf@intel.com,
        eric.auger@redhat.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200925062230-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200925084806.GB490533@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925084806.GB490533@myrica>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 25, 2020 at 10:48:06AM +0200, Jean-Philippe Brucker wrote:
> On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> > Add a topology description to the virtio-iommu driver and enable x86
> > platforms.
> > 
> > Since [v2] we have made some progress on adding ACPI support for
> > virtio-iommu, which is the preferred boot method on x86. It will be a
> > new vendor-agnostic table describing para-virtual topologies in a
> > minimal format. However some platforms don't use either ACPI or DT for
> > booting (for example microvm), and will need the alternative topology
> > description method proposed here. In addition, since the process to get
> > a new ACPI table will take a long time, this provides a boot method even
> > to ACPI-based platforms, if only temporarily for testing and
> > development.
> > 
> > v3:
> > * Add patch 1 that moves virtio-iommu to a subfolder.
> > * Split the rest:
> >   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
> >     support.
> >   * Patch 4 adds definitions.
> >   * Patch 5 adds parser in topology.c.
> > * Address other comments.
> > 
> > Linux and QEMU patches available at:
> > https://jpbrucker.net/git/linux virtio-iommu/devel
> > https://jpbrucker.net/git/qemu virtio-iommu/devel
> 
> I'm parking this work again, until we make progress on the ACPI table, or
> until a platform without ACPI and DT needs it. Until then, I've pushed v4
> to my virtio-iommu/topo branch and will keep it rebased on master.
> 
> Thanks,
> Jean

I think you guys need to work on virtio spec too, not too much left to
do there ...

-- 
MST

