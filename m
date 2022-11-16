Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7B62C5F5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKPRJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiKPRJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:09:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A7EE10;
        Wed, 16 Nov 2022 09:09:48 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668618587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ikR02Krd2bWM7QtM03WkmIJ/tmd489mqo9OvnzkaC1Q=;
        b=r2dW5nSk/HYqTZyJyGMkOXClLUNOqcudAEPRXrxpFnk03pwPIVcCdDLlCkMSGXKWDV9fvj
        lypp8Awo66GzeAYe7ZRfdSL/G6D+Dhw981l7+zCad0KRsAKQTseh9A/gbJGRIldpYeWyMP
        xfMqgQzvESJ3zHARmKSkKHyllPHVVEzm6SsjIq68SXLibaoRSQsYY49wpjksmnahJT6fdP
        LcBPoBz1lwgJzXAYJlH0fK9/2fOeaUh37NeDH8SKKxayV0OG424QzFld2volH96KRIySGs
        +Ijs3J2xq76VquEuOuJfG6OFxh6m09wLhGTQ64uNq+mL6O8/I4cejDuFBIu/yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668618587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ikR02Krd2bWM7QtM03WkmIJ/tmd489mqo9OvnzkaC1Q=;
        b=Nzyh2lhLKe+ltyMNeDMuG9x97MhJd7Gn+M/8PLuEUjBxdTR4OlfnkSXmU8dl8u8Oj4LA6x
        d9VOzVCVE9sbLyCQ==
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
Subject: Re: [patch 27/39] PCI/MSI: Move pci_disable_msix() to api.c
In-Reply-To: <20221116162617.GA1115753@bhelgaas>
References: <20221116162617.GA1115753@bhelgaas>
Date:   Wed, 16 Nov 2022 18:09:46 +0100
Message-ID: <87edu2q10l.ffs@tglx>
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

On Wed, Nov 16 2022 at 10:26, Bjorn Helgaas wrote:
>>  /**
>> + * pci_disable_msix() - Disable MSI-X interrupt mode on device
>> + * @dev: the PCI device to operate on
>> + *
>> + * Legacy device driver API to disable MSI-X interrupt mode on device,
>> + * free earlier-allocated interrupt vectors, and restore INTx emulation.
>
> Isn't INTx *emulation* a PCIe implementation detail?  Doesn't seem
> relevant to callers that it's emulated.

Don't know how the emulation ended up there. It restores INTx which is
obvioulsy not a wire on PCIe... But yes, it's uninteresting.


