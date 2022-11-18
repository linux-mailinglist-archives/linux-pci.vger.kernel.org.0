Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9562F47C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 13:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiKRMWi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 07:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiKRMWh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 07:22:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A68597353;
        Fri, 18 Nov 2022 04:22:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668774154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tAhxxVLNA+O7aP4JThklUXrC9ZpujQO8F5mZd76izq0=;
        b=PQ6J4TTN+X10HKzfA1cDtXWwxbM+8cGBJ1Q2MnMwDpahe9ZcvzpW2J5hjF6H3rCYe4utey
        x8sqsJAxIYJybU2H94kj02WlBHIsYdBYUXInKsEz3dyTcPkf+o2B0+8odjb3SUkcWsGE8z
        pvYmDAgIHyEZDZHJPOX6Pg2Fd5/6GEqbECoJHRjwC0KluIJuwogCR1w4iMMYYixGVber1I
        A3x6ByvZFDWCWY+Gk3HcHFP1Y8yJVd96cWpc54RRXHGmAUJk/vTulaZpW2YU69/sFFMAgw
        AW9I5hYslLMCqJ27dchEOFD3TSx7ZvbmrXkOCzbZ5nvogB3jMXARdVp8dsfZSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668774154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tAhxxVLNA+O7aP4JThklUXrC9ZpujQO8F5mZd76izq0=;
        b=0Un2RLS/nv2ztoiRrVAPs1HU4cM6POwWWeJsMM0bGlblKIxkHRn1UdeInIlhJVsJtRiswu
        sFlfMfue+wpkPPDw==
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
Subject: RE: [patch 12/20] genirq/msi: Make descriptor freeing domain aware
In-Reply-To: <BN9PR11MB52762A0081F7A1679850142A8C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.726275059@linutronix.de>
 <BN9PR11MB52762A0081F7A1679850142A8C099@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Fri, 18 Nov 2022 13:22:34 +0100
Message-ID: <87leo8jvud.ffs@tglx>
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

On Fri, Nov 18 2022 at 08:17, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>>  /**
>> - * msi_insert_msi_desc - Allocate and initialize a MSI descriptor in the
>> default domain
>> + * msi_insert_msi_desc - Allocate and initialize a MSI descriptor in the
>> default irqdomain
>> + *
>
> belong to last patch

Yes.

>> +/**
>> + * struct msi_ctrl - MSI internal management control structure
>> + * @domid:	ID of the domain on which management operations should
>> be done
>> + * @first:	First (hardware) slot index to operate on
>> + * @last:	Last (hardware) slot index to operate on
>> + */
>> +struct msi_ctrl {
>> +	unsigned int			domid;
>> +	unsigned int			first;
>> +	unsigned int			last;
>> +};
>> +
>
> this really contains the range information. what about msi_range and
> then msi_range_valid()?

It's range plus domain id and later it gains nirqs. So its awkward in
any case.

>> +static void msi_domain_free_descs(struct device *dev, struct msi_ctrl *ctrl)
>>  {
>>  	struct xarray *xa = &dev->msi.data->__store;
>>  	struct msi_desc *desc;
>>  	unsigned long idx;
>> +	int base;
>> +
>> +	lockdep_assert_held(&dev->msi.data->mutex);
>> 
>> -	if (WARN_ON_ONCE(first_index >= MSI_MAX_INDEX || last_index >=
>> MSI_MAX_INDEX))
>> +	if (!msi_ctrl_valid(dev, ctrl))
>>  		return;
>> 
>> -	lockdep_assert_held(&dev->msi.data->mutex);
>> +	base = msi_get_domain_base_index(dev, ctrl->domid);
>> +	if (base < 0)
>> +		return;
>
> What about putting domid checks in msi_ctrl_valid() then here could
> be a simple calculation on domid * MSI_XA_DOMAIN_SIZE.
>
> domid is part of msi_ctrl. then it sound reasonable to validate it
> together with first/last.

Let me look at that.
