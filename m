Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0D636BBF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 22:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiKWVCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 16:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWVCA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 16:02:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FA014D01;
        Wed, 23 Nov 2022 13:01:59 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669237317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPY0QPiwPxOVNsUhFw4qklPqSP46kFJcNzsOhN1n538=;
        b=ORlVKv/m7tEpD4UVrSrPCm6J+eBk0xqmjwUulhd3d/QDKGlpl1PrgW4uX9WBfYtVw8dMNQ
        KCJCOYvUUPW2sEp+Ti1YD5lD28plFoJnwMPjc0Xx/tosLREa8IY2uSTuAqt57VnhrFhVpb
        z4rp31jZV7sIxWROrFrG7BMo2digq5jqsNyl3Zgt/RJ2TQo+hvZM+ews4EL4cWzHZmVUju
        egBD+o8SetcnmCIoYMmRnCO5XZOOvRvEyyE9/I131m0NNmA9yYRlA/iCMuEKE7m2jgxhvC
        pMKQs6O8Sh0JYLc2qtTFb+lQ9AOgElBbZMrUv+VHkOK3RcJ1uieEU3nJUS0c5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669237317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPY0QPiwPxOVNsUhFw4qklPqSP46kFJcNzsOhN1n538=;
        b=O1eXHnlVkm6CTF96zn3Fg/SVgP3bXEsbm4ePNRytcJEB86WwopkHY3WPHu0o+uUPvD7vo6
        qYLo+gx3cBCp+iAQ==
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
In-Reply-To: <8735a9gau7.ffs@tglx>
References: <20221121083657.157152924@linutronix.de>
 <20221121091326.879869866@linutronix.de>
 <BN9PR11MB527604DE2A881FF615B7D0748C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8735a9gau7.ffs@tglx>
Date:   Wed, 23 Nov 2022 22:01:56 +0100
Message-ID: <875yf5e663.ffs@tglx>
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

On Wed, Nov 23 2022 at 12:38, Thomas Gleixner wrote:
> On Wed, Nov 23 2022 at 08:02, Kevin Tian wrote:
>>> +	bundle->info.hwsize = hwsize ? hwsize : MSI_MAX_INDEX;
>>
>> patch04 marks that hwsize being 0 means unknown or unlimited in the
>> header file.
>>
>> but here info.hwsize always gets a value i.e. the meaning of 0 only exists
>> in this function. What about removing the trailing words about 0 in
>> patch04?
>>
>> - + * @hwsize:		The hardware table size (0 if unknown/unlimited)
>> + + * @hwsize:		The hardware table size
>
> Fair enough, though I rather make that:
>
>  * @hwsize:		The hardware table size or the software defined
>                         index limit
>

Actually 0 still needs to be valid to guarantee backward compatibility
for all existing msi_domain_info implementations.

The above is the per device domain creation function, but yes, I can lift
that initialization into the common MSI domain creation code.

Let me stare at this some more.
