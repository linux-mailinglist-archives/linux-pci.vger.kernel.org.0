Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80AD465888
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbhLAVtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353182AbhLAVsY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:48:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F34C06174A;
        Wed,  1 Dec 2021 13:44:50 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638395087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=krYS43JDn9SwhYUn0VmJxoA+3m1JcN43I7KNWxc/6KA=;
        b=c9AgdUMR9JqdGWNNLAqKHjwrtKay6G/qiAgJJpfZAqmtIJw7eARlb5WF7+CLZJaQq1xJ/+
        Z2HM8EqZBlrkQlDlGKyjXi2ksTnl3P8i/RducOe/dpLAMVuKYLaLmSALzehEdDRzA6HiCJ
        up8P8Kq3RcBw3RNP7fBVHhiMhEK2uV3budj5JXwUlh60N0UnlgFolzRA2umjl/2S2VpwE+
        VS0Tt7PHV5QrcXA/NTOvcOG+XsrkcWQUoztnFh321tz9F/UoRY0JDFSWiIEhUMy8s5STdV
        ZNIzQO0+q77TkeY/G4dpVnJUuG8NfbAnwk2txV36hi6ypUJQ8R06nTeI+v9viA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638395087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=krYS43JDn9SwhYUn0VmJxoA+3m1JcN43I7KNWxc/6KA=;
        b=D4Dq7GfJ0fntpaB0Dk72G+5o2ZtwQeCy8JqvMF7EWdfTcmCwWnMGLRIxNsDMBocjAoz7P5
        +59jRcriNgFyXnBQ==
To:     Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        linux-ntb@googlegroups.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com> <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
Date:   Wed, 01 Dec 2021 22:44:47 +0100
Message-ID: <878rx480fk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01 2021 at 14:21, Dave Jiang wrote:
> On 12/1/2021 1:25 PM, Thomas Gleixner wrote:
>>> The hardware implementation does not have enough MSIX vectors for
>>> guests. There are only 9 MSIX vectors total (8 for queues) and 2048 IMS
>>> vectors. So if we are to do MSI-X for all of them, then we need to do
>>> the IMS backed MSIX scheme rather than passthrough IMS to guests.
>> Confused. Are you talking about passing a full IDXD device to the guest
>> or about passing a carved out subdevice, aka. queue?
>
> I'm talking about carving out a subdevice. I had the impression of you 
> wanting IMS passed through for all variations. But it sounds like for a 
> sub-device, you are ok with the implementation of MSIX backed by IMS?

I don't see anything wrong with that. A subdevice is it's own entity and
VFIO can chose the most conveniant representation of it to the guest
obviously.

How that is backed on the host does not really matter. You can expose
MSI-X to the guest with a INTx backing as well.

I'm still failing to see the connection between the 9 MSIX vectors and
the 2048 IMS vectors which I assume that this is the limitation of the
physical device, right?

What needs a subdevice to expose?

Thanks,

        tglx



