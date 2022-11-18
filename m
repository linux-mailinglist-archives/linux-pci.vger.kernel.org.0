Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5509D62F45B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 13:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiKRMRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 07:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbiKRMRG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 07:17:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB8E8433E;
        Fri, 18 Nov 2022 04:17:05 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668773824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tcQlI7YIv/JuyTTUko1uzNyPmENjCW3KTVrHBOgi0ng=;
        b=c4RZrm0+pEi8NCV00XRkCL6XtsZ4Le4ZyX2KZBs9DaEvXmRGi2ej5jdDbhZeKdEFcY/Sbl
        mlZQAZwhNQm/gyv/u/uSYsCc5GqEpHnYWWnvTNYYOaRjgwxOuVoSz/8rPHlLP49pjBmTJq
        3Ug3+qffL1EK4klpk/xkdfeBFto+0glHBR/uW+gYXEWHo2n5fyC/wdFNJ9l983i/3mRdD0
        5/A12LFa8HpMe5gIlA1ZpaIBw0cNZ17X2LAqvnic1LqvDCAGbS3RgMIV+CQbGr8Fvqi6jY
        8D63hepJpYOoOsSYGJfSQJ5M7bVDU1ttxVhcRP5Udkdy+eKFP6pm77r4FIX18w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668773824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tcQlI7YIv/JuyTTUko1uzNyPmENjCW3KTVrHBOgi0ng=;
        b=6ILjPSuTJE5rtGnvnYvQiBKj/x1fp0zjN4rIjG1Tq6vXD+sUc9eBhitM0gMyUTuNjM86qj
        ZZSdSsJt2w9/S9Bg==
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
Subject: RE: [patch 08/20] genirq/msi: Make MSI descriptor iterators device
 domain aware
In-Reply-To: <BN9PR11MB5276F39FAC20C32E273B7FB48C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.500733944@linutronix.de>
 <BN9PR11MB5276F39FAC20C32E273B7FB48C099@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Fri, 18 Nov 2022 13:17:04 +0100
Message-ID: <87r0y0jw3j.ffs@tglx>
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

On Fri, Nov 18 2022 at 07:57, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Sent: Friday, November 11, 2022 9:57 PM
>> 
>> +/* Invalid XA index which is outside of any searchable range */
>> +#define MSI_XA_MAX_INDEX	(ULONG_MAX - 1)
>> +#define MSI_XA_DOMAIN_SIZE	(MSI_MAX_INDEX + 1)
>> +
>
> Out of curiosity. Other places treat MSI_MAX_INDEX - 1 as the upper
> bound of a valid range. This size definition here implies that the last ID
> is wasted for every domain. Is it intended?

Bah. MSI_MAX_INDEX is inclusive so the size must be + 1. I obviously
missed that in the other places which use it as upper bound.

Not that it matters, but yes. Let me fix that.
