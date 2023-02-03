Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC816894C6
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 11:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjBCKIZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 05:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjBCKIY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 05:08:24 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4808BDE5;
        Fri,  3 Feb 2023 02:08:23 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6756D28011B82;
        Fri,  3 Feb 2023 11:08:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 455342E9C9A; Fri,  3 Feb 2023 11:08:21 +0100 (CET)
Date:   Fri, 3 Feb 2023 11:08:21 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Li, Ming" <ming4.li@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 06/10] PCI/DOE: Allow mailbox creation without devres
 management
Message-ID: <20230203100821.GB18459@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
 <291131574c9e625195e9c34591abf5fa75cd1279.1674468099.git.lukas@wunner.de>
 <20230124121543.00002600@Huawei.com>
 <d6d3a6c8-7b82-77c2-3407-705916c020b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d3a6c8-7b82-77c2-3407-705916c020b7@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 03, 2023 at 05:06:21PM +0800, Li, Ming wrote:
> On 1/24/2023 8:15 PM, Jonathan Cameron wrote:
> > On Mon, 23 Jan 2023 11:16:00 +0100 Lukas Wunner <lukas@wunner.de> wrote:
> > > +/**
> > > + * pci_doe_destroy_mb() - Destroy a DOE mailbox object
> > > + *
> > > + * @ptr: Pointer to DOE mailbox
> > > + *
> > > + * Destroy all internal data structures created for the DOE mailbox.
> > > + */
> > > +static void pci_doe_destroy_mb(void *ptr)
> 
> I don't get why uses "void *ptr" as the parameter of this function,
> maybe I miss something. I guess we can use "struct pci_doe_mb *doe_mb"
> as the parameter.

It's a "void *ptr" argument so that pci_doe_destroy_mb() can serve
as a callback for devm_add_action().  But as you've correctly noted,
devm_add_action() is removed in a subsequent commit and then the
argument is adjusted to "struct pci_doe_mb *doe_mb".

Thanks,

Lukas
