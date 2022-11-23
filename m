Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A9863691C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 19:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbiKWSiW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 13:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbiKWSiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 13:38:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368CB78D53;
        Wed, 23 Nov 2022 10:38:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669228696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=daT1YJxfMwuy6pb432L/pI8XGNEU5xaHY3x+cLaW8NI=;
        b=gQsSVhfSE9nDAm2PYwI4hMKLJzzew1dCZLsjwZKVkRkq+6XKRBd0/7VfkOK/fIMhmrmvlT
        WJPV/cJNZEqFvS3HlIhEloPf+T4EGgrRtoosuj2RqFSWxSV+q4HdD9ddoItWOE2xJyzZPG
        8Vai4V8pTo1upilUqtLTi3XyCtKCJmz4e7zHEH6CTU1fPJW6o4RDBzmfSa+b6N+gt/8H+/
        yyCuv7RV5qXMmKY4iEfaMv1jg47d/Wr0g4i86riUbawgkfAX7+QF5KSc1rONBqCuhkndMm
        NRwKcAVQfs3AA7xwwuVKDVQY55jM30wazZMYmXTnvJrT91k9YEKnXvI3QdXeiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669228696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=daT1YJxfMwuy6pb432L/pI8XGNEU5xaHY3x+cLaW8NI=;
        b=+/T8WOJGxO35BaVxcUGqP6aguns2dJnU2W2XTVPzjFzu1mwy6oNi8YoOwqAwP8FACTfOX+
        c11Fjw1gZcEIHaBQ==
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
In-Reply-To: <Y35RLzzvXYRisIBX@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.346985384@linutronix.de> <Y3U5xwujkZvI0TEN@nvidia.com>
 <871qpzkj9k.ffs@tglx> <Y3uzVJ/7ecL8DBK7@nvidia.com> <87bkp0hzai.ffs@tglx>
 <Y3wreJlD/7TsMCme@nvidia.com> <87k03mg1fc.ffs@tglx>
 <Y35RLzzvXYRisIBX@nvidia.com>
Date:   Wed, 23 Nov 2022 19:38:15 +0100
Message-ID: <878rk1ectk.ffs@tglx>
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

On Wed, Nov 23 2022 at 12:58, Jason Gunthorpe wrote:
> On Tue, Nov 22, 2022 at 09:49:11PM +0100, Thomas Gleixner wrote:
>> I guess we're nearing bike shed realm by now :) Let's pick one evil and
>> see how it works out. Coccinelle is there to help us fixing it up when
>> it turns out to be the wrong evil. :)
>
> Sure, it is all changeable
>
> I find your perspective on driver authors as the enemy quite
> interesting :)

I'm not seeing them as enemies. Just my expectations are rather low by
now :)

Thanks,

        tglx
