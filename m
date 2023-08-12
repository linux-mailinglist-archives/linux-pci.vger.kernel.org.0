Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C13779E28
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 10:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjHLI0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Aug 2023 04:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjHLI0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Aug 2023 04:26:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDD6270E;
        Sat, 12 Aug 2023 01:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 293EB602FB;
        Sat, 12 Aug 2023 08:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E10C433C7;
        Sat, 12 Aug 2023 08:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691828795;
        bh=ZvU+Ji3lEtuChDKihxuZBn05RJ9fLwG7X3gfqnGgG/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiLzYoIWsPw9lXFle737i8jKOA2d1j8tVQaPJiVoDDrQIKfCgX0Gdm1SMasl//pXa
         vNl+cpaetVg1KINPFmTvA2AfCAkkpm5OtPiLACyamHfFkDdM6FB+oJkKtPXWtGPVuU
         6NsSLQvSsGxNXzoG2omiB/z4yJdq18pUXbiMkjpQ=
Date:   Sat, 12 Aug 2023 10:26:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <2023081224-famished-devotion-6e0e@gregkh>
References: <20230809232851.1004023-1-alistair.francis@wdc.com>
 <20230810073457.GA26246@wunner.de>
 <CAKmqyKPm_BFnNxVLXCO_PVRDJaVb+XOj=kEEzXd+MgkwDiZhXA@mail.gmail.com>
 <20230812081526.GC9469@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812081526.GC9469@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 12, 2023 at 10:15:26AM +0200, Lukas Wunner wrote:
> On Thu, Aug 10, 2023 at 11:34:11AM -0400, Alistair Francis wrote:
> > On Thu, Aug 10, 2023 at 3:34???AM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Wed, Aug 09, 2023 at 07:28:51PM -0400, Alistair Francis wrote:
> > > > --- a/drivers/pci/pci-sysfs.c
> > > > +++ b/drivers/pci/pci-sysfs.c
> > > > @@ -1226,6 +1227,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
> > > >       int i;
> > > >       int retval;
> > > >
> > > > +#ifdef CONFIG_PCI_DOE
> > > > +     retval = doe_sysfs_init(pdev);
> > > > +     if (retval)
> > > > +             return retval;
> > > > +#endif
> > > > +
> > >
> > > The preferred way to expose PCI sysfs attributes nowadays is to add them
> > > to pci_dev_attr_groups[] and use the ->is_visible callback to check
> > > whether they're applicable to a particular pci_dev.  The alternative
> > > via pci_create_resource_files() has race conditions which I think
> > > still haven't been fixed. Bjorn recommended the ->is_visible approach
> > > in response to the most recent attempt to fix the race:
> > >
> > > https://lore.kernel.org/linux-pci/20230427161458.GA249886@bhelgaas/
> > 
> > The is_visible doen't seem to work in this case.
> > 
> > AFAIK is_visible only applies to the attributes under the group. Which
> > means that every PCIe device will see a `doe_protos` directory, no
> > matter if DOE is supported.
> 
> internal_create_group() in fs/sysfs/group.c does this:
> 
> 	if (grp->name) {
> 			...
> 			kn = kernfs_create_dir_ns(kobj->sd, grp->name, ...
> 
> So I'm under the impression that if you set the ->name member of
> struct attribute_group, the attributes in that group appear under
> a directory of that name.
> 
> In fact, the kernel-doc for struct attribute_group claims as much:
> 
>  * struct attribute_group - data structure used to declare an attribute group.
>  * @name:	Optional: Attribute group name
>  *		If specified, the attribute group will be created in
>  *		a new subdirectory with this name.
> 
> So I don't quite understand why you think that "every PCIe device will
> see a `doe_protos` directory, no matter if DOE is supported"?
> 
> Am I missing something?

I think the issue might be that the directory will be created even if no
attributes are present in it due to the is_visable() check not returning
any valid files?

If so, I had a patch somewhere around here where I was trying to fix
that up:
	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=debugfs_cleanup&id=f670945dfbaf353fe068544c31e3fa45575da5b5
but it didn't seem to work properly and kept crashing.  I didn't spend
much time on looking into it, but if this is an issue, I can work on
fixing this properly.

thanks,

greg k-h
