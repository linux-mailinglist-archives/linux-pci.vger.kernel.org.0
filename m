Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAE14713E2
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 14:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhLKNE4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 08:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhLKNEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Dec 2021 08:04:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA6FC061714;
        Sat, 11 Dec 2021 05:04:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639227892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=38/Db3j/tuzM5sMDcn0hVrQ9Hr7pHpt39b3WTf8tlcA=;
        b=w841xfDqQZN7kBkSecqzjfET5cCxoIWD7sohONld+A4/fywu7mxU8knTNNpYTU3LyTeN5W
        hRtH4deK3c+Nl6TRFf1ldQT0ovJkupvJfeiLMq5eEpHFYVIlxHcmxXieqT4Q7V9M6AJtpp
        jtACmPkh4As7iKGiv/EBYxFsPKsv6DfltP4wu30n2Qs63WKtqIIyJ9Y+cuOqwUm8276eg4
        DHcUAFEiCyFxPO1tRV8LSK84iuPIt1TVLHTvA5g3sgHalhsTOehFHHumjihCQ31gZhZ/+b
        j/id5XPT9RY+Ol5wMfbOBjmT+T07o6Vcog6FXDxt9dob/IYPDHFTpWDou4an2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639227892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=38/Db3j/tuzM5sMDcn0hVrQ9Hr7pHpt39b3WTf8tlcA=;
        b=F0rZXep58tnqWpssbFXotjfPeO0xx74comw8vNO4zW0sw2COD634KbX4OYtb7JqA/Is+XK
        Lek77MbqCrvMUzAA==
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com> <87fsr0xp31.ffs@tglx>
 <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Sat, 11 Dec 2021 14:04:52 +0100
Message-ID: <875yrvwavf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kevin,

On Sat, Dec 11 2021 at 07:44, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> On Fri, Dec 10 2021 at 08:39, Jason Gunthorpe wrote:
>> > It is clever, we don't have an vIOMMU that supplies vIR today, so by
>> > definition all guests are excluded and only bare metal works.
>> 
>> Dammit. Now you spilled the beans. :)
>
> Unfortunately we do have that today. Qemu supports IR for
> both AMD and Intel vIOMMU.

can you point me to the code?

All I can find is drivers/iommu/virtio-iommu.c but I can't find anything
vIR related there.

Thanks,

        tglx
