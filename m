Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022E03D01BA
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 20:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhGTRuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 13:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232391AbhGTRuH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 13:50:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE129610A7;
        Tue, 20 Jul 2021 18:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626805844;
        bh=FD0HmoBec4G2Jup48EN8HBUEeWmAwgIJ1JIBcuQGKDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KTS44wOyeVz02bGRo22MVJafz7z/cgJhyCaDM4p71ILASWKa2m09n4EmTcebG4WhF
         UBCUnZskySu0/pG3SThIOk/csE/Ab5lqdP/zPVbrj5XqJ3lncUFT/apyc/mZbxcf9J
         W86EGUsYIyzVRS2hylxPDkS7KUiLEsRddj/RGkVNjRJ3g7+5CKaL39u6prZo3ZSMcx
         yrRIlPEvUwCW2ONGYLlMDvfthkyo7FfYtYCj/xyJSd0/wXqdsXoz1BU0czIHR0OqOP
         BjMrZKMqJ3YGnQpV2G9mT6/ROZAaw1ABvBcxi6nfR8bUJP7FTlcZjuBdBQja/64eVh
         1NmeqvGhn/Oow==
Date:   Tue, 20 Jul 2021 13:30:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/3] PCI: aardvark: Fix checking for PIO status
Message-ID: <20210720183042.GA108003@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210720181155.lhmbrcvlnkhdj32o@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 20, 2021 at 08:11:55PM +0200, Pali Rohár wrote:
> On Tuesday 20 July 2021 11:34:51 Bjorn Helgaas wrote:
> > On Tue, Jul 20, 2021 at 04:49:55PM +0200, Pali Rohár wrote:

> > > So what should pci-aardvark driver in this case do? Return ~0 or re-send
> > > this config read request (and how many times)?
> > 
> > That's a good question.  I don't know what other hardware
> > implementations do, but I doubt they retry forever.  Since the spec
> > doesn't specify a number of retries, I think you can choose to do
> > none and immediately return ~0.
> 
> Ok, so I will change implementation to return ~0 without any retry. This
> is simple and easy implementation. Anyway, it would be nice to know what
> other real-hardware implementations of PCIe controllers are doing.
> 
> PCI_EXP_RTCTL_CRSSVE bit is only part of kernel emulated PCIe Bridge and
> has no real register in aardvark hw.
> 
> So for me it looks like that aardvark's pci_ops.read() should set read
> value to ~0 or 0xffff0001 based on what is stored in kernel emulated
> PCI_EXP_RTCTL_CRSSVE bit. Right?

Yes, that would be my advice.  Of course it's only if we're reading
the Vendor ID *and* PCI_EXP_RTCTL_CRSSVE is set.
