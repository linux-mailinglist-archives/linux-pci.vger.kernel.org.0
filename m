Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5BB10741C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 15:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfKVOgT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 09:36:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfKVOgS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Nov 2019 09:36:18 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05BC420715;
        Fri, 22 Nov 2019 14:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574433378;
        bh=sjserQ51iYtb6tWkCfOxOAhki9OnMNvjfzQD4Dzcu9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gx/IvULq9KCSyi56s2oI0cRNzKR4qs8qFpjphlDn+HA6FQ8RKLtpur2DULwNhvSWY
         Nb6AIhYUUdG+/cCR4F1+Yoj37uD2r/2OlqpKwDkWOaNFYNl2NWTYZaZfVJNGo5ZeVb
         rQcpss/BYFhOXCHZogQ3BhiyMFzYTCURqaLdfGL0=
Date:   Fri, 22 Nov 2019 08:36:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [BUG] rk3399-rockpro64 pcie synchronous external abort
Message-ID: <20191122143616.GA215594@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a381384-9d47-a7e2-679c-780950cd862d@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 10:03:27AM +0800, Shawn Lin wrote:
> From da9db487615c3687a0823c54d8d0790cbd4f79a2 Mon Sep 17 00:00:00 2001
> From: Shawn Lin <shawn.lin@rock-chips.com>
> Date: Thu, 21 Nov 2019 09:45:12 +0800
> Subject: [PATCH] WFT: PCI: rockchip: play game with unsupported request from
>  EP
> 
> Native defect prevents this RC far from supporting any response
> from EP which UR filed is set. Take a big hammer to take over
> Serror handler and work around it.

Peter, now that you have a way to at least boot, can you collect the
output of "sudo lspci -vvxxx"?

When we're enumerating devices, we don't know ahead of time which
devices exist, so we try to read the Vendor ID for each *possible*
device.  If the device doesn't exist, that config read should be
terminated with an Unsupported Request completion (see the
implementation note at the end of PCIe r5.0, sec 2.3.2).  So far this
is all standard PCIe hardware behavior (and sorry if this is all
obvious).

Sec 6.2.5 and 6.2.6 show several configuration bits that affect how
that UR is handled and ultimately reported, possibly via SERR#.  In
most Linux systems, a UR completion does not cause an SERR#, but the
PCI core does not manage those configuration bits directly (it
probably *should* be more proactive about this), so this is more a
result of how platform firmware set them than anything else.

I'm speculating that you may have PCI_COMMAND_SERR and similar bits
set, which will cause SERR# in cases where we don't see SERR# on other
platforms.  Your lspci output should show this.

Bjorn
