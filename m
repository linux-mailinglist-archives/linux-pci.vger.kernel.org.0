Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86A62D55D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 09:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiKQIqR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 03:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbiKQIqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 03:46:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EC3BFE;
        Thu, 17 Nov 2022 00:45:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668674753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u1qaKDnyy/v30VRyUA4NSH5qeXvkkd40FRaF+9lRfrQ=;
        b=h6YVokPX8fb70te11kTLevM9/Tboh3oKuMtJJqjfaSfvridZtz9knm1PMY7gwzFZeQ3wR0
        InixWku56XJk+RjRgkJErnPN390sPFUT8m6hzoLo/iWyR0L6+MMxpg9Bct7Hy8EMwiM8tT
        X9ABf4vnMDaieCcGsTz77TKOfFzyspa74HP6w0GZ/zQgReOg6wgr+/NgAHX2aJ3yJCSE7J
        GlzcTOcM+zrDJs0vFcyyvxBI+Vz8hSwgMBn7DKy5uff7GKO4LEehKJfDsACVdDykyfbhMM
        zHg6Lyp15oyGx4VNVB56XLqtYmP3vZk1wzpzAkS0ltNMGOXEUiA1lnq7/sAFAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668674753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u1qaKDnyy/v30VRyUA4NSH5qeXvkkd40FRaF+9lRfrQ=;
        b=t+QHIk0r5usoqiFoP1tk+PBrdg5zeTk4fanz2TZTeBvICzwCPm2sx3NsyBFjsFhU0n1N5c
        xfO8A/jSVfLn6JCg==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 12/33] PCI/MSI: Add support for per device MSI[X] domains
In-Reply-To: <Y3V+u+h7jGbRj3cE@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135205.951710169@linutronix.de> <Y3U2QFeoDB17kbIC@nvidia.com>
 <87tu2yo77n.ffs@tglx> <Y3V+u+h7jGbRj3cE@nvidia.com>
Date:   Thu, 17 Nov 2022 09:45:53 +0100
Message-ID: <87wn7um0ji.ffs@tglx>
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

On Wed, Nov 16 2022 at 20:22, Jason Gunthorpe wrote:
> On Wed, Nov 16, 2022 at 11:38:52PM +0100, Thomas Gleixner wrote:
>
>> >> +bool pci_setup_msi_device_domain(struct pci_dev *pdev)
>> >> +{
>> >> +	if (WARN_ON_ONCE(pdev->msix_enabled))
>> >> +		return false;
>> >> +
>> >> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSI))
>> >> +		return true;
>> >> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX))
>> >> +		msi_remove_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN);
>> >> +
>> >> +	return pci_create_device_domain(pdev, &pci_msi_template, 1);
>> >
>> > Hardwired to one 1? What about multi-msi?
>> 
>> MSI has exactly ONE descriptor whether it's single or multi-MSI.
>> 
>> Multi-MSI can have several interrupts hanging off the same descriptor,
>> but that's not how MSI looks at it because you write ONE message and the
>> hardware does the substitution of the low bits depending on which vector
>> is raised.
>
> Okay, that is very clear, maybe this in a comment right here ?

Sure.
