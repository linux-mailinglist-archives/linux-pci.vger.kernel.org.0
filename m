Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316985B4032
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiIITvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 15:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiIITvN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 15:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BADE7A741;
        Fri,  9 Sep 2022 12:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 737BA62088;
        Fri,  9 Sep 2022 19:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA887C433D6;
        Fri,  9 Sep 2022 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662753071;
        bh=9DjjD+aR7NYx3bikzYihaf7tVq9u5fJQiSFi20D95t4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m9DJzj4qvuGCUF+iJ+1YF6PU4OQ0kehy72dEUeUCiihqeJl8lYu36FG+/i7QYXgJ/
         IJAdFMlZ2L5bZsyFbWsp7C9Fqd48/7p3Bl8zjzs9pLoUPd217F0Du8VPYmQFqspwzt
         quUlBbfOwxznQXdyuXnIhJ/arQ7BGuyUf5mUYOjccja7RhFaGeX/nyKyTInD6VZx94
         OBjf+8mp+nMKcn31yV8ntA0C7bZ9bL+wlYVq3I0XqLfD6uCavNUxMOLh0rWfYrlIgA
         6mAjajs6GPyiWZk1GQL4uyBdA4gTpa8zEuoWBtGsTmA9qfiUP6Acz7wg8sBi6FlVDK
         crUh4kg4vgBDQ==
Date:   Fri, 9 Sep 2022 14:51:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v6 0/5] PCI: qcom: Add system suspend & resume support
Message-ID: <20220909195110.GA310839@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 09, 2022 at 02:14:39PM +0530, Krishna chaitanya chundru wrote:
> Add suspend and resume syscore ops.
> 
> When system suspends, and if the link is in L1ss, disable the clocks
> and power down the phy so that system enters into low power state by
> parking link in L1ss to save the maximum power. And when the system
> resumes, enable the clocks back and power on phy if they are disabled
> in the suspend path.
> 
> we are doing this only when link is in l1ss but not in L2/L3 as
> nowhere we are forcing link to L2/L3 by sending PME turn off.
> 
> is_suspended flag indicates if the clocks are disabled in the suspend
> path or not.
> 
> There is access to Ep PCIe space to mask MSI/MSIX after pm suspend ops
> (getting hit by affinity changes while making CPUs offline during suspend,
> this will happen after devices are suspended (all phases of suspend ops)).
> When registered with pm ops there is a crash due to un-clocked access,
> as in the pm suspend op clocks are disabled. So, registering with syscore
> ops which will called after making CPUs offline.
> 
> Make GDSC always on to ensure controller and its dependent clocks
> won't go down during system suspend.
> 
> Krishna chaitanya chundru (5):
>   PCI: qcom: Add system suspend and resume support
>   PCI: qcom: Add retry logic for link to be stable in L1ss
>   phy: core: Add support for phy power down & power up
>   phy: qcom: Add power down/up callbacks to pcie phy
>   clk: qcom: Alwaya on pcie gdsc

This seems fairly ugly because it doesn't fit nicely into the PM
framework.  Why is this a qcom-specific thing?  What about other
DWC-based controllers?

>  drivers/clk/qcom/gcc-sc7280.c            |   2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c   | 156 ++++++++++++++++++++++++++++++-
>  drivers/phy/phy-core.c                   |  30 ++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c |  50 ++++++++++
>  include/linux/phy/phy.h                  |  20 ++++
>  5 files changed, 256 insertions(+), 2 deletions(-)
> 
> -- 
> 2.7.4
> 
