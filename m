Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29DC4A7BF2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 00:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348169AbiBBXyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 18:54:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239165AbiBBXys (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 18:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643846088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBpJIq8plKHosD2jX5H6b08b/gKUpV2Uh7c6zubcVJs=;
        b=USLTLTgbF5y8YWliZYW/uDPvCtRmGeRF5JRcn8LP1ko9G25iYqCnUQ/BVfqfWXnPuqkHjP
        iWixQdi8+eOM2R7PMBs29FdBbte3B+/yQGLiB9DE0qLZiSMu/ejIpXmK6pggC2svhxLxup
        vSKRMh4kmk7/xxbBuVc6a7z1pnE47uc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-tpTEjhzANWWN6c5yu4_7SQ-1; Wed, 02 Feb 2022 18:54:47 -0500
X-MC-Unique: tpTEjhzANWWN6c5yu4_7SQ-1
Received: by mail-oi1-f197.google.com with SMTP id o130-20020aca5a88000000b002c8dd0d6fa3so447871oib.18
        for <linux-pci@vger.kernel.org>; Wed, 02 Feb 2022 15:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBpJIq8plKHosD2jX5H6b08b/gKUpV2Uh7c6zubcVJs=;
        b=rgjtPAvt935dVeWWm95lv98ln/QBhNzbtrRCepiqOk1jOErc/ewW9MzVeAJYOtKP2k
         Vrr6v3tVbwSY9S9D0+o4eEEXsXY/PVz10DwwDhVkkcTmk54izff4yc9EA/NhgDN2+vRf
         kPxtfattVrpqbtH7cUfMgC89wipDxLqjnQiPXgirdXex3D5U+5GuCoPE+BEPp/9h4xjv
         25Xlg6qcnEG5Yq1UE36VXbC6enOv3tdzVUkUY8SPLWl0kuyjS0FmUDS1o1IA/dWPw0OD
         qqRsKKl7n0/CxGIy4KvW9Xv0m2qWmqZG6xwSTdSqsRCc//tAZ6p5t1JgQsBHeu4eJghV
         shQg==
X-Gm-Message-State: AOAM530M6m2/1hlIuHXdVJ/nmDrUAxtWPkebG15bm7aEPVPSIAwjkVlF
        7DMd/byJA5J9zuQW6RaPIghIo1vPvKSEe+y2HTS4b7VpkmQrevbbEJl6Ais34uGpZGEcdv35Gp8
        EUW4de3oBQj9EhZwYxXF1
X-Received: by 2002:a4a:a2c9:: with SMTP id r9mr16204887ool.37.1643846086283;
        Wed, 02 Feb 2022 15:54:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4Mlr5MG7RXURcZnvvmwmixiDykwHQ0hC5c9AkY2EJIsO+5bsG3ZTU5VvuEJ7u6eFrPSRSwA==
X-Received: by 2002:a4a:a2c9:: with SMTP id r9mr16204871ool.37.1643846086069;
        Wed, 02 Feb 2022 15:54:46 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id o1sm8270528oik.0.2022.02.02.15.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:54:45 -0800 (PST)
Date:   Wed, 2 Feb 2022 16:54:44 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V6 mlx5-next 09/15] vfio: Extend the device migration
 protocol with RUNNING_P2P
Message-ID: <20220202165444.44816642.alex.williamson@redhat.com>
In-Reply-To: <20220201195003.GN1786498@nvidia.com>
References: <20220130160826.32449-1-yishaih@nvidia.com>
        <20220130160826.32449-10-yishaih@nvidia.com>
        <20220201113144.0c8dfaa5.alex.williamson@redhat.com>
        <20220201185321.GM1786498@nvidia.com>
        <20220201121322.2f3ceaf2.alex.williamson@redhat.com>
        <20220201195003.GN1786498@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Feb 2022 15:50:03 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Feb 01, 2022 at 12:13:22PM -0700, Alex Williamson wrote:
> > On Tue, 1 Feb 2022 14:53:21 -0400
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Tue, Feb 01, 2022 at 11:31:44AM -0700, Alex Williamson wrote:  
> > > > > +	bool have_p2p = device->migration_flags & VFIO_MIGRATION_P2P;
> > > > > +
> > > > >  	if (cur_fsm >= ARRAY_SIZE(vfio_from_fsm_table) ||
> > > > >  	    new_fsm >= ARRAY_SIZE(vfio_from_fsm_table))
> > > > >  		return VFIO_DEVICE_STATE_ERROR;
> > > > >  
> > > > > -	return vfio_from_fsm_table[cur_fsm][new_fsm];
> > > > > +	if (!have_p2p && (new_fsm == VFIO_DEVICE_STATE_RUNNING_P2P ||
> > > > > +			  cur_fsm == VFIO_DEVICE_STATE_RUNNING_P2P))
> > > > > +		return VFIO_DEVICE_STATE_ERROR;    
> > > > 
> > > > new_fsm is provided by the user, we pass set_state.device_state
> > > > directly to .migration_set_state.  We should do bounds checking and
> > > > compatibility testing on the end state in the core so that we can    
> > > 
> > > This is the core :)  
> > 
> > But this is the wrong place, we need to do it earlier rather than when
> > we're already iterating next states.  I only mention core to avoid that
> > I'm suggesting a per driver responsibility.  
> 
> Only the first vfio_mig_get_next_state() can return ERROR, once it
> succeeds the subsequent ones must also succeed.

Yes, I see that.

> This is the earliest can be. It is done directly after taking the lock
> that allows us to read the current state to call this function to
> determine if the requested transition is acceptable.

I think the argument here is that there's no value to validating or
bounds checking the end state, which could be done in the core ioctl
before calling the driver if the first iteration will already fail for
both the end state and the full path validation.

> > > Userspace can never put the device into error. As the function comment
> > > says VFIO_DEVICE_STATE_ERROR is returned to indicate the arc is not
> > > permitted. The driver is required to reflect that back as an errno
> > > like mlx5 shows:
> > > 
> > > +		next_state = vfio_mig_get_next_state(vdev, mvdev->mig_state,
> > > +						     new_state);
> > > +		if (next_state == VFIO_DEVICE_STATE_ERROR) {
> > > +			res = ERR_PTR(-EINVAL);
> > > +			break;
> > > +		}
> > > 
> > > We never get the driver into error, userspaces gets an EINVAL and no
> > > change to the device state.  
> > 
> > Hmm, subtle.  I'd argue that if we do a bounds and support check of the
> > end state in vfio_ioctl_mig_set_state() before calling
> > .migration_set_state() then we could remove ERROR from
> > vfio_from_fsm_table[] altogether and simply begin
> > vfio_mig_get_next_state() with:  
> 
> Then we can't reject blocked arcs like STOP_COPY -> PRE_COPY.

Right, I hadn't made it through to 15/, which helps to clarify how the
cur_fsm + new_fsm validate the full arc.
 
> It is setup this way to allow the core code to assert all policy, not
> just a simple validation of the next_fsm.
> 
> > Then we only get to ERROR by the driver placing us in ERROR and things
> > feel a bit more sane to me.  
> 
> This is already true.
> 
> Perhaps it is confusing using ERROR to indicate that
> vfio_mig_get_next_state() failed. Would you be happier with a -errno
> return?

Yes, it's confusing to me that next_state() returns states that don't
become the device_state.  Stuffing the next step back into cur_fsm and
using an errno for a bounds/validity/blocked-arc test would be a better
API.  Thanks,

Alex

