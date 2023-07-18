Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984BD75878D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 23:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGRV6k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 17:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGRV6j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 17:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C4C198D;
        Tue, 18 Jul 2023 14:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B36B60DC4;
        Tue, 18 Jul 2023 21:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBA9C433C8;
        Tue, 18 Jul 2023 21:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689717517;
        bh=hYKF8TnPc/PXhF/gvhdZibUWwFyVjiAJxCWDMaFDQ9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KKVKXMCnNwoKRubaOUZ88eDWdCJi3WH/TRbZznj1rmXZ7jN5L2VxgVzjBCrnXxgP7
         xp8L1Er0CninuX4Y5bbMkRw2hGAmU9EGzfMKEXFqTPb2o21sclEmcOWscUxSb9dqAs
         w9Pn77JG9HNJg7FVWp8Ruv9OYeij3Zc/SFFF9GZrR/lz/VCM2obgx/SFlr2DE2t8Ji
         /ZqUPfmAYpfvKRLZC857MS51jwmX5uFzjAbsyhxHWYweAtUsBr/LAatn8owQtUHmmj
         UhkbfzcrBHdLOGqi4iOn4hKxebDwqsb0kiTkmGqM/apDzYDnZhIjyj5B0hzwyyAANu
         fjXvEYDpvzryw==
Date:   Tue, 18 Jul 2023 16:58:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] PCI: Handle HAS_IOPORT dependencies
Message-ID: <20230718215835.GA496612@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718211224.GA494538@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 04:12:24PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 03, 2023 at 08:02:40PM +0200, Niklas Schnelle wrote:
> > On Mon, 2023-07-03 at 12:42 -0500, Bjorn Helgaas wrote:
> > > On Mon, Jul 03, 2023 at 03:52:53PM +0200, Niklas Schnelle wrote:
> > > > Hi Bjorn,
> > > > 
> > > > This is a follow up to my ongoing effort of making the inb()/outb() and
> > > > similar I/O port accessors compile-time optional. Previously I sent this as
> > > > a complete treewide series titled "treewide: Remove I/O port accessors for
> > > > HAS_IOPORT=n" with the latest being its 5th version[0]. Now about half of
> > > > the per-subsystem patches have been merged so I'm changing over to stand
> > > > alone subsystem patches. These series are stand alone and should be merged
> > > > via the relevant tree such that with all subsystems complete we can follow
> > > > this up with the last patch[1] that will make the I/O port accessors
> > > > compile-time optional.
> > > 
> > > Is the merge plan for each subsystem to merge this separately?  I
> > > acked these so they could be merged along with all the tree-wide
> > > changes.
> > 
> > Hi Björn,
> > 
> > Yeah this went back and forth a little, sorry about that. With the
> > Kconfig introduction of HAS_IOPORT merged about half of the original
> > patches have been merged via subsystem maintainers or are at least
> > sitting in linux-next already.  Arnd was anticipating that he'll pick
> > up some left overs but at the moment the simplest is for subsystems to
> > pick the patches up themselves ideally and if small enough for v6.5
> > still.
> 
> I didn't merge these in time for the v6.5 merge window.  If you want
> these in v6.5, it's fine with me, and it would probably make more
> sense for you to bundle them with any other leftovers.
> 
> Otherwise, let me know and I'm happy to queue them for v6.6.

I provisionally put these on pci/ioport for v6.6.  If you pick them up
for v6.5, let me know and I'll just drop that branch.

Bjorn
