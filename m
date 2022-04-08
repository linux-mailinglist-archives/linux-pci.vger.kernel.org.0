Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4834F9A1A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 18:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiDHQKA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 12:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiDHQKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 12:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 955613468D3
        for <linux-pci@vger.kernel.org>; Fri,  8 Apr 2022 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649434075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZJpwOwiX6p1TLjytT0LkEmh312IajsdmsbzULaJOWo=;
        b=LZdtz12k5N3E9fUlWjAfCnjUa4py3cAf/GdWklCo5hT5v2ERW/yCZvZu6RRQ0dE3Aeoywx
        vMTyz0SoBD6RJZhxrYJLqf6gFj6gDGrdYerlN4IquC9coF+hwkM1Cprh39Pq5h2gD4bgye
        xfGqYU33gdcd8pUGiifAshrV6PAtCrw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-i8eT3FPdMfajO42B6QUG4w-1; Fri, 08 Apr 2022 12:07:54 -0400
X-MC-Unique: i8eT3FPdMfajO42B6QUG4w-1
Received: by mail-io1-f70.google.com with SMTP id f5-20020a6be805000000b00649b9faf257so6024944ioh.9
        for <linux-pci@vger.kernel.org>; Fri, 08 Apr 2022 09:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=UZJpwOwiX6p1TLjytT0LkEmh312IajsdmsbzULaJOWo=;
        b=MYFM3DK09o4yGnfH5RnrPJcHzzsUVgQDUYO/bRR6CKIjuZEePXTqCubhOBgXi8Eoa/
         rqOrmN/jM8rP6NKceQhmDq7dvzm58yR6+/3OYJAcU1NPwGJE1xCspxHN6zpFGKXXDAMY
         WmcpPyURmiboHsBATzFtMKyyrar7CNZtDL6jfa1Fs8wHyLtp7SP0ZzfvHnzfhfv2tr9I
         mVg19ZXfW3Kn37C01DhTj15V0TRiQpeVS3GY0n6HEniwccZ2qz4ivrwLPjjn0dcGeCD2
         fHVek85OD+nbgvQMVZuKJ/fpacb+/GA6Ao8nVAZc0KSoXcbE/T6xtXvF/jnHhCHUngPj
         HN+g==
X-Gm-Message-State: AOAM531IUWOw/GD8NS0Zh/bENnz5vraNx6BBIbCnCAYWe/acNtxy0Cky
        rxRPTGdCPH9v+eKEaFPIfmHZldL1cBX2huZCbLPKo5i/W5dynWncQEfFH5+JrDW7OUxeJGNh/b1
        QB3FcItDg4S+/Y6fTh8HN
X-Received: by 2002:a92:c545:0:b0:2ca:1066:3d6 with SMTP id a5-20020a92c545000000b002ca106603d6mr9493052ilj.229.1649434073899;
        Fri, 08 Apr 2022 09:07:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/TufIImKux5pz6Rl4XI7KZTQV93OrbFNaYKMbngwhu1qKZ7ch3Hl40CSX8DSWlDm9zc9qJw==
X-Received: by 2002:a92:c545:0:b0:2ca:1066:3d6 with SMTP id a5-20020a92c545000000b002ca106603d6mr9493027ilj.229.1649434073692;
        Fri, 08 Apr 2022 09:07:53 -0700 (PDT)
Received: from redhat.com ([98.55.18.59])
        by smtp.gmail.com with ESMTPSA id s5-20020a056602168500b0064c82210ce4sm15878688iow.13.2022.04.08.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:07:53 -0700 (PDT)
Date:   Fri, 8 Apr 2022 10:07:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
        David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220408100750.77fd9ffc.alex.williamson@redhat.com>
In-Reply-To: <20220408155922.GA317094@bhelgaas>
References: <YlBWrE7kxX9vraOD@8bytes.org>
        <20220408155922.GA317094@bhelgaas>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 8 Apr 2022 10:59:22 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Apr 08, 2022 at 05:37:16PM +0200, Joerg Roedel wrote:
> > On Fri, Apr 08, 2022 at 11:17:47AM -0300, Jason Gunthorpe wrote:  
> > > You might consider using a linear tree instead of the topic branches,
> > > topics are tricky and I'm not sure it helps a small subsystem so much.
> > > Conflicts between topics are a PITA for everyone, and it makes
> > > handling conflicts with rc much harder than it needs to be.  
> > 
> > I like the concept of a branch per driver, because with that I can just
> > exclude that branch from my next-merge when there are issues with it.
> > Conflicts between branches happen too, but they are quite manageable
> > when the branches have the same base.  
> 
> FWIW, I use the same topic branch approach for PCI.  I like the
> ability to squash in fixes or drop things without having to clutter
> the history with trivial commits and reverts.  I haven't found
> conflicts to be a problem.

Same.  I think I've generally modeled my branch handling after Bjorn
and Joerg, I don't always use topic branches, but will for larger
contributions and I don't generally find conflicts to be a problem.
I'm always open to adopting best practices though.  Thanks,

Alex

