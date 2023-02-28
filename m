Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322E76A594D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 13:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjB1Moe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 07:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjB1Mod (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 07:44:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4340A8689
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2023 04:44:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBDDBB80E35
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2023 12:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345F4C433D2;
        Tue, 28 Feb 2023 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677588269;
        bh=5vD8F33+DLmNKEwc0z+5TwyctOD+cWuhRkWhA1uNv9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S2Ad+XD1tABYC74JbEHGqbvaffI+kZpdyJEHABbIWdt5JfdYyS3B4wRIEZdUgx59y
         JQCRJr45dHdXXvwQ3rVslym2Z02wejotL9G3Vmw2FTZ/eNobiCJETDgBCepVly8Vzz
         lnQlUjZEga/q/EwHqIBQKBYU+ScppuIwu7n/YmMDTuq061ZBFpLvMAYK6L9wrDSAsc
         K9PmPw1kgsKGuBv0V1TBBYv+3IZ8ojEcVfhqdJ0Eu9RDGKla/IgqYsq5ccvOHmyAfm
         TDReu7qBQndYptFDvL8eWNKNC8xymC9IcO1An2SmA/hikFy50mUePqw9A0tLel0AA7
         q7i7wKJZ0AdtQ==
Date:   Tue, 28 Feb 2023 06:44:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     smalltalk@swismail.com,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Kever Yang <kever.yang@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [Bug 217100] New: Bifurcation between pcie3x1 & pcie3x2 doesn't
 work in RK3568J.
Message-ID: <20230228124427.GA114786@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-217100-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 28, 2023 at 08:53:50AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=217100
> 
>            Summary: Bifurcation between pcie3x1 & pcie3x2 doesn't work in
>                     RK3568J.
> ...

> Hello.
> 
> First, I want to say that pcie3x1 crashes if started before pcie3x2 . Driver
> > pcie-designware.c 
> 
> in function 
> 
> > void dw_pcie_version_detect(struct dw_pcie *pci)
> 
> tries to read parameter from dbi register (PCIE_VERSION_NUMBER) and fails on
> it.
> So I changed sequence of declaration PCIE in rk3568.dtsi: first - pcie3x2 next
> pcie3x1. Now Linux first starts pcie3x2, then successfully starts pcie3x1.
> 
> But main problem is that bifurcation in phy driver 
> > phy-rockchip-snps-pcie3.c 
> 
> doesn't work. I tried add next lines in function
> 
> > static int rockchip_p3phy_probe(struct platform_device *pdev)
> 
> right after block check
> 
> > if (priv->num_lanes == -EINVAL) {
> > }
> 
> > priv->num_lanes = 2;
> > priv->lanes[0] = 1;
> > priv->lanes[1] = 2
> 
> And driver writes during Linux boot process that bifurcation is enabled, but
> 
> lspci
> 
> does't show second device.
> 
> Best regards,
> Anton.

Thanks much for your report, Anton.  People don't really pay attention
to the bugzilla, so I'm forwarding this to the mailing list and to
some folks who've worked on that driver in the past.

MAINTAINERS doesn't list an entry for pcie-dw-rockchip.c; I'm not sure
if that's an oversight or if nobody cares enough to actually maintain
it.

Bjorn
