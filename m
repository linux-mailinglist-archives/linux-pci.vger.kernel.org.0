Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27646529C5
	for <lists+linux-pci@lfdr.de>; Wed, 21 Dec 2022 00:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiLTXVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 18:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLTXVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 18:21:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5516AF7C
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 15:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671578464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/yL2ss9yIdWHwPse2tigQEB/FE3FbjAM3XIM8TGekM=;
        b=i+CJtNEDzlCqFSQjn5lbwH/fx0H1nGPCSpVNDnHWbSw+YLblO2UMzzNXyKcoDkP8PewWr1
        A6nQ1ui+4K0lnNOyXqFh0hK8rKG+Qv7M3g0FjpqC6Fd80kHfPm9AKXBDu1cQ4Aq5BJGVn2
        d3qFNAkwtP+YBWR6brhHn80GGCS2Zz0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-mu0Dsz3XPpqV0tJzt4NhvA-1; Tue, 20 Dec 2022 18:21:03 -0500
X-MC-Unique: mu0Dsz3XPpqV0tJzt4NhvA-1
Received: by mail-qv1-f71.google.com with SMTP id w1-20020a056214012100b004c6ecf32001so7769504qvs.8
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 15:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/yL2ss9yIdWHwPse2tigQEB/FE3FbjAM3XIM8TGekM=;
        b=bzjzm292SO57kiAeOOrv/bBIP6RQnc7sUSzTeqEWSdfpHa7jlTTxEX3hjvCbfDBy2l
         M5iGxfx5kfcGcfYXvJcAqJIk0gkmCCfX9J/Pzi/oIS3tl7RiB1+ET0d4V5MN9pitwVyy
         wVyoeLDsroSIfiMtw93IMj/IMK3pvAjs/sfn1PT9PDf2FdljOgDBXefCL5Rwb/3J6dI4
         hgf36yBEuNsTWKJGw6FLMJ9feONsPj8Vnx6z+AJn501pwPHg+MKc2LzuNqyBe+yqn2ZL
         REyAFQeEcD1gHUFZhjsak+DmIe9gx2THB+MfuzuZ5RdziANXSOTXxu1GXim7IPnG/kJp
         fUDQ==
X-Gm-Message-State: AFqh2kp2VaL1VDM5gF1kRN/3SFcWEPlgefAqXtGD4pvG+/jtPEQ0kF/S
        7BkDnl7JWTUnlFOehbC8uTwMFgcUyQBTAT0n7YcyjhU0C8UK+OySstbzvnoG3jssVCVftcIFzLa
        KF1r6hTxZ0tMb7n2Skss4
X-Received: by 2002:ad4:4c50:0:b0:4c7:2547:bc03 with SMTP id cs16-20020ad44c50000000b004c72547bc03mr14988657qvb.50.1671578462603;
        Tue, 20 Dec 2022 15:21:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsDl5nzwCTQTVtglgJWA2+tKSWwmW+GiT3UWFjEy1Jz1RZbeyhVIyRfPXdfqhBYgTBI7HoA+g==
X-Received: by 2002:ad4:4c50:0:b0:4c7:2547:bc03 with SMTP id cs16-20020ad44c50000000b004c72547bc03mr14988633qvb.50.1671578462340;
        Tue, 20 Dec 2022 15:21:02 -0800 (PST)
Received: from redhat.com ([37.19.199.117])
        by smtp.gmail.com with ESMTPSA id o20-20020a05620a22d400b006e07228ed53sm9565979qki.18.2022.12.20.15.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 15:21:01 -0800 (PST)
Date:   Tue, 20 Dec 2022 18:20:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Jason Wang <jasowang@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, llvm@lists.linux.dev
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221220182026-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
 <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
 <Y6IfwHicoMojJrIB@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6IfwHicoMojJrIB@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 20, 2022 at 01:49:04PM -0700, Nathan Chancellor wrote:
> On Tue, Dec 20, 2022 at 06:46:20PM +0200, Alvaro Karsz wrote:
> > Hi Nathan,
> > 
> > > This does not appear to be a false positive but what was the intent
> > > here? Should the local name variables increase their length or should
> > > the buffer length be reduced?
> > 
> > You're right, the local name variables and snprintf argument don't match.
> > Thanks for noticing.
> > I think that we should increase the name variables  to be
> > SNET_NAME_SIZE bytes long.
> > 
> > How should I proceed from here?
> > Should I create a new version for this patch, or should I fix it in a
> > follow up patch?
> 
> That is up to Michael at the end of the day (each maintainer handles
> their tree differently) but I would recommend sending a follow up fix,
> as it is easy to fold it in if they want to rebase the tree for it or
> just take it as a fix.
> 
> Thanks for the quick triage and response!
> 
> Cheers,
> Nathan

on top is ok but post soon please as i need to send this to Linus.

-- 
MST

