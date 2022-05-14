Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A007D52716B
	for <lists+linux-pci@lfdr.de>; Sat, 14 May 2022 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiENNz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 May 2022 09:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiENNzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 May 2022 09:55:24 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFF6C21;
        Sat, 14 May 2022 06:55:23 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9935130007925;
        Sat, 14 May 2022 15:55:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 81E322ED59F; Sat, 14 May 2022 15:55:21 +0200 (CEST)
Date:   Sat, 14 May 2022 15:55:21 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Message-ID: <20220514135521.GB14833@wunner.de>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de>
 <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de>
 <20220511191943.GB26623@wunner.de>
 <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 12:43:34PM -0700, Dan Williams wrote:
> On Wed, May 11, 2022 at 12:20 PM Lukas Wunner <lukas@wunner.de> wrote:
> > But the reset argument still stands:  That same section says that all
> > IDE streams transition to Insecure and all keys are invalidated upon
> > reset.
> 
> Right, this isn't the only problem with reset vs ongoing CXL operations...
> 
> https://lore.kernel.org/linux-cxl/164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com/

The above-linked cover letter refers to AER.

I believe with AER, the kernel is notified of an error via an interrupt
and asynchronously attempts recovery through a reset.
Obviously, an eternity may pass until the kernel gets around to do that
and whether accesses performed between the initial error and the reset
succeed is sort of undefined.  So it's kind of a "best effort" error
recovery.

With the advent of DPC, the situation has improved considerably as the
hardware (not the kernel) automatically disables the link upon occurrence
of the initial error.  Any subsequent accesses will fail and the kernel
does not perform a reset itself (the hardware already did that) but merely
attempts to bring the link back up.  That has made error recovery pretty
solid and NVMe drives now seamlessly recover from errors without the need
to unbind/rebind the driver.  Data centers heavily depend on that feature.

Perhaps if CXL.mem used DPC, it would be able to recover more reliably?

Circling back to the SPDM/IDE topic, while NVMe is now capable of
reliably recovering from errors, it does expect the kernel to handle
recovery within a few seconds.  I'm not sure we can continue to
guarantee that if the kernel depends on user space to perform
re-authentication with SPDM after reset.  That's another headache
that we could avoid with in-kernel SPDM authentication.

Thanks,

Lukas
