Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6B262F591
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 14:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiKRNKK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 08:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiKRNKJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 08:10:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D8879924;
        Fri, 18 Nov 2022 05:10:09 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668777007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2sQ2nYbs7q2LvKQWN/vpHz4cGjWuxM1X+erIeeKMnvQ=;
        b=0A9i3Mx6WEiyEzdF3cAhpSmISzWa8rM84qwpb8WqghriBd6bSawXQNCKorr6O2dmcH3vmJ
        E82SXmpkCxubxIzrWufJSiOPjAfUZfQrrnPs0CIKLuzat/kiIuy21SCFLyF6/nILsWCyNn
        8kcVYZNWJJ5lt6ZyguktISsreXDUEJuFzuQG9HIymPlyEO0qHvwOg1PXLa6yPUB2I7zdRC
        pQofjwVSDzcCvJpZt86lEHHg7aAglOrCnIkgKt9k4XSWAE0JPjQcBCGL6WnBLe4iXaLz7v
        1XyArzV7ahMPxWw02L0zF4VOFdNSL6I4ctMRMkbvvIcEtdeGb2C5lo/mfMMHZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668777007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2sQ2nYbs7q2LvKQWN/vpHz4cGjWuxM1X+erIeeKMnvQ=;
        b=C61NH3MOizEq+w7szJQVDojaOaBwVfIl8ZtLn6rOn+wgWfAgg9gGQlSMAA1iVV6CtzLX5u
        P5c982TClUf7/HBQ==
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
In-Reply-To: <87leo8jvud.ffs@tglx>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.726275059@linutronix.de>
 <BN9PR11MB52762A0081F7A1679850142A8C099@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87leo8jvud.ffs@tglx>
Date:   Fri, 18 Nov 2022 14:10:07 +0100
Message-ID: <87cz9kjtn4.ffs@tglx>
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

On Fri, Nov 18 2022 at 13:22, Thomas Gleixner wrote:
> On Fri, Nov 18 2022 at 08:17, Kevin Tian wrote:
>>> -	lockdep_assert_held(&dev->msi.data->mutex);
>>> +	base = msi_get_domain_base_index(dev, ctrl->domid);
>>> +	if (base < 0)
>>> +		return;
>>
>> What about putting domid checks in msi_ctrl_valid() then here could
>> be a simple calculation on domid * MSI_XA_DOMAIN_SIZE.

I need the base domain index w/o the ctrl thing too.

>> domid is part of msi_ctrl. then it sound reasonable to validate it
>> together with first/last.
>
> Let me look at that.

So I kept it as is, but renamed msi_ctrl_valid() to
msi_ctrl_range_valid().

Thanks,

        tglx
