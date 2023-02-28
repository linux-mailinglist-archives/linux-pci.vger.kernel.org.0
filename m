Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0376A52B0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 06:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjB1Fn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 00:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1Fn5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 00:43:57 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0906D1A4B8;
        Mon, 27 Feb 2023 21:43:54 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4F8AB102F1753;
        Tue, 28 Feb 2023 06:43:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 213C938176; Tue, 28 Feb 2023 06:43:53 +0100 (CET)
Date:   Tue, 28 Feb 2023 06:43:53 +0100
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
Message-ID: <20230228054353.GA32202@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
 <c3f9e24fffa318a045f89664fb9545099cb0d603.1676043318.git.lukas@wunner.de>
 <bc150b29-ee21-b033-7d05-dd28dd7a1af4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc150b29-ee21-b033-7d05-dd28dd7a1af4@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 28, 2023 at 12:18:07PM +1100, Alexey Kardashevskiy wrote:
> On 11/2/23 07:25, Lukas Wunner wrote:
> > For the same reason a DOE instance cannot be shared between the PCI core
> > and a driver.
> 
> And we want this sharing why? Any example will do. Thanks,

The PCI core is going to perform CMA/SPDM authentication when a device
gets enumerated (PCIe r6.0 sec 6.31).  That's the main motivation
to lift DOE mailbox creation into the PCI core.  It's not mentioned
here explicitly because I want the patch to stand on its own.
CMA/SPDM support will be submitted separately.

A driver that later on gets bound to the device should be allowed
to talk to it via DOE as well, possibly even sharing the same DOE
mailboxes used by the PCI core.

Patches for CMA/SPDM are under development on this branch:

https://github.com/l1k/linux/commits/doe


> > Currently a DOE instance cannot be shared by multiple drivers because
> > each driver creates its own pci_doe_mb struct for a given DOE instance.
> 
> Sorry for my ignorance but why/how/when would a device have multiple drivers
> bound? Or it only one driver at the time but we also want DOE MBs to survive
> switching to another (different or newer) driver?

Conceivably, a driver may have the need to talk to multiple devices
via DOE, even ones it's not bound to.  (E.g. devices in its ancestry
or children.)

Thanks,

Lukas
