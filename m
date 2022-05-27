Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693D7535D81
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350185AbiE0Jjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 05:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245331AbiE0Jjd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 05:39:33 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341A4BA55E;
        Fri, 27 May 2022 02:39:32 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7E2FE101951A4;
        Fri, 27 May 2022 11:39:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 52D002F792A; Fri, 27 May 2022 11:39:28 +0200 (CEST)
Date:   Fri, 27 May 2022 11:39:28 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Message-ID: <20220527093928.GA11083@wunner.de>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de>
 <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de>
 <20220511191943.GB26623@wunner.de>
 <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com>
 <20220514135521.GB14833@wunner.de>
 <CAPcyv4izKEGKw0L=QkTxp8MMfuWxzF9Rz4Bb_F0rRRiy_+2m8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4izKEGKw0L=QkTxp8MMfuWxzF9Rz4Bb_F0rRRiy_+2m8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 16, 2022 at 10:01:26AM -0700, Dan Williams wrote:
> On Sat, May 14, 2022 at 6:55 AM Lukas Wunner <lukas@wunner.de> wrote:
> > Circling back to the SPDM/IDE topic, while NVMe is now capable of
> > reliably recovering from errors, it does expect the kernel to handle
> > recovery within a few seconds.  I'm not sure we can continue to
> > guarantee that if the kernel depends on user space to perform
> > re-authentication with SPDM after reset.  That's another headache
> > that we could avoid with in-kernel SPDM authentication.
> 
> What is missing from this conversation is what constitutes a device
> leaving the trusted compute boundary and is the existing attestation
> invalidated by a reset. I.e. perhaps the kernel can just do a
> keep-alive heartbeat after the reset with the already negotiated key
> to confirm the session is still valid.

After a bit of digging in the spec I think I can answer your question.

Any type of reset (both Conventional Reset and FLR) "must result in all
IDE Streams associated with that Function transitioning to the Insecure
state, and all keys must be invalidated and rendered unreadable."
(PCIe r6.0, sec 6.33.8).

So IDE is always gone after reset and needs to be re-established.
An SPDM session is necessary for that.  Does a reset affect SPDM?

It depends on the type of reset:  A FLR "must not change the state
of the secure session" (PCIe r6.0, sec 6.31.4).

But for a Conventional Reset, the situation seems to be different:
The CMA/SPDM section of the spec doesn't say what happens to an
SPDM session upon a Conventional Reset, but sec 6.6.1 clearly states
that "all Port registers and state machines must be set to their
initialization values as specified in this document, except for
sticky registers".  So I think we must assume that the SPDM session
is gone after a Conventional Reset.

DPC results in a Conventional Reset at the port where it occurs and
also propagates a Hot Reset down the hierarchy (see ea401499e943).

The bottom line is that after DPC, both the SPDM session as well as IDE
need to be re-established, requiring the certificate validation
which is controversial here when performed at the kernel level.

(As an aside, sec 6.6.2 lists the registers not affected by a FLR
but neglects to mention the SPDM/CMA session state.  I think that's
an erratum, I've requested access to the protocol workgroup to
report that.)

Thanks,

Lukas
