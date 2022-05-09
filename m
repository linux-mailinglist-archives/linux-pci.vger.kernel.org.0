Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D69A51F8B7
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiEIJxi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 05:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiEIJwj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 05:52:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937F7224689;
        Mon,  9 May 2022 02:48:44 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KxbrL6gDtz683mZ;
        Mon,  9 May 2022 17:45:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 11:48:12 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 10:48:07 +0100
Date:   Mon, 9 May 2022 10:48:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, CHUCK_LEVER <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Message-ID: <20220509104806.00007c61@Huawei.com>
In-Reply-To: <20220507101848.GB31314@wunner.de>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
        <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
        <20220507101848.GB31314@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 7 May 2022 12:18:48 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Fri, May 06, 2022 at 03:40:25PM -0700, Dan Williams wrote:
> > On Tue, May 3, 2022 at 8:35 AM Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > So, like you, I was envisioning all the CMA and SPDM code landing in
> > the kernel until I read this:
> > 
> > "Extending in-kernel TLS support"
> > https://lwn.net/Articles/892216/
> > 
> > ...and questioned why this new CMA/SPDM session establishment, which
> > is similar to TLS, be done inside the kernel while TLS session
> > establishment is done in userspace? I had a chance to chat with Chuck
> > at LSF/MM and confirmed there is little appetite to change this
> > up-call requirement for session establishment and expect CMA to be the
> > same. The rough idea of how this works with CMA/SPDM is providing an
> > ABI to retrieve session setup data with the end result of userspace
> > instantiating a keyid via keyctl the to be used for future SPDM
> > messages.  
> 
> I'm still somewhat undecided on the kernel vs. user space question.

Likewise.  I feel a few more prototypes are needed to come to clear
conclusion.

> 
> The simplest approach would be to expose DOE to user space and just
> let it send the requests necessary for setting up an SPDM session
> as well as IDE.
> 
> Jonathan posted patches a while ago to expose a DOE chrdev:
> https://lore.kernel.org/all/20210524133938.2815206-5-Jonathan.Cameron@huawei.com/

Discussions at Plumbers last year (and on list) concluded that generic
interface was probably a non starter, but something SPDM specific should
be fine. (even if it's just that generic interface with a check that it
is the right DOE protocol ;)
> 
> On the other hand, I'm poring over Jonathan's latest kernel SPDM/CMA
> patches and they're not very large, hence seem upstreamable.

That ended up rather cleaner than I expected. Though note that series doesn't get
quite as far as secure channel setup which is the point where a
userspace stack might hand over to kernel.  It should be a fairly trivial
addition though.

> 
> It would be nice to have the kernel auto-detect that a PCI device
> supports IDE and create a directory in sysfs as a result.  The user
> would just drop certificates there which are added to a keyring
> and the kernel would automatically try to set up an SPDM session
> with one of the certificates and bring up IDE encryption.  Binding of
> drivers to devices could be delayed until IDE is set up, as could be
> enumeration of devices below a hot-plugged, IDE-capable PCIe switch.

Not sure interface would look exactly like that, but the point in general
is good.

> 
> (I can think of plenty of use cases, some good, some evil.
> Such as preventing malicious / forged devices from being used,
> but also vendors and employers controlling what people plug into
> their machines.  Brave new world.)

We could do driver specific 'blocking' until the 'authorized' bit Dan suggested
is set by userspace (after attestation) and end up with somewhat
similar security.  The only real difference being that a malicious device
might have more driver code to attack than it would if we blocked
the driver starting at all.  That would depend on how the driver was
implemented.

> 
> Of course, it would probably be possible to implement all of this
> in user space but it might not be as seamless.
> 
> I just fear that we may become a laughing stock for security researchers
> with a kernel-only implementation.  Kind of like "ASN.1 parsing at ring 0":
> https://x41-dsec.de/lab/blog/kernel_userspace/
> 
> I have some feedback on Jonathan's SPDM/CMA patches and will send it
> out in a bit...

Cool. Though I suspect those will be parked for now as 'sufficient' for
discussion.  Next step is to mock up what the alternative looks like...

Good to capture the feedback while it's fresh on basis we might end up back there!

Jonathan


> 
> Thanks,
> 
> Lukas
> 

