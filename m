Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6F56348B6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 21:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiKVUtX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 15:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiKVUtO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 15:49:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2AF5FCE;
        Tue, 22 Nov 2022 12:49:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669150152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pfc3U0FP2Lnc5z1VrfUAMhH4qSDsY0sFH+bolxBJV2Q=;
        b=hM0+j4i6YHKWujhAPxELP3h3lThk/nXpw7qkuDY/Lb7y3seyF2eocYM9s+sWoQ3bd2DGqm
        E+qArth+HozHaHY+WvfqqPd36wsdoJVwl1T/54uDaO1Kay7GArLu8lTlOhjonFmjEvkTdD
        baMPWWWONXa1JktJGSiN7//y2+FpRjAv3lpIF/HxN/owtdToF+pW2vs87IB34GC88BclLq
        yV3z9P8+ykSxZrXf59Zg+c8mRtNdqO1xG5tnGc6nDPXM9vC9W9vo6EbxVwHXeAUzHK237w
        xgPEKGPlObiHTpZlHcn/8pI9ovFfgbJDH7/GRcv9L+KE5UUlX8vUsBnf3DpqlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669150152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pfc3U0FP2Lnc5z1VrfUAMhH4qSDsY0sFH+bolxBJV2Q=;
        b=4vOCJeNnwKKKbqn7++W16tNi2GArm0BUEwdiN1YhXssZZvM8IOLP5YizELO29/tvSeGvvB
        dNASJi5SwSCkaNDA==
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
In-Reply-To: <Y3wreJlD/7TsMCme@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.346985384@linutronix.de> <Y3U5xwujkZvI0TEN@nvidia.com>
 <871qpzkj9k.ffs@tglx> <Y3uzVJ/7ecL8DBK7@nvidia.com> <87bkp0hzai.ffs@tglx>
 <Y3wreJlD/7TsMCme@nvidia.com>
Date:   Tue, 22 Nov 2022 21:49:11 +0100
Message-ID: <87k03mg1fc.ffs@tglx>
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

Jason,

On Mon, Nov 21 2022 at 21:52, Jason Gunthorpe wrote:
> On Mon, Nov 21, 2022 at 08:40:05PM +0100, Thomas Gleixner wrote:
>> When looking at the wire to MSI abomination and also PASID there is no
>> real per domain struct. It's plain integer information and I hate to
>> store it in a pointer. Especially as the pointer width on 32bit is not
>> necessarily sufficient.
>> 
>> Allocating 8 bytes and tracking them to be freed would be an horrible
>> idea.
>
> No, not allocation, just wrap in a stack variable:
>
>   struct foo_bar_domain_data arg = {.pasid = XX};
>
>   msi_domain_alloc_irq_at(..., &arg);
>
> Then there is a great big clue right in the code who is supposed to be
> consuming that opaque argument. grep the code for foo_bar_domain_data
> and you can find the receiving side

Agreed for the one or two sane people who actually will create their
data struct. The rest will just hand in a random pointer or a casted
integer, which is pretty useless for finding the counterpart.

>> At least from the two examples I have (IDXD and wire2MSI) the per
>> instance union works perfectly fine and I can't see a reason why
>> e.g. for your usecase
>> 
>>      cookie = { .ptr = myqueue };
>> 
>> would not work. 
>
> I'm not saying not work, I'm asking about the style choice

Sure. The other reason why made this choice is that for many cases it
spares a callback to actually convert the pointer into real storage,
which is necessary because the data it points to is on stack.

Just copying the data into the MSI descriptor solves this nicely without
having some extra magic.

I guess we're nearing bike shed realm by now :) Let's pick one evil and
see how it works out. Coccinelle is there to help us fixing it up when
it turns out to be the wrong evil. :)

Thanks,

        tglx
