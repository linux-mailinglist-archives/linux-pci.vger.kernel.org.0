Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08D778510D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 09:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjHWHCn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 03:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjHWHCn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 03:02:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8BECE8;
        Wed, 23 Aug 2023 00:02:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA3464982;
        Wed, 23 Aug 2023 07:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C11C433C7;
        Wed, 23 Aug 2023 07:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692774159;
        bh=GA8OiRBj8V4niqfWdyzMuban8l3H8iUS+3bcTCjZzJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lys1sm1gp/HmfpCprl8w8lst1MQRZK8lZUXzbUUWDghJla0YZGpqyuLJQfkd9/fwV
         sg9U79OrJ1bozUcZDlES6Y4kf5wSIOQQDSArLgZP3/pX85hPTA1AP6HtOMK9Lijz66
         7Xrr9zFZM/GPoW9oi0HkxDz78+5/pxUDS67eU0xk=
Date:   Wed, 23 Aug 2023 09:02:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to
 attribute_group
Message-ID: <2023082325-cognitive-dispose-1180@gregkh>
References: <20230817235810.596458-1-alistair.francis@wdc.com>
 <20230817235810.596458-2-alistair.francis@wdc.com>
 <2023081959-spinach-cherisher-b025@gregkh>
 <CAKmqyKM+DNTF1f0FvDEda_db792Ta4w_uAKNTZ6E3NkYoVcPFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKM+DNTF1f0FvDEda_db792Ta4w_uAKNTZ6E3NkYoVcPFQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 22, 2023 at 04:20:06PM -0400, Alistair Francis wrote:
> On Sat, Aug 19, 2023 at 6:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 17, 2023 at 07:58:09PM -0400, Alistair Francis wrote:
> > > The documentation for sysfs_merge_group() specifically says
> > >
> > >     This function returns an error if the group doesn't exist or any of the
> > >     files already exist in that group, in which case none of the new files
> > >     are created.
> > >
> > > So just not adding the group if it's empty doesn't work, at least not
> > > with the code we currently have. The code can be changed to support
> > > this, but it is difficult to determine how this will affect existing use
> > > cases.
> >
> > Did you try?  I'd really really really prefer we do it this way as it's
> > much simpler overall to have the sysfs core "do the right thing
> > automatically" than to force each and every bus/subsystem to have to
> > manually add this type of attribute.
> >
> > Also, on a personal level, I want this function to work as it will allow
> > us to remove some code in some busses that don't really need to be there
> > (dynamic creation of some device attributes), which will then also allow
> > me to remove some apis in the driver core that should not be used at all
> > anymore (but keep creeping back in as there is still a few users.)
> >
> > So I'll be selfish here and say "please try to get my proposed change to
> > work, it's really the correct thing to do here."
> 
> I did try!
> 
> This is an attempt:
> https://github.com/alistair23/linux/commit/56b55756a2d7a66f7b6eb8a5692b1b5e2f81a9a9
> 
> It is based on your original patch with a bunch of:
> 
> if (!parent) {
>     parent = kernfs_create_dir_ns(kobj->sd, grp->name,
>                   S_IRWXU | S_IRUGO | S_IXUGO,
>                   uid, gid, kobj, NULL);
>     ...
>     }
> 
> 
> added throughout the code base.
> 
> Very basic testing shows that it does what I need it to do and I don't
> see any kernel oops on boot.

Nice!

Mind if I take it and clean it up a bit and test with it here?  Again, I
need this functionality for other stuff as well, so getting it merged
for your feature is fine with me.

> I prefer the approach I have in this mailing list patch. But if you
> like the commit mentioned above I can tidy and clean it up and then
> use that instead

I would rather do it this way.  I can work on this on Friday if you want
me to.

thanks,

greg k-h
