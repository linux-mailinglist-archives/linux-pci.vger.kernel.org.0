Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6026C635BBA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbiKWLaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 06:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbiKWL3s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 06:29:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB3BE2D;
        Wed, 23 Nov 2022 03:29:34 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669202973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2mamiCyD9lwbw+o5WE1PalM2BxixtIfzBmHhS3AlxvU=;
        b=Akw1Kex4wmvemQD/WJuzl1kHatgTM4gSJXnNDx+e9f6cLXubHpuD0HpWmeNuvDv9h4SmbA
        668e2q7hrOyiwMzFkDwmVsNTJC0QTukrEvdye4DrlX884GNtmU8MIyHWSCTsn6mGEnNUXn
        tYIDti1L8uLhb/VqQ4a+J/1rNfOMNd7ubdd+iAEGyUHO5+7TNwJmQSDonu60DJxXSOZ2PB
        LKGrb4D8Az50uOqgjhhU5FQwUSw8yDDanMBrY9pRNzICRDDRPP0mOl3cyb5jfIjT1oLDyK
        FCk1vTX+rJCD5MM1otBNPuumez9LmP9b3HF+A7qwRtTB9iwhXZan/cJmcPzetA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669202973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2mamiCyD9lwbw+o5WE1PalM2BxixtIfzBmHhS3AlxvU=;
        b=WhkzKYjdxPK3csuxhz8jhKp6tjWE620MZiXckyX53hdJlrSmHSOVuDYZ0hgV0RsvcUrzTY
        6H6kNSH3RZS424DA==
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
Subject: RE: [patch V2 03/33] genirq/msi: Provide data structs for per
 device domains
In-Reply-To: <BN9PR11MB527698373FD71F975F3C5D7F8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091326.659141858@linutronix.de>
 <BN9PR11MB527698373FD71F975F3C5D7F8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Wed, 23 Nov 2022 12:29:32 +0100
Message-ID: <875yf5gb8j.ffs@tglx>
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
>> Sent: Monday, November 21, 2022 10:38 PM
>> 
>> Provide struct msi_domain_template which contains a bundle of struct
>> irq_chip, struct msi_domain_ops and struct msi_domain_info and a name
>> field.
>> 
>> This template is used by MSI device domain implementations to provide the
>> domain specific functionality, feature bits etc.
>> 
>> When a MSI domain is created the template is duplicated in the core code
>> so that it can be modified per instance. That means templates can be
>> marked const at the MSI device domain code.
>> 
>> The template is a bundle to avoid several allocations and duplications
>> of the involved structures.
>> 
>> The name field is used to construct the final domain and chip name via:
>> 
>>     $PREFIX-$NAME-$DEVNAME
>
> $PREFIX$NAME-$DEVNAME

Indeed.
