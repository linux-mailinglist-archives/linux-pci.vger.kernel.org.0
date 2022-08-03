Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6395885D9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 04:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiHCCij (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 22:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiHCCii (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 22:38:38 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 806FABC83
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 19:38:37 -0700 (PDT)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2732WBcd017473;
        Tue, 2 Aug 2022 21:32:12 -0500
Message-ID: <4a1ea48b5a3807e00df1342932daa76fa313afef.camel@kernel.crashing.org>
Subject: Re: [EXTERNAL]arm64 PCI resource allocation issue
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     David Woodhouse <dwmw2@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Robin Murphy <robin.murphy@arm.com>
Date:   Wed, 03 Aug 2022 12:32:11 +1000
In-Reply-To: <d7328d63126096be3d631d013b02c30bbdd1524a.camel@infradead.org>
References: <204dda77248a7c95787e27fc7a382f514341c88e.camel@kernel.crashing.org>
         <CAMj1kXFWN80TENuP-0E09LEqrqqL2zoS3SDCeQE7aMZuBPA53Q@mail.gmail.com>
         <d7328d63126096be3d631d013b02c30bbdd1524a.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2022-08-02 at 10:18 +0100, David Woodhouse wrote:
> On Tue, 2022-08-02 at 09:46 +0200, Ard Biesheuvel wrote:
> > > If we want this, I would propose (happy to provide the implementation
> > > but let's discuss the design first) something along the line of a
> > > generic mechanism to "register" such a system device, which would add
> > > it to a list. That list would be scanned on PCI device discovery for
> > > BAR address matches, and the pci_dev/BAR# added to the entry (that or
> > > put a pointer to the entry into pci_dev for speed/efficiency).
> > 
> > This means that bus numbers cannot be reassigned, which I don't think
> > we rely on today. To positively identify a PCI device, you'll need
> > some kind of path notation to avoid relying on the bus numbers
> > assigned by the firmware (this could happen for hot-pluggable root
> > ports where no bus range has been reserved by the firmware)
> 
> That kind of path notation already exists for the Intel IOMMU, and
> probably others. See dmar_match_pci_path(), dmar_pci_bus_add_dev() etc.
> 
> It would be good to lift that out and make it generic, rather than
> reinventing another version.

I think this is a completely orthogonal issue to what I'm trying to
solve. I don't think we actually have a problem with bus numbers
changing (see my other response).

Yes, bus-number-agnostic PCI paths have been a thing for a long time in
device-tree land :)

Cheers,
Ben.

