Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7B51E665
	for <lists+linux-pci@lfdr.de>; Sat,  7 May 2022 12:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359522AbiEGKWm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 May 2022 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351004AbiEGKWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 May 2022 06:22:39 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41814AE3B;
        Sat,  7 May 2022 03:18:52 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id F2D863000E43D;
        Sat,  7 May 2022 12:18:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E71B427C582; Sat,  7 May 2022 12:18:48 +0200 (CEST)
Date:   Sat, 7 May 2022 12:18:48 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Message-ID: <20220507101848.GB31314@wunner.de>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 06, 2022 at 03:40:25PM -0700, Dan Williams wrote:
> On Tue, May 3, 2022 at 8:35 AM Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> So, like you, I was envisioning all the CMA and SPDM code landing in
> the kernel until I read this:
> 
> "Extending in-kernel TLS support"
> https://lwn.net/Articles/892216/
> 
> ...and questioned why this new CMA/SPDM session establishment, which
> is similar to TLS, be done inside the kernel while TLS session
> establishment is done in userspace? I had a chance to chat with Chuck
> at LSF/MM and confirmed there is little appetite to change this
> up-call requirement for session establishment and expect CMA to be the
> same. The rough idea of how this works with CMA/SPDM is providing an
> ABI to retrieve session setup data with the end result of userspace
> instantiating a keyid via keyctl the to be used for future SPDM
> messages.

I'm still somewhat undecided on the kernel vs. user space question.

The simplest approach would be to expose DOE to user space and just
let it send the requests necessary for setting up an SPDM session
as well as IDE.

Jonathan posted patches a while ago to expose a DOE chrdev:
https://lore.kernel.org/all/20210524133938.2815206-5-Jonathan.Cameron@huawei.com/

On the other hand, I'm poring over Jonathan's latest kernel SPDM/CMA
patches and they're not very large, hence seem upstreamable.

It would be nice to have the kernel auto-detect that a PCI device
supports IDE and create a directory in sysfs as a result.  The user
would just drop certificates there which are added to a keyring
and the kernel would automatically try to set up an SPDM session
with one of the certificates and bring up IDE encryption.  Binding of
drivers to devices could be delayed until IDE is set up, as could be
enumeration of devices below a hot-plugged, IDE-capable PCIe switch.

(I can think of plenty of use cases, some good, some evil.
Such as preventing malicious / forged devices from being used,
but also vendors and employers controlling what people plug into
their machines.  Brave new world.)

Of course, it would probably be possible to implement all of this
in user space but it might not be as seamless.

I just fear that we may become a laughing stock for security researchers
with a kernel-only implementation.  Kind of like "ASN.1 parsing at ring 0":
https://x41-dsec.de/lab/blog/kernel_userspace/

I have some feedback on Jonathan's SPDM/CMA patches and will send it
out in a bit...

Thanks,

Lukas
