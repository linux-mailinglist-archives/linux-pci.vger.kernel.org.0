Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7944662D571
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbiKQItM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 03:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiKQIsz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 03:48:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2468356D67;
        Thu, 17 Nov 2022 00:48:47 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668674925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f4v0o1aapg52+kcGV5XzAXyexP8Lv3lkKr4tjq7Y6O8=;
        b=DpAi6RQXxFDAb2jCHZ8hlQGCjq7mUquhCkriQC1k+9L0/zpGPIDiDl1wxfoVJWMMc78fWv
        CvKgC6NDCv4M4ECMkgjqNPVdnWHXrvKJw3eIIuHWJdEh3qA+KdDo17J98VlAIUkbdENP3c
        uIYgYu3SkpZL6fgPFgpWDTw5m0wPt/FS5YSZeCsqZeRZ+AAiJ8CA9Ue9LHcLgni+DdqyC4
        9HVVmUt1xIcWD1QdHd7VEuB6t9AhpmgY9P6zv760Gn2NALAhbYSBtsMm5JG+DzAF+k65BS
        IWn5FdhAuzAg6oJvg9KiSyn3jKaDOTJRKePnnqaPxy+Hhpidj+kYQEhQXJAS/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668674925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f4v0o1aapg52+kcGV5XzAXyexP8Lv3lkKr4tjq7Y6O8=;
        b=VVj3wrOiImh69rAfSDo0/Y81RyorJMIHmdUsQW58EnPk24F1oOuavIpj30UCq+WmojLUnP
        UMMbhlSw349GX5AQ==
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
Date:   Thu, 17 Nov 2022 09:48:45 +0100
Message-ID: <87tu2ym0eq.ffs@tglx>
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
>
> Maybe could be written
>
> struct msi_desc {
>    u64 domain_data[2];
> }
>
> struct pci_msi_desc {
> 		u32 msi_mask;
> 		u8	multiple	: 3;
> 		u8	multi_cap	: 3;
> 		u8	can_mask	: 1;
> 		u8	is_64		: 1;
> 		u8	mask_pos;
> 		u16 default_irq;
> }
> static_assert(sizeof(struct pci_msi_desc) <= sizeof(((struct msi_desc *)0)->domain_data));
>
> struct pci_msix_desc {
> 		u32 msix_ctrl;
> 		u8	multiple	: 3;
> 		u8	multi_cap	: 3;
> 		u8	can_mask	: 1;
> 		u8	is_64		: 1;
> 		u16 default_irq;
> 		void __iomem *mask_base;
> }
> static_assert(sizeof(struct pci_msix_desc) <= sizeof(((struct msi_desc *)0)->domain_data));
>
> ideally hidden in the pci code with some irq_chip facing export API to
> snoop in the bits a few places need
>
> We've used 128 bits for the PCI descriptor, we might as well like
> everyone have all 128 bits for whatever they want to do

Not sure because we end up with nasty type casts for

> struct msi_desc {
>    u64 domain_data[2];
> }

Let me think about it.

Thanks,

        tglx
