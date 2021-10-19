Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5541A43400F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhJSVBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 17:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230454AbhJSVBN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 17:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634677140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4+WNR2eLymnTtTe8KwNWU19Ve6ylf5HkM+bJ6wI1go=;
        b=WfVGgmYJDpxwMDudkAHaMGn8EwZWq0IyG+8otche73r60p9D4mxARWsh5qP1Hhz1myKHPk
        QtntTWccCJjskMnjjD+KgDwNjOfChxNNHYfDjPn1XE8fd65Ii5kAARLaVayJQ10u3sqW30
        fZ94TMgYnk5ZP+0nYqsqEq7zD8zut2Q=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-z0jZtqHJNfS6l2V2P7XuxA-1; Tue, 19 Oct 2021 16:58:59 -0400
X-MC-Unique: z0jZtqHJNfS6l2V2P7XuxA-1
Received: by mail-ot1-f70.google.com with SMTP id b7-20020a0568301de700b0054e351e751aso2459318otj.11
        for <linux-pci@vger.kernel.org>; Tue, 19 Oct 2021 13:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4+WNR2eLymnTtTe8KwNWU19Ve6ylf5HkM+bJ6wI1go=;
        b=QolMoFIGrBstj63QOp0GwVYGDsq8zT/BNmSWWlCtrPP6qntULUv832m46aWphxzquy
         U7xgMGk4iudXBVMiX+8tPtYI81E9AmNbhaD76++UAl3RCvqpqwuzUHnSuT7e3FWALDgi
         XKSYBbnKiFBde2+/Wvt/a84j6g7rDNvbV2a/e3qrYmMdOVvxcbWeoBdxVSzbr5UoVjas
         7lj8SjO5NC4j5hECcqJWJxASyHiVC+g5h46RgDSs+34LNcnZqpS7AKK5tVanD4q9bGY2
         e+fMSoFrU4WwMbVYA+RyUjoeTL0H/TR/kmThFw84a/sGbPVLvAQmGo/VdDo1iSlt/dhq
         XUtw==
X-Gm-Message-State: AOAM533PFJFLbIznx/RWGK/DIGfFIj70+XDsU9E86tSXh8ib7BCTRb/q
        QcWjJkNc8AnjWEDp4mjka7v3MO5iyJSrD/pE63xaLC3y/Ry1XBNjti7UzdbXtxXWC6e9NTsdeMQ
        uzaI/XWGwunTHNdDC/JXj
X-Received: by 2002:a05:6808:13cf:: with SMTP id d15mr4565980oiw.56.1634677138377;
        Tue, 19 Oct 2021 13:58:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsN1oGyRVl+2odsviO25bJteg7tLOBYwgEX1/9Q2C9sqJ4ghXD86BKMaNyc/hkLuVwN+GW2Q==
X-Received: by 2002:a05:6808:13cf:: with SMTP id d15mr4565975oiw.56.1634677138166;
        Tue, 19 Oct 2021 13:58:58 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t8sm41451otc.74.2021.10.19.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:58:57 -0700 (PDT)
Date:   Tue, 19 Oct 2021 14:58:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V2 mlx5-next 12/14] vfio/mlx5: Implement vfio_pci driver
 for mlx5 devices
Message-ID: <20211019145856.2fa7f7c8.alex.williamson@redhat.com>
In-Reply-To: <20211019192328.GZ2744544@nvidia.com>
References: <20211019105838.227569-1-yishaih@nvidia.com>
        <20211019105838.227569-13-yishaih@nvidia.com>
        <20211019124352.74c3b6ba.alex.williamson@redhat.com>
        <20211019192328.GZ2744544@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 19 Oct 2021 16:23:28 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Oct 19, 2021 at 12:43:52PM -0600, Alex Williamson wrote:
