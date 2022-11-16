Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9015C62CE04
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 23:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKPWsz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 17:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiKPWsw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 17:48:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FAC167FA;
        Wed, 16 Nov 2022 14:48:49 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668638928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zTCdp2XTy4WV/TRq6AmcOpzAbhC2i0YQDZLmTTQbvWU=;
        b=pybGnpXR91ye2Jz7fzqWIvvHXHKcBQHy3yhPT4PUnEkoxw0z7Tk9qJdwg6tzaxzuembbZo
        hX8GoArXP6acbEoNPH8yk8yM/QPNxP+YNj4LKRgECkOUSykq+w1cn94gtUFd7w2OGVWIvl
        Arqsfl7G2AaMCZEAqkTF/tix9/S++grna9r8j761roXixlwnVBAikHqYPoGE6bL5i7RxNH
        9pRegwEKn0TA8irJ1+uYDMj2cQ/URQv5ejEzQWBJfQS9Qeta/4tOuCAzsORF8wAAmEA6AK
        JAQXVNVBJYV4vy1m69cuH9qLhLZ6FYnyCynYYYQ54nBwLaYOSyaUPHye7GJn2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668638928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zTCdp2XTy4WV/TRq6AmcOpzAbhC2i0YQDZLmTTQbvWU=;
        b=vXZ17LC/04L0m8gSNNgs6Jaj2t/5aaKWXwozWalYoUWSqn6f9jUPV7Dcjytgns0E8iKu73
        liCze9LCZtU8xTDQ==
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 08/39] genirq/msi: Provide msi_domain_ops::post_free()
In-Reply-To: <Y3Uhk4YZ9MN4x5Jx@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122014.063153448@linutronix.de> <Y3Uhk4YZ9MN4x5Jx@nvidia.com>
Date:   Wed, 16 Nov 2022 23:48:47 +0100
Message-ID: <87leoao6r4.ffs@tglx>
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

On Wed, Nov 16 2022 at 13:44, Jason Gunthorpe wrote:
> On Fri, Nov 11, 2022 at 02:54:27PM +0100, Thomas Gleixner wrote:
>> To prepare for removing the exposure of __msi_domain_free_irqs() provide a
>> post_free() callback in the MSI domain ops which can be used to solve
>> the problem of the only user of __msi_domain_free_irqs() in arch/powerpc.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  include/linux/msi.h |    4 ++++
>>  kernel/irq/msi.c    |    2 ++
>>  2 files changed, 6 insertions(+)
>
> Make sense, but I do wonder why PPC needs this ordering..

Some hypervisor thing.
