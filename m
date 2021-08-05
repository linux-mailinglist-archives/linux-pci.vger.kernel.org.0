Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65933E1CB6
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 21:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhHET3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 15:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhHET3y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 15:29:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6807A60ED6;
        Thu,  5 Aug 2021 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628191779;
        bh=iEmdFkjyawuD+S1Q0BXIFQeftxJ9iePLw2txAbIy8mo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HKzAiJuRmsIlLq/O+/OWuQpc06DYZaqJ5R43MCu1Wl/2SZ2Rqorqm2iMtxeFwseHr
         /i+ZKARPl9rGpqFcFKPntCOpk/fp2FIVV27QvL/A0GPn4e2fDNnIx32mcjcOA2d0/5
         aKifsIFpTGWcgB/jTUn77KjQMadInZPAgth+zMA1CFTCZYKC4po17+PpoUzlo++3V7
         cxuo28g0/adFTD7l1WuxCKvu3tV4L6G96BOdSaCwLX5czItdC34fH2G+UTI6Hn/iAL
         sMbLUaYtthCAYH/lcCJ85vBvb8iRbCU0AhKvR/0ksG8FMiaOGyUua2FwJxUQi4Uw2n
         nxOmFoB3QK8Iw==
Date:   Thu, 5 Aug 2021 14:29:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/5] PCI/VPD: Further improvements
Message-ID: <20210805192938.GA1777404@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b22a2ef2-2a32-410a-2680-ca05d7b52df3@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 05, 2021 at 09:10:51PM +0200, Heiner Kallweit wrote:
> On 03.08.2021 00:32, Bjorn Helgaas wrote:
> > On Thu, May 13, 2021 at 10:53:44PM +0200, Heiner Kallweit wrote:
> >> Series with further improvements to PCI VPD handling.
> >>
> >> Heiner Kallweit (5):
> >>   PCI/VPD: Refactor pci_vpd_size
> >>   PCI: Clean up VPD constants and functions in pci.h
> >>   PCI/VPD: Remove old_size argument from pci_vpd_size
> >>   PCI/VPD: Make pci_vpd_wait uninterruptible
> >>   PCI/VPD: Remove pci_vpd member flag
> >>
> >>  drivers/pci/vpd.c   | 106 ++++++++++++++++----------------------------
> >>  include/linux/pci.h |  43 ------------------
> >>  2 files changed, 37 insertions(+), 112 deletions(-)
> > 
> > Applied to pci/vpd for v5.15, thanks!
> > 
> pci/vpd hasn't been merged yet into next, is this intentional?

I let the 0-day bot build things before merging into next.  But thanks
for the reminder, there are a couple branches I should merge.

Bjorn
