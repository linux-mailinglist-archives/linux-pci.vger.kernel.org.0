Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA40630024
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 23:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKRWbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 17:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKRWbK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 17:31:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DC3922E6;
        Fri, 18 Nov 2022 14:31:09 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668810668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DkmsnDTBJ38CLVFri2Sxs2e83r1aTFEQrwjY6IcaV9Y=;
        b=2Reu5g9dHf+c6zh/wysNssnOToFlv3XC9lV4FgmrbXt0q0bJmuKq59z3Nkylb8NRIWteU3
        F6jURcpd8KTM7xB2ggvr8+t66UhmPtxLas51xhoeb0pvhaS4G3sfrJUkK5YPdF/xfH0bKI
        BOXiqNNcreurcAzI6bJhmKzdMjUDPZ5fmQRuHYLHhZiw791n5aq2mPyWsGlMTBhQdr/ca3
        wCsHq6XKO+xdmeD228vjU8JYvOawSw6g+hMFyX5qZxbS9Nepu9Nm9Lmzw9g91WTtT3WDE6
        v4y1FPbG+E2t4HIKsHqx58Rn6xkIH06KOAznlgUZdpqLVNjOAZVyhGSgiflOkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668810668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DkmsnDTBJ38CLVFri2Sxs2e83r1aTFEQrwjY6IcaV9Y=;
        b=aLVRMoGC/mD+1nPV1IbExqcqtMC3wFpRC1S+MWPeIzwcUw+R5HnIrmcpdcWQ7XJrI9sI7t
        sWgMl0mULXDAxoDA==
To:     Reinette Chatre <reinette.chatre@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: Re: [patch 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
In-Reply-To: <d33e63f0-a5ba-38d3-1cfb-dd5ab8d249b8@intel.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.463650635@linutronix.de>
 <0cbf645b-b23a-6c85-4389-bb039a677a52@intel.com> <87k03tkrii.ffs@tglx>
 <87zgcok4i2.ffs@tglx> <87wn7sjzeq.ffs@tglx>
 <d33e63f0-a5ba-38d3-1cfb-dd5ab8d249b8@intel.com>
Date:   Fri, 18 Nov 2022 23:31:07 +0100
Message-ID: <87y1s7j3o4.ffs@tglx>
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

On Fri, Nov 18 2022 at 10:18, Reinette Chatre wrote:
>> @@ -141,7 +141,7 @@ static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
>>  		if (ret)
>>  			goto fail;
>>  
>> -		desc->msi_index = index;
>> +		desc->msi_index = index - baseidx;
>
> Could msi_desc->msi_index be made bigger? The hardware I am testing
> on claims to support more IMS entries than what the u16 can
> accommodate.

Sure that's trivial. How big does it claim it is?

>> @@ -1476,9 +1476,10 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
>>  				       const struct irq_affinity_desc *affdesc,
>>  				       union msi_dev_cookie *cookie)
>>  {
>> +	struct msi_ctrl ctrl = { .domid	= domid, .nirqs = 1, };
>> +	struct msi_domain_info *info;
>>  	struct irq_domain *domain;
>>  	struct msi_map map = { };
>> -	struct msi_desc *desc;
>
> (*desc is still needed)

Yes, I figured that out later :)

> Thank you very much. With the above snippet it is possible to
> allocate an IMS IRQ. I am not yet able to use the IRQ and I am working
> on more tracing to figure out why. In the mean time, I did
> just try the pci_ims_alloc_irq()/pci_ims_free_irq() flow and
> pci_ims_free_irq() triggered the WARN below:
>
> remove_proc_entry: removing non-empty directory 'irq/220', leaking at least 'idxd-portal'

Hrm, that's the irq action directory. No idea why that is not torn down.

I assume your sequence is:

  pci_ims_alloc();
  request_irq();        <- This creates it
  free_irq();           <- This removes it
  pci_ims_free();

Right?

Thanks,

        tglx
