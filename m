Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AFC62C5E9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiKPRHc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbiKPRHE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:07:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A5F59871;
        Wed, 16 Nov 2022 09:06:32 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668618391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gMtjvKuzan+EitBOPG6mbHkFHraigrEr8V57kF2xOHg=;
        b=GSlVYVS8cqCCkAtiXSIgcwB7/v7yViOvR7AfIcmAkV1Fwnf9lQi1GBcnX5Y4Ju4s3TqUax
        SI7kdSMfFe52kUeFZogQm5vYXUYsQ711qOhOf6n+5fDc1uCT2j8ibEPRae5U0lLpGIs97Z
        +oTWClBQtsJ9RI/Y/awt0yHaTJkylyAH9nm54r3Ao4AcyOugeX6hASbTTKB68eZNNoG09O
        aOApii33W8z8RhuR+jxUJIV+zaXsWeYkc9ZbH4P9J+xTs3XRmTsdliMVoYaHNewOYjAErU
        Bshc1/9AxWWYhLyd7h5nzJ+ZgqVXWfEPoFB0udtJOlGokuJapopWZ46yQfZLQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668618391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gMtjvKuzan+EitBOPG6mbHkFHraigrEr8V57kF2xOHg=;
        b=llOgpdV3hMHSBIhQev8a/HMzrlttd0KuM/S/oask7Lf5ArUR3Gu3hdMmAW6RHbysShpDRH
        fHUSj6rq+ZuC3FDw==
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
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 22/39] PCI/MSI: Move pci_alloc_irq_vectors() to api.c
In-Reply-To: <20221116162210.GA1115315@bhelgaas>
References: <20221116162210.GA1115315@bhelgaas>
Date:   Wed, 16 Nov 2022 18:06:30 +0100
Message-ID: <87k03uq161.ffs@tglx>
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

On Wed, Nov 16 2022 at 10:22, Bjorn Helgaas wrote:
>> + * Allocate up to @max_vecs interrupt vectors on device. MSI-X irq
>
> s/irq/IRQ/
>
>> + * vector allocation has a higher precedence over plain MSI, which has a
>> + * higher precedence over legacy INTx emulation.
>> + *
>> + * Upon a successful allocation, the caller should use pci_irq_vector()
>> + * to get the Linux IRQ number to be passed to request_threaded_irq().
>> + * The driver must call pci_free_irq_vectors() on cleanup.
>> + *
>> + * Return: number of allocated vectors (which might be smaller than
>> + * @max_vecs), -ENOSPC if less than @min_vecs interrupt vectors are
>
> s/less/fewer/ (also in some previous patches, IIRC)

Will fix.
