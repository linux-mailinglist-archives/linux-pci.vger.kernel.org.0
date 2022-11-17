Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37E62D4EC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 09:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiKQIWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 03:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiKQIWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 03:22:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A14E6DCEB;
        Thu, 17 Nov 2022 00:22:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668673338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wIVX2MwJcu88wyoRSA1ASXFeHTanLRpod2fOiAYk42Q=;
        b=pRs5JR7b+MK5IrHfaCpInQxaDeC9PvLo7Zo1msTJyoCGPbL+6O8u4CqY3P5lAAqWNgdDeS
        Wor/o6pp3iVymD4p2gJG/HMX74WixBFfLFutuf+HsdWohrU85CZzDkvVKrovF6T+T3m+AW
        BDyNHqKpKeCG8Pa2zdgXoqAMhZ4x3ntI+1l75eBvNGQy5jeEGTbkgKSYJuB9Xa+hDLyRPo
        CP3cEuwwh7lHoufv9Otj/O10K7OhQ0HLfG06MINUxbYTEwlTMqaY9g/V9xuSqs+FZfpGMk
        JRzV6t/Z3sPM+330lwYCsVQBePNWNqlFlrM6HYoHwLO+biS1QiI67/gbnW8E4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668673338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wIVX2MwJcu88wyoRSA1ASXFeHTanLRpod2fOiAYk42Q=;
        b=VPYEAu0OHciMT2/0zjp9NwK3Ej0xV3gqu1ZiXKKa3Bl2hm2hGGSIINgmAIItBguwG+ofeA
        EnxX6Q1iJQJvdiDQ==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 34/39] PCI/MSI: Reject multi-MSI early
In-Reply-To: <20221116163118.GA1116261@bhelgaas>
References: <20221116163118.GA1116261@bhelgaas>
Date:   Thu, 17 Nov 2022 09:22:18 +0100
Message-ID: <8735aing79.ffs@tglx>
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

On Wed, Nov 16 2022 at 10:31, Bjorn Helgaas wrote:
> On Fri, Nov 11, 2022 at 02:55:09PM +0100, Thomas Gleixner wrote:
>>  
>> +/**
>> + * pci_msi_domain_supports - Check for support of a particular feature flag
>> + * @pdev:		The PCI device to operate on
>> + * @feature_mask:	The feature mask to check for (full match)
>> + * @mode:		If ALLOW_LEGACY this grants the feature when there is no irq domain
>> + *			associated to the device. If DENY_LEGACY the lack of an irq domain
>> + *			makes the feature unsupported
>
> Looks like some of these might be wider than 80 columns, which I think
> was the typical width of this file.

I accommodated to the general sentiment that 80 columns is yesterday. My
new cutoff is 100.

Thanks,

        tglx
