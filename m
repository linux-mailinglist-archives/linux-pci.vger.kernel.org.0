Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C61C62D760
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 10:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiKQJqi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 04:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiKQJqh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 04:46:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488483204D;
        Thu, 17 Nov 2022 01:46:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668678394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gquu1ZTTEBDKIhI2pV8dgt1FSaeBDeaXtLNdg4+XaPk=;
        b=wNcCk0qkTgyuNsVHaiNO8d3XS6+hY6fnnDIcMzVj36njCY6on15RXkl31j0Kk7Bdjjr8Eb
        VEKpv5K8wsJDfHX5iVN/n/2Ncea2ha6qd88Te7u4zYrZwzCR1HmQN3zAc8zuuogdqtB7F2
        rx6ZeLx2cI2hERpe/EQNVKBirR7HIFDyhrUKlblLX8Dg/uN40l9FPmJG8RmCDuAjfZH5o7
        E6zK+bTgfVlEb7QNOF2g6n1rCdi8xWL/sdjgBC0gStORRw6gnSEqesZAUS2r7ys227bzVw
        XuyDy4qTFrMHDDrzaLtdMoMkGbeUQZUSkmkuphcE59dXRhSFJIuakhOOVFd+1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668678394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gquu1ZTTEBDKIhI2pV8dgt1FSaeBDeaXtLNdg4+XaPk=;
        b=btkKxgoo4G39juKRAY25iro1A6DK9xxOm+3epNLxGy3fLzh3vnkeIqjlYNlKy18H53IJeY
        0hUwo4ykI4F0u6Cw==
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
Subject: Re: [patch 27/33] genirq/msi: Provide constants for PCI/IMS support
In-Reply-To: <Y3U/8/0p66cG4tjk@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.800062166@linutronix.de> <Y3U/8/0p66cG4tjk@nvidia.com>
Date:   Thu, 17 Nov 2022 10:46:34 +0100
Message-ID: <87o7t5ncat.ffs@tglx>
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

On Wed, Nov 16 2022 at 15:54, Jason Gunthorpe wrote:
> On Fri, Nov 11, 2022 at 02:58:54PM +0100, Thomas Gleixner wrote:
>> +	/* Support for PCI/IMS */
>> +	MSI_FLAG_PCI_IMS		= (1 << 21),
>
> Maybe for legacy reasons it is too complicated, but it would be so
> much clearer of the special case of "I only know how to support PCI
> MSI and PCI MSI-X" was called out as a special flag, and the more
> general case of "any write_msg is fine by me" was left behind.
>
> I feel like when the device domain is created in the first place the
> parent domain(s) should be able to reject the creation if the
> requested child domain is not one it supports. Eg the hypervisor
> interactions checks if the child domain is PCI MSI or PCI MSI-X and
> rejects otherwise, because that is the only thing the hypervisor knows
> how to work with.
>
> If we did that perhaps we don't even need a flag or further checks?

It's not that simple. The flags are part of the domain creation sanity
checks and due to other constraints in our marvelous zoo of
architectures, iommus, hypervisors and whatever being explicit about
this is really required. Look at the GICv3-ITS voodoo which explicitly
needs to differentiate between PCI and non-PCI MSI. I wish we could
start from a clean slate, but that train has left the station long ago.

Thanks,

        tglx
