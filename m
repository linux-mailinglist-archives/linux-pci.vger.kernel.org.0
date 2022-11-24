Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED56379EF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 14:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKXN2d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 08:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiKXN2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 08:28:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D39CEFCC;
        Thu, 24 Nov 2022 05:28:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669296510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEDcRqXrMXoIPqLdbUpkaT0UL1KUh1lqKTzcBbwi9ng=;
        b=0We3RBNmaL8qcBqAmz+TG+Tuzy8WYAaLanZWiF5JHssjMO8nvBk63NAIh1W4sobnU5m00l
        dEOZijAc1fObLzQbG9rNLSbom3w1ebz53IR953Af84FCGyB44dKvFiGbba2TArTURZEqN6
        6EUK9Z6gdvPbeBPaTsX+vsm7O/+PNLpTUsfFrsezsLh98egYT2SS9yiQholFjjpJ/KFzxm
        JtQRpok9kRlxUnYxivpsu/5dIt+PAFDjKYGeemQX3ul7fuhcl3FZGA+UiPwwzuWOCU6tmE
        0XpPUTlXl616h4N5eWWuwMmr+HnHgO5AsBSSSEzm/2JQzO8dpYc/q8kk6p8PpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669296510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEDcRqXrMXoIPqLdbUpkaT0UL1KUh1lqKTzcBbwi9ng=;
        b=kErtKUwJO1qUksa5X4RpNDUZf8n4KTYqvCmSjHUXAY9wBmh0NfnJcY+KQb7mJvma/TE+nS
        QvrhQquDM0znSwAg==
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
Subject: Re: [patch V2 27/33] genirq/msi: Provide constants for PCI/IMS support
In-Reply-To: <Y39tCFWB7I/fFEAa@nvidia.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.974140298@linutronix.de>
 <BN9PR11MB5276C9AE570B4CF854F6F5E48C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87o7swd8gi.ffs@tglx> <Y39tCFWB7I/fFEAa@nvidia.com>
Date:   Thu, 24 Nov 2022 14:28:30 +0100
Message-ID: <875yf4cwht.ffs@tglx>
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

On Thu, Nov 24 2022 at 09:09, Jason Gunthorpe wrote:
> On Thu, Nov 24, 2022 at 10:10:05AM +0100, Thomas Gleixner wrote:
>> On Thu, Nov 24 2022 at 03:01, Kevin Tian wrote:
>> > SECONDARY or be explicit IMS? Are we envisioning non-IMS usages to
>> > occupy this slot in the future?
>> 
>> I'm not really decided on that. Whatever the name or use-case for a
>> secondary domain is. Not, that this is not restricted to PCI.
>
> This is hierarchical right? So if a pci_device spawns an
> auxiliary_device, its driver could stick a msi domain on the
> MSI_DEFAULT_DOMAIN of the aux device as a child of the PCI device's
> domain?

A child of the PCI devices parent domain. The per device domains are
endpoint domains. They cannot serve as parent domains themself right
now.

If there is a real reason and use case which requires that, it can be
made work with trivial tweaks.

Thanks,

        tglx
