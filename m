Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58674B136A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 17:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbiBJQsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 11:48:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244967AbiBJQsP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 11:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 222BBEE
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 08:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644511695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53BPBlXQ9S5Ov+amkvoqYiyiQymDxhLzSDn632g3AnI=;
        b=TqQCAEFvVu2MN5IrnUqyRUIB3OC6sQ2O+rt3S0dNNM7lkrQ2VaPcpFIFxlj3pgXymt4KoN
        v55Oyao0ikkeC8Dg/5UycuK/kExBgqAZ4fCRQx4TWG/ufhAP9Izek0Dqkh4nz3I6bJ794d
        bILgDDoUSdqX1LRzbAOI/KubtoxzN/g=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-zFXj2_DCPPSYSZB9trN7Aw-1; Thu, 10 Feb 2022 11:48:14 -0500
X-MC-Unique: zFXj2_DCPPSYSZB9trN7Aw-1
Received: by mail-oi1-f198.google.com with SMTP id r15-20020a056808210f00b002d0d8b35b4eso1475273oiw.23
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 08:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=53BPBlXQ9S5Ov+amkvoqYiyiQymDxhLzSDn632g3AnI=;
        b=t+RvD4Pr+sXokZn8B+lI8xy6YpN5yykmKBrr7+gH5kp3L3eGXsXVq6U2NJeuNHcSUu
         5w23MA0GxNexB3er5YyZCMmCckFWXrD+2AW9zok1hl0K8RKxX+CwOG4PJ37SWEJvfGwT
         DanAC+qNBjQ3h+BdtePdapkbrGwRBoSN2WIuVUB9UrJpaQLzW2yJ3MuZi77VcfaEjV+f
         UdfXUc40UbrRxGdaqBymFvEqnP/ZgCQwmLZBC0Rq8lNYjwkZo8+WWwwrX3Q9e+sRHad5
         eULI13JZNLESqmmpIExrrO1VpT1zglmZDeHZfbW9TV5xodHs0g+54jyMM98/lXxDIhIZ
         6QkA==
X-Gm-Message-State: AOAM531S8JUcj2BtbGr3Dg5Vx8V1pCCgGuB4tI/kpKhMEQsVVcfHrRxK
        /JFn85vmKTSeyNcIiwMT7e2iHCvU0NCohww47GQN12Ef3RH0BasKFRHgIFNPQNxvI7ZcfikLYB6
        LG7phoMYb+L42WNJ/ClOQ
X-Received: by 2002:a05:6870:12d7:: with SMTP id 23mr1060327oam.133.1644511693326;
        Thu, 10 Feb 2022 08:48:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwwaQd00a+1hW/QSYxWvHGo3F2y4/ysYql9KJVOGrs/Tngz3B2WZGdj9eeXOUi+BnYh8YJDA==
X-Received: by 2002:a05:6870:12d7:: with SMTP id 23mr1060313oam.133.1644511693125;
        Thu, 10 Feb 2022 08:48:13 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id el40sm9398252oab.22.2022.02.10.08.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 08:48:12 -0800 (PST)
Date:   Thu, 10 Feb 2022 09:48:11 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com,
        ashok.raj@intel.com, kevin.tian@intel.com,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH V7 mlx5-next 14/15] vfio/mlx5: Use its own PCI
 reset_done error handler
Message-ID: <20220210094811.0f95fbd8.alex.williamson@redhat.com>
In-Reply-To: <20220209023918.GO4160@nvidia.com>
References: <20220207172216.206415-1-yishaih@nvidia.com>
        <20220207172216.206415-15-yishaih@nvidia.com>
        <20220208170801.39dab353.alex.williamson@redhat.com>
        <20220209023918.GO4160@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 8 Feb 2022 22:39:18 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Feb 08, 2022 at 05:08:01PM -0700, Alex Williamson wrote:
> > > @@ -477,10 +499,34 @@ static int mlx5vf_pci_get_device_state(struct vfio_device *vdev,
> > >  
> > >  	mutex_lock(&mvdev->state_mutex);
> > >  	*curr_state = mvdev->mig_state;
> > > -	mutex_unlock(&mvdev->state_mutex);
> > > +	mlx5vf_state_mutex_unlock(mvdev);
> > >  	return 0;  
> > 
> > I still can't see why it wouldn't be a both fairly trivial to implement
> > and a usability improvement if the unlock wrapper returned -EAGAIN on a
> > deferred reset so we could avoid returning a stale state to the user
> > and a dead fd in the former case.  Thanks,  
> 
> It simply is not useful - again, we always resolve this race that
> should never happen as though the two events happened consecutively,
> which is what would normally happen if we could use a simple mutex. We
> do not need to add any more complexity to deal with this already
> troublesome thing..

So walk me through how this works with QEMU, it's easy to hand-wave
userspace race and move on, but device reset can be triggered by guest
behavior while migration is supposed to be transparent to the guest.
These are essentially asynchronous threads where we're imposing a
synchronization point or lots of double checking in userspace whether
the device actually entered the state we think it did and if the
returned FD is usable.

Specifically, I suspect we can trigger this race if the VM reboots as
we're initiating a migration in the STOP_COPY phase, but that's maybe
less interesting if we expect the VM to be halted before the device
state is stepped.  More interesting might be how a PRE_COPY transition
works relative to asynchronous VM resets triggering device resets.  Are
we serializing all access to reset vs this DEVICE_FEATURE op or are we
resorting to double checking the device state, and how do we plan to
re-initiate migration states if a VM reset occurs during migration?
Thanks,

Alex

