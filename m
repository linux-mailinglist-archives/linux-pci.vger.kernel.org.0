Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3453E7AB27B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjIVM7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjIVM7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 08:59:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1039F1
        for <linux-pci@vger.kernel.org>; Fri, 22 Sep 2023 05:59:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390D1C433C8;
        Fri, 22 Sep 2023 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695387568;
        bh=kwyAJQNHj1NS84ixF3JLjE69QC32s7Oo3CPdX6//pig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=saxCTItPZ+XsmvyNORlBi060U6OjckBMhUIbfSpm2f0TtVaK9esvD/24zF/jsgmdH
         cnLh2SOYrb8O+I7I2Vh/qLDAXsZ478q9i1I+yZAuM1TP5HQmFZrjqH3pAXy8if4nR4
         7oXCFaptt3G3ZhOFpOP9SnfVg7lV7nol8RTX7F9rUYe2tIw3g2EP5oSJtsZ23eU1Bi
         pWSy5ucaLnbpCa7OiKsTPuaBdPlr3GQM8jiIYZpc/qMzc9QzapW5W9jFarNZjBqelM
         u2YhKq2ssjagq1git69uwdm4RKRIG2WtwH/Salytr7aoRiP2dReNgPsFcXVkZqMRGT
         GTVUz/hXcVdAw==
Date:   Fri, 22 Sep 2023 07:59:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Kamil Paral <kparal@redhat.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] PCI/PM: Mark devices disconnected if their upstream PCIe
 link is down on resume
Message-ID: <20230922125926.GA367919@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922044237.GC3208943@black.fi.intel.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thorsten]

On Fri, Sep 22, 2023 at 07:42:37AM +0300, Mika Westerberg wrote:
> On Thu, Sep 21, 2023 at 03:19:45PM -0500, Bjorn Helgaas wrote:
> > On Mon, Sep 18, 2023 at 08:30:41AM +0300, Mika Westerberg wrote:
> ...

> > Kamil also bisected a 60+ second resume delay to e8b908146d44
> > (https://lore.kernel.org/r/CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com),
> > but IIUC at
> > https://lore.kernel.org/linux-pci/20230824114300.GU3465@black.fi.intel.com/T/#u
> > you concluded that Kamil's issue was related to firmware and actually
> > had nothing to do with e8b908146d44.
> > 
> > Do you still think Kamil's issue is unrelated to e8b908146d44 and this
> > patch?  If so, how do we handle Kamil's issue?  An answer like "users
> > of v6.4+ must upgrade their Thunderbolt firmware" seems like it would
> > be kind of a nightmare for users.
> 
> It's a different issue. What happens in his system is that the link went
> down even though the dock was still connected and this should not happen
> (the firmware should bring the link up during resume). The delay was
> just a "symptom".

Do you have any leads for Kamil's issue?  If we had known that
e8b908146d44 would cause that problem, we never would have applied it
in the first place.

No OS would accept that resume delay, so there must be some way to fix
that in the OS without requiring a firmware update.

If Kamil's issue is that firmware doesn't bring up the link during
resume, how *does* the link get brought up, and what does the delay
have to do with it?

Bjorn
