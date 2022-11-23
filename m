Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65D635BB9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 12:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiKWLaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 06:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbiKWL3b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 06:29:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03EAF1DA6;
        Wed, 23 Nov 2022 03:29:01 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669202940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L7fuM0rr64qY+X/Z1scEYp+Nkr3OluGehBmXbPVIKos=;
        b=KdIoArcuq7T4jBPsKvAEhVYH+QaHYh5TM8g5fqZgwxpOmh0t4H9vabSKB/ChLyQ/FGrtly
        vuPzj5rQTxzyWUEO3ZDJLZC8MfzpYs1qnXsvbQgK62ScVbrzz00drbUal5OwF2TCIsglkK
        gs6sDjoPAMsXyS1ma50zcb4NtmTd6lZLtbuuaK3CEkJZ6CJb7pI94m25b/a0YqR6Rasn4W
        Kib5C9bhjyczhgooraZtmKZ1QoOCbaGSM5xtBkpg5NnIm/SDe2kYvmVWYWMCh+O5fV2GDN
        qyktXX5k/fXlT2lu5J0d635SxmEanGNTkFLIyEN1YsggBZZMlwIfpRqROfSAIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669202940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L7fuM0rr64qY+X/Z1scEYp+Nkr3OluGehBmXbPVIKos=;
        b=ivHAioTsT3h2ONpuHwI5UY8yzQ8oaxLtWMkZhfGDTA6u2SsfAgHi6zczbzQaYPIfGalgTU
        2TrQoLus0kp4jhCw==
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
Subject: RE: [patch V2 02/33] genirq/msi: Provide struct msi_parent_ops
In-Reply-To: <BN9PR11MB52768F0E5B9A4D8E2CF9C5578C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091326.604272160@linutronix.de>
 <BN9PR11MB52768F0E5B9A4D8E2CF9C5578C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Wed, 23 Nov 2022 12:28:59 +0100
Message-ID: <878rk1gb9g.ffs@tglx>
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

On Wed, Nov 23 2022 at 07:57, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> + * One solution is to let the root domain handle the initialization that's
>> + * why there is the @domain and the @msi_parent_domain pointer.
>  
> This is the part which I don't quite understand (sorry with limited knowledge
> in this area).
>
> In concept a hierarchical model has restrictions added up when moving
> down to lower layers i.e. presumably the root domain decides the minimal
> supported capabilities. In this case there is no need of a real parent pointer
> as long as every domain in the stack incrementally adds its restrictions to
> info->flags.
>
> I can see why this is required for x86 given that MULTI_MSI is supported
> only with IR. and we cannot make vector domain inclusively claiming
> MULTI_MSI since it's completely broken when the vector domain becomes
> the parent itself, in absence of IR.
>
> Just be curious whether this intermediate-parent-deciding-restrictions
> is generic instead of x86 specific, e.g. is it possible to have a 4-layers
> hierarchy where the root parent wants to check both two intermediate
> parents?

Sure. Nothing prevents you from doing so:

dom4:
    .init... = dom4_init

dom4_init()
    do_stuff()
    invoke parent init

dom3:
    .init... = parent_init

dom2:
    .init... = dom2_init

dom2_init()
    do_stuff()
    invoke parent init

....

See?

Thanks,

        tglx

