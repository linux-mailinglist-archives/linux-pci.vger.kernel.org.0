Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3236A8A20
	for <lists+linux-pci@lfdr.de>; Thu,  2 Mar 2023 21:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCBUWw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Mar 2023 15:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBUWv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Mar 2023 15:22:51 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0D51F97;
        Thu,  2 Mar 2023 12:22:47 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B27DD300160F0;
        Thu,  2 Mar 2023 21:22:45 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A54443187D; Thu,  2 Mar 2023 21:22:45 +0100 (CET)
Date:   Thu, 2 Mar 2023 21:22:45 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 12/16] PCI/DOE: Create mailboxes on device enumeration
Message-ID: <20230302202245.GA14357@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
 <c3f9e24fffa318a045f89664fb9545099cb0d603.1676043318.git.lukas@wunner.de>
 <bc150b29-ee21-b033-7d05-dd28dd7a1af4@amd.com>
 <20230228054353.GA32202@wunner.de>
 <66ca8670-6bd2-a446-d393-3c327aa45ccc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ca8670-6bd2-a446-d393-3c327aa45ccc@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 28, 2023 at 06:24:41PM +1100, Alexey Kardashevskiy wrote:
> On 28/2/23 16:43, Lukas Wunner wrote:
> > On Tue, Feb 28, 2023 at 12:18:07PM +1100, Alexey Kardashevskiy wrote:
> > > On 11/2/23 07:25, Lukas Wunner wrote:
> > > > For the same reason a DOE instance cannot be shared between the
> > > > PCI core and a driver.
> > > 
> > > And we want this sharing why? Any example will do. Thanks,
> > 
> > The PCI core is going to perform CMA/SPDM authentication when a device
> > gets enumerated (PCIe r6.0 sec 6.31).  That's the main motivation
> > to lift DOE mailbox creation into the PCI core.  It's not mentioned
> > here explicitly because I want the patch to stand on its own.
> > CMA/SPDM support will be submitted separately.
> 
> I was going the opposite direction with avoiding adding this into the PCI
> core as 1) the pci_dev struct is already 2K  and 2) it is a niche feature
> and  3) I wanted this CMA/SPDM session setup to be platform specific as on
> our platform the SPDM support requires some devices to be probed before we
> can any SPDM.

We had an open discussion at Plumbers with stakeholders from various
companies and the consensus was that initially we'll upstream a CMA/SPDM
implementation which authenticates devices on enumeration and exposes
the result to user space via sysfs.  Nothing more, nothing less:

https://lpc.events/event/16/contributions/1304/
https://lpc.events/event/16/contributions/1304/attachments/1029/1974/LPC2022-SPDM-BoF-v4.pdf

Thereby we seek to minimize friction in the upstreaming process
because we avoid depending on PCIe features layered on top of
CMA/SPDM (such as IDE) and we can postpone controversial discussions
about the consequences of failed authentication (such as forbidding
driver binding or firewalling the device off via ACS).

The patches under development follow the approach we agreed on back then.

I honestly think that the size of struct pci_dev is a non-issue because
even the lowest-end IoT devices come with gigabytes of memory these days
and as long as we do not exceed PAGE_SIZE (which is the limit when we'd
have to switch from kmalloc() to vmalloc() I believe), there's no
problem.

The claim that DOE and CMA/SPDM is going to be a niche feature is at
least debatable.  It seems rather likely to me that we'll see adoption
particularly in the mobile segment as iOS/Android/Chrome promulgators
will see an opportunity to harden their products further.

It's intriguing that you need some devices to be probed before you
can perform authentication.  What do you need this for?

Do you perhaps need to load firmware onto the device before you can
authenticate it?  Doesn't that defeat the whole point of authentication?

Or do you mean that certain *other* devices need to probe before a device
can be authenticated?  What are these other devices?

What happens if the device is suspended to D3cold or experiences a
Conventional Reset?  Do you need to do anything special before you
can re-authenticate the device?

On the one hand, performing authentication in the PCI core could be
considered a case of midlayer fallacy.  On the other hand, I think we
do want to afford CMA/SPDM and the features layered on top of it
(IDE, TDISP) regardless whether a driver is bound:  That way we can
protect the PCI core's communication with the device and with ACS
we can protect other PCI devices in the system from peer-to-peer
communication originating from a malicious device which failed to
authenticate.

I would like to make the implementation under development work for
your use case as well, but to do that I need a better understanding
what your requirements are.

Thanks,

Lukas
