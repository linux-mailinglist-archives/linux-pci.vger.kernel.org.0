Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA28741CC53
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbhI2TJw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 15:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245276AbhI2TJt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 15:09:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9228B61506;
        Wed, 29 Sep 2021 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632942488;
        bh=V7P9Dpo+mgUjVW9uQztKl7TPFTOtCqIlyiXw//J0a4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btPVSf5x7vMYBcmJQXGjDQufdGB7+wjOy/1iDEdfKVnUipcgeBnw5JU7jBFyK00ix
         YZoR4thoCZKqiMIguMmT04BdtlIVeF0i3IsuPSPzK0aNLoWDjY/aDUwO2XO21kL+E0
         5rholWmLqPj33VWKR3nhyfnjV7RNcquGdMWDstNsYDp+GSkqGFjfPgJmu6OKpd12sW
         akiKTy3ioJNpkN8aD1VAppF4Jbxa+qT5g5Vv+lRspuIdB2vVn9OO9sfVFcKQQmZJ5Z
         p0SfNbILnawfWuUYyqu/+385V8bJI7UH9Ph5R0uRpjsXig0t2etVtN9Ggsb1K8One2
         dlXiBwC5dsmgA==
Date:   Wed, 29 Sep 2021 12:08:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/7] PCI: ACPI: PM: Do not use pci_platform_pm_ops for
 ACPI
Message-ID: <YVS5k1H8KyVAk/h8@archlinux-ax161>
References: <1800633.tdWV9SEqCh@kreacher>
 <8879480.rMLUfLXkoz@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8879480.rMLUfLXkoz@kreacher>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 20, 2021 at 09:17:08PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Using struct pci_platform_pm_ops for ACPI adds unnecessary
> indirection to the interactions between the PCI core and ACPI PM,
> which is also subject to retpolines.
> 
> Moreover, it is not particularly clear from the current code that,
> as far as PCI PM is concerned, "platform" really means just ACPI
> except for the special casess when Intel MID PCI PM is used or when
> ACPI support is disabled (through the kernel config or command line,
> or because there are no usable ACPI tables on the system).
> 
> To address the above, rework the PCI PM code to invoke ACPI PM
> functions directly as needed and drop the acpi_pci_platform_pm
> object that is not necessary any more.
> 
> Accordingly, update some of the ACPI PM functions in question to do
> extra checks in case the ACPI support is disabled (which previously
> was taken care of by avoiding to set the pci_platform_ops pointer
> in those cases).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This patch as commit 9896a58cdd59 ("PCI: ACPI: PM: Do not use
pci_platform_pm_ops for ACPI") in -next causes the following build error
when compiling x86_64 allmodconfig with clang:

drivers/pci/pci-acpi.c:1125:7: error: variable 'adev' is uninitialized when used here [-Werror,-Wuninitialized]
        if (!adev || !acpi_device_power_manageable(adev))
             ^~~~
drivers/pci/pci-acpi.c:1110:26: note: initialize the variable 'adev' to silence this warning
        struct acpi_device *adev;
                                ^
                                 = NULL
1 error generated.

Should the adev assignment be moved up or is there a different fix
necessary?

Cheers,
Nathan
