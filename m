Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76295EAF8D
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 20:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiIZSWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 14:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIZSVb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 14:21:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF37BF45;
        Mon, 26 Sep 2022 11:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CC94611CA;
        Mon, 26 Sep 2022 18:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80883C43146;
        Mon, 26 Sep 2022 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664216281;
        bh=wAluiVNeo8nHql0makNUUTFAKus8zZtCrezjQxtwB+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U6YipxbEdNH1/lQItnlIL8t5MD0TobZ4XR4L3RR7dY4wqxziWPatMlpGXQ1lYTXee
         7YooBb+eDYGIl5mnXZbLCp4XlrEXL+woIDkpx5W5FpFE5d4fjVVmbGb+S6R9N83p8M
         z7KFG3HWzMzlZa36wwSnJBUhxJnnCahgWouh0op/ZlAWXjgLgzXuArgCeop8FIVFvi
         Elesc4bGObZUO4eHo7RXM949LhES1q/CYUC429sy3fOi77PPvMdRFBdyN9lYEy9uhb
         POLUb1fri+ac3o/LW4KukMgdn0NN9zIS7sjYuTSRyf00MHfZT0vc2kJyW9lKdps2sS
         4ecaNrSHm1GMg==
Date:   Mon, 26 Sep 2022 13:18:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, vkoul@kernel.org,
        mani@kernel.org, Sergey.Semin@baikalelectronics.ru,
        ffclaire1224@gmail.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 8/9] phy: tegra: p2u: Set ENABLE_L2_EXIT_RATE_CHANGE
 in calibration
Message-ID: <20220926181800.GA1612559@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926115038.24727-9-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 05:20:37PM +0530, Vidya Sagar wrote:
> Set ENABLE_L2_EXIT_RATE_CHANGE to request UPHY PLL rate change to Gen1
> during initialization. This helps in the below surprise down cases,
>   - Surprise down happens at Gen3/Gen4 link speed
>   - Surprise down happens and external REFCLK is cut off which causes
> UPHY PLL rate to deviate to an invalid rate
> 
> ENABLE_L2_EXIT_RATE_CHANGE needs to be set to bring the UPHY PLL rate
> back to Gen1 during controller initialization for the link up.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reported-by: kernel test robot <lkp@intel.com>

I doubt the kernel test robot reported the issue being fixed by this
patch.  More likely it reported a syntax or similar issue in v1, and I
think the "reported-by" tag is meaningless in cases like that.
