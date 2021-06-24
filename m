Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA743B38FD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 23:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhFXWAR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 18:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhFXWAQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 18:00:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00831613B9;
        Thu, 24 Jun 2021 21:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624571877;
        bh=yVk9OWhsYOUvvXi+eu9rDTIcKsexzhSWaaaSYGYVEWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bHbi53wf4EUCWV/VckTBBkgagYzQIdjlzw3hcwmfMZfsbYZSE4G0Othlk82OPvcZi
         mTEx1LgDjqNpWsw7u/wWPfhnX171bPwXZlPLByNKd2MAj8OYJctlnftGgyeTNf/vth
         TQZAgILapC5f3WM5jzMoBYOSMct2ATOCDOPDpXj6uDP1GHbaDHra10TGXLV5cp0eeA
         9o3UJCFoK9B2eXWiaufN4zDbHO/7TJ/GUTRU/E6lBcF8YfsNAxN5rNFHLPb3BhYZIL
         7RkKaM3A9/4ObdekMM6p0pDuF0bnJ8f3JhCuFhK4V12QZgbyB0Kdjb5i0xSx58rS1e
         uRlaHLRc8ceiQ==
Date:   Thu, 24 Jun 2021 16:57:50 -0500
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
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
Message-ID: <20210624215750.GA3556174@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608080409.1729276-1-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 08, 2021 at 10:04:09AM +0200, Javier Martinez Canillas wrote:
> IRQ handlers that are registered for shared interrupts can be called at
> any time after have been registered using the request_irq() function.
> 
> It's up to drivers to ensure that's always safe for these to be called.
> 
> Both the "pcie-sys" and "pcie-client" interrupts are shared, but since
> their handlers are registered very early in the probe function, an error
> later can lead to these handlers being executed before all the required
> resources have been properly setup.
> 
> For example, the rockchip_pcie_read() function used by these IRQ handlers
> expects that some PCIe clocks will already be enabled, otherwise trying
> to access the PCIe registers causes the read to hang and never return.

The read *never* completes?  That might be a bit problematic because
it implies that we may not be able to recover from PCIe errors.  Most
controllers will timeout eventually, log an error, and either
fabricate some data (typically ~0) to complete the CPU's read or cause
some kind of abort or machine check.

Just asking in case there's some controller configuration that should
be tweaked.
