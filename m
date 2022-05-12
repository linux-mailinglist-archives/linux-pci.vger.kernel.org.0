Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691F7524D46
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 14:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347846AbiELMpL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 08:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345760AbiELMpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 08:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817D71CD26B
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 05:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB6A61F8C
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 12:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38490C385B8;
        Thu, 12 May 2022 12:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652359508;
        bh=CiSM5k5I8BH5wYHCEvRtJ2V4OjBjPHHXnKvJf4ePol0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gOEOMN0bhj5ST6FQuJLw0g8jT2dwbpHlY4JsjtzoR5VlBiBVbeCJqICEG7bI7Iw3i
         Yqdj/NBb5yObIBvKKyV4PmwGuRTkfJqQp6W+RBOxnMWadbPG2WVaoyRzDkIduRhs/L
         XNdoV4K9zlSAzVGT7FI5b3PvLOQ01rHe5fB/T2r9DP5J6N05JiMf1j72PvgdFPV5Ch
         RDD4m1x5EWp/zKcFBrlT4eqst8V3GhvjYQBFlNJaklqigptB949ij7n2GsltaskD+U
         xVMasXVchWKRxWo2aD0wuLqZkxDO+uteIDmEKLpRiBsyEc7IpYTQkv9aTQV3Y9uhrW
         vsucPjLTvuxQg==
Date:   Thu, 12 May 2022 07:45:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/4] Revert "PCI: brcmstb: Do not turn off WOL regulators
 on suspend"
Message-ID: <20220512124506.GA842977@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66ec3a0-10b4-fd60-0b03-e9a3f3571645@leemhuis.info>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 08:24:00AM +0200, Thorsten Leemhuis wrote:
> On 11.05.22 22:18, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > This reverts commit 11ed8b8624b8085f706864b4addcd304b1e4fc38.
> > 
> > This is part of a revert of the following commits:
> > 
> >   11ed8b8624b8 ("PCI: brcmstb: Do not turn off WOL regulators on suspend")
> >   93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> >   67211aadcb4b ("PCI: brcmstb: Add mechanism to turn on subdev regulators")
> >   830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
> > 
> > Cyril reported that 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup()
> > into two funcs"), which appeared in v5.17-rc1, broke booting on the
> > Raspberry Pi Compute Module 4.  Apparently 830aa6f29f07 panics with an
> > Asynchronous SError Interrupt, and after further commits here is a black
> > screen on HDMI and no output on the serial console.
> > 
> > This does not seem to affect the Raspberry Pi 4 B.
> > 
> > Reported-by: Cyril Brulebois <kibi@debian.org>
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215925
> 
> A "Bugzilla" tag? Why don't you just use a proper "Link:" tag, as
> explained by the documentation to use in this case (I clarified the docs
> recently with regards to this). Such inventions (some people use
> "References:", others "BugLink:" and there were a few others I already
> forget about) make my regression tracking efforts hard. :-/

In this case, I actually looked through the history to try to figure
out the most common way to cite bugzilla but didn't see much
uniformity.

Anyway, I updated these to "Link:".
