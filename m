Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA15F7E01
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 21:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJGTc6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 15:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJGTc5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 15:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793442B27E;
        Fri,  7 Oct 2022 12:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B39361747;
        Fri,  7 Oct 2022 19:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAFDC433D6;
        Fri,  7 Oct 2022 19:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665171175;
        bh=V3eErinl3SskgtvkBOxmRnMnVmgrOAHOP2OxO4FJ8bY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OkKKyRGJiOyTSqTASZtOdm41aEgDvZVfgO4FzM4wABUz2qXGrq/zS/60nG0X3BnNH
         efbBi7BWwkb1yjwkHQxFonPPC8BZxNUJRH3FOnjpvD8gb63xXma+GPQ1HVJRjmWZnM
         rxIfP+Z3Nu5e8/tbp/lB9D4UF5fSZxPQlZhlj8Wb9snJFZkGe85ChGwz7PkGr+hUAi
         vjoa5LFwC+HEQ5eoBnbzQwNXNzsz9gfqYv1d1OAreYJc7sW8XZSyjlH9Jrf2QerAzP
         Krjm/b4RzcPnir/zqmyX8G/Gya+JWeXkJ47N1gzrCTtu0XNwPHu/EkPXl+DF1alX4/
         wvhyq0WUsKHHA==
Date:   Fri, 7 Oct 2022 14:32:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 5/5] PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits
Message-ID: <20221007193253.GA2643566@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006220322.33000-6-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 06, 2022 at 06:03:21PM -0400, Jim Quinlan wrote:
> Set RCB_MPS mode bit so that data for PCIe read requests up to the size of
> the Maximum Payload Size (MPS) are returned in one completion,

> and data for
> PCIe read requests greater than the MPS are split at the specified Read
> Completion Boundary setting.

I think this second part is required by PCIe r6.0, sec 2.3.1.1,
regardless of the setting of RCB_MPS, isn't it?

> Set RCB_64B so that read compeletion boudnary is 64B.

To match usage in spec and above and fix typos,

s/that read compeletion boudnary/the Read Completion Boundary/

Bjorn
