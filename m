Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5456468DF37
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 18:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjBGRr2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 12:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjBGRr1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 12:47:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F571BC3
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 09:47:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A34E60F71
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 17:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8864AC433EF;
        Tue,  7 Feb 2023 17:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675792045;
        bh=11u+DVYDcn1Cg1TcJ6WdzcaumYQTfeYPs76gTT7V1RQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AAyACOyrEx2Q/KJ8srnGdOuPnGt2C/TsPpT7jPMEusW7aYFWXTA7lzK5e22hZLqXv
         hych1BBA9rCPoJC45t7AEI3d3rfYw6zzXSu4+o6wgZF4laA94w1fJrcObbE+TZRF2x
         UGyGCWGuUn1JbnUP0/wQmHUbk3If7DZBwK0DgOdomgauBTwKYj1zHVw3B9uKpie1Eq
         ccT2uZsmbMZFcaKSH5P+NGsBR/w4dBL19rprjNUzyQojdgksEjCknzCabEgye330g4
         3BtR0ocQSM1ETMkYN4WYI1KR6C7Box0qoC4aCr6NGntfpnhwKBjz2NziQrVdnPZ/Zw
         nYdWa8NUL1Law==
Date:   Tue, 7 Feb 2023 11:47:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Alexander Motin <mav@ixsystems.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/3] PCI: distribute resources for root buses
Message-ID: <20230207174724.GA2357295@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131092405.29121-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 31, 2023 at 11:24:02AM +0200, Mika Westerberg wrote:
> Hi all,
> 
> This is sixth iteration of the patch series trying to solve the problem
> reported by Chris Chiu [1]. In summary the current resource distribution
> code does not cover the initial device enumeration so if we find
> unconfigured bridges they get the bare minimum.
> 
> In addition to that it turned out the current resource distribution code
> does not take into account possible multifunction devices and/or other
> devices on the bus. The patch 1/2 tries to make it more generic. I've
> tested it on QEMU following the topology Jonathan is using and also in a
> a couple of systems with Thunderbolt controller and complex topologies
> to make sure it still keeps working.
> 
> The previous versions of the series can be found:
> 
> v5: https://lore.kernel.org/linux-pci/20230112110000.59974-1-mika.westerberg@linux.intel.com/
> v4: https://lore.kernel.org/linux-pci/20230104091635.63331-1-mika.westerberg@linux.intel.com/
> v3: https://lore.kernel.org/linux-pci/20221130112221.66612-1-mika.westerberg@linux.intel.com/
> v2: https://lore.kernel.org/linux-pci/20221114115953.40236-1-mika.westerberg@linux.intel.com/
> v1: https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/
> 
> Changes from v5:
>   * Correct typo in mmio calculation (io_per_hp -> mmio_per_hp)
>   * Add missing -1 to the mmio_pref end when align == 0.
> 
> Changes from v4:
>   * Split the alignment fix into separate patch
>   * Create helper for removing resources
>   * Skip VF BARs when removing
>   * Add check for 32-bit/64-bit prefetchable resource so that we account
>     them correctly.
>   * Update comments and commit log slightly according to review
>     comments.
>   * Did not add the "lookup for hotplug bridges below non-hotplug ones".
>     It turned out to be non-trivial. The current code works for the
>     "common" case of Thunderbolt/USB4 PCIe switches but we may need to
>     revisit this if there is a real need.
> 
> Changes from v3:
>   * Make it more generic and not depend on how many bridges there are
>     on the bus.
> 
> Changes from v2:
>   * Make both patches to work with PCI devices too (do not expect that
>     the bridge is always first device on the bus).
>   * Allow distribution with bridges that do not have all resource
>     windows programmed (therefore the patch 2/2 is not revert anymore)
>   * I did not add the tags from Rafael and Jonathan because the code is
>     not exactly the same anymore so was not sure if they still apply.
> 
> Changes from v1:
>   * Re-worded the commit message to hopefully explain the problem better
>   * Added Link: to the bug report
>   * Update the comment according to Bjorn's suggestion
>   * Dropped the ->multifunction check
>   * Use %#llx in log format.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216000
> 
> Mika Westerberg (3):
>   PCI: Align extra resources for hotplug bridges properly
>   PCI: Take other bus devices into account when distributing resources
>   PCI: Distribute available resources for root buses too
> 
>  drivers/pci/setup-bus.c | 232 ++++++++++++++++++++++++++++------------
>  1 file changed, 166 insertions(+), 66 deletions(-)

Applied to pci/resource for v6.3, thanks, Mika!
