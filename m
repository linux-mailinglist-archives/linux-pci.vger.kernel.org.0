Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6E262F473
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 13:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbiKRMT7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 07:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbiKRMTz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 07:19:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4A697353;
        Fri, 18 Nov 2022 04:19:49 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668773987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WhwsHEanhWlPM5Bzweid0/1/mRw2xWqkE+tJM2n22fk=;
        b=VV2lDm4JJjwYE/2GMczR4Mz3fiiKXicayezNfoLoysRgw53paE/+ph82V6nA5SW1yuYX8A
        gqyf0MutVGYJSGrpkj2XqGHF9uJGfhP113D40Tw4KAnxztYxcrT28dWoXBU1e6L+F7iCOK
        3AwLrDJxXBA2HbPYZOPe6PODVYmAuJ5DUBNSSXNU1khrjI3Qdr9uecdkbuV2KGON79aCh/
        jrIcJEI1H8EH3VUnvDJCB1QHjHxBX9csO7M8fp4O61sCO/uUTrdSLhbxIAw/3jcSmVBR8G
        JKyRDRPwaLjbBbbBP8J9xamGN08yYnZZmezPQskNSr4IjiUlDZ1jgsjUM8Q5/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668773987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WhwsHEanhWlPM5Bzweid0/1/mRw2xWqkE+tJM2n22fk=;
        b=xaRugJgOXc58D7WTJ/dDyPI0h75WqGErGRGwLTVJz9g8bkGyX+V/sVf9dEWSeCVPMJgz71
        HoQVJ2dzTSrHMtDA==
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
Subject: RE: [patch 11/20] genirq/msi: Make descriptor allocation device
 domain aware
In-Reply-To: <BN9PR11MB527676BC82A9A1E71AC7F6608C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.670241974@linutronix.de>
 <BN9PR11MB527676BC82A9A1E71AC7F6608C099@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Fri, 18 Nov 2022 13:19:47 +0100
Message-ID: <87o7t4jvz0.ffs@tglx>
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

On Fri, Nov 18 2022 at 08:10, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> +	if (WARN_ON_ONCE(first_index >= MSI_MAX_INDEX || last_index >=
>> MSI_MAX_INDEX))
>> +		return;
>> +
>>  	lockdep_assert_held(&dev->msi.data->mutex);
>> 
>>  	xa_for_each_range(xa, idx, desc, first_index, last_index) {
>
> this doesn't belong to allocation. and next patch will convert it to
> domid aware plus a formal check. Probably can just remove it
> from this patch.

I added this just for paranoia sake so I could catch my conversion
error. So yes and no.
