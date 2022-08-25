Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD95A1C6D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbiHYWcq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 18:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbiHYWcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 18:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D70B958C
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661466764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oy2aubXb5hLNj8VJ/ILuyIzESlVY8G+jddCf/KXjxGU=;
        b=HFNSVFlTxa3afw+pvVRY6hjU06cuoOVBVqf0sDSpdBpfzHYK6kyU4HpysU8QnWr24DNAov
        9XaDPGgmstRMh7m8iyrBcSjMwS2hkL88Qy4ot5eHfeDwcWZ2BlhpUneoNfETMldUpc+oAY
        1yWQIrSZfRHHx3SyoibIn6EMsC5DZy8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-548-AAJAAcANN82fF1ZBJ0qhkA-1; Thu, 25 Aug 2022 18:32:42 -0400
X-MC-Unique: AAJAAcANN82fF1ZBJ0qhkA-1
Received: by mail-il1-f199.google.com with SMTP id l20-20020a056e02067400b002dfa7256498so15927198ilt.4
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 15:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=Oy2aubXb5hLNj8VJ/ILuyIzESlVY8G+jddCf/KXjxGU=;
        b=B2Z7/BWUyz4y3ecAEE0V2CgSAEPDKeQFem853JPZsQ41SsYvMAYlreVlflGDO6ecF2
         YyKIWhS86r86F2nUZo1LutaIBgHFaJMph6ZApeGM4bVPMXGL9W/kc9q1pMaw/tZuRtwE
         gzGxOaGXeeCcuM28izZrrhqNh41ggxbz6nRrTUXRJ9opZt3he4u5JBCb/OWyQNuR3k0/
         sXJPbnNzQD3FIvZofqqVeNJB3cGCkBu83+8gbJBMHLKYPGgI6lHT1UiW8LQkyXgWNVci
         WnZBpES2JV6ymU5b+TrhWywJ7G4kaUMoD0VgYgo7LJSjNZqNLv8KRJgJcxbFqM19SgHT
         04ng==
X-Gm-Message-State: ACgBeo0zorvtDUSGiw/iF20bzhGH8tGPBDZ3wYEsCSp6pMaIzPDlXgM2
        e3DcBLWU3dRldIor1och5XtEjzzKQ7aNluAtotUj7Km4ODalWoyuf6j6aKsIVpFWW52FwpkWekB
        KdZdtomBsEk0NgLg1ZuDt
X-Received: by 2002:a02:1d09:0:b0:33b:a8cc:17d3 with SMTP id 9-20020a021d09000000b0033ba8cc17d3mr2742331jaj.25.1661466762088;
        Thu, 25 Aug 2022 15:32:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5DxfwLwJkfemFe6fofZO7Sa2Jt0xLr+PHGNw1XLZEm3kULrHFXM6KOQKsSVRF5mDTKeRkUZg==
X-Received: by 2002:a02:1d09:0:b0:33b:a8cc:17d3 with SMTP id 9-20020a021d09000000b0033ba8cc17d3mr2742320jaj.25.1661466761898;
        Thu, 25 Aug 2022 15:32:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t14-20020a056e02010e00b002e93764c9e3sm278115ilm.54.2022.08.25.15.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:32:41 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:32:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 5/5] vfio/pci: Implement
 VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY_WITH_WAKEUP
Message-ID: <20220825163240.274950c8.alex.williamson@redhat.com>
In-Reply-To: <62e6d510-8e7c-8a31-fb7f-905bb13afe67@nvidia.com>
References: <20220817051323.20091-1-abhsahu@nvidia.com>
        <20220817051323.20091-6-abhsahu@nvidia.com>
        <Yvzy0VOfKkKod0OV@nvidia.com>
        <5363303b-30bb-3c4a-bf42-426dd7f8138d@nvidia.com>
        <Yv0oH23UYbI/LI+X@nvidia.com>
        <62e6d510-8e7c-8a31-fb7f-905bb13afe67@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 18 Aug 2022 22:31:03 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:

> On 8/17/2022 11:10 PM, Jason Gunthorpe wrote:
> > On Wed, Aug 17, 2022 at 09:34:30PM +0530, Abhishek Sahu wrote:  
> >> On 8/17/2022 7:23 PM, Jason Gunthorpe wrote:  
> >>> On Wed, Aug 17, 2022 at 10:43:23AM +0530, Abhishek Sahu wrote:
> >>>  
> >>>> +static int
> >>>> +vfio_pci_core_pm_entry_with_wakeup(struct vfio_device *device, u32 flags,
> >>>> +				   void __user *arg, size_t argsz)  
> >>>
> >>> This should be
> >>>   struct vfio_device_low_power_entry_with_wakeup __user *arg
> >>>  
> >>
> >>  Thanks Jason.
> >>
> >>  I can update this.
> >>
> >>  But if we look the existing code, for example
> >>  (vfio_ioctl_device_feature_mig_device_state()), then there it still uses
> >>  'void __user *arg' only. Is this a new guideline which we need to take
> >>  care ?  
> > 
> > I just sent a patch that fixes that too
> >   
> 
>  Thanks for the update.
>  I will change this. 
> 
> >>  Do we need to keep the IOCTL name alphabetically sorted in the case list.
> >>  Currently, I have added in the order of IOCTL numbers.  
> > 
> > It is generally a good practice to sort lists of things.
> > 
> > Jason  
> 
>  Sure. I will make the sorted list.

The series looks good to me, so I'd suggest to rebase on Jason's
patches[1][2] so you can easily sort out the above.  Thanks,

Alex

[1]https://lore.kernel.org/all/0-v1-da6fc51ee22e+562-vfio_pci_priv_jgg@nvidia.com/
[2]https://lore.kernel.org/all/0-v1-11d8272dc65a+4bd-vfio_ioctl_split_jgg@nvidia.com/

