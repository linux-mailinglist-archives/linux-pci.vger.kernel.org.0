Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981A37B3CB1
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 00:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjI2WpK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 18:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjI2WpJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 18:45:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECD8193
        for <linux-pci@vger.kernel.org>; Fri, 29 Sep 2023 15:45:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674D6C433C7;
        Fri, 29 Sep 2023 22:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696027507;
        bh=BCklHoXXN0rueUy/UxbEdUqXNCowGks0ac0yhpALZjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SqkEUlw/gTUYBKiafbKcFuGu8Ckujr4V9yl6IsAJZX23O2wF5KS3Gaj3s6Bil5QQb
         kr/slsKasSSYSFpepoy/8TEa89SfeWBH+1MTL8/Oi1G3lHqTLtw4cI+JqWaAaP2uaS
         ADiiMbGIasGXiC6ZMCS/Vo8U0o9wOpeBpfPDr+dr6H6XlBYH+gpViCBzS+pbLEaiZw
         6iQza//ijv5840ZIcFZY8yys6lEmOT0xzEFqiNUqYyN46pwzhdTB5p8nexjZPFVTg8
         7/8c/cDXOWCn7/X6wF7bmFQ8lR+BW2BLPO3CMDJrwgwT3I+1/+9YO2Z+CRfa4/A616
         krVh/0Hl5dBtA==
Date:   Fri, 29 Sep 2023 17:45:05 -0500
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
Message-ID: <20230929224505.GA559478@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921201945.GA343804@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thorsten]

On Thu, Sep 21, 2023 at 03:19:45PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 18, 2023 at 08:30:41AM +0300, Mika Westerberg wrote:
> > Mark Blakeney reported that when suspending system with a Thunderbolt
> > dock connected and then unplugging the dock before resume (which is
> > pretty normal flow with laptops), resuming takes long time.
> > ...

> > Fixes: e8b908146d44 ("PCI/PM: Increase wait time after resume")
> > Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217915
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Applied with Lukas' Reviewed-by to pm for v6.7.
> 
> e8b908146d44 appeared in v6.4.  Seems like maybe a candidate for
> stable?  IIUC, resume actually does work, but takes 65+ seconds longer
> than it should?

I moved this to for-linus for v6.6 and added a stable tag for v6.4+.

Bjorn