> > > +	/* Running switches on */
> > > +	if (((old_state ^ state) & VFIO_DEVICE_STATE_RUNNING) &&
> > > +	    (state & VFIO_DEVICE_STATE_RUNNING)) {
> > > +		ret = mlx5vf_pci_unfreeze_device(mvdev);
> > > +		if (ret)
> > > +			return ret;
> > > +		ret = mlx5vf_pci_unquiesce_device(mvdev);
> > > +		if (ret) {
> > > +			vmig->vfio_dev_state = VFIO_DEVICE_STATE_ERROR;
> > > +			return ret;
> > > +		}
> > > +	}  
> > 
> > Per previous discussion, I understand that freeze and quiesce are
> > loosely stop-responding-to-dma and stop-sending-dma, respectively.
> > Once we're quiesced and frozen, device state doesn't change.  What are
> > the implications to userspace that we don't expose a quiesce state
> > (yet)?  I'm wondering if this needs to be resolved before we introduce
> > our first in-tree user of the uAPI (and before QEMU support becomes
> > non-experimental).  Thanks,  
> 
> The prototype patch I saw added a 4th bit to the state which was
>    1 == 'not dma initiating'
> As you suggested I think a cap bit someplace should be defined if the
> driver supports the 4th bit.
> 
> Otherwise, I think it is backwards compatible, the new logic would be
> two ifs
> 
>  if ((flipped & STATE_NDMA) &&
>       (flipped & (STATE_NDMA | STATE_RUNNING)) == STATE_NDMA | STATE_RUNNING)
>       mlx5vf_pci _quiesce_device()
> 
>  [..]
> 
>  if ((flipped == (STATE_NDMA)) &&
>       (flipped & (STATE_NDMA | STATE_RUNNING)) == STATE_RUNNING)
>       mlx5vf_pci_unquiesce_device()
> 
> Sequenced before/after the other calls to quiesce_device
> 
> So if userspace doesn't use it then the same driver behavior is kept,
> as it never sees STATE_NDMA flip
> 
> Asking for STATE_NDMA !STATE_RUNNING is just ignored because !RUNNING
> already implies NDMA
> 
> .. and some optimization of the logic to avoid duplicated work

Ok, so this new bit just augments how the device interprets _RUNNING,
it's essentially a don't-care relative to _SAVING or _RESTORING.

I think that gives us this table:

|   NDMA   | RESUMING |  SAVING  |  RUNNING |
+----------+----------+----------+----------+ ---
|     X    |     0    |     0    |     0    |  ^
+----------+----------+----------+----------+  |
|     0    |     0    |     0    |     1    |  |
+----------+----------+----------+----------+  |
|     X    |     0    |     1    |     0    |
+----------+----------+----------+----------+  NDMA value is either compatible
|     0    |     0    |     1    |     1    |  to existing behavior or don't
+----------+----------+----------+----------+  care due to redundancy vs
|     X    |     1    |     0    |     0    |  !_RUNNING/INVALID/ERROR
+----------+----------+----------+----------+
|     X    |     1    |     0    |     1    |  |
+----------+----------+----------+----------+  |
|     X    |     1    |     1    |     0    |  |
+----------+----------+----------+----------+  |
|     X    |     1    |     1    |     1    |  v
+----------+----------+----------+----------+ ---
|     1    |     0    |     0    |     1    |  ^
+----------+----------+----------+----------+  Desired new useful cases
|     1    |     0    |     1    |     1    |  v
+----------+----------+----------+----------+ ---

Specifically, rows 1, 3, 5 with NDMA = 1 are valid states a user can
set which are simply redundant to the NDMA = 0 cases.  Row 6 remains
invalid due to lack of support for pre-copy (_RESUMING | _RUNNING) and
therefore cannot be set by userspace.  Rows 7 & 8 are error states and
cannot be set by userspace.

Like other bits, setting the bit should be effective at the completion
of writing device state.  Therefore the device would need to flush any
outbound DMA queues before returning.

The question I was really trying to get to though is whether we have a
supportable interface without such an extension.  There's currently
only an experimental version of vfio migration support for PCI devices
in QEMU (afaik), so it seems like we could make use of the bus-master
bit to fill this gap in QEMU currently, before we claim
non-experimental support, but this new device agnostic extension would
be required for non-PCI device support (and PCI support should adopt it
as available).  Does that sound right?  Thanks,

Alex

