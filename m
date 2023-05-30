Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34B77170AF
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 00:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjE3W13 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjE3W12 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 18:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AE497;
        Tue, 30 May 2023 15:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E559F62CB1;
        Tue, 30 May 2023 22:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF59C4339B;
        Tue, 30 May 2023 22:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685485646;
        bh=cheXLQ8vzvhg3HHlEbp/nhH1v4qNXPvIuztE6YHAz8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LxJm7SB497PbN+6xSXHmc2pTJhHae0WzBcbxOtTgG3MRSh9p1dfYBRfUdQy7AyVRQ
         1IezZSWPhIKD7XbfWiql8Plc+Ulv9e2XMV0Y9YzU+8zsQuv6SFrhqDkS6x4c+oZDWP
         /L5OMnL+JMkyqRiQ4gYXhKTcO9jwWh5H7cLBy4aVIEnsrJ+3/NVsL0WDcE29kmRv45
         38YRs0n+sv7VZwRllWBofAEQUQjc9UG0Jen3unekyfBRKw8j9GtCbYz+A/LwtVrVsM
         vh/qbXD8fYjZaPnWr4d5573Wuyg+udrUB5D3tqXZmXDnOdKQv+rhIf4g6OnEvx+oIF
         cwQuZSAvQLzsA==
Date:   Tue, 30 May 2023 17:27:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH pci] PCI: don't skip probing entire device if first fn OF
 node has status = "disabled"
Message-ID: <ZHZ4TFjFLrKeHPGi@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530220436.fooxifm47irxqlrj@skbuf>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 31, 2023 at 01:04:36AM +0300, Vladimir Oltean wrote:
> On Tue, May 30, 2023 at 04:58:55PM -0500, Bjorn Helgaas wrote:
> > Can you write this description in terms of PCI topology?  The
> > nitty-gritty SERDES details are not relevant at this level, except to
> > say that Function 0 is present in some cases but not others, and when
> > it is not present, *other* functions may be present.
> 
> No. It is to say that within the device, all PCIe functions (including 0)
> are always available and have the same number, but depending on SERDES
> configuration, their PCIe presence might be practically useful or not.
> So that's how function 0 may end having status = "disabled" in the
> device tree.
>
> > Sigh.  Per spec (PCIe r6.0, sec 7.5.1.1.9), software is not permitted
> > to probe for Functions other than 0 unless "explicitly indicated by
> > another mechanism, such as an ARI or SR-IOV Capability."
> > 
> > Does it "work" to probe when the spec prohibits it?  Probably.  Does
> > it lead to some breakage elsewhere eventually?  Quite possibly.  They
> > didn't put "software must not probe" in the spec just to make
> > enumeration faster.
> > 
> > So I'm a little grumpy about further complicating this already messy
> > path just to accommodate a new non-compliant SoC.  Everybody pays the
> > price of understanding all this stuff, and it doesn't seem in balance.
> > 
> > Can you take advantage of some existing mechanism like
> > PCI_SCAN_ALL_PCIE_DEVS or hypervisor_isolated_pci_functions() (which
> > could be renamed and made more general)?
> 
> Not responding yet to the rest of the email since it's not clear to me
> that you've understood function 0 is absolutely present and responds
> to all config space accesses - it's just disabled in the device tree
> because the user doesn't have something useful to do with it.

Ah, you're right, sorry I missed that.  Dispensing with the SERDES
details would make this more obvious.

Not sure why this needs to change the pci_scan_slot() path, since
Function 0 is present and enumerable even though it's not useful in
some cases.  Seems like something in pci_set_of_node() or a quirk
could do whatever you need to do.

Bjorn
