Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC440B776
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 21:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhINTGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 15:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhINTGU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 15:06:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB95B6113B;
        Tue, 14 Sep 2021 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631646303;
        bh=S+WBtW6HNUgPMZLeWY7k0MAg6G4+RTj47Ww0A0vOLL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aW8H+3EnbpNtT0Q6jAuhJ2xACzDdXhpREproWljO3gmQoVZb8+tuCQTIpSkWydeUz
         ll4DjX5fJGGPKqrvpgG4OpIeoQ/NMI9g8+6hQUhuPAu2RXE9n4kIUPYoLI7F4Munan
         q5TwCHTqM7BAR5+avqQSgQD1yJaoLrOq83kXx3dEDcN+N9Ap8UZ8k/gtQBczWsNG38
         9ay/nZ43qPC+9PKZ5Fz2Mnsbuo7XhnDFIeZdDjPLPllpuDEbcTSCVYeibBmEzkFB8m
         pxq7g5gS/HsqJrEH4hD9HZi+dzrca46kPVBdnlYxtsDgvGY+uMmbxfoKbqrsPtrhGl
         /DsJ8ahZ7fAhg==
Date:   Tue, 14 Sep 2021 14:05:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org, bjorn.andersson@linaro.org,
        sallenki@codeaurora.org, skananth@codeaurora.org,
        vpernami@codeaurora.org, vbadigan@codeaurora.org
Subject: Re: [PATCH v7 0/3] Add Qualcomm PCIe Endpoint driver support
Message-ID: <20210914190501.GA1445131@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914080911.GA16774@thinkpad>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 14, 2021 at 01:39:11PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> On Thu, Jul 22, 2021 at 05:42:39PM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds support for Qualcomm PCIe Endpoint controller found
> > in platforms like SDX55. The Endpoint controller is based on the designware
> > core with additional Qualcomm wrappers around the core.
> > 
> > The driver is added separately unlike other Designware based drivers that
> > combine RC and EP in a single driver. This is done to avoid complexity and
> > to maintain this driver autonomously.
> > 
> > The driver has been validated with an out of tree MHI function driver on
> > SDX55 based Telit FN980 EVB connected to x86 host machine over PCIe.
> 
> Ping again! Do I need to resend this series on top of v5.15-rc1? I
> thought this one could go in for v5.15 but...

It's still "New" in patchwork:

  https://patchwork.kernel.org/project/linux-pci/list/?series=519709

so if it still applies cleanly on top of v5.15-rc1, you needn't post
it again.

If it requires any tweaks to apply on v5.15-rc1, please rebase it and
post a v8.

Bjorn
