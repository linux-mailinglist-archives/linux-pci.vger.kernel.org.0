Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC42A7D7269
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 19:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjJYRgC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjJYRft (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 13:35:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F455187
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 10:35:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E95FC433C7;
        Wed, 25 Oct 2023 17:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698255336;
        bh=cr+xsjzlJjNwwmmyK3BYe5LelBs/qSR+1qnO6d+5Sas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pyCkSoX3dMfy+GBuCi0EFvqnZUhOpw7rQ/cFiaxBapk9o3sAFEPl7pAfXCmBuYq+d
         HRQ0p/a7x61XE7wBO48AY9Mmr2baZEP9GpxPy9kG1LPXnMOxPRi/AqTbwcMO/QbGcV
         DJYLVcI1rizT7u5+W2akUwncytVmXwniMOtApautY7rdYkgOycQrDSN1Os71l5wFmg
         zcoJULQG08k1bPud1zU3ACayafVbl7EXCn6pGNX6nelZkwzT5zsdgAwDk0EFNBAC0n
         S0LwNR41DsfPuYOWcdJq+QiHdxQmNoBBTvX/mbKn5o/kpI/SlmcxD6PfQm+I59MKsl
         8m5qsTdYMuqzw==
Date:   Wed, 25 Oct 2023 12:35:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Richter <sjr@debian.org>, 1015871@bugs.debian.org,
        linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Emanuele Rocca <ema@debian.org>
Subject: Re: Enabling PCI_P2PDMA for distro kernels?
Message-ID: <20231025173534.GA1755254@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025171126.GA9661@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 25, 2023 at 07:11:26PM +0200, Lukas Wunner wrote:
> On Wed, Oct 25, 2023 at 10:30:07AM -0600, Logan Gunthorpe wrote:
> > In addition to the above, P2PDMA transfers are only allowed by the
> > kernel for traffic that flows through certain host bridges that are
> > known to work. For AMD, all modern CPUs are on this list, but for Intel,
> > the list is very patchy.
> 
> This has recently been brought up internally at Intel and nobody could
> understand why there's a whitelist in the first place.  A long-time PCI
> architect told me that Intel silicon validation has been testing P2PDMA
> at least since the Lindenhurst days, i.e. since 2005.
> 
> What's the reason for the whitelist?  Was there Intel hardware which
> didn't support it or turned out to be broken?
> 
> I imagine (but am not certain) that the feature might only be enabled
> for server SKUs, is that the reason?

No, the reason is that the PCIe spec doesn't require routing of
peer-to-peer transactions between Root Ports:
https://git.kernel.org/linus/0f97da831026

I think there was a little discussion about adding a firmware
interface to advertise this capability, but I guess nobody cared
enough to advance it.

Bjorn
