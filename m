Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8062F451
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 13:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiKRMPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 07:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRMPt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 07:15:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379898433E;
        Fri, 18 Nov 2022 04:15:48 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668773746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KbhC+CeOnQyJado2rlUErrgQRP0kTDr+v7gOg9BPMlA=;
        b=020atVsyMLfolWBiYY38Feh3nJrkY9r32xCdjepoHGTdP+8iC/MiCsVWps1h1Q6dCOPd0V
        3dRyC/HX5/IsS84pv78SBBwI/59zF/onT4/sOywjPEZgNEhczCb1RgmIh2H8DG2u+xzWu9
        jesRPEWmTvzZyMncjclTqMu6tWsTYceEQIol+X9YYXiPZDmdDoGDGznuy6zPKpRnEmy3vB
        VG2c2IJ6jlZG5yCMZu2be7uQxvJRYv+88IWB3EfpoCAuyVojD1x4saB7dOpO9K0zr/+oy+
        bxZSkBlRlsu8cXuZ0fs8gW+PckjldhsEG5fGDNU4+KukgXGGMyx5IaaCcDufdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668773746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KbhC+CeOnQyJado2rlUErrgQRP0kTDr+v7gOg9BPMlA=;
        b=jEIHVfw7ZE92bK+yriuOZSMTdYskff83TpusIBX/kEnzgq8aqxSrUqjyVKwcXlrq7ZZhKc
        HE5daoQTXiaM67DQ==
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
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: RE: [patch 06/20] genirq/msi: Check for invalid MSI parent domain
 usage
In-Reply-To: <BN9PR11MB52761A0C8124248D78076B3F8C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.388892782@linutronix.de>
 <BN9PR11MB52761A0C8124248D78076B3F8C099@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Fri, 18 Nov 2022 13:15:45 +0100
Message-ID: <87tu2wjw5q.ffs@tglx>
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

On Fri, Nov 18 2022 at 07:50, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Sent: Friday, November 11, 2022 9:57 PM
>> 
>> @@ -937,13 +937,21 @@ int msi_domain_alloc_irqs_descs_locked(s
>> 
>>  	lockdep_assert_held(&dev->msi.data->mutex);
>> 
>> +	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain))) {
>> +		ret = -EINVAL;
>> +		goto free;
>> +	}
>> +
>> +	/* Frees allocated descriptors in case of failure. */
>>  	ret = msi_domain_add_simple_msi_descs(info, dev, nvec);
>>  	if (ret)
>>  		return ret;
>
> it's unusual to see a direct return when error unwind is already required
> at an early failure point. is it something which can be improved here?

It's redundant in this case, but you are right it looks weird.
