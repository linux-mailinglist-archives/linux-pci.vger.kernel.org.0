Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811DF62CE08
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 23:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiKPWuH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 17:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238783AbiKPWuG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 17:50:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A967D102;
        Wed, 16 Nov 2022 14:50:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668639004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJINf6BQpwrxQblgElY3Z/Qake6SaBEaI8K197mgKXI=;
        b=i2zVGcjjlmtD6RzaAN7Rd8kq8M9SCk4OpZIQDtcnq05onovT5445baNfe1sWBc2cspfcGV
        lUd0NTWh04skUtkdZpVkqtXRa00FHct9e+ll7+ToZyQ3mGc9rSNCCmckoPMBVGb9UHLlAs
        X/xaF0Gx3UqpT7weCv6SGUUg78LHE6qMqpmJPehXumZ4PZlkS7qbS/J6XZk74LdBKHv1k6
        ismg4/n78osu6aIytwon5YEISBmtQHQHNyhDRs6HSkEFWSGJLWUV/UvR+NQW6MyBGw9JiG
        77+S86sUqEy1+O3RIq/jaOCEVEn+OC4BVRAklJIr0G6vKZRy9NrTKCPVHZKfYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668639004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJINf6BQpwrxQblgElY3Z/Qake6SaBEaI8K197mgKXI=;
        b=tPDGD/t7fzyzH2BG49DjIxgAsUrKrCtx9CryyXHlRnNXrE1tNhMmGX4Wm6sSFgsZI1yKx/
        K10CADLTJTyEk+AA==
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
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 12/39] genirq/msi: Add bus token to struct msi_domain_info
In-Reply-To: <Y3Uim3pC3hy3HwH8@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122014.294554462@linutronix.de> <Y3Uim3pC3hy3HwH8@nvidia.com>
Date:   Wed, 16 Nov 2022 23:50:04 +0100
Message-ID: <87iljeo6oz.ffs@tglx>
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

On Wed, Nov 16 2022 at 13:49, Jason Gunthorpe wrote:

> On Fri, Nov 11, 2022 at 02:54:33PM +0100, Thomas Gleixner wrote:
>> From: Ahmed S. Darwish <darwi@linutronix.de>
>> 
>> Add a bus token member to struct msi_domain_info and let
>> msi_create_irq_domain() set the bus token.
>> 
>> That allows to remove the bus token updates at the call sites.
>> 
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  include/linux/msi.h |   19 +++++++++++--------
>>  kernel/irq/msi.c    |    7 +++++--
>>  2 files changed, 16 insertions(+), 10 deletions(-)
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
>>  struct msi_domain_info {
>> -	u32			flags;
>> -	struct msi_domain_ops	*ops;
>> -	struct irq_chip		*chip;
>> -	void			*chip_data;
>> -	irq_flow_handler_t	handler;
>> -	void			*handler_data;
>> -	const char		*handler_name;
>> -	void			*data;
>> +	u32				flags;
>> +	enum irq_domain_bus_token	bus_token;
>> +	struct msi_domain_ops		*ops;
>> +	struct irq_chip			*chip;
>> +	void				*chip_data;
>> +	irq_flow_handler_t		handler;
>> +	void				*handler_data;
>> +	const char			*handler_name;
>> +	void				*data;
>>  };
>
> This is why I've been frowning on horizontal alignment :(

Yes, it's annoying when you have to adjust it, but it's fundamentaly
simpler to parse than the clogged together word salad.
