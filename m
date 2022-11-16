Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F5E62CE0F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 23:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiKPWwD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 17:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbiKPWv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 17:51:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3518E0F;
        Wed, 16 Nov 2022 14:51:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668639114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=og7VFGWgga/WDNrUO7ZE1y9YFk0rZZz1Y7SQa3rc/Bo=;
        b=sZmX6Yg3XezzZ2hq1tZefSPYyfecyqklALECXScfxof5PazPB2pQMWRIq3wUTu43H8z6hb
        WEwyl4EmYgpScWUlFaXeaT282S6rdI53Thh1Za1i6LXUb+psAzFJsG3vdZDfFLVyvw/JCw
        cwNu2XjbgPipQlBYCSry4kJc84H4Kg8smh1T7pMdbtgloyQJlj9sRzAx4eomTMleUHdPKo
        hlT3wRrONZpVSFl2GOjlxVJkbhazs1D90M/bX1BePMGs/NwN3nEx3gsHEQESH0iRS6Cpju
        DVXaRP9DDJutgsollRsjdoUnbJGLLBgUHHoh6qVhBUkccGZHxhG2kB4lpTMsRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668639114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=og7VFGWgga/WDNrUO7ZE1y9YFk0rZZz1Y7SQa3rc/Bo=;
        b=57u6ql1eCbyCY2SupG0ktAPUYRyn+XthnjW8tkxBEfsMcHX0R/8u/XSsMZf/nZLpWEX8UW
        CM5vMBglNyqiNVAA==
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
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 13/39] PCI/MSI: Use msi_domain_info::bus_token
In-Reply-To: <Y3UjOc2XhwYSVVP1@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122014.352437595@linutronix.de> <Y3UjOc2XhwYSVVP1@nvidia.com>
Date:   Wed, 16 Nov 2022 23:51:54 +0100
Message-ID: <87fseio6lx.ffs@tglx>
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

On Wed, Nov 16 2022 at 13:51, Jason Gunthorpe wrote:
> On Fri, Nov 11, 2022 at 02:54:35PM +0100, Thomas Gleixner wrote:
>>  	/* PCI-MSI is oneshot-safe */
>>  	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
>> +	/* Let the core update the bus token */
>> +	info->bus_token = DOMAIN_BUS_PCI_MSI;
>
> comment seems a bit obvious

:)

> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Should the callers be updated to set this in their "struct
> msi_domain_info" ?

For PCI/MSI we can handle that in the core for all of them. :)

The other msi_domain_info usage in various places needs obviously
special care.

Thanks,

        tglx
