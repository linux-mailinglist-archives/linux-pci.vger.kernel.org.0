Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF514BA6D2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 18:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbiBQRQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 12:16:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiBQRQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 12:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD9CC2B04A8
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645118158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vK764Lcwway8Tvw3MqNXFsVBTl99kT8sKodI/qvZ50Q=;
        b=DjoYVZ6nsXlJy3G3NDkTSzxCOVzb6RW61KqIEpQht5a6gh2WZYsLGqe3AsYsSsV+xZiE7d
        sI+OqteidJZmr6p6xU6u9omjlgnUYhtcCcVDcYHPAWc9NXCtFHgJ9JFyrEnSowOU2iu9gh
        e0E2UcXk+AgUJMZuPllQO6X5XhtR9vU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-U8S9ViY1MKiLShF8jHYz1A-1; Thu, 17 Feb 2022 12:15:57 -0500
X-MC-Unique: U8S9ViY1MKiLShF8jHYz1A-1
Received: by mail-il1-f200.google.com with SMTP id i17-20020a925411000000b002bf4c9c4142so2337726ilb.6
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 09:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=vK764Lcwway8Tvw3MqNXFsVBTl99kT8sKodI/qvZ50Q=;
        b=RoMfwPJs84oyUk++iUkTwy88pB6pNsywuvEnwY7odUSzGEZJCj88afgYeLku/ViOXZ
         R40abzJWrbFt1PID/1MT10p+BNDDVYxeykfxs3ehMOqDcnYIqUMjv8uu36Y7p5I4pRO/
         n6bzdShkZvqVNaUr0Y6QdAnjik4lIz8NPlyeebEhlcZa/+8p2gQNLQW5pK147tvJ+gsj
         uFl2FdS380kLZI5ZLahX+a7TRKNqffBtH/iER20EVQnDFsHcdMmIi6e2LOrBXkMR/k01
         DjzA2ISydx2XzlESVh9ic9LgPU3LJqECscVxWeJLN1S0TkJeeav/9Lz1RUasc6TtjuhS
         aPrg==
X-Gm-Message-State: AOAM530CDg/UiiS2rRbkwouJDcr7SxLHmjLODwzGFSbdDPqzaYOirX2L
        paNuAha4eiQJdnKLo4/LCliggwApkSijSNux3Ym+tw+X8/tmBjVWXy4aYITJJ8nGv1VRcueD2oW
        g2gS1zVMe3v9Swi04Jv2T
X-Received: by 2002:a6b:c84f:0:b0:637:d023:4cc8 with SMTP id y76-20020a6bc84f000000b00637d0234cc8mr2557794iof.215.1645118156885;
        Thu, 17 Feb 2022 09:15:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6CJylLowRlY5qgrihQ8i0FkpuKzcystck5XFkiKaJ3yLL2prCoiA4Yqva8IVPc1yVFdWf8g==
X-Received: by 2002:a6b:c84f:0:b0:637:d023:4cc8 with SMTP id y76-20020a6bc84f000000b00637d0234cc8mr2557776iof.215.1645118156640;
        Thu, 17 Feb 2022 09:15:56 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y7sm2094197ila.7.2022.02.17.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:15:56 -0800 (PST)
Date:   Thu, 17 Feb 2022 10:15:54 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     <bhelgaas@google.com>, <jgg@nvidia.com>, <saeedm@nvidia.com>,
        <linux-pci@vger.kernel.org>, <kvm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <kuba@kernel.org>, <leonro@nvidia.com>,
        <kwankhede@nvidia.com>, <mgurtovoy@nvidia.com>, <maorg@nvidia.com>,
        <ashok.raj@intel.com>, <kevin.tian@intel.com>,
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH V7 mlx5-next 15/15] vfio: Extend the device migration
 protocol with PRE_COPY
Message-ID: <20220217101554.26f05eb1.alex.williamson@redhat.com>
In-Reply-To: <20220207172216.206415-16-yishaih@nvidia.com>
References: <20220207172216.206415-1-yishaih@nvidia.com>
        <20220207172216.206415-16-yishaih@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 7 Feb 2022 19:22:16 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> The optional PRE_COPY states open the saving data transfer FD before
> reaching STOP_COPY and allows the device to dirty track internal state
> changes with the general idea to reduce the volume of data transferred
> in the STOP_COPY stage.
> 
> While in PRE_COPY the device remains RUNNING, but the saving FD is open.
> 
> Only if the device also supports RUNNING_P2P can it support PRE_COPY_P2P,
> which halts P2P transfers while continuing the saving FD.
> 
> PRE_COPY, with P2P support, requires the driver to implement 7 new arcs
> and exists as an optional FSM branch between RUNNING and STOP_COPY:
>     RUNNING -> PRE_COPY -> PRE_COPY_P2P -> STOP_COPY
> 
> A new ioctl VFIO_DEVICE_MIG_PRECOPY is provided to allow userspace to
> query the progress of the precopy operation in the driver with the idea it
> will judge to move to STOP_COPY at least once the initial data set is
> transferred, and possibly after the dirty size has shrunk appropriately.
> 
> We think there may also be merit in future extensions to the
> VFIO_DEVICE_MIG_PRECOPY ioctl to also command the device to throttle the
> rate it generates internal dirty state.
> 
> Compared to the v1 clarification, STOP_COPY -> PRE_COPY is made optional
> and to be defined in future. While making the whole PRE_COPY feature
> optional eliminates the concern from mlx5, this is still a complicated arc
> to implement and seems prudent to leave it closed until a proper use case
> is developed. We also split the pending_bytes report into the initial and
> sustaining values, and define the protocol to get an event via poll() for
> new dirty data during PRE_COPY.

I feel obligated to ask, is PRE_COPY support essentially RFC at this
point since we have no proposed in-kernel users?

It seems like we're winding down comments on the remainder of the
series and I feel ok with where it's headed and the options we have
available for future extensions.  Pre-copy seems like an important gap
to fill and I think this patch shows that a future extension could
allow it, but with the scrutiny not to add unused code to the kernel,
I'm not sure there's a valid justification to add it now.  Thanks,

Alex

PS - Why is this a stand-alone ioctl rather than a DEVICE_FEATURE?

