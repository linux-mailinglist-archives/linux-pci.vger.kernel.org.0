Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937D93C7A65
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 02:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbhGNAJa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 20:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbhGNAJa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 20:09:30 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAE1C0613DD;
        Tue, 13 Jul 2021 17:06:38 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id s193so2790431qke.4;
        Tue, 13 Jul 2021 17:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BRzBORQqhYkIvSSgRD10J8EaiYQ9ItZJaai9Sym40Us=;
        b=teI5WRKub2F/rwFPxCg0ZINCjBfRJc54nJqUFdAMXpGIMiTspU9RrcrUvARcHwoeMd
         CQXv1wJ/Fog/rhWZSvumcNrgcq+BxotT51h+tTiRDV8aZpevQuwsLDR4vyQtZSmmoC6h
         F9IEcsAuWnvI+dAhgG0Eo2jqsi01XmkKdYdzhKwGl4vTdbqsh5/P7DXsca+16o6s1nU2
         2kLICjJFyej3TGeGHMleEoqCSW2m15wa6CXhxq4NskVTucQzPb/x7tap01fpFeI4k0/I
         0oDywPh08J0yunT5JHEEyAcZVTBsHz7FszjRqikpByO6wq8hJu89C/WxnMp4EIv1s5qc
         +urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BRzBORQqhYkIvSSgRD10J8EaiYQ9ItZJaai9Sym40Us=;
        b=jaCUceWBz0/cYOZU79Cy/ec70DX30Bo1aoN/oPuSkOaiiYTi3SUCKRdyvSv4RzBerP
         1FnrzLRKfxBZ/aFjA13qpVxlv7vqXhNaQFDd2O7A7Ric9gVkgOERzJmLlAln/uTxY60n
         aiT/ocug+AUhyXkbcaieKVSkOhcmNtwsrQw0a/vEfckxmzuAE/E2h7q6dyFUzQIiBxS9
         f7JLGmz/k7fHAt6Iiz6eFA8H0+Asqy57eHziNJeuQua9fSfR+2YxyiZNA/yJX86wvnYQ
         SINmcGetzP8D6ppOFtxJXze34/fBw4odSABy8Me72gNSSTWqtq6RUnRAX9rWGnOSBGI4
         zOqw==
X-Gm-Message-State: AOAM530aHdgwBMIgaujGcK30XvvgoFRjVJW/ih+yMxrCWOZlEBxRBQiS
        uE5rkAMf18C2CAHrZKo5fgE=
X-Google-Smtp-Source: ABdhPJwNdfUqk7dW6v+BkJSkD78e6Hf5RHfzRN9m+TvOapNBOx9APu0hdr4kc7VyqpHBok4bqL0fFQ==
X-Received: by 2002:a05:620a:b85:: with SMTP id k5mr282577qkh.219.1626221197830;
        Tue, 13 Jul 2021 17:06:37 -0700 (PDT)
Received: from fedora ([130.44.160.152])
        by smtp.gmail.com with ESMTPSA id o1sm128098qta.87.2021.07.13.17.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:06:37 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Tue, 13 Jul 2021 20:06:33 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Will Deacon <will@kernel.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
        peterz@infradead.org, benh@kernel.crashing.org,
        joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
        chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
        Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bskeggs@redhat.com, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Thierry Reding <treding@nvidia.com>,
        intel-gfx@lists.freedesktop.org, matthew.auld@intel.com,
        linux-devicetree <devicetree@vger.kernel.org>,
        Jianxiong Gao <jxgao@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
        Nathan Chancellor <nathan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Claire Chang <tientzu@chromium.org>,
        boris.ostrovsky@oracle.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jgross@suse.com, Nicolas Boichat <drinkcat@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
        Tom Lendacky <thomas.lendacky@amd.com>, bauerman@linux.ibm.com
Subject: Re: [PATCH v15 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
Message-ID: <YO4qifiYjL4BTMv4@fedora>
References: <YN/7xcxt/XGAKceZ@Ryzen-9-3900X.localdomain>
 <20210705190352.GA19461@willie-the-truck>
 <20210706044848.GA13640@lst.de>
 <20210706132422.GA20327@willie-the-truck>
 <a59f771f-3289-62f0-ca50-8f3675d9b166@arm.com>
 <20210706140513.GA26498@lst.de>
 <YORsr0h7u5l9DZwh@char.us.oracle.com>
 <20210706165720.GC20750@willie-the-truck>
 <YOSMDZmtfXEKerpf@char.us.oracle.com>
 <20210712135645.GA28881@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712135645.GA28881@willie-the-truck>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

..snip..
> > > I think the main question I have is how would you like to see patches for
> > > 5.15? i.e. as patches on top of devel/for-linus-5.14 or something else?
> > 
> > Yes that would be perfect. If there are any dependencies on the rc1, I
> > can rebase it on top of that.
> 
> Yes, please, rebasing would be very helpful. The broader rework of
> 'io_tlb_default_mem' is going to conflict quite badly otherwise.

There is a devel/for-linus-5.15 (based on v5.14-rc1) now.

Thank you!
> 
> Cheers,
> 
> Will
