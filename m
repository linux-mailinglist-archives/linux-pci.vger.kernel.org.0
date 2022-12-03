Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A7F641722
	for <lists+linux-pci@lfdr.de>; Sat,  3 Dec 2022 14:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiLCNvy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Dec 2022 08:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiLCNvy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Dec 2022 08:51:54 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68402656F;
        Sat,  3 Dec 2022 05:51:52 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D54962800B4BF;
        Sat,  3 Dec 2022 14:51:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C9F2C4A8C8; Sat,  3 Dec 2022 14:51:50 +0100 (CET)
Date:   Sat, 3 Dec 2022 14:51:50 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/DOE: Provide synchronous API
Message-ID: <20221203135150.GA22097@wunner.de>
References: <cover.1669608950.git.lukas@wunner.de>
 <7ced46eaf68bed71b6414a93ac41f26cfd54a991.1669608950.git.lukas@wunner.de>
 <20221130153330.000049b3@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130153330.000049b3@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 30, 2022 at 03:33:30PM +0000, Jonathan Cameron wrote:
> On Mon, 28 Nov 2022 05:25:52 +0100 Lukas Wunner <lukas@wunner.de> wrote:
> > + * NOTE there is no need for the caller to initialize work or doe_mb.
> 
> Cut and paste from original, but what's the "caller" of a struct? I'd just
> drop this NOTE as it's better explained below.

Okay, will drop this note when respinning, it just duplicates the
code comment inside the pci_doe_task declaration.


> >  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> >  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > +int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
> 
> Whilst there is clearly a verb hidden in that doe, the fact that the
> whole spec section is called the same is confusing.
> 
> pci_doe_query_response() maybe or pci_doe_do() perhaps?

Going forward the PCI core will allocate DOE mailboxes on device
enumeration.  And the API will then consist of just two calls:

One call to get a pointer to a pci_doe_mb for a (pci_dev, vendor, protocol)
triple which I intend to call pci_find_doe_mailbox().

And one call to perform a synchronous query/response over a pci_doe_mb.
That's the pci_doe() I'm introducing here.

I initially went for pci_doe_exchange(), then realized that the "e" in
"doe" already stands for "exchange", so that would be redundant.

We generally try to use the same terms as the PCIe Base Spec to make it
easy for an uninitiated reader to connect the spec to the implementation.
The spec talks about "performing data object exchanges", but
pci_doe_perform() didn't seem very appealing to me.

I ended up just using pci_doe() for simplicity and because it makes it
easy to stay within 80 chars if the function name is short.

Passing in the request and response pointers directly instead of
populating a struct is likewise an attempt to make things as simple
as possible for driver authors.  It's modeled after the SPI and I2C
APIs which offer similar primitives to perform read/write exchanges
with devices.

(Side note: pci_find_doe_mailbox() will return the *first* mailbox found
for a given (pci_dev, vendor, protocol) triple.  Conceivably, there may
be devices with multiple mailboxes supporting the same protocols.  We may
have to add a pci_find_next_doe_mailbox(), should such devices appear.
Those names match what we already have for capabilities, i.e.
pci_find_ext_capability() and pci_find_next_ext_capability().)

Thanks,

Lukas
