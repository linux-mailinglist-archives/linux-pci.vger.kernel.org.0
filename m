Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED4A6374DA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 10:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKXJKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 04:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKXJKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 04:10:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B00114BB8;
        Thu, 24 Nov 2022 01:10:43 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669281041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wxDUIdcZqV8qzd3zeBKegPzdz1xDmsJGqZx6pnAnrGQ=;
        b=k3TAhx0ejLrT/moxsbfBhl8aA+yL/nIzDsmPXXG0r5Q1a91rSr0UtC/Urqx2ObJb8XI7Pu
        B4s/8kuWBUqqBgK67MLP8zwvpH3PH1wJiT+lp/D0avGZciW4WS2R/4llHDOsJUCLIenTDE
        KllfQYTa1vbt0SwcnX/A6++E/m3izy+6ZJJt4hp5QecW7n3xc8bLXrxW741G3uGYt1mV9O
        vULPdTh5H7A/B19Qx/tVOagL0ML0lgo/5/LxaAFHnVeUz3BfkLQPBvtlf8WcWZ2KjbzS8W
        P0DNzdADWLHJ2PAVMOMWnyMN+Ph/0QyM3uWJZtKeOpKQEMapNdoTzloA97DoEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669281041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wxDUIdcZqV8qzd3zeBKegPzdz1xDmsJGqZx6pnAnrGQ=;
        b=H64hB/MybL/Y4njxJn6/CNrDc6lNjcLNNpfUi4NJ9+K+QCU6VdjV/8vDRHLiXGUgpl+J0H
        AOuaR6JsRJnchcCQ==
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
Subject: RE: [patch V2 28/33] PCI/MSI: Provide IMS (Interrupt Message Store)
 support
In-Reply-To: <BN9PR11MB5276549A90576254ACCCBED48C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091328.026206487@linutronix.de>
 <BN9PR11MB5276549A90576254ACCCBED48C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Thu, 24 Nov 2022 10:10:41 +0100
Message-ID: <87leo0d8fi.ffs@tglx>
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

On Thu, Nov 24 2022 at 03:10, Kevin Tian wrote:

>> From: Thomas Gleixner <tglx@linutronix.de>
>> Sent: Monday, November 21, 2022 10:38 PM
>> 
>> The IMS domains have a few constraints:
>> 
>>   - The index space is managed by the core code.
>> 
>>     Device memory based IMS provides a storage array with a fixed size
>>     which obviously requires an index. But there is no association between
>>     index and functionality so the core can randomly allocate an index in
>>     the array.
>> 
>>     Queue memory based IMS does not have the concept of an index as the
>>     storage is somewhere in memory. In that case the index is purely
>>     software based to keep track of the allocations.
>
> 'Queue' could be a HW queue or SW queue. Is it clearer to just use
> 'system memory based IMS" here?

Yes
