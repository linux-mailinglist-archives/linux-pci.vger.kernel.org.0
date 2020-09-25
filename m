Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09E2785BD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 13:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgIYL0u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 07:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgIYL0u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 07:26:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E9C0613CE
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 04:26:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so2655791wmd.5
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A60QA7/hIdfukqiV/j0jVbWiv3LMArbDpJyApzX3WvI=;
        b=ftqCBkfn/C4p7By9V/KyZFqPJeZy7/xn1PfcJxEBZdug495AZSrw033D60K7eAB6Ig
         T98+fFtAtR2fMfrf4YpUyoeQAItmIPpMlw70708iaz4Mys8RWfY2L98A6R2XRNA82dEr
         a08VdMoZwpfa9+SIFcuqZyeGWLJU3y8eSbJDwTprwOVIB1VgWpnJf2RaAPIGgXd8cIrK
         Pu0SWfemDZSdI8Ed0fXEr6cbjjHFarJER4aRSRYls0ebusVExXYK1NbWWwqy1Il2FhLO
         qOa+1Tog0CADvniUdEJMYfA7Bsk0DoYsFbpV1Pp5Khcuf7QbdoWqeYDorAGSyVqjNm+y
         zsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A60QA7/hIdfukqiV/j0jVbWiv3LMArbDpJyApzX3WvI=;
        b=OfcmvwxndXgEFyqbX5BsjEIVSxC/8gKKSFzxc7hKqcaB+asE1ahWq4emZRp606DHXi
         AM7iblNtlB6EJgMPel09MZ8vzgEZOj3jBWh1CMZ3ttqTeRiShxrfRArg1kO9M0cVfVSp
         uSEwvX/a88+zYxF4QIX6uI7LG6RcnuQGSnlH3WW3rdOZJhSyZ2qm2g2ylV0fwkuqrhtL
         Xn9EpcIQ/iVYpS1+I63BzmScoECHB/RAXThetT0ClxF0xHuMGcim3iuNENtY71MCGMca
         2wElhxsWYvL2eyVlF7b5BTzag9l5BmQnh3KS06pzLCeeVUSog3+fefHMKxdZLvnFvHSq
         0vcg==
X-Gm-Message-State: AOAM531JygFFs3I/kT7QwOObNBM4r5VaFThZ1O9OSfnNtWluTBKWr7d9
        8rHtoZBIaotTMgGOiMIqkSN14/y9tQFd0l5JZFw=
X-Google-Smtp-Source: ABdhPJyv13qwG5g2DgIM8ecyiaNCHrI1193NKi2NMlWF2QntaY8OnbgiSNf16JhwZ6M3gzNUrPJS7g==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr2764224wmi.53.1601033208483;
        Fri, 25 Sep 2020 04:26:48 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w7sm2422588wmc.43.2020.09.25.04.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 04:26:47 -0700 (PDT)
Date:   Fri, 25 Sep 2020 13:26:29 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        joro@8bytes.org, bhelgaas@google.com, jasowang@redhat.com,
        kevin.tian@intel.com, sebastien.boeuf@intel.com,
        eric.auger@redhat.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200925112629.GA1337555@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200925084806.GB490533@myrica>
 <20200925062230-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925062230-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 25, 2020 at 06:22:57AM -0400, Michael S. Tsirkin wrote:
> On Fri, Sep 25, 2020 at 10:48:06AM +0200, Jean-Philippe Brucker wrote:
> > On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> > > Add a topology description to the virtio-iommu driver and enable x86
> > > platforms.
> > > 
> > > Since [v2] we have made some progress on adding ACPI support for
> > > virtio-iommu, which is the preferred boot method on x86. It will be a
> > > new vendor-agnostic table describing para-virtual topologies in a
> > > minimal format. However some platforms don't use either ACPI or DT for
> > > booting (for example microvm), and will need the alternative topology
> > > description method proposed here. In addition, since the process to get
> > > a new ACPI table will take a long time, this provides a boot method even
> > > to ACPI-based platforms, if only temporarily for testing and
> > > development.
> > > 
> > > v3:
> > > * Add patch 1 that moves virtio-iommu to a subfolder.
> > > * Split the rest:
> > >   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
> > >     support.
> > >   * Patch 4 adds definitions.
> > >   * Patch 5 adds parser in topology.c.
> > > * Address other comments.
> > > 
> > > Linux and QEMU patches available at:
> > > https://jpbrucker.net/git/linux virtio-iommu/devel
> > > https://jpbrucker.net/git/qemu virtio-iommu/devel
> > 
> > I'm parking this work again, until we make progress on the ACPI table, or
> > until a platform without ACPI and DT needs it. Until then, I've pushed v4
> > to my virtio-iommu/topo branch and will keep it rebased on master.
> > 
> > Thanks,
> > Jean
> 
> I think you guys need to work on virtio spec too, not too much left to
> do there ...

I know it's ready and I'd really like to move on with this, but I'd rather
not commit it to the spec until we know it's going to be used at all. As
Gerd pointed out the one example we had, microvm, now supports ACPI. Since
we've kicked off the ACPI work anyway it isn't clear that the built-in
topology will be useful.

Thanks,
Jean
