Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92C741C613
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344345AbhI2NwF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 09:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344331AbhI2NwF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 09:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632923423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhEYkN6eSJLZP/cV07GjlQRPbO9M+hVC+ywwE/y96y8=;
        b=gl7PIxOHnXveXEhqmHZ/sFQ962stFMlpM+TVhOzsI+RTkQpQWU5twg07D6lcl4aAlZtr0/
        puj0zUBNjvHLm2KobPmcvyITiOwYzY9CsimohDTXbBO9LbMJB/cCWAfrbj504xZ/IrEcUS
        iO3ipYfwt4CicWHo1xTT4fXUjxFCjro=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-XRTKmRkgOQah5cPOGQ-KkQ-1; Wed, 29 Sep 2021 09:50:22 -0400
X-MC-Unique: XRTKmRkgOQah5cPOGQ-KkQ-1
Received: by mail-ot1-f70.google.com with SMTP id u19-20020a0568301f1300b005472c85a1feso1970846otg.12
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 06:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FhEYkN6eSJLZP/cV07GjlQRPbO9M+hVC+ywwE/y96y8=;
        b=uqcyd9dYxfHeRY4i5uu3C5lBksSKDAJ0spP+veWZt0BL9hWFpHbHvxXrE7KiWXnq7m
         6WcOMZDwo4jlJbSSbq3gEaBkwfkenBG8sghvhO/Yw7CYCiiaKv9s3ZlCtl0trcrMU8v8
         DyB5Jf7G4Fzg9s681Uds41w1bfcq5gQD2G26OJMeNbp4wKOzDkv3Oilb3lWj/0kAsDFH
         +H5HyV/R1SR/1t+aPg9gW9evLbcQis79wBT6aBP1woevXpXUvVtWeTe/UBzddBxlPz/z
         M0BcOsLhyDYj1lyEzNgJ2ITRQpNpIY2vYpo1FCTo0+1mNkZ1wUvA3+5ti0XswfNYrsp3
         cN0w==
X-Gm-Message-State: AOAM533YsFKi64j4/Mmjw7LnHxGzmlYLL5qCFibOm6a8+Qs+Ux3/2p+o
        xjABkwQhQgMdxRoRrOVjnoQqF3nDrbOMAi11SPxIenjohKsW74L1Dx2IBt4ZO1sMXNrAzp9882q
        K2HpbAb2BrMD2PEi9x968
X-Received: by 2002:aca:adc5:: with SMTP id w188mr8119141oie.40.1632923421714;
        Wed, 29 Sep 2021 06:50:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBuOrTDixbcm+glLpv+7QenclxccxJ6UkYSq7KtnLZB5CHTBD74Coi0b7Um+05XIgMwgd7Pg==
X-Received: by 2002:aca:adc5:: with SMTP id w188mr8119119oie.40.1632923421462;
        Wed, 29 Sep 2021 06:50:21 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id p8sm458585oti.15.2021.09.29.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 06:50:21 -0700 (PDT)
Date:   Wed, 29 Sep 2021 07:50:19 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH mlx5-next 2/7] vfio: Add an API to check migration state
 transition validity
Message-ID: <20210929075019.48d07deb.alex.williamson@redhat.com>
In-Reply-To: <1eba059c-4743-4675-9f72-1a26b8f3c0f6@nvidia.com>
References: <cover.1632305919.git.leonro@nvidia.com>
        <c87f55d6fec77a22b110d3c9611744e6b28bba46.1632305919.git.leonro@nvidia.com>
        <20210927164648.1e2d49ac.alex.williamson@redhat.com>
        <20210927231239.GE3544071@ziepe.ca>
        <25c97be6-eb4a-fdc8-3ac1-5628073f0214@nvidia.com>
        <20210929063551.47590fbb.alex.williamson@redhat.com>
        <1eba059c-4743-4675-9f72-1a26b8f3c0f6@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 29 Sep 2021 16:26:55 +0300
Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> On 9/29/2021 3:35 PM, Alex Williamson wrote:
> > On Wed, 29 Sep 2021 13:44:10 +0300
> > Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >  
> >> On 9/28/2021 2:12 AM, Jason Gunthorpe wrote:  
> >>> On Mon, Sep 27, 2021 at 04:46:48PM -0600, Alex Williamson wrote:  
> >>>>> +	enum { MAX_STATE = VFIO_DEVICE_STATE_RESUMING };
> >>>>> +	static const u8 vfio_from_state_table[MAX_STATE + 1][MAX_STATE + 1] = {
> >>>>> +		[VFIO_DEVICE_STATE_STOP] = {
> >>>>> +			[VFIO_DEVICE_STATE_RUNNING] = 1,
> >>>>> +			[VFIO_DEVICE_STATE_RESUMING] = 1,
> >>>>> +		},  
> >>>> Our state transition diagram is pretty weak on reachable transitions
> >>>> out of the _STOP state, why do we select only these two as valid?  
> >>> I have no particular opinion on specific states here, however adding
> >>> more states means more stuff for drivers to implement and more risk
> >>> driver writers will mess up this uAPI.  
> >> _STOP == 000b => Device Stopped, not saving or resuming (from UAPI).
> >>
> >> This is the default initial state and not RUNNING.
> >>
> >> The user application should move device from STOP => RUNNING or STOP =>
> >> RESUMING.
> >>
> >> Maybe we need to extend the comment in the UAPI file.  
> >
> > include/uapi/linux/vfio.h:
> > ...
> >   *  +------- _RESUMING
> >   *  |+------ _SAVING
> >   *  ||+----- _RUNNING
> >   *  |||
> >   *  000b => Device Stopped, not saving or resuming
> >   *  001b => Device running, which is the default state
> >                              ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > ...
> >   * State transitions:
> >   *
> >   *              _RESUMING  _RUNNING    Pre-copy    Stop-and-copy   _STOP
> >   *                (100b)     (001b)     (011b)        (010b)       (000b)
> >   * 0. Running or default state
> >   *                             |
> >                   ^^^^^^^^^^^^^
> > ...
> >   * 0. Default state of VFIO device is _RUNNING when the user application starts.
> >        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > The uAPI is pretty clear here.  A default state of _STOP is not
> > compatible with existing devices and userspace that does not support
> > migration.  Thanks,  
> 
> Why do you need this state machine for userspace that doesn't support 
> migration ?

For userspace that doesn't support migration, there's one state,
_RUNNING.  That's what we're trying to be compatible and consistent
with.  Migration is an extension, not a base requirement.

> What is the definition of RUNNING state for a paused VM that is waiting 
> for incoming migration blob ?

A VM supporting migration of the device would move the device to
_RESUMING to load the incoming data.  If the VM leaves the device in
_RUNNING, then it doesn't support migration of the device and it's out
of scope how it handles that device state.  Existing devices continue
running regardless of whether the VM state is paused, it's only devices
supporting migration where userspace could optionally have the device
run state follow the VM run state.  Thanks,

Alex

