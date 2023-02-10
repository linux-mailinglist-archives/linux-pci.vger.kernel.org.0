Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2E06929C8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 23:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjBJWD7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 17:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjBJWD6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 17:03:58 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC55ACF0;
        Fri, 10 Feb 2023 14:03:57 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8D1932808FA25;
        Fri, 10 Feb 2023 23:03:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 75F1D571E6; Fri, 10 Feb 2023 23:03:53 +0100 (CET)
Date:   Fri, 10 Feb 2023 23:03:53 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 06/10] PCI/DOE: Allow mailbox creation without devres
 management
Message-ID: <20230210220353.GC15326@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
 <291131574c9e625195e9c34591abf5fa75cd1279.1674468099.git.lukas@wunner.de>
 <20230124121543.00002600@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124121543.00002600@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 24, 2023 at 12:15:43PM +0000, Jonathan Cameron wrote:
> On Mon, 23 Jan 2023 11:16:00 +0100 Lukas Wunner <lukas@wunner.de> wrote:
> > DOE mailbox creation is currently only possible through a devres-managed
> > API.  The lifetime of mailboxes thus ends with driver unbinding.
> > 
> > An upcoming commit will create DOE mailboxes upon device enumeration by
> > the PCI core.  Their lifetime shall not be limited by a driver.
> > 
> > Therefore rework pcim_doe_create_mb() into the non-devres-managed
> > pci_doe_create_mb().  Add pci_doe_destroy_mb() for mailbox destruction
> > on device removal.
[...]
> I'd like to understand why flushing in the tear down
> can't always be done as that makes the code more complex.

After sending out v2, I realized I had made a mistake:

In v2, on device removal I canceled any ongoing DOE exchanges
and declared the DOE mailbox dead before unbinding the driver
from a device.  That's the right thing to do for surprise removal
because you don't want to wait for an ongoing exchange to time out.

However we also have a code path for orderly device removal,
either via sysfs or by pressing the Attention Button (if present).
In that case, it should be legal for the driver to still perform
DOE exchanges in its ->remove() hook.

So in v3 I've changed the behavior to only cancel requests on
surprise removal.  By doing so, I was able to always flush on
mailbox destruction, as you've requested, and thereby simplify
the error paths.


> > +err_flush:
> > +	pci_doe_flush_mb(doe_mb);
> > +	xa_destroy(&doe_mb->prots);
> 
> Why the reorder wrt to the original devm managed cleanup?
> I'd expect this to happen on any error path after the xa_init.
> 
> It doesn't matter in practice because there isn't anything to
> do until after pci_doe_cache_protocols though.

Right, it's unnecessary to call xa_destroy() if
alloc_ordered_workqueue() failed because the xarray is still empty
at that point.  It doesn't need to be destroyed until it's been
populated by pci_doe_cache_protocols().

I've amended the commit message to explain that, but otherwise
did not change the code in v3.  Let me know if you have any
objections or feel strongly about moving xa_init().

Thanks,

Lukas
