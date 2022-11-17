Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA762DEEC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 16:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiKQPBE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 10:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiKQPBE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 10:01:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB3CE0;
        Thu, 17 Nov 2022 07:01:01 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RP+U+feZlcZmrP3/IlXzJjEfrliAdXsJ/Be3VTH8hM4=;
        b=yIMYsx8Ax/ruYoEaGB1680I3hBo33RXitUEA7+OswjFiHPWiao11xXYIPjCJvTM2HCKaI2
        RY7j8mOW2ncx+3XttulWIEsrwrOODQ+4ZsrTQ7ufRC5IwPXGED+cydt8Wi2iNcTejnW4BH
        GgGs/41wgb0SUGvNk1ONVVc/6kNv3J+M5NACfPeN5D0bLosXCcEsNYnxKhbFXYu51i3MbX
        qaNNPRCMV2c0+ex4tdvDIoqEOm9H/tQsBWcrDGUC7qT1PNY7IBJXiAQ8kQIyhguimgV2rR
        OgoiPXH4zFIqhCiB46/y6o8YQwdobX4ctsnN3sbopkL08t5BQv4ydmABvcHAdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RP+U+feZlcZmrP3/IlXzJjEfrliAdXsJ/Be3VTH8hM4=;
        b=zD3n5LruqflYwcA/byHi6Sl3zDk32yjCX+vWdV3TVGvkIuIL5PtPucTyH45LuHX4K2xR9n
        HW/N/3UKH0gtg3DA==
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
Subject: Re: [patch 39/39] x86/apic: Remove X86_IRQ_ALLOC_CONTIGUOUS_VECTORS
In-Reply-To: <Y3Umh+Pa1WSJ33fD@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122015.865042356@linutronix.de> <Y3Umh+Pa1WSJ33fD@nvidia.com>
Date:   Thu, 17 Nov 2022 16:00:58 +0100
Message-ID: <87a64pmxqt.ffs@tglx>
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

Jason, Bjorn, Ashok!

On Wed, Nov 16 2022 at 14:05, Jason Gunthorpe wrote:
> On Fri, Nov 11, 2022 at 02:55:17PM +0100, Thomas Gleixner wrote:
>> Now that the PCI/MSI core code does early checking for multi-MSI support
>> X86_IRQ_ALLOC_CONTIGUOUS_VECTORS is not required anymore.
>
>> Remove the flag and rely on MSI_FLAG_MULTI_PCI_MSI.
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks for taking the time to go through this pile!

       tglx
