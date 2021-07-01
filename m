Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AB03B9293
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 15:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhGAOCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 10:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhGAOCV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 10:02:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70AF5613EF;
        Thu,  1 Jul 2021 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625147990;
        bh=7yIdbx5G0asNF47kyLGub6yCdbe55aWTfmtrPq+WZHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KCKxL/USD4qbC3q797R4dfrTjrmgnqjqtI4cG9TGAb7e9udh2QPQifLboVBxJ/swd
         rFJtdJuj9GBU0p3dUCtB/ph+kDMhtfa+wPoaAHerFD/9lgeuL3us5IElOmrcOQyLyY
         wwesIvzNZtIL+6PJt7EkBbxO3lm7vMbtnT+aksVq3vtLxfB8SiOKhNxYun7U8KdRxj
         x54HlAQUVWM/4tUUtthtHuiU+7HPFin12M8FGtyt211TjTd2Wd76VZf9ecBq+eplFE
         UgFua6rQPEg78rLwXg10P7aWJLQAp2/G6aEFC6M6ftCAT/+a1jrMaIn3Cr9FrIkfF2
         xME9arZwlo11w==
Date:   Thu, 1 Jul 2021 08:59:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
Message-ID: <20210701135949.GA51123@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51276875-658e-e6fe-5433-b5d795b253ff@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 01, 2021 at 12:09:58AM +0200, Javier Martinez Canillas wrote:
> On 6/30/21 10:30 PM, Bjorn Helgaas wrote:
> > On Wed, Jun 30, 2021 at 09:59:58PM +0200, Javier Martinez Canillas wrote:
> 
> [snip]
> 
> >> But maybe you can also add a paragraph that mentions the
> >> CONFIG_DEBUG_SHIRQ option and shared interrupts? That way, other
> >> driver authors could know that by enabling this an underlying
> >> problem might be exposed for them to fix.
> > 
> > Good idea, thanks!  I added this; is it something like what you
> > had in mind?
> 
> Thanks a lot for doing this rewording. I just have a small nit for
> the text.
> 
> >     Found by enabling CONFIG_DEBUG_SHIRQ, which calls the IRQ
> >     handler when it is being unregistered.  An error during the
> >     probe path might cause this unregistration and IRQ handler
> >     execution before the device or data structure init has
> >     finished.
> 
> The IRQ handler is not called when unregistered, but it is called
> when another handler for the shared IRQ is unregistered. In this
> particular driver, both a "pcie-sys" and "pcie-client" handlers are
> registered, then an error leads to "pcie-sys" being unregistered and
> the handler for "pcie-client" being called.

Is this really true?  I think that would mean CONFIG_DEBUG_SHIRQ would
not find this kind of bug unless we actually registered two or more
handlers for the shared IRQ, but it's still a bug even only one
handler is registered.

Looking at __free_irq() [1], my impression is that "action" is what
we're removing and action->handler() is the IRQ handler we call when
CONFIG_DEBUG_SHIRQ, so it doesn't look like it's calling the remaining
handlers after removing one of them.

> So maybe the following instead?
> 
>     Found by enabling CONFIG_DEBUG_SHIRQ, which calls the IRQ
>     handlers when a handler for the shared IRQ is unregistered. An
>     error during the probe path might cause this unregistration and
>     handler execution before the device or data structure init has
>     finished.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/irq/manage.c?id=v5.13#n1805
