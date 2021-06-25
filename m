Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4733B459D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 16:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhFYOe6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 10:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhFYOe5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 10:34:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6DCB61953;
        Fri, 25 Jun 2021 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624631556;
        bh=2Rsr+frvlcCR/IKRspsnz6sq84iOA0m+JQ4nu1bYRWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JFEbQu3OYlq7C7dwQ8IB+5DV/KhwM33GLo/pQSDGvu69txLQYrnZWwANbYWJ002R+
         0nk7eSMXPs+nDjIVwzqAMvV8Os6cy99lHC0D9QG6JZyJI1w5iE+WCoMpgxTImv4RHH
         FlmXeTju1AUiQ87JOtSNEfio7CmstAtjC23VHFzP0jDWVZGcOlHJ/CS4w9ViC8CZs9
         86rCNNOqeHhULLa1ak4Nb+2GX8qnfiFZlz/VvcQjr7w2XAaO+oQS9Cw+0ojazRbMMt
         W1BLmXGbTStGPUJA9iHlZ2kFXbHpJdse1vwiGCwCKEW2LT6goSl07skkmVTPafRRy5
         rrcRgt1Mu/G6A==
Date:   Fri, 25 Jun 2021 09:32:35 -0500
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
        Ley Foon Tan <ley.foon.tan@intel.com>,
        rfi@lists.rocketboards.org, Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
Message-ID: <20210625143235.GA3624355@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bee3702-595b-f57b-f962-28644b7e646f@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 09:09:36AM +0200, Javier Martinez Canillas wrote:
> On 6/25/21 12:40 AM, Bjorn Helgaas wrote:

> > I think this is also an issue with the following other drivers.  They all
> > set the handler to something that uses an IRQ domain before they
> > actually initialize the domain:
> 
> Yes, I agreed with your assessment and also noticed that others drivers have
> similar issues. I just don't have any of those platforms to try to reproduce
> the bugs and test a fix.

Even if you don't have other platforms for testing, I'm thrilled when
folks point out issues with them and (given time and inclination) post
patches for them.

I'd much rather fix *all* instances of the problem than just one, even
if we can't test them all.  Frequently driver maintainers will review
and test patches for their hardware even if we can't.

Bjorn
