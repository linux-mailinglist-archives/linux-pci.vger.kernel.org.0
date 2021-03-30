Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98834F46B
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 00:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhC3WoH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 18:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhC3Wno (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 18:43:44 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF6FC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Mar 2021 15:43:44 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id by2so9025339qvb.11
        for <linux-pci@vger.kernel.org>; Tue, 30 Mar 2021 15:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IIcMx65Xjr6sarStui031eegAp4rV6obXVhOlQJIwcc=;
        b=FQ/X78Gbn8/AFNwcq4uV6BvYxVjO/FZq1cc/UBBzbENb562ZGF1qzbA+L6Q3dUanBh
         FuhyHM605A6tbhClVXEZTJuMdiGxIuRD8KfdU7mx2+6a0iumko1k/zWm/UnBdllmHFMp
         a2tQPAY0RxnrVsxydwGZB7ezBf3B4/paHcHkQRshyILx+XSOPRj6HTECVyfmE+1Vq9Y8
         9qZ2jGVD/PpY5SPnkGCCt8piBbaaZOW14Tvttaac+T34z/2CfsufKwNFOd/o6Av86U0S
         5d2a18QD6s2mm88Vvg5hR1vT29ZmAl/aBq7VgdaitGLRdv1bCCCvWb5g9U8udQctoknr
         y9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IIcMx65Xjr6sarStui031eegAp4rV6obXVhOlQJIwcc=;
        b=AGJ90MVv7kuR5meVnzAlGm9TlxDzO48uT+vXoT/z/yCyTCIRfgJUnFxGFA5wudmevG
         ENMuPSkUz5fcHxXSu6VwCnczSS3yxXyadnnpg4Rv0CbKqWgNxpJzTB11EmCMh1xOLQMt
         fdzuqjXuod/erIThZSwiuj/K6sOMHD4Up7szVpCQJ5xPod07MtNMNoYFO67gqeFJKfZk
         8MuAIp0jW/aa/TiZNfcyUeZ20dOqhV0F4AuZLzpYFA/UHU+tToG0xegYmDzXygMCS/D5
         vDhplkl1FTr1E6r6smk8fwY/R9Z+r9cP+1ZHlp5bc35GlDr45Ka9w5cCdibxSXLVzCDH
         xWsQ==
X-Gm-Message-State: AOAM533V8BKcfz7RywtQmqsZS1nGyK7zu4np3NFj7ruRbgh7AQ2N51s5
        8XXNwtJnP6Q71WLbLewocVRzcg==
X-Google-Smtp-Source: ABdhPJxfStxN1I9QH0d4CFABSpYm5eXMQ23kcbQyRo7RfO6qbRToZW/i10SiBS/nmAtb366ke0iZhQ==
X-Received: by 2002:a0c:e148:: with SMTP id c8mr453944qvl.56.1617144223164;
        Tue, 30 Mar 2021 15:43:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id j6sm120559qkm.81.2021.03.30.15.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:43:42 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lRN5J-0066i3-Ij; Tue, 30 Mar 2021 19:43:41 -0300
Date:   Tue, 30 Mar 2021 19:43:41 -0300
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
Message-ID: <20210330224341.GW2710221@ziepe.ca>
References: <20210330194716.GV2710221@ziepe.ca>
 <20210330204141.GA1305530@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330204141.GA1305530@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 30, 2021 at 03:41:41PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 30, 2021 at 04:47:16PM -0300, Jason Gunthorpe wrote:
> > On Tue, Mar 30, 2021 at 10:00:19AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Mar 30, 2021 at 10:57:38AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Mar 29, 2021 at 08:29:49PM -0500, Bjorn Helgaas wrote:
> > > > 
> > > > > I think I misunderstood Greg's subdirectory comment.  We already have
> > > > > directories like this:
> > > > 
> > > > Yes, IIRC, Greg's remark applies if you have to start creating
> > > > directories with manual kobjects.
> > > > 
> > > > > and aspm_ctrl_attr_group (for "link") is nicely done with static
> > > > > attributes.  So I think we could do something like this:
> > > > > 
> > > > >   /sys/bus/pci/devices/0000:01:00.0/   # PF directory
> > > > >     sriov/                             # SR-IOV related stuff
> > > > >       vf_total_msix
> > > > >       vf_msix_count_BB:DD.F        # includes bus/dev/fn of first VF
> > > > >       ...
> > > > >       vf_msix_count_BB:DD.F        # includes bus/dev/fn of last VF
> > > > 
> > > > It looks a bit odd that it isn't a subdirectory, but this seems
> > > > reasonable.
> > > 
> > > Sorry, I missed your point; you'll have to lay it out more explicitly.
> > > I did intend that "sriov" *is* a subdirectory of the 0000:01:00.0
> > > directory.  The full paths would be:
> > >
> > >   /sys/bus/pci/devices/0000:01:00.0/sriov/vf_total_msix
> > >   /sys/bus/pci/devices/0000:01:00.0/sriov/vf_msix_count_BB:DD.F
> > >   ...
> > 
> > Sorry, I was meaning what you first proposed:
> > 
> >    /sys/bus/pci/devices/0000:01:00.0/sriov/BB:DD.F/vf_msix_count
> > 
> > Which has the extra sub directory to organize the child VFs.
> > 
> > Keep in mind there is going to be alot of VFs here, > 1k - so this
> > will be a huge directory.
> 
> With 0000:01:00.0/sriov/vf_msix_count_BB:DD.F, sriov/ will contain
> 1 + 1K files ("vf_total_msix" + 1 per VF).
> 
> With 0000:01:00.0/sriov/BB:DD.F/vf_msix_count, sriov/ will contain
> 1 file and 1K subdirectories.

The smallest directory sizes is with the current patch since it
re-uses the existing VF directory. Do we care about directory size at
the sysfs level?
 
> No real difference now, but if we add more files per VF, a BB:DD.F/
> subdirectory would certainly be nicer.

Hard to know if that will happen, there is a lot of 'pre-driver'
configuration but it seems to mostly be living in other places. 

If this is restricted to be only the generic PCI attributes (and I
think it should be) I'm having a hard time coming up with a future
extension.

> I'm dense and don't fully understand Greg's subdirectory comment.

I also don't know udev well enough. I've certainly seen drivers
creating extra subdirectories using kobjects.

> But it doesn't seem like that level of control would be in a udev rule
> anyway.  A PF udev rule might *start* a program to manage MSI-X
> vectors, but such a program should be able to deal with whatever
> directory structure we want.

Yes, I can't really see this being used from udev either. 

I assume there is also the usual race about triggering the uevent
before the subdirectories are created, but we have the
dev_set_uevent_suppress() thing now for that..

Jason
