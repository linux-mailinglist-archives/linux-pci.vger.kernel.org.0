Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F02262E06B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 16:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiKQP4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 10:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbiKQP4M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 10:56:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F7478198;
        Thu, 17 Nov 2022 07:56:10 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668700568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=043nO1RjXIjY2HLU/OMiG3oSNWN6iRW9GS+br86kdpI=;
        b=GHwkXhr2GApTSD2jktsDA4KqT5GPFDF+6NaQdXu32KwyoET6vF+DM1NHLoh/bAMm/97yxP
        4ihZDkhp/3ZiYc902Ft6Wsimcjgzs5jlivpOpHX4CTkrYe00l5RUzOcxxsmzfKJ8WzeVcU
        qW3xLSXdXxNRNLMc/F0/o639kNXX7Wg6DIGmvBt1iJAqckKEY0R/8oJyCnUdp8r68Aquan
        Is7b7COYXkxtEgXuIK9qG2yc3yjLQ5b5zG39LMbWUzFy/2YNiepEiCjoYsCSYI/gdndQNN
        JGEm7Nupap3cKiRqKfZ32EO8DQ4uFChJzpWyhSVXTqCZx3DfssdnNE+x0zAnVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668700568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=043nO1RjXIjY2HLU/OMiG3oSNWN6iRW9GS+br86kdpI=;
        b=ZRJdS7AU1ymDEY7qsMUVfQSDenoppCa7q9n+l9Gazgl8Uer6u4hAh99Qj6QohFgN4VUiAt
        IhoUDr+yEAnBu/DA==
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
Subject: Re: [patch 02/20] genirq/irqdomain: Rename irq_domain::dev to
 irq_domain::pm_dev
In-Reply-To: <Y3UqSOGDHl+vnlo9@nvidia.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.163937407@linutronix.de> <Y3UqSOGDHl+vnlo9@nvidia.com>
Date:   Thu, 17 Nov 2022 16:56:08 +0100
Message-ID: <875yfdmv6v.ffs@tglx>
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

On Wed, Nov 16 2022 at 14:22, Jason Gunthorpe wrote:
>> +	if (gic->domain->pm_dev)
>> +		seq_printf(p, gic->domain->pm_dev->of_node->name);
>
> This looks a bit odd now? I guess it still prints something meaningful
> to debugfs but I suppose this would someday make more sense to be the
> ::dev version?

Maybe, but for now I just want to keep it compatible.

>> --- a/include/linux/irqdomain.h
>> +++ b/include/linux/irqdomain.h
>> @@ -117,53 +117,53 @@ struct irq_domain_chip_generic;
>>  
>>  /**
>>   * struct irq_domain - Hardware interrupt number translation object
>> - * @link: Element in global irq_domain list.
>> - * @name: Name of interrupt domain
>> - * @ops: pointer to irq_domain methods
>> - * @host_data: private data pointer for use by owner.  Not touched by irq_domain
>> - *             core code.
>> - * @flags: host per irq_domain flags
>> - * @mapcount: The number of mapped interrupts
>> + * @link:	Element in global irq_domain list.
>> + * @name:	Name of interrupt domain
>> + * @ops:	Pointer to irq_domain methods
>
> Maybe all this whitespace change would like to be in its own patch?

Yes.
