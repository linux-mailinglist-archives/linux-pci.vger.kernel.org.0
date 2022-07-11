Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD55570B28
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 22:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiGKULE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 16:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGKULE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 16:11:04 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3600ADE80
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 13:11:02 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4C2282800C7FC;
        Mon, 11 Jul 2022 22:11:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3CB0C233686; Mon, 11 Jul 2022 22:11:00 +0200 (CEST)
Date:   Mon, 11 Jul 2022 22:11:00 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Paul Luse <paul.e.luse@intel.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jing Liu <jing2.liu@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2] PCI: Add save and restore capability for TPH config
 space
Message-ID: <20220711201100.GA31003@wunner.de>
References: <20220707154238.2536-1-paul.e.luse@intel.com>
 <YscuzThniuGE6qYW@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YscuzThniuGE6qYW@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 07, 2022 at 01:06:53PM -0600, Keith Busch wrote:
> On Thu, Jul 07, 2022 at 11:42:38AM -0400, Paul Luse wrote:
> > +config PCIE_TPH
> > +	bool "PCI TPH (Transaction Layer Packet Processing Hints) capability support"
> > +	help
> > +	  This enables PCI Express TPH (Transaction Layer Packet Processing Hints) by
> > +	  making sure they are saved and restored across resets. Enable this if your
> > +	  hardware uses the PCI Express TPH capabilities. For more information please
> > +	  refer to PCIe r6.0 sec 6.17.
> 
> I'm not sure this needs a config option. Even if hardware isn't supporting TPH,
> this state save code doesn't takes up much space, and saving this config
> capability seems to always be the right thing if hardware is supporting TPH.

We recently had a complaint from Christoph Hellwig that DOE support
should not "bloat every single kernel built with PCI support":

https://lore.kernel.org/linux-pci/YkVBJ+nRA2g%2FWDxa@infradead.org/

And OpenWRT folks once tried to make PCI quirks conditional on a
config option to reduce kernel footprint by 12 kBytes on space-
constrained Mips routers:

https://lore.kernel.org/linux-pci/1482306784-29224-1-git-send-email-john@phrozen.org/

Paul has followed your advice and did away with the config option
in his most recent version of the patch, but I'm not sure that's
actually the right thing to do.  I don't think TPH is a mainstream
PCIe feature and we need to cater to the needs of low-end devices
with PCIe as well.

Thanks,

Lukas
