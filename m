Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4651462C5E7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKPRHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiKPRGl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:06:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE305EF89;
        Wed, 16 Nov 2022 09:05:57 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668618356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0nLXzHCM/9XWJ+CMFPSpqROvymes9f+yWx6tRnxa+c=;
        b=lb4e92ZPrWNarh8wXVyzL34Lx5FSRAuYKSVO+wWi99kVOgC6pKy9eyOEUz2LeKKVwAnU9J
        POoEMyE8RXbX+nLRVcwlaMMI6hXH9MaaELMsWDxe9HQfkrYC/FukDwtL/cZ3I2aWaK5m3v
        wfeD2W0O3ZVtfhAfkAymQaSFAXEj2FmNhKJl6EjWye4YCJ+nnWKnifI5ZF7x2Na4O8ELWQ
        sgZ8wVyc3DxUotRZPGm2zaeI/Eni3ScKxnrxJMCzKiNIX/gN3p/uN1SNCt9YknAmeHF4os
        KZ4jKed0PqMc6rVZQQAyyToJe8hXLm94RpQc+LjjxLy5L31FLb69dV8z8uttpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668618356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0nLXzHCM/9XWJ+CMFPSpqROvymes9f+yWx6tRnxa+c=;
        b=sYbIvezOT81QU499/hP7iD6CvOFKqoHyM3Yf48D+LHOeB+ppdhzCEz71TqsqPLg1bB8qZy
        0mMPMBKYHddP/QCg==
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
Subject: Re: [patch 20/39] PCI/MSI: Move pci_enable_msi() API to api.c
In-Reply-To: <20221116161839.GA1115061@bhelgaas>
References: <20221116161839.GA1115061@bhelgaas>
Date:   Wed, 16 Nov 2022 18:05:55 +0100
Message-ID: <87mt8qq170.ffs@tglx>
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

On Wed, Nov 16 2022 at 10:18, Bjorn Helgaas wrote:
> On Fri, Nov 11, 2022 at 02:54:46PM +0100, Thomas Gleixner wrote:
>> From: Ahmed S. Darwish <darwi@linutronix.de>
>> 
>> To distangle the maze in msi.c all exported device-driver MSI APIs are now
>> to be grouped in one file, api.c.
>> 
>> Move pci_enable_msi() and make its kernel-doc comprehensive.
>> 
>> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Nit: suggest "disentangle" or "untangle" for "distangle" here and in
> subsequent patches.

My fault. I suggested the word to Ahmed well knowing that this is one of
the words I never get spelled correctly :)
