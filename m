Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D0F4CAA55
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 17:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbiCBQe7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 11:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiCBQe6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 11:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54A6A4D276
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646238854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PWSd2XUF2mosol4Wi2khE1roXr1zOMVG1AnKT6xRjqU=;
        b=i2SA5x4nyrGHtzaNIQC6d7hvZJwSj/ihy08/ikH1YByKqJCni/E9F9zVeIvUNxlIXREmvc
        CwokTuCQJnkryLF0rhnAszAXuutvAlP0XXf57GZ16HFUKZyls/rFQVJizFt+mqPoAVlh/t
        c8LfIVodTxKsDOLakm6muLkpa2fIjHc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-9ZJKSUKDM26rMQVTDLDJ3Q-1; Wed, 02 Mar 2022 11:34:13 -0500
X-MC-Unique: 9ZJKSUKDM26rMQVTDLDJ3Q-1
Received: by mail-ot1-f71.google.com with SMTP id t3-20020a9d7483000000b005ad2f92e885so1566200otk.21
        for <linux-pci@vger.kernel.org>; Wed, 02 Mar 2022 08:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PWSd2XUF2mosol4Wi2khE1roXr1zOMVG1AnKT6xRjqU=;
        b=RpZ0A2Oh5ffAW2zPSNCvrPG832TkLqx22396PchpL2o4KwtPwhGU6z4YLVCrCOnJPr
         OLDRdG11KHwoDJHSdGnllg1zwS3SsL4NDvR5CdWKMcJtD/uhpMyWAOeuOvoII0ZBX4vc
         KL1T4PH/LexlKSZUHet0m2yxOz9i3VHwt1X1Y26QAWfHldwDbZO0g1g3nPONdieLK/tr
         e7Wmf1/zrpvZnpQXUlIM/Oh9zdyyjGDTthY1zNvYXa5soFWKNweb2PK94Sp9+be8oJ1x
         cqBszFCXtw6CAhh0eV/dVe0cJHDVxeFrhUtY3t3e36+PQR9m/h4uTNUsY+lUl7cWiPYX
         TLdg==
X-Gm-Message-State: AOAM531Sqe8qi5pGfo9gr6VnflsW+/y8rzbvRDZDX/ImdhbW5IDfK2vx
        b8iW0gPqhVL2Tkw9maVSLtDO54JJN+6gypxgtv6tseyYIMSJNczNugQyVrob4m6+DUx2AN5Bk0b
        C490FUOw0giUKCkfyE1ov
X-Received: by 2002:a9d:715c:0:b0:5ad:3858:4d54 with SMTP id y28-20020a9d715c000000b005ad38584d54mr16223132otj.214.1646238852770;
        Wed, 02 Mar 2022 08:34:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBw2AqrPCsUU+HrPTnHR2yY44LF5FaN0crr7APTArZemj3pcA/s+JkRdkPJTlr0hwX4hI6Ng==
X-Received: by 2002:a9d:715c:0:b0:5ad:3858:4d54 with SMTP id y28-20020a9d715c000000b005ad38584d54mr16223107otj.214.1646238852555;
        Wed, 02 Mar 2022 08:34:12 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id n7-20020a4a6107000000b0031c402d8ec9sm8032303ooc.35.2022.03.02.08.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 08:34:12 -0800 (PST)
Date:   Wed, 2 Mar 2022 09:34:09 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com,
        ashok.raj@intel.com, kevin.tian@intel.com,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH V9 mlx5-next 09/15] vfio: Define device migration
 protocol v2
Message-ID: <20220302093409.1aef2b6e.alex.williamson@redhat.com>
In-Reply-To: <87mti8ibie.fsf@redhat.com>
References: <20220224142024.147653-1-yishaih@nvidia.com>
        <20220224142024.147653-10-yishaih@nvidia.com>
        <87tucgiouf.fsf@redhat.com>
        <20220302142732.GK219866@nvidia.com>
        <20220302083440.539a1f33.alex.williamson@redhat.com>
        <87mti8ibie.fsf@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 02 Mar 2022 17:07:21 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, Mar 02 2022, Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > On Wed, 2 Mar 2022 10:27:32 -0400
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >  
> >> On Wed, Mar 02, 2022 at 12:19:20PM +0100, Cornelia Huck wrote:  
> >> > > +/*
> >> > > + * vfio_mig_get_next_state - Compute the next step in the FSM
> >> > > + * @cur_fsm - The current state the device is in
> >> > > + * @new_fsm - The target state to reach
> >> > > + * @next_fsm - Pointer to the next step to get to new_fsm
> >> > > + *
> >> > > + * Return 0 upon success, otherwise -errno
> >> > > + * Upon success the next step in the state progression between cur_fsm and
> >> > > + * new_fsm will be set in next_fsm.    
> >> > 
> >> > What about non-success? Can the caller make any assumption about
> >> > next_fsm in that case? Because...    
> >> 
> >> I checked both mlx5 and acc, both properly ignore the next_fsm value
> >> on error. This oddness aros when Alex asked to return an errno instead
> >> of the state value.  
> >
> > Right, my assertion was that only the driver itself should be able to
> > transition to the ERROR state.  vfio_mig_get_next_state() should never
> > advise the driver to go to the error state, it can only report that a
> > transition is invalid.  The driver may stay in the current state if an
> > error occurs here, which is why we added the ability to get the device
> > state.  Thanks,
> >
> > Alex  
> 
> So, should the function then write anything to next_fsm if it returns
> -errno? (Maybe I'm misunderstanding.) Or should the caller always expect
> that something may be written to new_fsm, and simply only look at it if
> the function returns success?

Note that this function doesn't actually transition the device to
next_fsm, it's only informing the driver what the next state is.
Therefore I think it's reasonable to expect that the caller is never
going to use it's actual internal device state for next_fsm.  So I
don't really see a case where we need to worry about preserving
next_fsm in the error condition.  Thanks,

Alex

