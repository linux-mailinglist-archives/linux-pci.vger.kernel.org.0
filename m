Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ACE6076A8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 14:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJUMBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 08:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJUMBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 08:01:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0047025E88A;
        Fri, 21 Oct 2022 05:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 906C761E68;
        Fri, 21 Oct 2022 12:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC042C433C1;
        Fri, 21 Oct 2022 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666353691;
        bh=lFmVFFa/5/iKN/Yo2q9AW/qANwcO3UhaXshlV3Z6Umw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kiQBMbsyBg7JyvM9JlDzqbseUWfTuCFGqmjFOrnS5Bv/B3HdA51uDLNEdVMBpg/kT
         6l8LizZqkldUz1mlD6Y+9Pgv9sfIRTMbSFWgOZmGX6Ep2yGBsOflaog3GWqgdNzwxt
         /nFEQcLM4KyuKH4dNMc71cXam5P/6b0ekEQInTjLZZtKg57J8PkyUxX9SnQceiqN4v
         yg/snDhaEwK5kRPUDF0Ggg2/MfsrrqBMun+XVylanKhuJfW6Zitw+RyVQhsyhIDuTC
         SIAQec1Vjjs46rwSe/Um12tcq/3lOVXKN4g3ZlORt717fbLaCoNxgDK7i1F8e9HSQO
         c3M2OC7XJ1DNQ==
Date:   Fri, 21 Oct 2022 07:01:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V4 1/4] ACPI / PCI: fix LPIC IRQ model default PCI IRQ
 polarity
Message-ID: <20221021120129.GA185586@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8a64289-6560-7d75-461c-39b7a612e9c2@loongson.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 21, 2022 at 09:58:57AM +0800, Jianmin Lv wrote:
> On 2022/10/21 上午12:47, Bjorn Helgaas wrote:
> > On Thu, Oct 20, 2022 at 04:22:02PM +0800, Jianmin Lv wrote:
> > > On LoongArch ACPI based systems, the PCI devices (e.g. sata
> > > controlers and PCI-to-to PCI bridge controlers) existed in
> > > Loongson chipsets output high-level interrupt signal to the
> > > interrupt controller they connected to,

> > The point is that one should be able to write this code from a spec,
> > without having to empirically discover the interrupt polarity.  What
> > spec tells you about using ACTIVE_HIGH here?
> > 
> Yes, no mentions for the inverter in ACPI spec, the description about
> device interrupt type can be found in Loongson chipset manual:
> 
> https://github.com/loongson/LoongArch-Documentation/blob/main/docs/Loongson-7A1000-usermanual-EN/interrupt-controller/device-interrupt-types.adoc

That's the kind of reference I was looking for.  The link to HTML is
convenient in some ways, but since specs evolve over time and URLs are
ephemeral, I think a citation like "Loongson 7A1000 Bridge User Manual
v2.00, sec 5.3" is more likely to be useful far in the future.

Bjorn
