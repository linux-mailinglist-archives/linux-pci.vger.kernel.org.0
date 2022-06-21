Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A00A553AA9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 21:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354025AbiFUTee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 15:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354022AbiFUTed (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 15:34:33 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D523220F70;
        Tue, 21 Jun 2022 12:34:32 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 82EDA2800B3C7;
        Tue, 21 Jun 2022 21:34:27 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6B9162732F7; Tue, 21 Jun 2022 21:34:27 +0200 (CEST)
Date:   Tue, 21 Jun 2022 21:34:27 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     ira.weiny@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V11 5/8] cxl/port: Read CDAT table
Message-ID: <20220621193427.GA25003@wunner.de>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-6-ira.weiny@intel.com>
 <62ad1fb69d742_8920729490@dwillia2-xfh.notmuch>
 <62b2178bdcf5d_89207294ac@dwillia2-xfh.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62b2178bdcf5d_89207294ac@dwillia2-xfh.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 12:10:03PM -0700, Dan Williams wrote:
> It is really the interrupt setup that makes this an awkward fit all
> around. The PCI core knows how to handle capabilities with interrupts,
> but only for PCIe port services. DOE is both a PCIe port service *and*
> and "endpoint service" like VPD (pci_vpd_init()). The more I think about
> this the closer I get to the recommendation from Lukas which is that
> DOE is more like pci_vpd_init() than pci_aer_init(), or a custom
> enabling per driver.
> 
> If the DOE enumeration moves to a sub-function of
> pci_init_capabilities() then the cxl_pci and/or cxl_port drivers just
> look those up and use them. The DOE instances would remain in polled
> mode unless and until a PCI driver added interrupt support late. In
> other words, DOE can follow the VPD init model as long as interrupts are
> not involved, and if interrupts are desired it requires late allocation
> of IRQ vectors.

Thomas Gleixner has been working on dynamic allocation of MSI-X vectors.
We should probably just build on that and let the PCI core allocate
vectors for DOE mailboxes independently from drivers.

To conserve vectors, I'd delay allocation for a DOE mailbox until
it is first used.  There may be mailboxes that are never used.

DOE requires MSI-X or MSI.  We could probably leave MSI unsupported
until a device with broken MSI-X support shows up.  I envision that
with MSI, the onus is on the driver to allocate vectors for mailboxes
it intends to use and it would then have to "donate" those vectors
to the PCI core via a library function.

As for portdrv, that's a driver but Bjorn has expressed a desire
for a long time to move its functionality into the PCI core.
It shouldn't be allowed to unbind portdrv via sysfs and thus break
DPC etc, as is currently possible.

The question with regards to this series is, do we get *something*
merged and perfect it over time once it's in the tree, or do we
keep iterating on the mailing list.  I deliberately only provided
a single, comprehensive review and then stayed mum because I feel
bad for Ira having to keep reacting to more and more feedback
despite being at v11 already (or v12?  I've lost count).
Particularly because I suspect (I might be mistaken) that Ira's
natural habitat is actually CXL not PCI, so it might be a burden for him.
I'd be fine to implement suggestions I've made myself after Ira's
series lands.  No need for him to keep iterating ad infinitum.

Thanks,

Lukas
