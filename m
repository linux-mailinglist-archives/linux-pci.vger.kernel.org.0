Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615EB5B792C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 20:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiIMSLd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 14:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiIMSLH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 14:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956E172FD0;
        Tue, 13 Sep 2022 10:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3155E61525;
        Tue, 13 Sep 2022 17:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A0FC433D6;
        Tue, 13 Sep 2022 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663089475;
        bh=W5O5q1S7tLTEXTSypm8r+8EveveNHQIfVB/39PA8/sc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IGLP0E6BOH/LbW3OJSyw8cj5IxqOlvnmuQakefWfzE74DStvQ8BBFHn3S0AcT/QTw
         3k6qBwgLO6ip8Kk0HGVGlZZ0ZANGLxJX1kwbNBIQS/obl5gkPWcuoBezOO4kGrECPp
         x9WmUD/VmM1ec4T4LvNWqYzmwSmvBXnJxuYhdcXbccG/nD3MSSRuQ85jYgbfAJ4h39
         Qjfl8NcqvHWuKqNqE6hT82cbeen7vbmLHrk9XCodDKmBN1E6Pnfngzs5IVYJHdoPSK
         gSSzaoPa0sZw/rN+CpwqmVAz/gL8EPDXOUGDvXpY+mSoE/x6NDdSfyPGRd1o691wwP
         C4bAAYx092Twg==
Date:   Tue, 13 Sep 2022 12:17:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        kenny@panix.com, kai.heng.feng@canonical.com, abhsahu@nvidia.com,
        sagupta@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 0/2] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <20220913171753.GA609036@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913131822.16557-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 06:48:20PM +0530, Vidya Sagar wrote:
> This patch series saves and restores the ASPM L1SS capability registers
> during suspend/resume cycle of the system.
> First patch refactors the existing L1SS register programming code to
> take out the common code.
> Second patch adds support to save and restore of the L1SS registers using
> the common code extracted in the first patch to restore the registers.
> 
> This patch is verified on Tegra194 and Tegra234 platforms.
> 
> Vidya Sagar (2):
>   PCI/ASPM: Refactor ASPM L1SS control register programming
>   PCI/ASPM: Save/restore L1SS Capability for suspend/resume
> 
>  drivers/pci/pci.c       |   7 +++
>  drivers/pci/pci.h       |   4 ++
>  drivers/pci/pcie/aspm.c | 106 +++++++++++++++++++++++++++-------------
>  3 files changed, 83 insertions(+), 34 deletions(-)

Applied to pci/aspm for v6.1, thanks!

I dropped the pci_is_pcie() testing since pci_configure_ltr() only
sets dev->l1ss for PCIe devices.
