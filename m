Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3397AB249
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 14:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjIVMlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 08:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjIVMlU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 08:41:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C655C100
        for <linux-pci@vger.kernel.org>; Fri, 22 Sep 2023 05:41:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447FCC433C7;
        Fri, 22 Sep 2023 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695386474;
        bh=o981hDS7boSSAHOMgEtRmQK8NTyJ2mzVB2lvrCJEtR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bIHVp0RjEj5J4nFDoUIH19EJFZ6dwPLt3bU4Zuhs/7MlUorn1XcLH1U1ajCT2C9Kd
         I3AhZYdMmQUNYXxS7Eg4KH/VI597uWwHw+rRDRDDhuPc976lCwI7wupibt5hGha5YO
         e4wgnoN5QMsOxP4TpBQ0uxGIiiKx5s9pk52XTcgAXkgR8DEkcmVTF75xLXgbVclyGk
         ds4S27VCPZ/YPOCkusGVdLZEtkjV/6+PEn+efaEXu3ghRq1AK7BNgDTbmmaDbWs+Us
         LDWkCsTO2L/Pf8mpPW3PM8z0ZqFMKBQy86pk15Duw9Ce9SheUu6FbFT8xkybzmop3+
         meWOmvEL1lzdA==
Date:   Fri, 22 Sep 2023 07:41:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Kamil Paral <kparal@redhat.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH] PCI/PM: Mark devices disconnected if their upstream PCIe
 link is down on resume
Message-ID: <20230922124112.GA367772@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785cbc11-3d85-4551-8290-0ca31e9be77e@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 22, 2023 at 01:45:58PM +0200, Thorsten Leemhuis wrote:
> On 21.09.23 22:19, Bjorn Helgaas wrote:
> > On Mon, Sep 18, 2023 at 08:30:41AM +0300, Mika Westerberg wrote:
> >> Mark Blakeney reported that when suspending system with a Thunderbolt
> >> dock connected and then unplugging the dock before resume (which is
> >> pretty normal flow with laptops), resuming takes long time.
> >>
> >> What happens is that the PCIe link from the root port to the PCIe switch
> >> inside the Thunderbolt device does not train (as expected, the link is
> >> upplugged):
> > [...]
> >> Fixes: e8b908146d44 ("PCI/PM: Increase wait time after resume")
> >> Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217915
> >> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Applied with Lukas' Reviewed-by to pm for v6.7.
> >
> > e8b908146d44 appeared in v6.4. 
> 
> Then why did you apply this for 6.7 and not to a branch targeting the
> current cycle? Linus wants regression introduced during round about the
> last 12 months to be handled liked regressions from the current cycle,

I was not aware of the last 12 months rule.  Happy to change if that's
the guideline.  My previous rule of thumb was: fixes for regressions
in the most recent merge window always go to current cycle, fixes for
older regressions case-by-case.

Bjorn
