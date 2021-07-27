Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AD3D798E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhG0PSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 11:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232633AbhG0PSS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 11:18:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D872861B2D;
        Tue, 27 Jul 2021 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627399098;
        bh=xS5YDQ/FeI6AHeCE46oZYAT+V/kJOyo5kEuks9WATiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Iz2sEXTiDQcBFBVDHWFcNJqECnBuIA8GdEk0xfD+/9OyG6k9F/ibUrld4Xdz+AxC5
         tjb9VIuNZIHek+kSuPJG7O2BtR01RdAf5ReClPSeyFqxMBP3On5mfoFJdxjXCfcJyR
         /PvM6UX1YJBulkuxRi3/QVAUFDDPYrC7QqSLUkppa+7nGy9kZfUdEnpvG1aFUo7NE+
         ZInNpjCvm68BS27ZjLXtWsY/55qCk9sfPAhrWesmuuBpyuQtWAWBQtGimP+wg0YISX
         vt/zwc2E72oKvlKSlhdEIMJdoCPuvS4yJqbsY50XYhDZgy+aB3DxASRrYSdTAnjo0L
         YUW0FFiJkGxrQ==
Date:   Tue, 27 Jul 2021 10:18:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     hemantk@codeaurora.org, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, bjorn.andersson@linaro.org,
        linux-pci@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>
Subject: Re: Query on ASPM driver design
Message-ID: <20210727151816.GA714116@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28465f90-3c64-678a-9b90-209eaa30a084@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 27, 2021 at 07:51:37AM +0530, Om Prakash Singh wrote:
> Hi Bjorn,
> I think it makes sense to have the scope of keeping default ASPM
> policy disable and API pci_enable_link_state() to selectively enable
> by EP Driver.
>
> sysfs interface for ASPM also does not allow enabling ASPM for a
> device if the default policy (policy_to_aspm_state()) does not allow
> it.

The ASPM policy implementation may require changes.  I think the
current setup where a policy is compiled into the kernel via Kconfig
options is seriously flawed.

We need a fail-safe kernel parameter, i.e., "pcie_aspm=off", for cases
where devices don't work at all with ASPM.  We need quirks to work
around devices known to be broken, e.g., those that advertise ASPM
support that doesn't actually work, or those that advertise incorrect
exit latencies.  I think most other configuration should be done via
sysfs.

> Consider a situation, for a platform one wants to utilize ASPM
> capability of an onboard PCIe device because it is well evaluated,
> at the same time they want to keep ASPM disabled for other PCIe
> devices that can be connected on open PCIe slot to avoid possible
> performance issue.
> 
> I see ASPM is broken on many devices, though the device shows ASPM
> capabilities but has performance issues when it is enabled.

I'll wait to see your proposal and use case before commenting on this.

Bjorn
