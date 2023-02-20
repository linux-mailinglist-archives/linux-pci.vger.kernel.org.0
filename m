Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2224869D2C1
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 19:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjBTSaT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 13:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBTSaS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 13:30:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F8B9EDC;
        Mon, 20 Feb 2023 10:30:17 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676917816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFg2EPnUWLFexDOXDISc45YCNnDvUoaXqoiZP2vcC4I=;
        b=M2ynnCYdgseHZeLwYWt6l6sWmbOd+he7NnlH/wbV1/LBBdjQwgSzx3AB6zPf3kwXWfa132
        LsGzon39hWVGfNLvEv/pguEbGTt6x0qtwvgFqENNcZe8cFjELRYfGLiGRlQov3+BfqmeMM
        hZVzEez4vkQ3Yt52jd2OyM2Ej7CEDvasKN+wcxREks+Lam0qzMklOuxbntrkmLPGFXQkVA
        /wFuAv5CY+1U/WioytKGkr0VQN6aAOeD4sI0yI02o24kRydEEZPpaXHx86dO93m4UOsMPh
        yib8m2IA4b0mvgGgo1M78Uypso0yN2TZecITEJz8TU+TsvaUrVkgsZhI0KKoxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676917816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFg2EPnUWLFexDOXDISc45YCNnDvUoaXqoiZP2vcC4I=;
        b=bvfIT9+wNpnZkGjTgeO3YEf+2au8wqJF6JEtoxu5eoz7yKtMkL0np90hM5V/AmJSadb0fr
        p3+fGeZLVqe+YnAw==
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
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
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [REGRESSION] Re: [patch V3 09/33] genirq/msi: Add range
 checking to msi_insert_desc()
In-Reply-To: <Y/Opu6ETe3ZzZ/8E@shell.armlinux.org.uk>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <Y/Opu6ETe3ZzZ/8E@shell.armlinux.org.uk>
Date:   Mon, 20 Feb 2023 19:30:15 +0100
Message-ID: <871qmkqjew.ffs@tglx>
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

On Mon, Feb 20 2023 at 17:11, Russell King wrote:
> On Fri, Nov 25, 2022 at 12:25:59AM +0100, Thomas Gleixner wrote:
> Hi Thomas,
>
> This patch appears to cause a regression on Macchiatobin, delaying the
> boot by about ten seconds due to all the warnings the kernel now
> produces.
>
>> @@ -136,11 +149,16 @@ static bool msi_desc_match(struct msi_de
>>  
>>  static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
>>  {
>> +	unsigned int hwsize;
>> +
>>  	if (WARN_ON_ONCE(ctrl->domid >= MSI_MAX_DEVICE_IRQDOMAINS ||
>> -			 !dev->msi.data->__domains[ctrl->domid].domain ||
>> -			 ctrl->first > ctrl->last ||
>> -			 ctrl->first > MSI_MAX_INDEX ||
>> -			 ctrl->last > MSI_MAX_INDEX))
>> +			 !dev->msi.data->__domains[ctrl->domid].domain))
>> +		return false;
>> +
>> +	hwsize = msi_domain_get_hwsize(dev, ctrl->domid);
>
> This calls msi_get_device_domain() without taking dev->msi.data->mutex,
> resulting in the lockdep_assert_held() firing for what seems to be every
> MSI created by the Armada 8040 ICU driver, which suggests something isn't
> taking the lock as you expect. Please can you take a look and propose a
> patch to fix this regression.

Groan. I'll have a look.
