Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83B155227F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiFTQw3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 12:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiFTQw3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 12:52:29 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C40A17E06;
        Mon, 20 Jun 2022 09:52:21 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id CF726300002A0;
        Mon, 20 Jun 2022 18:52:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C515211797C; Mon, 20 Jun 2022 18:52:17 +0200 (CEST)
Date:   Mon, 20 Jun 2022 18:52:17 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "ben@bwidawsk.net" <ben@bwidawsk.net>, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, "Box, David E" <david.e.box@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: (SPDM) Device attestation, secure channels from host to device
 etc: Discuss at Plumbers?
Message-ID: <20220620165217.GA18451@wunner.de>
References: <20220609124702.000037b0@Huawei.com>
 <YqICCSd/6Vxidu+v@iweiny-desk3>
 <20220617112124.00002296@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617112124.00002296@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 11:21:24AM +0100, Jonathan Cameron wrote:
> On Thu, 9 Jun 2022 07:22:01 -0700 Ira Weiny <ira.weiny@intel.com> wrote:
> > On Thu, Jun 09, 2022 at 12:47:02PM +0100, Jonathan Cameron wrote:
> > > I'll start by saying I haven't moved forward much with the
> > > SPDM/CMA over Data Object Exchange proposal from the PoC that led to
> > > presenting it last year as part of the PCI etc uconf last year.
> > > https://lpc.events/event/11/contributions/1089/
> > > https://lore.kernel.org/all/20220303135905.10420-1-Jonathan.Cameron@huawei.com/
> > > I'm continuing to carry the QEMU emulation but not posted for a while
> > > as we are slowly working through a backlog of CXL stuff to merge.

So the SDPM series you posted in March is the latest version?

If you lack bandwidth to carry on with it, I would pick up the baton
and rework that version based on the review feedback I've posted.
(Unless someone else is eager to do that.)


> > Yes, while this could work as part of the CXL uconf it is probably a more
> > general topic.
> 
> Maybe steal time from PCI given CXL uconf is going to be busy!
> (lets see if any of the PCI folk are reading this thread.. :)
> 
> At the moment I'm not seeing enough interest to put in a proposal for
> anything 'officially scheduled', but there is a bit more time until
> the deadline so let's see if we get any other interest in that time.

How about a BoF session to discuss the status quo and any open issues?

(I'm not involved with CXL, hence probably belong to "PCI folk".)


> > I [...] was hoping to go in person but I'm unsure of travel budgets.
> > I will likely be virtual if I can't attend in person.

Same.

Thanks,

Lukas
