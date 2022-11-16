Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFBC62C5B7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiKPRDJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiKPRDH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:03:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C796FC76F;
        Wed, 16 Nov 2022 09:03:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668618185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eOfL205iUtArVsJR5Cv2Qtv3GplSQquUjpKC4BPz1VQ=;
        b=p5NIRSDRdgNg6sjXezPWC2TxqPe4xfBPWZPlRq8AEA+qx8f8LwxdiY6BdbvqwFwhOm29Vy
        TaLKsf6n+wkRGox3pcK4qVEcl6c26bXvfM1KmJX3PrPOWwOYIQxt4oOWY7Ga2LD0021F8h
        p5+FwT1n0Dcp+DGtS0QSwAw/kahUq5WSdDie+MF66QsWtLakAl4cBB4ddCY8iRiJj5FZtT
        nh541QKhFZbf2fpNYqTYfZy5d3Et363GISC8S389rbYTkjtF+hMnzGQjEWU2RQKhiBLSGT
        Q8kpS0iEIcnCwAJK2Z/3UpzF5uIZlyEYC9VqBUHMFRMgWsP8LCgtE9p62TVgOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668618185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eOfL205iUtArVsJR5Cv2Qtv3GplSQquUjpKC4BPz1VQ=;
        b=78yxMdLZgx5iu9Ei93SsTPYjPK3n8cN81g/Po4FLgS4BlUxWJhZUPkYMuviNPQ0E4/exmA
        3OJ7HD4B1ghQ8qCg==
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
Subject: Re: [patch 03/39] iommu/amd: Remove bogus check for multi MSI-X
In-Reply-To: <Y3UJkEb7ejrxbW22@a4bf019067fa.jf.intel.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122013.772447165@linutronix.de>
 <Y3UJkEb7ejrxbW22@a4bf019067fa.jf.intel.com>
Date:   Wed, 16 Nov 2022 18:03:04 +0100
Message-ID: <87tu2yq1br.ffs@tglx>
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

On Wed, Nov 16 2022 at 08:02, Ashok Raj wrote:
> On Fri, Nov 11, 2022 at 02:54:19PM +0100, Thomas Gleixner wrote:
>> PCI/Multi-MSI is MSI specific and not supported for MSI-X
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  drivers/iommu/amd/iommu.c |    3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3294,8 +3294,7 @@ static int irq_remapping_alloc(struct ir
>>  
>>  	if (!info)
>>  		return -EINVAL;
>> -	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI &&
>> -	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
>> +	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI)
>>  		return -EINVAL;
>>  
>>  	/*
>> 
>
> nit:
>
> maybe better to merge patch2/3 since both seem related?

What's better about it? It's two different drivers.
