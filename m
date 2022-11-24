Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388C9637413
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 09:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiKXIgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 03:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiKXIgS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 03:36:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDAFEC084;
        Thu, 24 Nov 2022 00:36:17 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669278976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TORikMNpewqjUSTSg8RHjgWS+OHYnHpL2PiWb9zaLNw=;
        b=QJZP8YxtpyCumHuuAH40WhwEe4M+TuoKfhJU8CC+MtQ8PtWpLGnw8paE1F7LepoXBovQaH
        95sYVITaB9bGF63n9pQCbtUgmbIKiiEBlN4cBa4cDTesGj453DxJnHEdZT8Lk/fVODXAYc
        T2nGvYuV2vFe7YcirCwFE9Zf0IJWESejj+qNuM2BknW9w97dCXfQHYRuhjeK7kTgiAmF2e
        HAIbU1l9hrER2TQVavNJt2VBbDQGtxUn4dI8U8rZzZeUV8RkPZNlZoiPUATcepZcmEMj3K
        ml8vfkCqWasg2uLwlbdp8kJ6lCxf2Tlz7aHXnFIWL18PnJiX4y3Jpp1wW5Aq1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669278976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TORikMNpewqjUSTSg8RHjgWS+OHYnHpL2PiWb9zaLNw=;
        b=5p4PBhK3Q5TwSJczVi1PHywg3VLU3Se4ga9MoTivLrMQWgm8OpgAQ4BK/DGYexWkrA7Wiv
        o+sYJ5ci4Bl9fdCA==
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
        Allen Hubbe <allenbh@gmail.com>
Subject: RE: [patch V2 07/33] genirq/msi: Provide
 msi_create/free_device_irq_domain()
In-Reply-To: <BN9PR11MB5276EE7F109A251141E936308C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091326.879869866@linutronix.de>
 <BN9PR11MB527604DE2A881FF615B7D0748C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8735a9gau7.ffs@tglx>
 <BN9PR11MB5276EE7F109A251141E936308C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Thu, 24 Nov 2022 09:36:15 +0100
Message-ID: <87tu2oda0w.ffs@tglx>
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

On Thu, Nov 24 2022 at 01:07, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
> I looked at it from the outmost invocation:
>
> @@ -436,6 +436,9 @@ int __pci_enable_msi_range(struct pci_de
>  	if (rc)
>  		return rc;
>  
> +	if (!pci_setup_msi_device_domain(dev))
> +		return -ENODEV;
> +
>
> the current style kind of converts meaningful -EINVAL/-ENOMEM/etc.
> into -ENODEV.

But go to the call sites of the various places in drivers which set up
MSI or MSI-X and check whether anything evaluates those error codes in a
meaningful way.

Some of them print the error code, but that does not help much because
the error code does not allow you to pin point the place which returns
that. If you just analyze the pci_alloc_irq_vectors_affinity() call then
you find at least 10 places, which can return -ENOMEM. So how is that
meaningful and helpful?

All it tells you is that some memory allocation failed. In that case the
failure of the PCI/MSI[-X] setup is the least of the problems.

Where error codes are mandatory are user space interfaces, but in the
kernel a simple fail/success like we have with many interfaces which
just return a NULL pointer on fail is sufficient.

Just because the kernel historically propagated error codes all over the
place does not make them useful or meaningful.

Thanks,

        tglx


