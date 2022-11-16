Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F303F62C5B5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiKPRCd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiKPRCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:02:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355771B799;
        Wed, 16 Nov 2022 09:02:32 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668618150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73/k+Pqe+eIdLrX5pigBKT2S4Kr0WftEUmk46mQSZq4=;
        b=KDnklEjxF7By95INYq+dtxZdCdY/C01Z76Y3GVUU4F3KTF6wB9npHtyJk3/UAgAb2A+Kl2
        OO8l0ogbhCgtGOzGSm278d7Ntq9gnX5OWX3a6rnZ4IXbyxowohL3X/waIh8pZdLxNBb0T6
        AL5Ba0JCMIs8eN7MF+cdBQIMfREMbj5b283h9U+0gizZueBJ2TbopR81DOJDkA+yLscvLG
        5FHYQIDq160F+/ffXyNSwf1Pr1MYqKx6AnPF4ABlFzMU4zcMo5Y3U2X2+lhW6JuSf+6b83
        w3dIwnYYAiAmM5Vry7hYiK9ZrD8cGZlRqSpgOZrAqzDh3QEn/1udH8Sv89Gl7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668618150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73/k+Pqe+eIdLrX5pigBKT2S4Kr0WftEUmk46mQSZq4=;
        b=/lLRXLA6lsq9XHJeSKJip6VCUSvS/TfY12kAhlPgvsYIqLFWJcn73WeC2hRsndLX2l+7Fj
        tgC7oNEGsKmJLACQ==
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 02/39] iommu/vt-d: Remove bogus check for multi MSI-X
In-Reply-To: <Y3UHVGptkWZnIEgI@a4bf019067fa.jf.intel.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122013.713848846@linutronix.de>
 <Y3UHVGptkWZnIEgI@a4bf019067fa.jf.intel.com>
Date:   Wed, 16 Nov 2022 18:02:30 +0100
Message-ID: <87wn7uq1cp.ffs@tglx>
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

On Wed, Nov 16 2022 at 07:52, Ashok Raj wrote:
> On Fri, Nov 11, 2022 at 02:54:17PM +0100, Thomas Gleixner wrote:
>> PCI/Multi-MSI is MSI specific and not supported for MSI-X.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  drivers/iommu/intel/irq_remapping.c |    3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> --- a/drivers/iommu/intel/irq_remapping.c
>> +++ b/drivers/iommu/intel/irq_remapping.c
>> @@ -1334,8 +1334,7 @@ static int intel_irq_remapping_alloc(str
>>  
>>  	if (!info || !iommu)
>>  		return -EINVAL;
>> -	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI &&
>> -	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
>> +	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI)
>>  		return -EINVAL;
>>  
>>  	/*
>> 
>
> This check is only making sure that when multi-msi is requested that the
> type has to be either MSI/MSIX.

MSI-X does not support multi vector allocations on a single entry.

> Wouldn't this change return -EINVAL when type = MSIX?

Rightfully so. MSIX vectors are allocated one by one. Has been that way
forever.

Thanks,

        tglx


