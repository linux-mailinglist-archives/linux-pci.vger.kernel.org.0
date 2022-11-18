Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C4562F4BC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 13:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbiKRM2s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 07:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbiKRM1l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 07:27:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BC29AC83;
        Fri, 18 Nov 2022 04:26:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668774417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EG1Khhz+uxMnO27CwLjm0H0h424VL6GigVyFVyuBn7M=;
        b=zmeGxIMtSB92aEaQ2y1OZBXzDmKNHkPfNBjPp72ri3pYKUrl49F/+PnVR2I5op7sGGDNjO
        nOTa6or76pQ0BX/KjGa5J/yurwyYt3X20FW5LPDwM7uRnmVdp4p5sejgZly/AHM3eDa6Pi
        KLKt+vT4shJqaRDub4bBXHlb0sBqeUNcDHCQCiHhu6KXjdy1WTElDOEJEYbsTn8bp9zV7b
        AfYwvAA/NsEtjouSXPIrCrPyw9kcnV4ILPgH4NXnAOyuYUk4GEIJi1zKH5Tdi9dOIAevOp
        VVpy4Q3MFG126roR+Pm/SWjB8YBpcLLqE5RqjG1GyJl2Mqoa4+sMx6XHi/ZHrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668774417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EG1Khhz+uxMnO27CwLjm0H0h424VL6GigVyFVyuBn7M=;
        b=Y5hSd7h3MRUk4a+iGGjEI5xe5vw36SDqIOUTpEtph33aXM3qPN3dqlhgQVBh6M5bFFF8jl
        FG2+ASiTIyIm4iCw==
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
Subject: RE: [patch 17/20] platform-msi: Switch to the domain id aware MSI
 interfaces
In-Reply-To: <BN9PR11MB5276453E63A0C02A4BB386F58C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132707.005001510@linutronix.de>
 <BN9PR11MB5276453E63A0C02A4BB386F58C099@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Fri, 18 Nov 2022 13:26:56 +0100
Message-ID: <87fsegjvn3.ffs@tglx>
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

On Fri, Nov 18 2022 at 08:53, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> 
>> -	err = msi_domain_alloc_irqs(dev->msi.domain, dev, nvec);
>> +	err = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0,
>> nvec - 1);
>>  	if (err)
>>  		platform_msi_free_priv_data(dev);
>> 
>
> Out of curiosity. Why don't we provide an unlocked version of
> msi_domain_alloc_irqs_all()?

-ENOUSER
