Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548DF3BD875
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 16:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhGFOmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 10:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232570AbhGFOmC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jul 2021 10:42:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD72561A2B;
        Tue,  6 Jul 2021 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625581935;
        bh=MpC+v47qgx+KkX/thu3NeybQ/OD5nBZlVpqt/YblKUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HeVuGnq4utCuVax3L8n1oNffJVPCendPHnqL2JLDxKHRfoQbkz1w2cOhAH6rZTgtG
         eAbhbw4gEM7sEzNrvWShLBtJ3ogg31AZteUKsA3GWgbvQrGklXDq8YrZSk72egOfhI
         sc1cr+b3uLhK3TNgxPS64/SiF3JTAxGdV2uOB35aiwAn/sjNOIdTvYpQ8djuBbT1Ch
         eA2WvuepwWzID8dkfpxPolmUJOAjE+tne4DiS7FoAkxNH9+WPEtlPPms6TpuXpoaqv
         e19s5xTZemtByIri6REoC7b0tczIFeU5b/B87edXj3lIs4Gn4rq93rNU90MWcycy97
         hvFFidE6brDFg==
Date:   Tue, 6 Jul 2021 09:32:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/5] PCI/VPD: Further improvements
Message-ID: <20210706143213.GA777225@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfbdfbb5-ffde-c89c-db3a-d69941bf1d76@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 06, 2021 at 07:56:11AM +0200, Heiner Kallweit wrote:
> On 13.05.2021 22:53, Heiner Kallweit wrote:
> > Series with further improvements to PCI VPD handling.
> > 
> > Heiner Kallweit (5):
> >   PCI/VPD: Refactor pci_vpd_size
> >   PCI: Clean up VPD constants and functions in pci.h
> >   PCI/VPD: Remove old_size argument from pci_vpd_size
> >   PCI/VPD: Make pci_vpd_wait uninterruptible
> >   PCI/VPD: Remove pci_vpd member flag
> > 
> >  drivers/pci/vpd.c   | 106 ++++++++++++++++----------------------------
> >  include/linux/pci.h |  43 ------------------
> >  2 files changed, 37 insertions(+), 112 deletions(-)
> > 
> This series is still sitting as new in patchwork.
> Is it simply waiting for free review capacity or .. ?

Yes, sorry, Heiner, I'm hopelessly behind.  Trying to finish up the
v5.14 pull request today, and then next week I'll start on the v5.15
material.

If this series applies cleanly to v5.14-rc1, you don't need to do
anything.  If it needs any rebasing for v5.14-rc1, it would save me
some time if you could post an update.

Bjorn
