Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6962442FD45
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 23:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbhJOVPA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 17:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243063AbhJOVO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 17:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634332369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=weAZOzcimLn9TcTx54d1qD50QofXmr04GPHd/Nkp3yc=;
        b=e+bmhGAW5Lq21AWVWVel8J6143aUnPwOZ+ulHBULkwbVjKfC8Xq/XjMAiDHV+zy89UjOt8
        EldyoXVX9P2TEje3TcN+YHv6GI9c8EWTQ6PyMVFv3XliShXmVLuTXc/Ab21Dj3umXNxx5n
        hLtTbgUmt17EmeA795xWaY0psg6l86I=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-8wnSiqwjOjOgcsR4JKSHtg-1; Fri, 15 Oct 2021 17:12:48 -0400
X-MC-Unique: 8wnSiqwjOjOgcsR4JKSHtg-1
Received: by mail-ot1-f72.google.com with SMTP id i14-20020a056830402e00b0054dd0ce0d1dso6308157ots.19
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 14:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=weAZOzcimLn9TcTx54d1qD50QofXmr04GPHd/Nkp3yc=;
        b=is4CFn2Ythw4mQCp2VfRbERoFJtOYi7WK3P3ViYRIrF/lUgpEyyU2qmM/OvEUS3Wq/
         OgfxG/z9CCjwMLyW9mxcA6wWUkFFL9se/7RkbPRB8SFRg2wFaZXMvTDJQZxAiPyg/ktn
         tQnG8GvgTah/Mx+6j9ll5tRzJMAGfD8b/j0SGldb8Nvpgfs+k7u0i+TEGo6DtfenRpJv
         M1xwTPP+GphQOHVIDH8Odbf5cWAi7jiW5yaeTzRSK7r/s5dHfbjmkgDKo1/3bIccGlSt
         7kaB/EP52O31Hp7LW+qCLsTzAG4LB6i+vUQrFj8/5QBGRBnW8mntktDJC1SKQBbMvSsA
         1WfA==
X-Gm-Message-State: AOAM533xniaHZVwmp45dcdX9eM3/eBYoW41UIEd831PdylAZH8j4uv2U
        XTLdanlG3h3ASJIKsTnucZF4dJy3NNZdcca1lOOh1+1r0h6dhslRRGsCnG3IwtI0cKy80pyyGrF
        6wqnDb3sNhOjwi7arGVmt
X-Received: by 2002:a4a:b282:: with SMTP id k2mr10450160ooo.11.1634332366161;
        Fri, 15 Oct 2021 14:12:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoAojjBNArO7t601HnDHe1CSsfX+KCR+pGZCiebFDNtXd/IxGPbZjTG6dLcXRMcmQeR3Rs9g==
X-Received: by 2002:a4a:b282:: with SMTP id k2mr10450141ooo.11.1634332365962;
        Fri, 15 Oct 2021 14:12:45 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q15sm1434362otm.15.2021.10.15.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 14:12:45 -0700 (PDT)
Date:   Fri, 15 Oct 2021 15:12:43 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V1 mlx5-next 12/13] vfio/pci: Add infrastructure to let
 vfio_pci_core drivers trap device RESET
Message-ID: <20211015151243.3c5b0910.alex.williamson@redhat.com>
In-Reply-To: <20211015200328.GG2744544@nvidia.com>
References: <20211013094707.163054-1-yishaih@nvidia.com>
        <20211013094707.163054-13-yishaih@nvidia.com>
        <20211015135237.759fe688.alex.williamson@redhat.com>
        <20211015200328.GG2744544@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 15 Oct 2021 17:03:28 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Oct 15, 2021 at 01:52:37PM -0600, Alex Williamson wrote:
> > On Wed, 13 Oct 2021 12:47:06 +0300
> > Yishai Hadas <yishaih@nvidia.com> wrote:
> >   
> > > Add infrastructure to let vfio_pci_core drivers trap device RESET.
> > > 
> > > The motivation for this is to let the underlay driver be aware that
> > > reset was done and set its internal state accordingly.  
> > 
> > I think the intention of the uAPI here is that the migration error
> > state is exited specifically via the reset ioctl.  Maybe that should be
> > made more clear, but variant drivers can already wrap the core ioctl
> > for the purpose of determining that mechanism of reset has occurred.  
> 
> It is not just recovering the error state.
> 
> Any transition to reset changes the firmware state. Eg if userspace
> uses one of the other emulation paths to trigger the reset after
> putting the device off running then the driver state and FW state
> become desynchronized.
> 
> So all the reset paths need to be synchronized some how, either
> blocked while in non-running states or aligning the SW state with the
> new post-reset FW state.

This only catches the two flavors of FLR and the RESET ioctl itself, so
we've got gaps relative to "all the reset paths" anyway.  I'm also
concerned about adding arbitrary callbacks for every case that it gets
too cumbersome to write a wrapper for the existing callbacks.

However, why is this a vfio thing when we have the
pci_error_handlers.reset_done callback.  At best this ought to be
redundant to that.  Thanks,

Alex

