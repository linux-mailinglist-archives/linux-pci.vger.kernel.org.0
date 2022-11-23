Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298EB635BED
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 12:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiKWLlO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 06:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbiKWLlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 06:41:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A30109583;
        Wed, 23 Nov 2022 03:41:07 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669203666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=373bQ1nq+nl0rYtdJTO5Jt2zlt/TLiciMjBg/gptv3M=;
        b=KpEqNtPqfiJppK8AvzqtheMaPcoZmN8t/rFv6jjr6hTYoy40ftLFhpimHJ5jw8l6Va6aMw
        Hj8rFIEBDV55rsgKjpjmn7AIQVUNwC2gbZf1xfpahuw3LOSLh/LJheui3OO1y+1cm92f6x
        HQIXyX+ew/MZPbmSyWMukFU5yTJnHGzvmeRo4Z3KIKZfQvoGpIuFiGmWGU1jHalUcMt94Q
        UjDY8OCA77xKJVyyWjMTJG76mp6GpoVYrvAE002YCUD9t6HNkhsIHaymA3SxGTYalj768Y
        JPVHnOXR9BT/siy0wfNlaD21yUTYXDrgoxQ6VRkYoAyn0ji4clI4WvLn5hj9Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669203666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=373bQ1nq+nl0rYtdJTO5Jt2zlt/TLiciMjBg/gptv3M=;
        b=cQlKvLqRtjVxKMFF8O3YttItxpSP0whK6NO6CdL/nA66+knkQDkTy9kfdNkswueZtwmlSX
        vU8ev3zdRcFC1GBQ==
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
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: RE: [patch V2 12/33] PCI/MSI: Add support for per device MSI[X]
 domains
In-Reply-To: <BN9PR11MB5276E9AD0F86A27A23ED8CFB8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.163146917@linutronix.de>
 <BN9PR11MB5276E9AD0F86A27A23ED8CFB8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Wed, 23 Nov 2022 12:41:05 +0100
Message-ID: <87zgchew4u.ffs@tglx>
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

On Wed, Nov 23 2022 at 08:08, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>
> pci_mask_msi() and pci_msi_mask() are confusing.
>
> Probably pci_irq_mask_msi() given the parameter is irq_data.

maybe.

>> +bool pci_setup_msi_device_domain(struct pci_dev *pdev)
>> +{
>> +	if (WARN_ON_ONCE(pdev->msix_enabled))
>> +		return false;
>
> the check already exists in __pci_enable_msi_range()
>
>> +bool pci_setup_msix_device_domain(struct pci_dev *pdev, unsigned int
>> hwsize)
>> +{
>> +	if (WARN_ON_ONCE(pdev->msix_enabled))
>> +		return false;
>
> ditto.
>
> btw according to the comment this should check pdev->msi_enabled.

Yeah, those are probably redundant.

>
>> @@ -152,13 +316,33 @@ bool pci_msi_domain_supports(struct pci_
>>  {
>>  	struct msi_domain_info *info;
>>  	struct irq_domain *domain;
>> +	unsigned int supported;
>> 
>>  	domain = dev_get_msi_domain(&pdev->dev);
>> 
>>  	if (!domain || !irq_domain_is_hierarchy(domain))
>>  		return mode == ALLOW_LEGACY;
>> -	info = domain->host_data;
>> -	return (info->flags & feature_mask) == feature_mask;
>> +
>> +	if (!irq_domain_is_msi_parent(domain)) {
>> +		/*
>> +		 * For "global" PCI/MSI interrupt domains the associated
>> +		 * msi_domain_info::flags is the authoritive source of
>> +		 * information.
>> +		 */
>> +		info = domain->host_data;
>> +		supported = info->flags;
>> +	} else {
>> +		/*
>> +		 * For MSI parent domains the supported feature set
>> +		 * is avaliable in the parent ops. This makes checks
>> +		 * possible before actually instantiating the
>> +		 * per device domain because the parent is never
>> +		 * expanding the PCI/MSI functionality.
>> +		 */
>> +		supported = domain->msi_parent_ops->supported_flags;
>
> This is general PCI MSI logic. So an open related to my rely to patch02,
> is it correct for PCI core to assume that the real parent imposes all the
> restrictions and there is no need to further go down the hierarchy?

That was my working assumption and it turned out to be correct with both
x86 and ARM.

Thanks,

        tglx
