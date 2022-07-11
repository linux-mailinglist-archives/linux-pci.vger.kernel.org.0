Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514EF570CF3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 23:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiGKVpe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 17:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGKVpe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 17:45:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C1A7AB19
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 14:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30907B810DF
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 21:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F60C34115;
        Mon, 11 Jul 2022 21:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657575931;
        bh=Xk+6fOvn5+xVVr6kA5iu3JK9z49lP9ub3141Bwi3uq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1AuTdH05cCZXa0eZG3QsakgtD12MUra4mQBf+i1dX/4csOhJs6N+boitic7qDHmp
         iS5vJ6YoX+MjYr40k8aIfo3NBG/Wm4pJ6TynXjKmZQ8D4dGvT36aDcaJ+FJ0QcAPjx
         VIihLQRsQrVJxaNrPLDgpJ4KQT0y8n/lUGxuBg1AqrMV5CxDs6MmFIx2/PHmYEf/KZ
         24uiI5Z70afUlmtQAvw9I6WSaYze2fkr7p/lhc+8TnjsAmzlqGj01nUl5JwAPWZol4
         6CHl8ADYffTaspgWC+V8zf0Zqjg4Ip5pdQxI2/2WD+5anzwBlTEcfRrojsmvBFOQOD
         wf7KZTYxn1cMg==
Date:   Mon, 11 Jul 2022 15:45:27 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Paul Luse <paul.e.luse@intel.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jing Liu <jing2.liu@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2] PCI: Add save and restore capability for TPH config
 space
Message-ID: <YsyZ97xKQ69OtKxl@kbusch-mbp>
References: <20220707154238.2536-1-paul.e.luse@intel.com>
 <YscuzThniuGE6qYW@kbusch-mbp.dhcp.thefacebook.com>
 <20220711201100.GA31003@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711201100.GA31003@wunner.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 11, 2022 at 10:11:00PM +0200, Lukas Wunner wrote:
> On Thu, Jul 07, 2022 at 01:06:53PM -0600, Keith Busch wrote:
> > On Thu, Jul 07, 2022 at 11:42:38AM -0400, Paul Luse wrote:
> > > +config PCIE_TPH
> > > +	bool "PCI TPH (Transaction Layer Packet Processing Hints) capability support"
> > > +	help
> > > +	  This enables PCI Express TPH (Transaction Layer Packet Processing Hints) by
> > > +	  making sure they are saved and restored across resets. Enable this if your
> > > +	  hardware uses the PCI Express TPH capabilities. For more information please
> > > +	  refer to PCIe r6.0 sec 6.17.
> > 
> > I'm not sure this needs a config option. Even if hardware isn't supporting TPH,
> > this state save code doesn't takes up much space, and saving this config
> > capability seems to always be the right thing if hardware is supporting TPH.
> 
> We recently had a complaint from Christoph Hellwig that DOE support
> should not "bloat every single kernel built with PCI support":
> 
> https://lore.kernel.org/linux-pci/YkVBJ+nRA2g%2FWDxa@infradead.org/
> 
> And OpenWRT folks once tried to make PCI quirks conditional on a
> config option to reduce kernel footprint by 12 kBytes on space-
> constrained Mips routers:
>
> https://lore.kernel.org/linux-pci/1482306784-29224-1-git-send-email-john@phrozen.org/
> 
> Paul has followed your advice and did away with the config option
> in his most recent version of the patch, but I'm not sure that's
> actually the right thing to do.  I don't think TPH is a mainstream
> PCIe feature and we need to cater to the needs of low-end devices
> with PCIe as well.

If the added code size from this is not negligable for any enviroment, then
okay, fair enough.

Paul, sorry for pointing you in the wrong direction.
