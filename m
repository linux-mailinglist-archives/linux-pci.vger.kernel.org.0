Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF436DE765
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 00:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDKWkT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 18:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDKWkS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 18:40:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D2410D5
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 15:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B243F6280A
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 22:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E94C433D2;
        Tue, 11 Apr 2023 22:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681252817;
        bh=Qwzk9Pesd0zqA5fjWLb38V32XLoHgQNrMgZ725utmhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R9SPvzjcfMh9j6Uo3oxvk1hyFg57Fj/l10Y7eyNoCDqq1LZ5HPGQ8eTrfOkjV65oQ
         EagxHoF6YlB8PfIcj3gpyB9GrV/LJi/p6DWRvXjDm1roDU/NOjA2nsUmonc3I4AUS7
         0XE3A8sNk+sz3mARh9r0PABTiOQ/OL9DnaA5/SBQv5yPbRKmpA81pYH27Trh0NzLZQ
         2m0YD9/kl0XPgtBdNjWZL639/HNHOrHAU85aG0PGqOZLAkpWB1O+WQal/UGk/g3ah9
         iqRBSZm0fb7v5Z80wEwrVTXyqSczY16FUh97uhP511krib1qf8Nn/I29f4tipFD3M0
         LPCB6Aqoxpmgw==
Date:   Tue, 11 Apr 2023 17:40:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI/PM: Resume/reset wait time change
Message-ID: <20230411224014.GA4185844@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404052714.51315-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 04, 2023 at 08:27:12AM +0300, Mika Westerberg wrote:
> Hi all,
> 
> This series first increases the time we wait on resume path to
> accommondate certain device, as reported in [1], and then "optimizes"
> the timeout for slow links to avoid too long waits if a device is
> disconnected during suspend.
> 
> Previous version can be found here:
> 
>   https://lore.kernel.org/linux-pci/20230321095031.65709-1-mika.westerberg@linux.intel.com/
> 
> Changes from the previous version:
> 
>   * Split the patch into two: one that increases the resume timeout (on
>     all links, I was not able to figure out a simple way to limit this
>     only for the fast links) and the one that decreases the timeout on
>     slow links.
> 
>   * Use dev->link_active_reporting instead of speed to figure out slow
>     vs. fast links.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216728
> 
> Mika Westerberg (2):
>   PCI/PM: Increase wait time after resume

I applied the above to pci/reset for v6.4.

>   PCI/PM: Decrease wait time for devices behind slow links

Part of this patch is removing the pci_bridge_wait_for_secondary_bus()
timeout parameter, since all callers now supply the same value
(PCIE_RESET_READY_POLL_MS).  I extracted that part out and applied it
as well.

I'm hoping we can restructure the rest of this as mentioned in the
thread.  If that's not possible, can you rebase what's left on top of
this?

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=reset

>  drivers/pci/pci-driver.c |  2 +-
>  drivers/pci/pci.c        | 42 ++++++++++++++++++++++++++--------------
>  drivers/pci/pci.h        | 16 +--------------
>  drivers/pci/pcie/dpc.c   |  3 +--
>  4 files changed, 30 insertions(+), 33 deletions(-)
> 
> -- 
> 2.39.2
> 
