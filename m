Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26652E474
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 07:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344644AbiETFm2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 01:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbiETFmU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 01:42:20 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A3059322;
        Thu, 19 May 2022 22:42:18 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id C903F10045BE2;
        Fri, 20 May 2022 07:42:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AC73D313920; Fri, 20 May 2022 07:42:14 +0200 (CEST)
Date:   Fri, 20 May 2022 07:42:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Message-ID: <20220520054214.GB22631@wunner.de>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de>
 <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de>
 <20220511191943.GB26623@wunner.de>
 <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com>
 <20220514135521.GB14833@wunner.de>
 <YoT4C77Yem37NUUR@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoT4C77Yem37NUUR@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 18, 2022 at 06:43:39AM -0700, Christoph Hellwig wrote:
> On Sat, May 14, 2022 at 03:55:21PM +0200, Lukas Wunner wrote:
> > Circling back to the SPDM/IDE topic, while NVMe is now capable of
> > reliably recovering from errors, it does expect the kernel to handle
> > recovery within a few seconds.  I'm not sure we can continue to
> > guarantee that if the kernel depends on user space to perform
> > re-authentication with SPDM after reset.  That's another headache
> > that we could avoid with in-kernel SPDM authentication.
> 
> I wonder if we need kernel bundled and tightly controlled userspace
> code for these kinds of things (also for NVMe/NFS TLS).  That is,
> bundle a userspace ELF file or files with a module which is unpacked
> to or accessible by a ramfs-style file systems.  Then allow executing
> it without any interaction with the normal userspace, and non-pagable
> memory.  That way we can reuse existing userspace code, have really
> nice address space isolation but avoid all the deadlock potential
> of normal userspace code.  And I don't think it would be too hard to
> implement either.

Just as a reminder, on resume from system sleep, IDE needs to be
set up by pci_pm_resume_noirq() to comply with the existing assumption
that a PCI driver's ->resume_noirq callback may access the device.

At that point (device) interrupts are disabled, so it's not possible
to e.g. read certificates from disk or perform an OCSP request.
So the bundled userspace code would have to conform to a number of
severe restrictions to avoid resume issues.

Thanks,

Lukas
