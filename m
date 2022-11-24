Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1266379D0
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 14:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKXNVI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 08:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKXNVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 08:21:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70AF725F3;
        Thu, 24 Nov 2022 05:21:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669296065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcSivvCokxNkF1QPV7TJQxglKFkFKtiHag+c/24kTJo=;
        b=Jsk9wMkQor96JUMQd/WDKwECmSKycWCOitLA95BFxxMZP06HaH4uZocgjqURcQ668mYfNH
        s8Wkmdk2bjxps0GMI4l1NL4otlLMG48KvAP1qs77Tweavg/78hXazB/djxOWvpbnTrIDUr
        UtIEHjnoTp949AY+wvzy3//+oAo7352W/VScAdVXcJIVfG58qH6dnPX9Onk+fg+p7dh2Mq
        79oPP1wuCRmBEvBeb3zsaMnafKkaFBMoXsTnS/FM0ClsBWZT/8HCDIKFk/dMPdrd63qvac
        aE0SPCBgWtQl96L4SfDFwcnO86b7p37iWoylHMXVXllK26t/MV/BbYPLRr2Vzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669296065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcSivvCokxNkF1QPV7TJQxglKFkFKtiHag+c/24kTJo=;
        b=qaa9J1jkiXljNshb+W3Dm/bLZIVPe2i9i98NrZHMyq+qtvxx61NTon850Gw4uZDP3towos
        byxnDgYUBjlx2XDg==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V2 31/33] iommu/vt-d: Enable PCI/IMS
In-Reply-To: <Y39uGVLrH3MvOoZ4@nvidia.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091328.184455059@linutronix.de>
 <BN9PR11MB527650A018BE7BF422BDA2F58C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87ilj4d766.ffs@tglx> <Y39uGVLrH3MvOoZ4@nvidia.com>
Date:   Thu, 24 Nov 2022 14:21:04 +0100
Message-ID: <878rk0cwu7.ffs@tglx>
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

On Thu, Nov 24 2022 at 09:14, Jason Gunthorpe wrote:
> On Thu, Nov 24, 2022 at 10:37:53AM +0100, Thomas Gleixner wrote:
>> Jason said, that the envisioned Mellanox use case does not depend on the
>> IOMMU because the card itself has one which takes care of the
>> protections.
>
> Right, but that doesn't mean we need the physical iommu turned
> off. Setting the mlx pci device to identity mode is usually enough to
> get back to full performance.

Ok.

>> How are we going to resolve that dilemma?
>
> The outcome is we don't have a strategy right now to make IMS work in
> VMs. This series is all about making it work on physical machines,
> that has to be a good first step.
>
> I'm hoping the OCP work stream on SIOV will tackle how to fix the
> interrupt problems. Some of the ideas I've seen could be formed into
> something that would work in a VM.

Fair enough.

Let me put the limitation into effect then.

Thanks,

        tglx
