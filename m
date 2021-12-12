Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124BF471D0C
	for <lists+linux-pci@lfdr.de>; Sun, 12 Dec 2021 21:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhLLUuo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Dec 2021 15:50:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhLLUuo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Dec 2021 15:50:44 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639342242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w3giibguzthIGHYHZS8eAHBYfn6QZq1ks3+DemGTi2A=;
        b=oLGM0fJWooQOY1C0QcNqNUf1Nt9JIwFQ/JkKPqr2NcAAgY0Ia2UAOsHWXbkqrxD5dGI9Bj
        wSuaWdPSIWfyBnVpV8V7URTH5aJd0ivsI1tg+96Yj8PqzajDOg8PQg3F375Mn0xleyXtXs
        IAWGgYhPt55iHkmlj9WPhpFq1lNr2GNfn+Hq8Cbe5tT09PCd4JA5k5f1e1S7m5cNzsmRqN
        PNzgZQNxwIfT6oxKifUC5+vze6DMYkz8my+C/uMCG+Wm2184S5HAbG4gosXtqgqMiRxutU
        v0LibPW+tVdCOdFWlzKmvB7s9K+vQIFLmcbKyqDBjhDMPTMhuZ4ZeyMrNXAMXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639342242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w3giibguzthIGHYHZS8eAHBYfn6QZq1ks3+DemGTi2A=;
        b=jlqj5iobosYd6KCJKJLfe1h8raKVADcf0qJ+sMUPFX8AiT7ouYDhQUAu7kEfKliB+AcapX
        suBlA8e5xDCALdDw==
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
In-Reply-To: <BL1PR11MB5271BFC6B2218CF7E9151EE88C739@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
 <BN9PR11MB5276B2584F928B4BFD4573428C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87lf0qvfze.ffs@tglx>
 <BL1PR11MB5271BFC6B2218CF7E9151EE88C739@BL1PR11MB5271.namprd11.prod.outlook.com>
Date:   Sun, 12 Dec 2021 21:50:41 +0100
Message-ID: <87ilvtv97i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kevin,

On Sun, Dec 12 2021 at 02:14, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
> I just continue the thought practice along that direction to see what
> the host flow will be like (step by step). Looking at the current 
> implementation is just one necessary step in my thought practice to 
> help refine the picture. When I found something which may be 
> worth being aligned then I shared to avoid follow a wrong direction 
> too far.
>
> If both of your think it simply adds noise to this discussion, I can
> surely hold back and focus on 'concept' only.

All good. We _want_ your participartion for sure. Comparing and
contrasting it to the existing flow is fine.

Thanks,

        tglx
