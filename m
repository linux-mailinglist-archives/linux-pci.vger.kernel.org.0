Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1485069B024
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBQQEC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 11:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBQQEC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 11:04:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B16D786
        for <linux-pci@vger.kernel.org>; Fri, 17 Feb 2023 08:04:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7764461E5D
        for <linux-pci@vger.kernel.org>; Fri, 17 Feb 2023 16:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F52C433D2;
        Fri, 17 Feb 2023 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676649839;
        bh=eDkMcaAB9PDTD1nuerM8BEXMPI7ZxUXOoMWwzIEYxks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HusGSxu30G78zq7UWlhoh2nwCi4JomWDdv8JdhlzL83IsB06k9RsucnYaC+z6gJdt
         Clkucr/Aa55OryeSxU948ttDiKgx5waBxWVOsqEhDf4hElGm+LrBqRrXoo4m9iVUGO
         Q5ChaUp16GvbkTopQ+yGGMn2eLiSVW1zmbKEMpmriygkqG31o3QXq6OA3gXcgnp9bQ
         JHCheClnOlduyTWLuxIDKioTcbo9o8b/QPwFKCiGHCBif4PHMVKY3nXFWJKP+hUlRv
         har0MYTaLFqDa+XOn+XJ3SH/ub68B1+ielaKL8UogwccnyjyFRvZQ0OG56FZ9gTNU7
         knJuDejU2TIkA==
Date:   Fri, 17 Feb 2023 10:03:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Anatoli Antonovitch <anatoli.antonovitch@amd.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Anatoli Antonovitch <a.antonovitch@gmail.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com
Subject: Re: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Message-ID: <20230217160358.GA3404296@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d474514-4d28-d41f-52cd-972ca7e3fc1d@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 13, 2023 at 09:59:52AM -0500, Anatoli Antonovitch wrote:
> Hi Lukas,
> 
> Can we revisit the patches again to get a fix?
> The issue still reproduce and visible in the kernel 6.2.0-rc8.

> On 2023-01-23 14:30, Anatoli Antonovitch wrote:
> > I do not see a deadlock, when applying the following old patch:
> > https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/

This old patch would need to be updated and reposted.  There was a
0-day bot issue and a question to be resolved.  Maybe this is all
already resolved, but it needs to be posted and tested with a current
kernel.

> > after merge for the kernel 6.2.0-rc5, and applied the alternative patch:
> > https://patchwork.kernel.org/project/linux-pci/patch/3dc88ea82bdc0e37d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de/

This one is on track to appear in v6.3-rc1:
https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=74ff8864cc84

> > I have uploaded the merged patch and the system log for the upstream
> > kernel.
> > 
> > Anatoli
> > 
> > 
> > On 2023-01-21 02:21, Lukas Wunner wrote:
> > > You're now getting a different deadlock. That one is addressed by this
> > > old patch (it's already linked from the bugzilla):
> > > 
> > > https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/
> > > 
> > > 
> > > If you apply that patch plus the new one, do you still see a deadlock?
