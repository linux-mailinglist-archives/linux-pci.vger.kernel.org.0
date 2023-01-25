Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0C067BDEB
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 22:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbjAYVPV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 16:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbjAYVPS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 16:15:18 -0500
X-Greylist: delayed 608 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Jan 2023 13:15:13 PST
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3E5241D3;
        Wed, 25 Jan 2023 13:15:13 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id B3F252800C90C;
        Wed, 25 Jan 2023 22:05:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9AF3A1AFD9E; Wed, 25 Jan 2023 22:05:01 +0100 (CET)
Date:   Wed, 25 Jan 2023 22:05:01 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 01/10] PCI/DOE: Silence WARN splat with
 CONFIG_DEBUG_OBJECTS=y
Message-ID: <20230125210501.GA13856@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
 <cc4b61809e2520d835cf3d4f62e7d5ed00a9d031.1674468099.git.lukas@wunner.de>
 <63cf276083fe1_4a9a29468@iweiny-mobl.notmuch>
 <20230124103208.00000675@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124103208.00000675@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 24, 2023 at 10:32:08AM +0000, Jonathan Cameron wrote:
> On Mon, 23 Jan 2023 16:33:36 -0800 Ira Weiny <ira.weiny@intel.com> wrote:
> > Lukas Wunner wrote:
> > > Gregory Price reports a WARN splat with CONFIG_DEBUG_OBJECTS=y upon CXL
> > > probing because pci_doe_submit_task() invokes INIT_WORK() instead of
> > > INIT_WORK_ONSTACK() for a work_struct that was allocated on the stack.
> > > 
> > > All callers of pci_doe_submit_task() allocate the work_struct on the
> > > stack, so replace INIT_WORK() with INIT_WORK_ONSTACK() as a backportable
> > > short-term fix.
[...]
> It's an unusual requirement, but this is indeed the minimal fix
> given current users.  Obviously becomes more sensible later in the
> series once you make the API synchronous only.

Okay, I'll amend the commit message as follows when respinning
to make more obvious what's being done here:

    The long-term fix implemented by a subsequent commit is to move to a
    synchronous API which allocates the work_struct internally in the DOE
    library.

Thanks,

Lukas
