Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0990372323
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 00:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhECWnP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 18:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhECWnP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 18:43:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47B5E61185;
        Mon,  3 May 2021 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620081741;
        bh=cfPGy931uKudM1etaqx236gFfd6SiYQnL01wqHKEi38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Dy4yUdOetcAC5ROSwPGbLaRUo1nQvSbfEWnTUEwXDXH+pOkRDoGukIYGCF8s2JO2S
         wHTq3KSdqlh9SNeqEDdr91W4H+9vnkLh65iQTwO7uU8INuCp4VksAYqNNK6blIDd/K
         OKpv7OZOquDB+OFAAx8w9Iy1jSDEL0JGvhj+pr/Z+psVu2WXx9djqaKeoWcIXL6N9C
         gvKRaFZq2hdWGjoStJ6W8hutIEXIqawLedeFISuJzoiiOdVmhKTMxkJxQKsXIQHWse
         TmaJut0/o/8mScR7YjIp3jTGBuILVVqOD2Qi8mP2jvSjfQtP32/T5J9re4k2jxi+Ze
         ngTgRA3bPKDUw==
Date:   Mon, 3 May 2021 17:42:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Message-ID: <20210503224220.GA999955@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c89d4e-6b26-6c56-d71e-508a715394ab@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 05:11:23PM -0500, Shanker R Donthineni wrote:
> Thanks Bjorn for reviewing patch.
> 
> On 4/30/21 12:01 PM, Bjorn Helgaas wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Wed, Apr 28, 2021 at 07:49:07PM -0500, Shanker Donthineni wrote:
> >> On select platforms, some Nvidia GPU devices do not work with SBR.
> >> Triggering SBR would leave the device inoperable for the current
> >> system boot. It requires a system hard-reboot to get the GPU device
> >> back to normal operating condition post-SBR. For the affected
> >> devices, enable NO_BUS_RESET quirk to fix the issue.
> > Since 1/2 adds _RST support, should I infer that _RST works on these
> > Nvidia GPUs even though SBR does not?  If so, how does _RST do the
> > reset?
> Yes, _RST method works but not SBR. The _RST method in DSDT-AML uses
> platform-specific initialization steps outside of the GPU BARs for resetting
> the GPU device.

Obviously _RST only works for built-in devices, since there's no AML
for plug-in devices, right?  So if there's a plug-in card with this
GPU, neither SBR nor _RST will work?

> > Do you have a root cause for why SBR doesn't work?  
> It is a hardware implementation specific issue. GPU end-point device
> is inoperative after receiving SBR from the RP/SwitchPort. This quirk is
> to prevent SBR.

That's not a root cause; it's basically still "it doesn't work."  But
OK.

I'm wondering if we should log something to dmesg in
quirk_no_bus_reset(), quirk_no_pm_reset(), quirk_no_flr(), etc., just
so we have a hint about the fact that resets won't work quite as
expected on these devices.

Bjorn
