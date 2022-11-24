Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9E637559
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 10:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKXJh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 04:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKXJhz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 04:37:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C561A1F62F;
        Thu, 24 Nov 2022 01:37:54 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669282673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tjizbh8hWoBsQRunZtQQh9g5OJSznOxQIsaJyKhrvY4=;
        b=C9MBI36lXTOK5rNSl4tj3DGptwslIqTgmLItfx0CKyB3ne+Dd0tmdMIfiz209fcA9vixlx
        2teLzuNjJ8ljmoIvc7Xy1N2SYBSUgRWzvAlTjDHemyxp0BsUJarg1y+wCqCVqn+JcQu/Ti
        qnaDwwdOar5iGkhrs8YwASq6UweHRtprwNGW5v5TkHd8ghGTJIpIYU+1bAYh5ALMRY7k7v
        s8CJ0i2EMsuZ7cn8F3OuXqa9AxR4WdK5iG8gYhcWjvoAeOZlXdlJNPfNvW7ZTVirlCKiAS
        OUt2Bz+zaiepmEr8bANxSA3/kA9+qm9vFhqRVw9qwLzimcENlYADSD85oa7JOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669282673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tjizbh8hWoBsQRunZtQQh9g5OJSznOxQIsaJyKhrvY4=;
        b=302zCTmDM6qHG2AccjtKzwe2xp7tI80vPQ9FLQhiYOUW7KQ0JmmNLbD94Oq9fCUBCFgotm
        jDHDMlJDWpl50xBw==
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
Subject: RE: [patch V2 31/33] iommu/vt-d: Enable PCI/IMS
In-Reply-To: <BN9PR11MB527650A018BE7BF422BDA2F58C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091328.184455059@linutronix.de>
 <BN9PR11MB527650A018BE7BF422BDA2F58C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Thu, 24 Nov 2022 10:37:53 +0100
Message-ID: <87ilj4d766.ffs@tglx>
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

On Thu, Nov 24 2022 at 03:17, Kevin Tian wrote:
>>  static const struct msi_parent_ops dmar_msi_parent_ops = {
>> -	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
>> MSI_FLAG_MULTI_PCI_MSI,
>> +	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
>> +				  MSI_FLAG_MULTI_PCI_MSI |
>> +				  MSI_FLAG_PCI_IMS,
>>  	.prefix			= "IR-",
>>  	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
>>  };
>
> vIR is already available on vIOMMU today [1].
>
> Fortunately both intel/amd IOMMU has a way to detect whether it's a vIOMMU.
>
> For intel it's cap_caching_mode().
>
> For AMD it's amd_iommu_np_cache.
>
> Then MSI_FLAG_PCI_IMS should be set only on physical IOMMU.

Ok. Let me fix that then.

But that made me read back some more.

Jason said, that the envisioned Mellanox use case does not depend on the
IOMMU because the card itself has one which takes care of the
protections.

How are we going to resolve that dilemma?

Thanks,

        tglx
