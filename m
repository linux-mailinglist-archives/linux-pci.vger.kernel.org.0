Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5657B632D15
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 20:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiKUTkP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 14:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiKUTkJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 14:40:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38541CB97F;
        Mon, 21 Nov 2022 11:40:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669059605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C7m3d+zzcm0+ck6h+pP6E95Yb1gw+Bq/lQH+jPmZyAA=;
        b=2tDN8HUylQIoLblLUF/8xofiDN73yCUjsW5zcweV3AzT5UjOsM1EKGgEsXbHuLfBL3V5yL
        eIqd2cYgrBqtCoqLolT/EY18p2OK8ZP6N7qwALemkb54z4PgH6PnLvjOz7PoLbBNwAr3EP
        wiT4PzRQPbaIdyy/jkzK/xGjLJoCjRtU/urP6ydwSzFtqHAoFYyKMPWe3+awRbzHZdcWiz
        y2X39W4YFlCmfcCkYfIse2CDhUYgJEfrqMGzk5hXU04z2JqtFSAQRdec2xoG+VbLECKnt7
        5C9H5WOJ227IAaaTj/zEIZ1x95Br8FabKcMeGzPnoKseeMu7MAxhsLJlZlZZtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669059605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C7m3d+zzcm0+ck6h+pP6E95Yb1gw+Bq/lQH+jPmZyAA=;
        b=TIDZELAFfx7uUVsHRIhKCWs5wmXklSKUz1ZNni4hnXD389UGK3ZWkK4X/JXyxtjr32vkOK
        5KJPzS//zccOhFBg==
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
In-Reply-To: <Y3uzVJ/7ecL8DBK7@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.346985384@linutronix.de> <Y3U5xwujkZvI0TEN@nvidia.com>
 <871qpzkj9k.ffs@tglx> <Y3uzVJ/7ecL8DBK7@nvidia.com>
Date:   Mon, 21 Nov 2022 20:40:05 +0100
Message-ID: <87bkp0hzai.ffs@tglx>
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

On Mon, Nov 21 2022 at 13:20, Jason Gunthorpe wrote:
> On Fri, Nov 18, 2022 at 11:08:55PM +0100, Thomas Gleixner wrote:
>> Sure I could make both cookies plain u64, but I hate these forced type
>> casts and the above is simple to handle and understand.
>
> I guess, they aren't what I think of as cookies, so I wouldn't make
> them u64 in the first place.
>
> The argument to msi_domain_alloc_irq_at() ideally wants to be a
> per-domain-type struct so we can folow it around more cleanly. This is
> C so we have to type erase it as a void * through the core code, but
> OK.

When looking at the wire to MSI abomination and also PASID there is no
real per domain struct. It's plain integer information and I hate to
store it in a pointer. Especially as the pointer width on 32bit is not
necessarily sufficient.

Allocating 8 bytes and tracking them to be freed would be an horrible
idea.

> The second one is typically called "driver private data" in device
> driver subsystems that can't use container_of for some reason - just a
> chunk of data the driver can associate with a core owned struct.
>
> The usual pattern for driver private data is for the core to provide
> some kind of accessor void *get_priv() (think dev_get_drvdata()) or
> whatever.
>
> But I do understand your point about keeping the drivers away from
> things. Maybe some other pattern is better in this case.

At least from the two examples I have (IDXD and wire2MSI) the per
instance union works perfectly fine and I can't see a reason why
e.g. for your usecase

     cookie = { .ptr = myqueue };

would not work. The meaning of the cookie is domain implementation
defined and only the actual MSI domain and the related users know
whether its a value or a pointer and what to do with this information. I
named it cookie because from the core MSI code's view it's completely
opaque and aside of the fact that the allocation function copies the
cookie into msi_desc, the core does not care at all about it. Same for
the domain one which is solely handled by the domain setup code and is
e.g. used to enable the irq chip callbacks to do what they need to do.

Thanks,

        tglx
