Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ECA635BE8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 12:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiKWLiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 06:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbiKWLiL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 06:38:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFE610891E;
        Wed, 23 Nov 2022 03:38:10 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669203489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c7FlrRcKHIFrRkveac6JF/JglSqA3pnlIgJwgHBeStQ=;
        b=qgyTEwouWkDqwBtPTCRvXfUr+Sf0+ZE1xJx7iOH3iyXycWsnawONGi48BREDiIAn2APn/3
        2i93++u3PGfhxSiB8dXRzVTDrseed7iuEVhpHYFoXA1Um53D+/VeJoACr7KTSg3xIPOG5Y
        UaSjE72bWKOSMAeHAktclJ4S78PNoIlHlUpeY0IMqoFIrJTOCQUVfk48el7XMAeAWQ4isM
        9voMIBx/u7Hkm0O1JfL4Cx5H7NvlY6Rui+E/7FkiYn3iLnWkE50ksc2+eHb/S1AkhIvD+9
        oh6kPwtjqICbs1XyZuPLLqqh9e+U9nz/IllkqTukUg49nbx5ZG6t3d2vHxBs9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669203489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c7FlrRcKHIFrRkveac6JF/JglSqA3pnlIgJwgHBeStQ=;
        b=YnTSrjh0MPSCf5N+/jH1zstArJBEc2I71dc4NMcPzS1HLbHzwLtbt+/u3XlAVmgzFkGUbO
        9KkYwN2nUbNop2Cg==
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
In-Reply-To: <BN9PR11MB527604DE2A881FF615B7D0748C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091326.879869866@linutronix.de>
 <BN9PR11MB527604DE2A881FF615B7D0748C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Wed, 23 Nov 2022 12:38:08 +0100
Message-ID: <8735a9gau7.ffs@tglx>
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

On Wed, Nov 23 2022 at 08:02, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Sent: Monday, November 21, 2022 10:38 PM
>> 
>> 
>> +static inline void msi_remove_device_irqdomains(struct device *dev, struct
>> msi_device_data *md)
>> +{
>
> 'md' is unused

Duh, yes.

>> + *
>> + * Return: True on success, false otherwise
>
> Can you elaborate why boolean type is selected instead of returning the
> actual error codes? the outmost callers are all new functions:
>
> 	pci_setup_msi[x]_device_domain()
> 	pci_create_ims_domain()
>
> I didn't find out any legacy convention forcing this way...

What's the value of error codes? 99% of all callsites do:

       ret = foo();
       if (ret)
          goto fail;

Nothing evaluates the error codes, unless there is real useful
information like EAGAIN or ENOSPC which can tell the caller to retry
eventually or with different parameters. But for the above, the error
code is just useless.

>> +	bundle = kmemdup(template, sizeof(*bundle), GFP_KERNEL);
>> +	if (!bundle)
>> +		return false;
>> +
>> +	bundle->info.hwsize = hwsize ? hwsize : MSI_MAX_INDEX;
>
> patch04 marks that hwsize being 0 means unknown or unlimited in the
> header file.
>
> but here info.hwsize always gets a value i.e. the meaning of 0 only exists
> in this function. What about removing the trailing words about 0 in
> patch04?
>
> - + * @hwsize:		The hardware table size (0 if unknown/unlimited)
> + + * @hwsize:		The hardware table size

Fair enough, though I rather make that:

 * @hwsize:		The hardware table size or the software defined
                        index limit




      
