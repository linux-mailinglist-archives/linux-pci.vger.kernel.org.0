Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA72D67CEF8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 15:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjAZOwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 09:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjAZOwb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 09:52:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDBB6B9AC;
        Thu, 26 Jan 2023 06:52:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F39ACE24AD;
        Thu, 26 Jan 2023 14:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A51AC433D2;
        Thu, 26 Jan 2023 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674744722;
        bh=F9wPDL14DyENKQWHuzRKYw2D0Df71Uvt9kOe8yYjEdw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fu9IRowp94gfxx7w4wpqN0NEj2N4k3iLexz/EWtyHQB8Xh/1iCvj019brhoPlhgck
         +2mPCLMrHoCEnZKfwkMmH0DY9SZHSSydjhSn7p1suflQQmI79Fldy5v+02PHVFI7wI
         9gRDvybad8yvhkK/tmgZmEEsmw1+ExvNgc91cmtn8T11LKf7x+CzbBGOmqHimdiuuj
         cyD62OMNky7AbGlsH8YM9h/Fa4K/b3h+12lZvsNCMd4UYr8LgqKdWPc/lANtud22Dx
         j7kAKqy1BdewPyCFBDOCJGC0SiDocSB2cdH5WaPHILZjsPGor/ihQ8c5r8CGRegD2o
         fFPMosSs55+9Q==
Date:   Thu, 26 Jan 2023 08:52:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        wenrui.li@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/8] PCI: rockchip: Fix PCIe endpoint controller driver
Message-ID: <20230126145200.GA1270846@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rick,

Thanks very much for your work.

On Thu, Jan 26, 2023 at 02:50:40PM +0100, Rick Wertenbroek wrote:
> This is a series of patches that fixes the PCIe endpoint controller driver
> for the Rockchip RK3399 SoC. It is based on Linux kernel 6.0.19
> 
> The original driver in mainline had issues and would not allow for the
> RK3399 to operate in PCIe endpoint mode. This patch series fixes that so
> that the PCIe core controller of the RK3399 SoC can now act as a PCIe
> endpoint.

So we merged cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip
PCIe controller") when it actually didn't work?  Ouch.  Thanks for
fixing it and testing it.

> Rick Wertenbroek (8):
>   PCI: rockchip: Removed writes to unused registers
>   PCI: rockchip: Fixed setup of Device ID
>   PCI: rockchip: Fixed endpoint controller Configuration Request Retry
>     Status
>   PCI: rockchip: Added poll and timeout to wait for PHY PLLs to be
>     locked
>   PCI: rockchip: Added dtsi entry for PCIe endpoint controller
>   PCI: rockchip: Fixed window mapping and address translation for
>     endpoint
>   PCI: rockchip: Fixed legacy IRQ generation for endpoint
>   PCI: rockchip: Fixed MSI generation from PCIe endpoint core

For the next iteration, can you please update these subject lines and
commit logs to:

  - Use imperative mood, i.e., read like a command, instead of a past
    tense description of what was done.  For example, say "Remove
    writes to unused registers" instead of "Removed writes ..."

  - Be more specific when possible.  "Fix" conveys no information
    about the actual code change.  For example, "Fixed endpoint
    controller Configuration Request Retry Status" gives a general
    idea, but it would be more useful if it said something about
    clearing config mode after probe.

  - Say what the patch does in the commit log.  The current ones often
    describe a *problem*, but do not explicitly say what the patch
    does.  The commit log should be complete in itself even without
    the subject line, so it usually contains a slightly expanded
    version of the subject line.

  - Split patches that do more than one logical thing.  The commit log
    for "Fixed MSI generation ..." talks about a u16/u32 shift issue,
    but the patch also adds an unrelated check for multi-function
    devices.

  - If a patch is a fix for an existing issue and may need to be
    backported, identify the commit that introduced the issue and add
    "Fixes: " lines.  This helps distros figure out whether and how
    far to backport patches.

  - Refer to the device consistently.  I see:
      RK3399 PCI EP core
      RK3399 SoC PCIe EP core
      RK3399 PCIe endpoint core
    I vote for "RK3399 PCIe Endpoint core".

Notes about imperative mood:
  https://chris.beams.io/posts/git-commit/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.0#n94

>  arch/arm64/boot/dts/rockchip/rk3399.dtsi  |  25 ++++
>  drivers/pci/controller/pcie-rockchip-ep.c | 149 +++++++++++-----------
>  drivers/pci/controller/pcie-rockchip.c    |  16 +++
>  drivers/pci/controller/pcie-rockchip.h    |  36 ++++--
>  4 files changed, 137 insertions(+), 89 deletions(-)
> 
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
