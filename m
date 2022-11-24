Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7F86374D6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 10:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiKXJKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 04:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKXJKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 04:10:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD86B54EE;
        Thu, 24 Nov 2022 01:10:07 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669281005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JhcbIcud+oJyJ/Gocbu3yX3jIZNRzox919nTeMWqp9Y=;
        b=QPmRT5zGqOSBQEtAXlPEAodsiS/1hLuKlC68dNnLQ8xWTQjj67opPMdPxUlzDHljOzyDW3
        utc1gJpmBqYBLcSDOfD5mNDHDguNuHBmKfxnqmvrMDN9rrejdcapdDc/x2U7ROcRymfBaK
        27/Wv78/q6agAgvJqQw93hbUncLx6/gll/M9KAmmzyj28xFgyWtNt1JkpcAJEl/g/rPYc1
        mSBHUmxJ3YkjNLNz9+7ca2Lg5TJhJxQIvmF3bkoZ2+qLxuaeCGEEHiwsp5GA/o39czbU7m
        IHCUjp2vo0ZxAC7LY2LpxjXaq6OZJyfU4J1mjdz+n1cVvJPxL2mHb0/gWq8ITA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669281005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JhcbIcud+oJyJ/Gocbu3yX3jIZNRzox919nTeMWqp9Y=;
        b=4YX+D2N3bAJ/77krC3MXdjlWcVu0D3Rulsp7tUDExKlsSChBCJsK+7bHetV5oMFQd4iwBz
        TDlyiVkIsHG+cJDA==
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
Subject: RE: [patch V2 27/33] genirq/msi: Provide constants for PCI/IMS support
In-Reply-To: <BN9PR11MB5276C9AE570B4CF854F6F5E48C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.974140298@linutronix.de>
 <BN9PR11MB5276C9AE570B4CF854F6F5E48C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Thu, 24 Nov 2022 10:10:05 +0100
Message-ID: <87o7swd8gi.ffs@tglx>
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

On Thu, Nov 24 2022 at 03:01, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> @@ -15,6 +15,7 @@ struct device;
>>   */
>>  enum msi_domain_ids {
>>  	MSI_DEFAULT_DOMAIN,
>> +	MSI_SECONDARY_DOMAIN,
>>  	MSI_MAX_DEVICE_IRQDOMAINS,
>
> SECONDARY or be explicit IMS? Are we envisioning non-IMS usages to
> occupy this slot in the future?

I'm not really decided on that. Whatever the name or use-case for a
secondary domain is. Not, that this is not restricted to PCI.

Thanks,

        tglx
