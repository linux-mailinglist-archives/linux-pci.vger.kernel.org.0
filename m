Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8706B62FFC8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiKRWKM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 17:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiKRWJK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 17:09:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4002A247;
        Fri, 18 Nov 2022 14:08:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668809336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnfgXd1Z1kEJz/iUidm8c/wi9GfdOU18AFgTdLiaHzQ=;
        b=zyc09kpEikj+0oYrNiLkiSvG9o5luUsIacAec8CTkLA1ktWLFgHIB6NS9ZfzkF11H1HY6T
        fEH0fU8bWxin7bquD/8CFOsBgQvwRy9cfQ9EZXHdkKJ57g+Kl35U48VSmGgOU+2EFOZKrx
        yRJJ8S/aNHH8uUnZ1WTFV9HPAmR0QbdT5lJ5Tlf4pSWhfHzVmEri5XUou7/gmtYOAX6yOB
        DwD3VZWWvLOwgw67lrDcI1lnbY77G78Nc1kNuQbzISMzsb/OhTorHW3IGQlDS22AdDdO1M
        L5CMFQustvn7er8uhTWsSKM+nZ5sjRu7kB2mTbtQUQNidHpZZ60B31PXY84+3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668809336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnfgXd1Z1kEJz/iUidm8c/wi9GfdOU18AFgTdLiaHzQ=;
        b=gwW+7N4k+YwFIof1NRxdeJBMMVdkWDrF3YynFdWLoC2YtLMMwmVmr2iGssZHh8hWnfx4Uh
        fl68IDVGrHvdcgBA==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 19/33] genirq/msi: Provide msi_desc::msi_data
In-Reply-To: <Y3U5xwujkZvI0TEN@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.346985384@linutronix.de> <Y3U5xwujkZvI0TEN@nvidia.com>
Date:   Fri, 18 Nov 2022 23:08:55 +0100
Message-ID: <871qpzkj9k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16 2022 at 15:28, Jason Gunthorpe wrote:
> On Fri, Nov 11, 2022 at 02:58:41PM +0100, Thomas Gleixner wrote:
>
>> +/**
>> + * struct msi_desc_data - Generic MSI descriptor data
>> + * @iobase:     Pointer to the IOMEM base adress for interrupt callbacks
>> + * @cookie:	Device cookie provided at allocation time
>> + *
>> + * The content of this data is implementation defined, e.g. PCI/IMS
>> + * implementations will define the meaning of the data.
>> + */
>> +struct msi_desc_data {
>> +	void			__iomem *iobase;
>> +	union msi_dev_cookie	cookie;
>> +};
>
> It would be nice to see the pci_msi_desc converted to a domain
> specific storage as well.

I looked into this and it gets ugly very fast.

The above has two parts:

    iobase    is domain specific and setup by the domain code

    cookie    is per interrupt allocation. That's where the instance
              queue or whatever connects to the domain.

I can abuse the fields for PCI/MSI of course, but see below.

> Maybe could be written
>
> struct pci_msi_desc {
> }
> static_assert(sizeof(struct pci_msi_desc) <= sizeof(((struct msi_desc *)0)->domain_data));
>
> struct pci_msix_desc {
> }
> static_assert(sizeof(struct pci_msix_desc) <= sizeof(((struct msi_desc *)0)->domain_data));
>
> ideally hidden in the pci code with some irq_chip facing export API to
> snoop in the bits a few places need

I can't use that for the current combo legacy PCI/MSI code as I can't
split the irq chip implementations like I can with the new per device
domains.

And no, I'm not going to create separate code pathes which do the same
thing on different data structures just to pretend that it's all shiny.

> We've used 128 bits for the PCI descriptor, we might as well like
> everyone have all 128 bits for whatever they want to do

That's fine, but there are two parts to it:

   1) Domain specific data

   2) Per allocation specific data

#1 is data which the domain code puts there, e.g. in the prepare_desc()
   callback

#2 is data which the usage site hands in which gives the domain and the
   interrupt chip the information it needs

So the data structure should look like this:

struct msi_desc_data {
	union msi_domain_cookie		dom_cookie;
	union msi_instance_cookie	ins_cookie;
};

union msi_domain_cookie {
	void __iomem	*iobase;
        void		*ptr;
        u64		value;
};

union msi_instance_cookie {
        void		*ptr;
        u64		value;
};

Sure I could make both cookies plain u64, but I hate these forced type
casts and the above is simple to handle and understand.

So you get your 128 bit, but not per instance because that's a nightmare
to validate versus the allocation code which has to copy the data into
the msi descriptor, whatever it is (PASID, queue pointer ....).

Having two cookies makes a lot of sense to have a proper separation
between domain and usage site.

For IDXD the domain wants to store the iobase and needs a per allocation
PASID.

For your queue model, the domain wants a pointer to some device or
whatever specific things and the queue provides a pointer so that the
domain/chip can do the right thing for that particular instance.

For both sides, the domain and the allocation side something like the
above is sufficient.

Thanks,

        tglx
