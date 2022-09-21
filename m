Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B25E53FE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 21:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiIUTxF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Sep 2022 15:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIUTxE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2022 15:53:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8BDA1A57
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2022 12:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7118AB82613
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2022 19:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079DFC433C1;
        Wed, 21 Sep 2022 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663789980;
        bh=PdU8Gr8cc8IN+VJuteyVt/AxAPSXajC5EdWmedWluKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H4FeLe24ZH/3wqdGCDz3lSvAF6Yq4mLB4Vfh+ZDM0ytQhTh/rVJqctEo4GfuFvSL7
         rXeq7sVrdOcQN6wYqHgPKKhY/UHhFJaNtNdndBV7L+vHQ0GuPx3P5wgJGU591EA0GG
         geoWMveWx73LpqGWuj+i5zQdB7MxpeXL2/dDZc3nT0mwnXxffBY+K61gYULfpM74ZT
         4Qe/hne+tNR7c24N7++ZOiz25m/x/Or7ACoSPJB2fotDD73OYLiOtljhXSfO3tZhwg
         qCh0/apMhA4JDaGK5op64tO6RVtFqwOppAEKAJJdoQHD9plQvzo5n35UZyd0h2/y3G
         6eetVVC9TD0cg==
Date:   Wed, 21 Sep 2022 14:52:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: Allow for future resource expansion on
 initial root bus scan
Message-ID: <20220921195258.GA1232632@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 11:02:26AM +0300, Mika Westerberg wrote:
> Hi,
> 
> The series works around an issue found on some Dell systems where
> booting with Thunderbolt/USB4 devices connected the BIOS leaves some of
> the PCIe devices unconfigured. If the connected devices that are not
> configured have PCIe hotplug ports as well the initial root bus scan
> only reserves the minimum amount of resources to them making any
> expansion happening later impossible.
> 
> We do already distribute the "spare" resources between hotplug ports on
> hot-add but we have not done that upon the initial scan. The first four
> patches make the initial root bus scan path to do the same.
> 
> The additional patches are just a small cleanups that can be applied
> separately too.
> 
> The related bug: https://bugzilla.kernel.org/show_bug.cgi?id=216000.
> 
> The previous version of the patch series can be found here:
> 
>   https://lore.kernel.org/linux-pci/20220816100740.68667-1-mika.westerberg@linux.intel.com/
> 
> Changes from the previous version:
> 
>   * Split patch 3 into two: move and then the actual fix as suggested by
>     Andy.
>   * Fold the two whitespace fixes into one patch.
>   * Added tags from Chris and Andy.
> 
> Mika Westerberg (6):
>   PCI: Fix used_buses calculation in pci_scan_child_bus_extend()
>   PCI: Pass available buses also when the bridge is already configured
>   PCI: Move pci_assign_unassigned_root_bus_resources()
>   PCI: Distribute available resources for root buses too
>   PCI: Fix whitespace and indentation
>   PCI: Fix typo in pci_scan_child_bus_extend()
> 
>  drivers/pci/probe.c     |  13 +-
>  drivers/pci/setup-bus.c | 290 ++++++++++++++++++++++++----------------
>  2 files changed, 181 insertions(+), 122 deletions(-)

Applied to pci/resource for v6.1, thanks, Mika!
