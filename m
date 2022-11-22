Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058386344E4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiKVTxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 14:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiKVTx2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 14:53:28 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E57EBFD;
        Tue, 22 Nov 2022 11:53:24 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id D3435300002A0;
        Tue, 22 Nov 2022 20:53:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C7CEAA2390; Tue, 22 Nov 2022 20:53:16 +0100 (CET)
Date:   Tue, 22 Nov 2022 20:53:16 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH V2 1/2] PCI/DOE: Remove the pci_doe_flush_mb() call
Message-ID: <20221122195316.GC20515@wunner.de>
References: <20221122155324.1878416-1-ira.weiny@intel.com>
 <20221122155324.1878416-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122155324.1878416-2-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 07:53:23AM -0800, ira.weiny@intel.com wrote:
> Each struct doe_mb is managed as part of the PCI device.  They can't go
> away as long as the PCI device exists.  pci_doe_flush_mb() was set up to
> flush the workqueue and prevent any further submissions to the mailboxes
> when the PCI device goes away.  Unfortunately, this was fundamentally
> flawed.  There was no guarantee that a struct doe_mb remained after
> pci_doe_flush_mb() returned.  Therefore, the doe_mb state could be
> invalid when those threads waiting on the workqueue were flushed.
> 
> Fortunately the current code is safe because all callers make a
> synchronous call to pci_doe_submit_task() and maintain a reference on the
> PCI device.
> 
> For these reasons, pci_doe_flush_mb() will never be called while tasks
> are being processed and there is no use for it.

Going forward my plan is to allocate all existing DOE mailboxes
of a device upon enumeration.  That will allow concurrent use
of a mailbox by multiple drivers.

When a pci_dev goes away, say, because it's been hot-removed,
we need a way to abort all ongoing DOE exchanges.

pci_doe_flush_mb() seems to do just that so I'm not sure why
it's being removed?

Thanks,

Lukas
