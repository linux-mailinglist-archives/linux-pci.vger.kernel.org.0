Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FE734F1C3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 21:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhC3Tru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhC3TrT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 15:47:19 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFEEC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Mar 2021 12:47:19 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q9so8786731qvm.6
        for <linux-pci@vger.kernel.org>; Tue, 30 Mar 2021 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=us5cFBs72fe7SxXP8VCtXnt+ziiJs90xPUDYqlGlda4=;
        b=iqhThtSYPMBCa11dL2go1wgMGuMF9Cb8zrDp2y8EqfH0DocwMxdiYWbuZ5EyM8+ovU
         PS+mFuOD7RB5cihJKf2U9JCBf49uYgZgwrmJRJpDJtPYZH9hW+w5b5EjrcHi2wfyisPe
         /gcc2z6d5ecWarZqgUm9Tg43+vtsCRnbPCGuhGkUaTjTZgISUwAekG+u2HOHkKuvNVpx
         MHY0bz4qOM/hsMiSNAHh2lVVbPe6LK7mBAGJu2bY4UmyhsAY6MSdfSvlx6WVyHp1yJ9d
         CaXxQ4hHeCoKGOlX5W/wz99szvI0EkMH7XrvIXhbHWHicrkOKfaQNA6v0/L63TYCXkC5
         ge8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=us5cFBs72fe7SxXP8VCtXnt+ziiJs90xPUDYqlGlda4=;
        b=ZMH7RR2hT32jjnh3bpEqPjA3glGZobKvcBDGTNkTBa4iU1oqXPHHi43jcqkvSFMRVI
         boEUtfGXn+jfrE/84C+y/oIxpacEAy4chw1uPOVnhbS+rQtcjr7IsPHtUhgRQsLQ0tVG
         hxo/dipxEVAbC7hIrhMOinJ+Lr1p4ZWJNg5MdhHuCKSVld3U/Z/kp2J0OY/OR99+E5gR
         BFs2D5bTC/UhysxvDDu21S8QYo4kKLD1T8M/CjBly6V5kVKtf7ttkTdw2qq4XbTbqvnY
         kMPh2ipv8kMM4cWo6F3oXfdBt4/W2T+tFJqvIxgvq0lKuXVgBmSJ5VC399cXkuR5rBla
         /h0w==
X-Gm-Message-State: AOAM532b8aI4X6wKVYToJbabNSRown1HEA94qCHKibeyN8bw2QP95/PB
        vynuhMXrzCjYiHVk+n1NTD50BA==
X-Google-Smtp-Source: ABdhPJzYBgqOhBM9uIp+LsyGQ6hRK3i1Fqr6p9bBLXmKnWaF92FK8jhlFNPXveU0gWN9z2KKTeasLg==
X-Received: by 2002:ad4:50c7:: with SMTP id e7mr31714410qvq.58.1617133638583;
        Tue, 30 Mar 2021 12:47:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id z124sm16993978qke.36.2021.03.30.12.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 12:47:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lRKKa-0061A8-Oa; Tue, 30 Mar 2021 16:47:16 -0300
Date:   Tue, 30 Mar 2021 16:47:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-rdma@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Don Dutile <ddutile@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH mlx5-next v7 0/4] Dynamically assign MSI-X vectors count
Message-ID: <20210330194716.GV2710221@ziepe.ca>
References: <20210330135738.GU2710221@ziepe.ca>
 <20210330150019.GA1270419@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330150019.GA1270419@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 30, 2021 at 10:00:19AM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 30, 2021 at 10:57:38AM -0300, Jason Gunthorpe wrote:
> > On Mon, Mar 29, 2021 at 08:29:49PM -0500, Bjorn Helgaas wrote:
> > 
> > > I think I misunderstood Greg's subdirectory comment.  We already have
> > > directories like this:
> > 
> > Yes, IIRC, Greg's remark applies if you have to start creating
> > directories with manual kobjects.
> > 
> > > and aspm_ctrl_attr_group (for "link") is nicely done with static
> > > attributes.  So I think we could do something like this:
> > > 
> > >   /sys/bus/pci/devices/0000:01:00.0/   # PF directory
> > >     sriov/                             # SR-IOV related stuff
> > >       vf_total_msix
> > >       vf_msix_count_BB:DD.F        # includes bus/dev/fn of first VF
> > >       ...
> > >       vf_msix_count_BB:DD.F        # includes bus/dev/fn of last VF
> > 
> > It looks a bit odd that it isn't a subdirectory, but this seems
> > reasonable.
> 
> Sorry, I missed your point; you'll have to lay it out more explicitly.
> I did intend that "sriov" *is* a subdirectory of the 0000:01:00.0
> directory.  The full paths would be:
>
>   /sys/bus/pci/devices/0000:01:00.0/sriov/vf_total_msix
>   /sys/bus/pci/devices/0000:01:00.0/sriov/vf_msix_count_BB:DD.F
>   ...

Sorry, I was meaning what you first proposed:

   /sys/bus/pci/devices/0000:01:00.0/sriov/BB:DD.F/vf_msix_count

Which has the extra sub directory to organize the child VFs.

Keep in mind there is going to be alot of VFs here, > 1k - so this
will be a huge directory.

Jason
