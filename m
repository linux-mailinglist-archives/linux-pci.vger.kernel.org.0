Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967C458123A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiGZLkN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 07:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiGZLkL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 07:40:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8012BD3;
        Tue, 26 Jul 2022 04:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3051CCE1828;
        Tue, 26 Jul 2022 11:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92010C341C8;
        Tue, 26 Jul 2022 11:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658835607;
        bh=yL/84tqi9gVAqhM4QwwAMzi32hAb0stsqpRwvMm7GAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZHyDADn38pBiojVQRSYLMdqpCW60v82r3p9EwMoz2DEqz0PNDMiW8VJv7/LLzDCxD
         7rEZhIWSy7QmYv6uVvObGFYHEyO0a44+J4SdqzqZaKQieEQNIyZerarBTf2qvoG3ej
         bJxHTjhpPU4gYt45/f27KlV6n0MYAOIqyGqjTze0HL89rvJ46LhQOYHw28ZL6O6ceu
         1g6r5n4Dc37NsgF4odx6rOLuWSwtK4ONpTgSllXMil4Al7m9XuvP24d42nqKk+OhbH
         t0F2wMXPIjV9cJGyHfu0SJx4K3vMZT+kcLduE5LK327DDLnffIqAq3ou+PY1Wuh3kj
         UPKJefehBh9xA==
Date:   Tue, 26 Jul 2022 12:40:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, jonmasters@google.com
Subject: Re: [PATCH 0/4] PCI SMC conduit, now with DT support
Message-ID: <20220726114000.GA21450@willie-the-truck>
References: <20220725163905.2024437-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725163905.2024437-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 25, 2022 at 11:39:01AM -0500, Jeremy Linton wrote:
> This is a rebase of the later revisions of [1], but refactored
> slightly to add a DT method as well. It has all the same advantages of
> the ACPI method (putting HW quirks in the firmware rather than the
> kernel) but now applied to a 'pci-host-smc-generic' compatible
> property which extends the pci-host-generic logic to handle cases
> where the PCI Config region isn't ECAM compliant. With this in place,
> and firmware managed clock/phy/etc its possible to run the generic
> driver on hardware that isn't what one would consider standards
> compliant PCI root ports.

I still think that hiding the code in firmware because the hardware is
broken is absolutely the wrong way to tackle this problem and I thought
the general idea from last time was that we were going to teach Linux
about the broken hardware instead [1]. I'd rather have the junk where we
can see it, reason about it and modify it.

What's changed?

In my mind, the main thing that's happened since we last discussed this
is that Apple shipped arm64 client hardware with working ECAM. *Apple*
for goodness sake: a company with basically no incentive to follow
standards for their vertically integrated devices! Perhaps others need
to raise their game instead of wasting everybody's time on firmware
hacks; getting the hardware right obviously isn't as difficult as folks
would lead us to believe.

Will

[1] https://lore.kernel.org/r/20210325131231.GA18590@e121166-lin.cambridge.arm.com
