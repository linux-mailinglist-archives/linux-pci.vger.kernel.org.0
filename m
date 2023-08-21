Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C079782589
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 10:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjHUIfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHUIfB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 04:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC79B5;
        Mon, 21 Aug 2023 01:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C775862D31;
        Mon, 21 Aug 2023 08:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE5BC433C7;
        Mon, 21 Aug 2023 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692606898;
        bh=oEQbal5/vxqRGZ3YLafZj8Knbvn9kAOi/AFZtF9uDxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTDJqY5Yjj4O2DGZawjCbvMfpNiue4Yewjl6wur35PIheVqyPapwog1sJB5n89Ajm
         jvZ0Y0a9XpQ39CzToNwGXA0cCcfRVNsNzZB80eFLy2SnIkCi0eYp2mOLyajO52bIeF
         Gysae0y+8BV1c4+/IJtvMD1LB+TZa0gtQzc0+AXQegNjbA7xXv3eHDi7ojoOdnBCXV
         /ICtDfJN3agBpY0kkaQcJjRgoh9r8optOCWGCUYjQ0omVc1F/WxYvUsApbnxHzSX4Y
         rGbTeDp46sriFOPRhAC8FddeSDgr35+GEvy8jVUmyDFDtIaxE+/APWux6jEeRDxpGR
         Ygd+84jMdrElg==
Date:   Mon, 21 Aug 2023 10:34:51 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 0/5] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <ZOMhq8a/wnURWsFP@lpieralisi>
References: <20230623144100.34196-1-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623144100.34196-1-james.quinlan@broadcom.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 23, 2023 at 10:40:53AM -0400, Jim Quinlan wrote:
> v6 -- No code has been changed.
>    -- Changed commit subject and comment in "#PERST" commit (Bjorn, Cyril)
>    -- Changed sign-off and author email address for all commits.
>       This was due to a change in Broadcom's upstreaming policy.
> 
> v5 -- Remove DT property "brcm,completion-timeout-us" from	 
>       "DT bindings" commit.  Although this error may be reported	 
>       as a completion timeout, its cause was traced to an	 
>       internal bus timeout which may occur even when there is	 
>       no PCIe access being processed.  We set a timeout of four	 
>       seconds only if we are operating in "L1SS CLKREQ#" mode.
>    -- Correct CEM 2.0 reference provided by HW engineer,
>       s/3.2.5.2.5/3.2.5.2.2/ (Bjorn)
>    -- Add newline to dev_info() string (Stefan)
>    -- Change variable rval to unsigned (Stefan)
>    -- s/implementaion/implementation/ (Bjorn)
>    -- s/superpowersave/powersupersave/ (Bjorn)
>    -- Slightly modify message on "PERST#" commit.
>    -- Rebase to torvalds master
> 
> v4 -- New commit that asserts PERST# for 2711/RPi SOCs at PCIe RC
>       driver probe() time.  This is done in Raspian Linux and its
>       absence may be the cause of a failing test case.
>    -- New commit that removes stale comment.
> 
> v3 -- Rewrote commit msgs and comments refering panics if L1SS
>       is enabled/disabled; the code snippet that unadvertises L1SS
>       eliminates the panic scenario. (Bjorn)
>    -- Add reference for "400ns of CLKREQ# assertion" blurb (Bjorn)
>    -- Put binding names in DT commit Subject (Bjorn)
>    -- Add a verb to a commit's subject line (Bjorn)
>    -- s/accomodat(\w+)/accommodat$1/g (Bjorn)
>    -- Rewrote commit msgs and comments refering panics if L1SS
>       is enabled/disabled; the code snippet that unadvertises L1SS
>       eliminates the panic scenario. (Bjorn)
> 
> v2 -- Changed binding property 'brcm,completion-timeout-msec' to
>       'brcm,completion-timeout-us'.  (StefanW for standard suffix).
>    -- Warn when clamping timeout value, and include clamped
>       region in message. Also add min and max in YAML. (StefanW)
>    -- Qualify description of "brcm,completion-timeout-us" so that
>       it refers to PCIe transactions. (StefanW)
>    -- Remvove mention of Linux specifics in binding description. (StefanW)
>    -- s/clkreq#/CLKREQ#/g (Bjorn)
>    -- Refactor completion-timeout-us code to compare max and min to
>       value given by the property (as opposed to the computed value).
> 
> v1 -- The current driver assumes the downstream devices can
>       provide CLKREQ# for ASPM.  These commits accomodate devices
>       w/ or w/o clkreq# and also handle L1SS-capable devices.
> 
>    -- The Raspian Linux folks have already been using a PCIe RC
>       property "brcm,enable-l1ss".  These commits use the same
>       property, in a backward-compatible manner, and the implementaion
>       adds more detail and also automatically identifies devices w/o
>       a clkreq# signal, i.e. most devices plugged into an RPi CM4
>       IO board.
> 
> 
> Jim Quinlan (5):
>   dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss property
>   PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream
>     device

I am not merging the first two patches since the discussion thread
is still open and I'd like to understand better what can/should be
done, sorry.

>   PCI: brcmstb: Set higher value for internal bus timeout
>   PCI: brcmstb: Assert PERST# on BCM2711
>   PCI: brcmstb: Remove stale comment

Is it OK to apply these three on their own ? Overall it would be
great to avoid mixing patches with different end goals in a single
series.

Thanks,
Lorenzo

>  .../bindings/pci/brcm,stb-pcie.yaml           |  9 ++
>  drivers/pci/controller/pcie-brcmstb.c         | 91 ++++++++++++++++---
>  2 files changed, 89 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 8a28a0b6f1a1dcbf5a834600a9acfbe2ba51e5eb
> -- 
> 2.17.1
> 


