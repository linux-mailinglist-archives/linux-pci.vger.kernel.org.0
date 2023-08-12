Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7D779E1E
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 10:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjHLIP0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Aug 2023 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLIPZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Aug 2023 04:15:25 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83447CE;
        Sat, 12 Aug 2023 01:15:28 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id E7D42100DCEFD;
        Sat, 12 Aug 2023 10:15:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AA336EA35; Sat, 12 Aug 2023 10:15:26 +0200 (CEST)
Date:   Sat, 12 Aug 2023 10:15:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com,
        gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230812081526.GC9469@wunner.de>
References: <20230809232851.1004023-1-alistair.francis@wdc.com>
 <20230810073457.GA26246@wunner.de>
 <CAKmqyKPm_BFnNxVLXCO_PVRDJaVb+XOj=kEEzXd+MgkwDiZhXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKPm_BFnNxVLXCO_PVRDJaVb+XOj=kEEzXd+MgkwDiZhXA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 10, 2023 at 11:34:11AM -0400, Alistair Francis wrote:
> On Thu, Aug 10, 2023 at 3:34???AM Lukas Wunner <lukas@wunner.de> wrote:
> > On Wed, Aug 09, 2023 at 07:28:51PM -0400, Alistair Francis wrote:
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -1226,6 +1227,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
> > >       int i;
> > >       int retval;
> > >
> > > +#ifdef CONFIG_PCI_DOE
> > > +     retval = doe_sysfs_init(pdev);
> > > +     if (retval)
> > > +             return retval;
> > > +#endif
> > > +
> >
> > The preferred way to expose PCI sysfs attributes nowadays is to add them
> > to pci_dev_attr_groups[] and use the ->is_visible callback to check
> > whether they're applicable to a particular pci_dev.  The alternative
> > via pci_create_resource_files() has race conditions which I think
> > still haven't been fixed. Bjorn recommended the ->is_visible approach
> > in response to the most recent attempt to fix the race:
> >
> > https://lore.kernel.org/linux-pci/20230427161458.GA249886@bhelgaas/
> 
> The is_visible doen't seem to work in this case.
> 
> AFAIK is_visible only applies to the attributes under the group. Which
> means that every PCIe device will see a `doe_protos` directory, no
> matter if DOE is supported.

internal_create_group() in fs/sysfs/group.c does this:

	if (grp->name) {
			...
			kn = kernfs_create_dir_ns(kobj->sd, grp->name, ...

So I'm under the impression that if you set the ->name member of
struct attribute_group, the attributes in that group appear under
a directory of that name.

In fact, the kernel-doc for struct attribute_group claims as much:

 * struct attribute_group - data structure used to declare an attribute group.
 * @name:	Optional: Attribute group name
 *		If specified, the attribute group will be created in
 *		a new subdirectory with this name.

So I don't quite understand why you think that "every PCIe device will
see a `doe_protos` directory, no matter if DOE is supported"?

Am I missing something?

Thanks,

Lukas
