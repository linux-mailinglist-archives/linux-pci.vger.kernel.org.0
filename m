Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D6471D12
	for <lists+linux-pci@lfdr.de>; Sun, 12 Dec 2021 21:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhLLUzf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Dec 2021 15:55:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhLLUzf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Dec 2021 15:55:35 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639342533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X/NAgpabmqU7SvS/VZzGUCF8aINHFotBjDodV/Kfsg4=;
        b=LpEiLakmAttHKGEe/3XvPR1wZM1Zx04nHfXTOtMTF+y2v8crOvCX0wLiHUiSxD2FMv70dd
        pVyrjpQGUNXm58MyJoCymnp+uSMpvxZnJPhGJa4bENiiTG4Tx6pYhvxGRFH0V84NDRbSzF
        6essnvXYnG0FXAPt+wqOfhMKDE8tNgK0lOLemWVecVSYa/Isa8wFkTUp45sIKm8iuR7JRK
        73Bi6yC8SORzL04D7o1qph0B/nQEXBpoCQTxZWY8AfMdKlWhBMJba8XHmqBLFYgd62OD6+
        lCYxnrO3qvB6jMsSI4UwL+BfNgM4mUqSqh0zXXY8IN/6StMQhO6/wd+p+7HX6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639342533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X/NAgpabmqU7SvS/VZzGUCF8aINHFotBjDodV/Kfsg4=;
        b=bcZqTtGalDhuJSdfHxRVIoNBI2gdJizxqQQ5t6JV10dXy2tkk45yd0xK2H3YKD2oPO52mo
        TOV2vJAYg0Kr3gAQ==
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
        "x86@kernel.org" <x86@kernel.org>, "Rodel, Jorg" <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com> <87fsr0xp31.ffs@tglx>
 <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <875yrvwavf.ffs@tglx>
 <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
Date:   Sun, 12 Dec 2021 21:55:32 +0100
Message-ID: <87fsqxv8zf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kevin,

On Sun, Dec 12 2021 at 01:56, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> All I can find is drivers/iommu/virtio-iommu.c but I can't find anything
>> vIR related there.
>
> Well, virtio-iommu is a para-virtualized vIOMMU implementations.
>
> In reality there are also fully emulated vIOMMU implementations (e.g.
> Qemu fully emulates Intel/AMD/ARM IOMMUs). In those configurations
> the IR logic in existing iommu drivers just apply:
>
> 	drivers/iommu/intel/irq_remapping.c
> 	drivers/iommu/amd/iommu.c

thanks for the explanation. So that's a full IOMMU emulation. I was more
expecting a paravirtualized lightweight one.

Thanks,

        tglx
