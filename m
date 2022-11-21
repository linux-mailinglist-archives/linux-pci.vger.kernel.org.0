Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2463631E7A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 11:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiKUKeb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 05:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKUKe3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 05:34:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05965987D;
        Mon, 21 Nov 2022 02:34:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669026867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wgqTjLWFMbYTKP3B3JAejdIePhrfjaPRTiSq0SNLFX4=;
        b=hzthuOHJZx7zcqf03P9EJMWfil39KpG55Fw2j07jOar5/f7qi5E2pv04xbch6uM0n+861T
        qxbXzlbcQd3J89VNUgm91NVA/kyYLnBrIGfLWVOX49ozmnIKc3Hy0lAAKxLDXzxmjGHcoE
        wuaVZcmM4gwloGcy9ugD5a3wy+KU2E8R1+0ozoi2vzTtv1gppzurFoSvfgeHM/K+rPwX0R
        dGWrMJf20m9K3bZ7t/SbS7zIDB/BAbclhEpxPuIOaxVcZ+8Q79sYZBJwxsljTP8jAgxtGY
        gqjWcUbNmoYjakGjSprwaNPseKQ43kaUgdvclGznQDtcuijNd0GLgUOeYWI5Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669026867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wgqTjLWFMbYTKP3B3JAejdIePhrfjaPRTiSq0SNLFX4=;
        b=lJv+UaovQnxg6vQ2zurZGWlXxKCY6W644sGEmVhWi5kROwaCsIcs+mTUwgka612A7lOIz2
        xX+/c1fkQ8T0k/Bg==
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: RE: [patch 17/20] platform-msi: Switch to the domain id aware MSI
 interfaces
In-Reply-To: <BN9PR11MB5276EB567D822DA9148BEB3A8C0A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132707.005001510@linutronix.de>
 <BN9PR11MB5276453E63A0C02A4BB386F58C099@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87fsegjvn3.ffs@tglx>
 <BN9PR11MB5276EB567D822DA9148BEB3A8C0A9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Mon, 21 Nov 2022 11:34:26 +0100
Message-ID: <87sficiojx.ffs@tglx>
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

On Mon, Nov 21 2022 at 03:42, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> On Fri, Nov 18 2022 at 08:53, Kevin Tian wrote:
>> > Out of curiosity. Why don't we provide an unlocked version of
>> > msi_domain_alloc_irqs_all()?
>> 
>> -ENOUSER
>
> msi_domain_alloc_irqs() and msi_domain_alloc_irqs_descs_locked()
> are a pair.

Sure, but if there is no use case why should we provide the interface?

> What I didn't get was why the unlocked invocation in this patch
> is replaced by a range-based helper while the locked invocation
> in previous patch16 was replaced by an all-based helper:
>
> 	if (domain && irq_domain_is_hierarchy(domain))
> -		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, nvec);
> +		return msi_domain_alloc_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN, nvec);
>
> The reason could probably be marked out in the commit msg.

The point is that range based is obviously the better choice because
it's precise. Especially for domains which let the core code allocate
the MSI descriptors a precise range is required. The old interface was
kinda blury there.

In case of PCI/MSI[-X] the MSI descriptors are allocated by the PCI core
upfront and there are allocations which have gaps in the indices, so the
range is not well defined and we just keep using the existing scan all
mechanism.

Thanks,

        tglx


