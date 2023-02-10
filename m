Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03E669297B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 22:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjBJVrM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 16:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjBJVrL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 16:47:11 -0500
X-Greylist: delayed 470 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Feb 2023 13:47:10 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCEA1554F;
        Fri, 10 Feb 2023 13:47:09 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2837D10333602;
        Fri, 10 Feb 2023 22:39:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E744E2D938; Fri, 10 Feb 2023 22:39:15 +0100 (CET)
Date:   Fri, 10 Feb 2023 22:39:15 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
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
Subject: Re: [PATCH v2 00/10] Collection of DOE material
Message-ID: <20230210213915.GA15326@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
 <20230123223053.GA994135@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123223053.GA994135@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 04:30:53PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 23, 2023 at 11:10:00AM +0100, Lukas Wunner wrote:
> > Collection of DOE material, v2:
> 
> Do you envision getting acks from the CXL folks and
> merging via the PCI tree, or the reverse?

I do not have a strong preference myself.

I've just submitted v3 and based that on pci/next.

The patches apply equally well to cxl/next, save for a trivial conflict
in patch [13/16] due to a context change in drivers/cxl/cxlmem.h.
(I'm removing "struct xarray doe_mbs" and an adjacent new line was
added in cxl/next for "struct cxl_event_state event".)

I recognize that it might be too late to squeeze the full series into 6.3.
However, the first 6 patches are fixes tagged for stable, so at least
those should still be fine for 6.3.

I believe Dave Jiang is basing his in-kernel CDAT parsing on this series,
hence needs it merged during the next cycle.  So if you do not want to
apply the full series for 6.3, then the last 10 patches should probably
be picked up by Dan for 6.4 early during the next cycle in support of
Dave.

All of those ruminations are moot of couse if there are objections
requiring another respin.

Dan, what do you think?

Thanks,

Lukas
