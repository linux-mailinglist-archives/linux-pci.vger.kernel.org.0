Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00777771E4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 09:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjHJHs4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjHJHs4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 03:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA15211E;
        Thu, 10 Aug 2023 00:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22E29651D6;
        Thu, 10 Aug 2023 07:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0EEC433C8;
        Thu, 10 Aug 2023 07:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691653733;
        bh=Tm3hXQwoDjfq1lJqS0uY3AYuTtyBzJD+EkwzV99FVaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XveL0le9szv1D4Vty0V1Ks2eJJ8IiK8v/awhvRgoaJhdK2HpRjCtxKHJeMR028QJQ
         Fr+pv/2PGMCxqQbYKYKvLx76V7RC4oZ7IP5fqmZHdGmsWYckheki8Kf/FE/VPjkZUK
         VSKuZ5yKX6h2s5YVwwpX6poeeGQiBLsBttVVeQ6M=
Date:   Thu, 10 Aug 2023 09:48:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <2023081019-nuclei-drone-32de@gregkh>
References: <20230809232851.1004023-1-alistair.francis@wdc.com>
 <2023081005-ground-muster-63c8@gregkh>
 <20230810074444.GA11861@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810074444.GA11861@wunner.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 10, 2023 at 09:44:44AM +0200, Lukas Wunner wrote:
> On Thu, Aug 10, 2023 at 07:05:12AM +0200, Greg KH wrote:
> > On Wed, Aug 09, 2023 at 07:28:51PM -0400, Alistair Francis wrote:
> > > v3:
> > >  - Expose each DOE feature as a separate file
> > 
> > But you don't actually have anything in the sysfs files, why not?
> 
> He wants to expose a list of supported protocols.
> 
> He first exposed the list in a single attribute, separated by newlines.
> Which made sense because it allows users to grep for a specific protocol.
> 
> You told him not to expose multiple values in a single attribute.
> So he's exposing the available protocols each in an empty file.
> The file name contains the protocol.
> 
> You got what you asked for. ;)

But that's not what was documented, it should say "empty file",
otherwise this is going to be very odd when people try to read a file
that is marked as readable, but yet returns an error :(

> > > --- a/drivers/pci/doe.c
> > > +++ b/drivers/pci/doe.c
> > > @@ -56,6 +56,10 @@ struct pci_doe_mb {
> > >  	wait_queue_head_t wq;
> > >  	struct workqueue_struct *work_queue;
> > >  	unsigned long flags;
> > > +
> > > +#ifdef CONFIG_SYSFS
> > > +	struct device_attribute *sysfs_attrs;
> > > +#endif
> > 
> > Please don't put #ifdefs in .c files if you can prevent it.  I think
> > this will work just fine if you don't have the #ifdef.  And who would be
> > using pci without sysfs?
> 
> People with space-constrained devices such as routers.

So the extra pointer here is a real problem for them?  And how much
memory are you saving?

> It is perfectly legal to compile a kernel with CONFIG_PCI=y and
> CONFIG_SYSFS=n.

Sure, just not common.

> And it is reasonable not to include code in the kernel which has
> specifically been deselected in the kernel config.

Sure, but not at the expense of a zillion #ifdef lines :)

thanks,

greg k-h
