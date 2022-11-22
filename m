Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692BF6344D5
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 20:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiKVTsi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 14:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiKVTsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 14:48:37 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3565E3F0;
        Tue, 22 Nov 2022 11:48:32 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 59DE42800B6EB;
        Tue, 22 Nov 2022 20:48:29 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4D2C5A3DD6; Tue, 22 Nov 2022 20:48:29 +0100 (CET)
Date:   Tue, 22 Nov 2022 20:48:29 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming4" <ming4.li@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
Message-ID: <20221122194829.GB20515@wunner.de>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
 <IA1PR11MB6171B27750AB469AFE47CD5E890A9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20221121110714.0000720a@Huawei.com>
 <IA1PR11MB6171444A263C4ABB216FF1F5890A9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20221121174148.0000647d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121174148.0000647d@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 05:41:48PM +0000, Jonathan Cameron wrote:
> On Mon, 21 Nov 2022 14:17:37 +0000 "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com> wrote:
> > It's good that this potential issue has been noticed. I think moving
> > the 'find' logic and the xarray from CXL to the PCI core should save
> > a lot of such duplicated works for other drivers using DOE.
> > 
> > One more though:
> > For a driver, I think it's only interested in getting a DOE mailbox
> > from a PCI device with specified VID+protocol and using it.
> > The driver doesn't care how is the DOE mailbox instance created and
> > the driver also doesn't want to maintain it.

Totally agree on all of your above points Qiuxu.


> > After using the DOE mailbox instance then the driver puts it back.

That won't be necessary I think.  The PCI core allocates all existing
DOE mailboxes and enumerates the supported protocols.  Drivers just
ask the PCI core for a mailbox supporting a specific protocol and
are free to use that as long as the PCI device exists.


> There is also a dance around interrupts (once those are supported
> for DOEs in general).  Until the PCI driver has requested interrupts
> we can't use them for DOE, but we may want to poll it before that
> stage then switch over.

Thomas Gleixner has returned to his patch sets for dynamic MSI-X
allocation.  We'll be able to leverage that to request an interrupt
in the PCI core for DOE before a driver is bound.  And a driver
can then get additional MSI-X vectors if needed.  Will only work
for MSI-X though, not MSI.

Thanks,

Lukas
