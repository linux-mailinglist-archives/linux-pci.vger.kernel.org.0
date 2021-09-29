Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA19241C4D0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 14:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbhI2Mhi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 08:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343760AbhI2Mhh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 08:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632918955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AONkSvJzainTezsYTPbpK+b1pds40CMHvB/8u5WAv5I=;
        b=I1Qye6qxC6Hka+IYkgMKxNWFKNiUOkICrqBVcqvrysQ/2xBzG3ZL994BB6v1cKGWOQ9QP0
        QHE1nyxJqjXtp1Qagk9sJA4rtPijO1gV4LxTzt0sDSBDyhC12Y9sN6GrDb2APgPYV6zmOA
        TuLrRLjjFDwMlWFV9L+1QRTNprIZzS0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-U62yRuPwNjyXP_vgPm0nrQ-1; Wed, 29 Sep 2021 08:35:54 -0400
X-MC-Unique: U62yRuPwNjyXP_vgPm0nrQ-1
Received: by mail-ot1-f70.google.com with SMTP id 76-20020a9d0152000000b0053b372910bbso1834976otu.14
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 05:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=AONkSvJzainTezsYTPbpK+b1pds40CMHvB/8u5WAv5I=;
        b=1W7z1jX/B6skWflayZ6ZYF7IL3zN76MLVLXRsfhCUwkFRQg9GSH6sFdqXU9IBalZSS
         R7PtHXDLqcxeDs4OKO2XEZReAxAipxGn0Duns4/3IL+FtIdN08jrqwt1eJ73bxLoLpyH
         62WBNSLQOvcHFFyC9PGS4wChCosHaoGmNXVnFgGCLsWo6HXVrHfwoV3TqiUoLSfSc8fi
         WMsZhPG2D7xz2/UzQMUwdEa0MTRgk/NnP9hGw28rXAGFTTbaveh4Ti8iN140QXyJit78
         IF7+oO0+lxrmIk9AXcdaH5pd7vtDWlfZh+QM5qh/OdoOzU7e4rrBFb+xrPLhsMoDIxgT
         +d3Q==
X-Gm-Message-State: AOAM530AOvqp3vLKCbIU8UwX8vdqJR8g42PxnURPUh5FSJyMcz6vRo/h
        5t+ayl1kDdD60+3e3XUS7zxnWGV3Y5uIvEKjy1xJdn+KcUJBOm3VRnm9Cnqq28gE8xi8GeNlR0N
        pf4e6Lfhm8cc7TmOck9UF
X-Received: by 2002:a4a:6412:: with SMTP id o18mr9657625ooc.79.1632918953839;
        Wed, 29 Sep 2021 05:35:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7xJTXMz3LEJouQo9Mbo40gZ+qwISlNXYsOoerhBOEC0o4ttCybgLQImKulrrTsSCBaW0jvA==
X-Received: by 2002:a4a:6412:: with SMTP id o18mr9657611ooc.79.1632918953630;
        Wed, 29 Sep 2021 05:35:53 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id a1sm430363otr.33.2021.09.29.05.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 05:35:53 -0700 (PDT)
Date:   Wed, 29 Sep 2021 06:35:51 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH mlx5-next 2/7] vfio: Add an API to check migration state
 transition validity
Message-ID: <20210929063551.47590fbb.alex.williamson@redhat.com>
In-Reply-To: <25c97be6-eb4a-fdc8-3ac1-5628073f0214@nvidia.com>
References: <cover.1632305919.git.leonro@nvidia.com>
        <c87f55d6fec77a22b110d3c9611744e6b28bba46.1632305919.git.leonro@nvidia.com>
        <20210927164648.1e2d49ac.alex.williamson@redhat.com>
        <20210927231239.GE3544071@ziepe.ca>
        <25c97be6-eb4a-fdc8-3ac1-5628073f0214@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 29 Sep 2021 13:44:10 +0300
Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> On 9/28/2021 2:12 AM, Jason Gunthorpe wrote:
> > On Mon, Sep 27, 2021 at 04:46:48PM -0600, Alex Williamson wrote:  
> >>> +	enum { MAX_STATE = VFIO_DEVICE_STATE_RESUMING };
> >>> +	static const u8 vfio_from_state_table[MAX_STATE + 1][MAX_STATE + 1] = {
> >>> +		[VFIO_DEVICE_STATE_STOP] = {
> >>> +			[VFIO_DEVICE_STATE_RUNNING] = 1,
> >>> +			[VFIO_DEVICE_STATE_RESUMING] = 1,
> >>> +		},  
> >> Our state transition diagram is pretty weak on reachable transitions
> >> out of the _STOP state, why do we select only these two as valid?  
> > I have no particular opinion on specific states here, however adding
> > more states means more stuff for drivers to implement and more risk
> > driver writers will mess up this uAPI.  
> 
> _STOP == 000b => Device Stopped, not saving or resuming (from UAPI).
> 
> This is the default initial state and not RUNNING.
> 
> The user application should move device from STOP => RUNNING or STOP => 
> RESUMING.
> 
> Maybe we need to extend the comment in the UAPI file.


include/uapi/linux/vfio.h:
...
 *  +------- _RESUMING
 *  |+------ _SAVING
 *  ||+----- _RUNNING
 *  |||
 *  000b => Device Stopped, not saving or resuming
 *  001b => Device running, which is the default state
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^
...
 * State transitions:
 *
 *              _RESUMING  _RUNNING    Pre-copy    Stop-and-copy   _STOP
 *                (100b)     (001b)     (011b)        (010b)       (000b)
 * 0. Running or default state
 *                             |
                 ^^^^^^^^^^^^^
...
 * 0. Default state of VFIO device is _RUNNING when the user application starts.
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The uAPI is pretty clear here.  A default state of _STOP is not
compatible with existing devices and userspace that does not support
migration.  Thanks,

Alex

