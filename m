Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6766C62C5DF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbiKPRF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiKPREy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:04:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B83659FF8;
        Wed, 16 Nov 2022 09:04:22 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668618260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Haup1+EG6/nyZ+dTGHkeO4GoC5W1dC85saJanHjmmb0=;
        b=EohNRDhsZX3YNcyJ4gnN9eEHeeGTGmgS0vaYkSBnpxiqZ4hgpefZJ+mLrZ1AgOloCkEc6K
        6WRNM6BV/MuXhXd9h7W+DB+dfWlXp3tYG3YhqA9XR00/0PXP0381a47uiZbZSao7TpsRUH
        QsUWRy//tMsojpVM/c9tjDo4tUrkKe8h+49ZGDXNd0mtNWROjByJAuZWS1ES66sDt9ah+3
        wdIl5ekfKcRhEljA1oOGPwll/R8fP+CdpI0R/kAuz0hC5I04X41OcpsTM6ItAhc4revBop
        RMDzDqPrCFWvHWyov7+9obntnAbLqGN1GlxjgTe+HYbISWOaaV2YPE73vyCNyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668618260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Haup1+EG6/nyZ+dTGHkeO4GoC5W1dC85saJanHjmmb0=;
        b=Ckye8rDIgS7J7NV3L3Clr4HG9VuIyyDOMR7gghBvjxvNkIhp0jWte1cUOhVJw7Wf2hYg2L
        CzpJcC4xDl1OgoAg==
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 15/39] PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN
In-Reply-To: <20221116161230.GA1113864@bhelgaas>
References: <20221116161230.GA1113864@bhelgaas>
Date:   Wed, 16 Nov 2022 18:04:20 +0100
Message-ID: <87r0y2q19n.ffs@tglx>
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

On Wed, Nov 16 2022 at 10:12, Bjorn Helgaas wrote:
> On Fri, Nov 11, 2022 at 02:54:38PM +0100, Thomas Gleixner wrote:
>> What a zoo:
>> 
>>      PCI_MSI
>> 	select GENERIC_MSI_IRQ
>> 
>>      PCI_MSI_IRQ_DOMAIN
>>      	def_bool y
>> 	depends on PCI_MSI
>> 	select GENERIC_MSI_IRQ_DOMAIN
>> 
>> Ergo PCI_MSI enables PCI_MSI_IRQ_DOMAIN which in turn selects
>> GENERIC_MSI_IRQ_DOMAIN. So all the dependencies on PCI_MSI_IRQ_DOMAIN are
>> just an indirection to PCI_MSI.
>> 
>> Match the reality and just admit that PCI_MSI requires
>> GENERIC_MSI_IRQ_DOMAIN.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Just FYI, this will conflict with my work-in-progress to add more
> COMPILE_TEST coverage:
>   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=72b5e7c401a1
>
> No *actual* conflicts, just textually next door, so should be sipmle
> to resolve.  Worst case I can postpone my patch until the next cycle.

Linus should be able to resolve that conflict :)
