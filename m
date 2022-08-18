Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0358F598FCB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 23:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiHRVzM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 17:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiHRVzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 17:55:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D93CE337;
        Thu, 18 Aug 2022 14:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83FDAB821F3;
        Thu, 18 Aug 2022 21:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E26C433C1;
        Thu, 18 Aug 2022 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660859708;
        bh=Q4W4nyOfSzKfjU1c5JYeiQAtxRobHNwHU+ds+S705O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okSz/UICGkfKJNYaawRZbdgAtPtvLyfmdbZLHREDiVtf1YmHBkWpcCS2+9vnDeRBD
         JhwZAxOA5JfgDDW1WeAeIebXHoQ0eiw1kc41Av+r3jC6mRZ98mx76quj/NABH/wHae
         v3ixTLs2pagyVdLMrXRlyXHNYmnFnpmC3EFm5TELqQZF0Adq3mMzczDbKTwevRX8v+
         i7C2npf9+UgQschWzmNipdMcM2/vDfHS7X9qnVHylFm28BGf098NdB5LS43NY80NAh
         xU+ZnVVEYPpyBLFlpEuWbFKw9b4m5ok4COR4rS/dsKIFjJN0HSRyIsMrpCJzlMyFGj
         FMNMp2rHn1k0A==
Received: by pali.im (Postfix)
        id A95AE770; Thu, 18 Aug 2022 23:55:04 +0200 (CEST)
Date:   Thu, 18 Aug 2022 23:55:04 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        boqun.feng@gmail.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, jonmasters@google.com
Subject: Re: [PATCH 0/4] PCI SMC conduit, now with DT support
Message-ID: <20220818215504.srfih73x24n5u5gc@pali>
References: <20220725163905.2024437-1-jeremy.linton@arm.com>
 <20220726114000.GA21450@willie-the-truck>
 <7e4a0b4a-ac2f-5454-9778-e83f651b84a3@arm.com>
 <YvtOSedi3SqYngbV@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvtOSedi3SqYngbV@arm.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 16 August 2022 08:59:05 Catalin Marinas wrote:
> Hi Jeremy,
> 
> On Thu, Jul 28, 2022 at 12:20:55PM -0500, Jeremy Linton wrote:
> > On 7/26/22 06:40, Will Deacon wrote:
> > > On Mon, Jul 25, 2022 at 11:39:01AM -0500, Jeremy Linton wrote:
> > > > This is a rebase of the later revisions of [1], but refactored
> > > > slightly to add a DT method as well. It has all the same advantages of
> > > > the ACPI method (putting HW quirks in the firmware rather than the
> > > > kernel) but now applied to a 'pci-host-smc-generic' compatible
> > > > property which extends the pci-host-generic logic to handle cases
> > > > where the PCI Config region isn't ECAM compliant. With this in place,
> > > > and firmware managed clock/phy/etc its possible to run the generic
> > > > driver on hardware that isn't what one would consider standards
> > > > compliant PCI root ports.
> > > 
> > > I still think that hiding the code in firmware because the hardware is
> > > broken is absolutely the wrong way to tackle this problem and I thought
> > > the general idea from last time was that we were going to teach Linux
> > > about the broken hardware instead [1]. I'd rather have the junk where we
> > > can see it, reason about it and modify it.
> [...]
> > Is it the official position of the Linux kernel maintainers that they will
> > refuse to support future Arm standards in order to gate keep specific
> > hardware platforms?
> 
> (just back from holiday; well, briefly, going away for a few days soon)
> 
> We shouldn't generalise what maintainers wwould accept or not. We decide
> on a case by case basis. With speculative execution mitigations, for
> example, we try to do as much as we can in the kernel but sometimes
> that's just not possible, hence an EL3 call and we'd rather have this
> standardised (e.g. custom branch loops to flush the branch predictor if
> possible from the normal world, secure call if not).
> 
> You mention PSCI but that's not working around broken hardware, it was a
> concious decision from the start to standardise the booting protocol and
> CPU power management.
> 
> Now this PCI SMC protocol was simply created because hardware did not
> comply with another PCI standard that has been around for a long time.
> As with the speculative execution mitigations, we'd rather work around
> broken hardware in the kernel first and, if it's not possible, we can
> look at a firmware interface (and ideally standardised). Do you have an
> example where we cannot work around the PCI hardware bugs in the kernel
> and EL3 firmware involvement is necessary?
> 
> So, in summary, Arm Ltd proposing a new standard because hardware
> companies can't be bothered with an existing one is not an argument for
> accepting its support in the Linux kernel. This PCI SMC conduit is not
> presented as a hardware bug workaround interface but rather as an
> alternative to ECAM (and, yes, the kernel maintainers can choose not to
> support specific "standards" in Linux).

Hello! I think that this PCI SMC could be already marked as deprecated
as Linux can use "native" drivers to access PCIe config space, without
need to use any kind of RPC mechanism, like ARM SMC.

Note that for example kernel driver phy-mvebu-a3700-comphy.c was
converted from ARM SMC API to true "native" linux driver which touch
hardware directly (and does not use RPC API). And this is the right
direction, stop using RPC APIs in kernel and configure hardware
directly without need to depends on firmware, SMC or any other SW which
is running on CPU. Depending on the firmware or its functionality which
access same HW as kernel itself, is always nightmare. x86 developers
have enough experience with BIOS and its poor implementations and there
was for a long time direction to not use x86 BIOS and rather communicate
with hardware directly. And if PCIe hardware is broken? Well, PCIe
controller drivers should be extended to handle or workaround it. I have
already sent lot of patches for Marvell PCIe controllers to workaround
HW design issues, so similarly it should be done for other (known
broken) vendor HW.

So in my opinion, instead of PCI SMC, kernel PCIe controller drivers
should be fixed to correctly access PCIe config space and completely
deprecate/remove this PCI SMC from kernel. And if PCI SMC has not landed
in kernel yet, even better, because deprecation step can be skipped.
