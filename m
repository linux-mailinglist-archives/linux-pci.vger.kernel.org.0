Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EAB78192D
	for <lists+linux-pci@lfdr.de>; Sat, 19 Aug 2023 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjHSK7v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Aug 2023 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjHSK7u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Aug 2023 06:59:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F90D48887;
        Sat, 19 Aug 2023 03:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA8D961F36;
        Sat, 19 Aug 2023 10:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DCDC433C7;
        Sat, 19 Aug 2023 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692442625;
        bh=Mn8ulUN0jq+qzUt1cHG1kBd7PLnMl6tB5HKMwHLTmc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITOT/jqJJxiT7PYDSYOmskWxqFHRsGeE1r260Po8q+Af5TmRBESANo+9/BcI524T3
         1rnoXT4hHj6CdWGAz9HUCJlqjtS36q5kLmFMbbcOXXqhRO7ypfzqbyHAvX2uDgQ2xx
         swqDk9+VaqScE2B2QbQqOok/LdKWC2TbGWTeXTD4=
Date:   Sat, 19 Aug 2023 12:57:02 +0200
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
Message-ID: <2023081959-spinach-cherisher-b025@gregkh>
References: <20230817235810.596458-1-alistair.francis@wdc.com>
 <20230817235810.596458-2-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817235810.596458-2-alistair.francis@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 17, 2023 at 07:58:09PM -0400, Alistair Francis wrote:
> The documentation for sysfs_merge_group() specifically says
> 
>     This function returns an error if the group doesn't exist or any of the
>     files already exist in that group, in which case none of the new files
>     are created.
> 
> So just not adding the group if it's empty doesn't work, at least not
> with the code we currently have. The code can be changed to support
> this, but it is difficult to determine how this will affect existing use
> cases.

Did you try?  I'd really really really prefer we do it this way as it's
much simpler overall to have the sysfs core "do the right thing
automatically" than to force each and every bus/subsystem to have to
manually add this type of attribute.

Also, on a personal level, I want this function to work as it will allow
us to remove some code in some busses that don't really need to be there
(dynamic creation of some device attributes), which will then also allow
me to remove some apis in the driver core that should not be used at all
anymore (but keep creeping back in as there is still a few users.)

So I'll be selfish here and say "please try to get my proposed change to
work, it's really the correct thing to do here."

thanks,

greg k-h
