Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD663FE07
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 03:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiLBCOy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Dec 2022 21:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiLBCOx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Dec 2022 21:14:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E85D4ADE;
        Thu,  1 Dec 2022 18:14:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669947291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lD7pKkXLgkiyYrKKHa9vPUBiC5sLicsrvBKqdXugtHo=;
        b=0KSzOIDODfYAV+94Atbtbm0MIpgzqpP1gKVU6rafFgqLTOqa8NbBZFej1Ms4tdV4UtzXWg
        GAUdFxqG/cZuMceZlsaBID7uzmY16z206/Or16abFB059+8EzfogXnh91+Wvuh3fCY3M4d
        l6ZB3MGLDFdkyYEwwtQfV+gBwu0wsClzhC24YTB/0SG4rHEy4Lj59p5mRqkAcQsOjQJu4I
        0+9iLqhhug5UobDwKbVmzgM5m7ej1BuiNa7aSPTXuqljLWEBM4O+G+jM33E9dVkUrI9aIz
        QR8EMkwxLWZ7KngYfTyXcm6htF58FzsU3gKirP5jMjGwxxmGwJ1oiIkB1ATkqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669947291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lD7pKkXLgkiyYrKKHa9vPUBiC5sLicsrvBKqdXugtHo=;
        b=U+UYMkJOSz7TsGHqYX0sauaJZVJPXsLEuja/Jb64nwCFScD3s4UAW1jzYvLG9OJDdsUmwL
        fbAgmYT6NAPPvUDQ==
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
In-Reply-To: <Y4lIXPVUSYc48A7q@nvidia.com>
References: <878rk1ectk.ffs@tglx> <87cz93s464.ffs@tglx>
 <Y4lIXPVUSYc48A7q@nvidia.com>
Date:   Fri, 02 Dec 2022 03:14:50 +0100
Message-ID: <87edtir1ph.ffs@tglx>
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

Jason!

On Thu, Dec 01 2022 at 20:35, Jason Gunthorpe wrote:
> On Thu, Dec 01, 2022 at 01:24:03PM +0100, Thomas Gleixner wrote:
>> On Wed, Nov 23 2022 at 19:38, Thomas Gleixner wrote:
>> > On Wed, Nov 23 2022 at 12:58, Jason Gunthorpe wrote:
>> >> I find your perspective on driver authors as the enemy quite
>> >> interesting :)
>> >
>> > I'm not seeing them as enemies. Just my expectations are rather low by
>> > now :)
>> 
>> This made me think about it for a while. Let me follow up on that.
>
> I didn't intend to pick such a harsh word, I get your point.

I didn't take that as offence at all.

It's a good thing to be enforced from time to time to reflect on what
I'm doing and why I'm doing it to make sure that I'm not completely off
track.

Thanks,

        Thomas
